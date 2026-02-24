<?php
require __DIR__ . "/config.php";

header("Content-Type: application/json; charset=utf-8");

$input = json_decode(file_get_contents("php://input"), true);
$email = trim($input["email"] ?? "");

if ($email === "") {
  http_response_code(400);
  echo json_encode(["ok" => false, "message" => "Email is required"]);
  exit;
}

// Always return same message (security: don’t reveal if email exists)
$generic = ["ok" => true, "message" => "If the email exists, a reset link will be provided."];

$stmt = $pdo->prepare("SELECT id FROM users WHERE email = ? LIMIT 1");
$stmt->execute([$email]);
$user = $stmt->fetch();

if (!$user) {
  echo json_encode($generic);
  exit;
}

// Create token
$token = bin2hex(random_bytes(32)); // raw token shown in link
$token_hash = hash("sha256", $token);
$expires_at = (new DateTime("+30 minutes"))->format("Y-m-d H:i:s");

// Invalidate old unused tokens (optional but good)
$pdo->prepare("UPDATE password_resets SET used_at = NOW()
               WHERE user_id = ? AND used_at IS NULL")->execute([$user["id"]]);

$pdo->prepare("INSERT INTO password_resets (user_id, token_hash, expires_at)
               VALUES (?, ?, ?)")->execute([$user["id"], $token_hash, $expires_at]);

// If you have email later, send this link by email instead
$reset_link = "http://localhost/helpdesk/reset_password.html?token=" . $token;

echo json_encode([
  "ok" => true,
  "message" => $generic["message"],
  "dev_reset_link" => $reset_link // remove this when you add real email
]);