<?php
require __DIR__ . "/config.php";
require __DIR__ . "/helpers.php";

$u = auth_user($pdo);
$token = get_bearer_token();
$hash = token_hash($token);

$pdo->prepare("DELETE FROM auth_tokens WHERE token_hash = ?")->execute([$hash]);
respond(200, ["ok" => true]);
