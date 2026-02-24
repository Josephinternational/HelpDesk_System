<?php
require __DIR__ . "/config.php";
require __DIR__ . "/helpers.php";

$u = auth_user($pdo);
require_role($u, ["admin"]);

$data = json_input();
require_fields($data, ["ticket_id", "technician_id"]);

$ticket_id = (int)$data["ticket_id"];
$tech_id = (int)$data["technician_id"];

$pdo->prepare("UPDATE tickets SET assigned_to=?, status='assigned' WHERE id=?")
    ->execute([$tech_id, $ticket_id]);

respond(200, ["ok"=>true]);
