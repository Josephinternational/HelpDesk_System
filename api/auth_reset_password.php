<?php
require __DIR__ . "/config.php";

header("Content-Type: application/json; charset=utf-8");

$input = json_decode(file_get_contents("php://input"), true);
$token = trim($input["token"] ?? "");
$new_password = (string)($input["new_password"] ?? "");

if ($token === "" || $new_password === "") {
  http_response_code(400);
  echo json_encode(["ok" => false, "message" => "Token and new password are required"]);
  exit;
}

if (strlen($new_password) < 6) {
  http_response_code(400);
  echo json_encode(["ok" => false, "message" => "Password must be at least 6 characters"]);
  exit;
}

$token_hash = hash("sha256", $token);

// Find valid token
$stmt = $pdo->prepare("
  SELECT pr.id AS reset_id, pr.user_id
  FROM password_resets pr
  WHERE pr.token_hash = ?
    AND pr.used_at IS NULL
    AND pr.expires_at > NOW()
  LIMIT 1
");
$stmt->execute([$token_hash]);
$row = $stmt->fetch();

if (!$row) {
  http_response_code(400);
  echo json_encode(["ok" => false, "message" => "Reset link is invalid or expired"]);
  exit;
}

// Update password
$hash = password_hash($new_password, PASSWORD_DEFAULT);

$pdo->beginTransaction();
try {
  $pdo->prepare("UPDATE users SET password_hash = ? WHERE id = ?")
      ->execute([$hash, $row["user_id"]]);

  $pdo->prepare("UPDATE password_resets SET used_at = NOW() WHERE id = ?")
      ->execute([$row["reset_id"]]);

  // Optional: log out all sessions by deleting tokens
  $pdo->prepare("DELETE FROM auth_tokens WHERE user_id = ?")
      ->execute([$row["user_id"]]);

  $pdo->commit();
} catch (Throwable $e) {
  $pdo->rollBack();
  http_response_code(500);
  echo json_encode(["ok" => false, "message" => "Server error"]);
  exit;
}

echo json_encode(["ok" => true, "message" => "Password reset successful. Please login."]);