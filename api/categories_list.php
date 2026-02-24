<?php
require __DIR__ . "/config.php";
require __DIR__ . "/helpers.php";

auth_user($pdo);

$rows = $pdo->query("SELECT id, name FROM categories ORDER BY name")->fetchAll();
respond(200, ["ok" => true, "categories" => $rows]);
