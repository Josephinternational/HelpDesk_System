<?php
require __DIR__ . "/config.php";
require __DIR__ . "/helpers.php";

$u = auth_user($pdo);
respond(200, ["ok" => true, "user" => $u]);
