<?php
require __DIR__ . "/config.php";
require __DIR__ . "/helpers.php";

$u = auth_user($pdo);

$data = json_input();
require_fields($data, ["ticket_id", "message"]);

$ticket_id = (int)$data["ticket_id"];
$msg = trim($data["message"]);

$stmt = $pdo->prepare("SELECT user_id, assigned_to FROM tickets WHERE id=?");
$stmt->execute([$ticket_id]);
$t = $stmt->fetch();
if (!$t) respond(404, ["ok"=>false,"error"=>"Ticket not found"]);

if ($u["role"] === "user" && (int)$t["user_id"] !== (int)$u["id"]) respond(403, ["ok"=>false,"error"=>"Forbidden"]);
if ($u["role"] === "technician" && (int)$t["assigned_to"] !== (int)$u["id"]) respond(403, ["ok"=>false,"error"=>"Forbidden"]);

$pdo->prepare("INSERT INTO comments (ticket_id, user_id, message) VALUES (?,?,?)")
    ->execute([$ticket_id, $u["id"], $msg]);

respond(201, ["ok"=>true]);
