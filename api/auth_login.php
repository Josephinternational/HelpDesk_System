<?php
require __DIR__ . "/config.php";
require __DIR__ . "/helpers.php";

$data = json_input();
require_fields($data, ["email", "password"]);

$email = strtolower(trim($data["email"]));
$pass  = (string)$data["password"];

$stmt = $pdo->prepare("SELECT id, full_name, email, password_hash, role FROM users WHERE email = ? LIMIT 1");
$stmt->execute([$email]);
$u = $stmt->fetch();

if (!$u || !password_verify($pass, $u["password_hash"])) {
  respond(401, ["ok" => false, "error" => "Wrong email or password"]);
}

$token = make_token();
$tokenHash = token_hash($token);
$expires = (new DateTime("+7 days"))->format("Y-m-d H:i:s");

$pdo->prepare("INSERT INTO auth_tokens (user_id, token_hash, expires_at) VALUES (?,?,?)")
    ->execute([$u["id"], $tokenHash, $expires]);

respond(200, [
  "ok" => true,
  "token" => $token,
  "user" => [
    "id" => (int)$u["id"],
    "full_name" => $u["full_name"],
    "email" => $u["email"],
    "role" => $u["role"]
  ]
]);
