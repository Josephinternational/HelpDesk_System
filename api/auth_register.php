<?php
require __DIR__ . "/config.php";
require __DIR__ . "/helpers.php";

$data = json_input();
require_fields($data, ["full_name", "email", "password"]);

$full_name = trim($data["full_name"]);
$email = strtolower(trim($data["email"]));
$pass = (string)$data["password"];

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
  respond(400, ["ok" => false, "error" => "Invalid email"]);
}
if (strlen($pass) < 6) {
  respond(400, ["ok" => false, "error" => "Password must be at least 6 characters"]);
}

$hash = password_hash($pass, PASSWORD_BCRYPT);

try {
  $stmt = $pdo->prepare("INSERT INTO users (full_name, email, password_hash, role) VALUES (?,?,?, 'user')");
  $stmt->execute([$full_name, $email, $hash]);
  respond(201, ["ok" => true, "message" => "Registered successfully. Please login."]);
} catch (Throwable $e) {
  respond(400, ["ok" => false, "error" => "Email already exists"]);
}
