<?php
require __DIR__ . "/config.php";
require __DIR__ . "/helpers.php";

$u = auth_user($pdo);
require_role($u, ["admin"]);

$data = json_input();
require_fields($data, ["name"]);
$name = trim($data["name"]);

try {
  $pdo->prepare("INSERT INTO categories (name) VALUES (?)")->execute([$name]);
  respond(201, ["ok" => true]);
} catch (Throwable $e) {
  respond(400, ["ok" => false, "error" => "Category exists"]);
}
