<?php
require __DIR__ . "/config.php";
require __DIR__ . "/helpers.php";

$u = auth_user($pdo);
require_role($u, ["admin"]);

$rows = $pdo->query("SELECT id, full_name, email FROM users WHERE role='technician' ORDER BY full_name")->fetchAll();
respond(200, ["ok"=>true, "technicians"=>$rows]);
