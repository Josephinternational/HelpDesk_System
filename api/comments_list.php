<?php
require __DIR__ . "/config.php";
require __DIR__ . "/helpers.php";

$u = auth_user($pdo);
$ticket_id = (int)($_GET["ticket_id"] ?? 0);
if ($ticket_id <= 0) respond(400, ["ok"=>false,"error"=>"Missing ticket_id"]);

$stmt = $pdo->prepare("SELECT user_id, assigned_to FROM tickets WHERE id=?");
$stmt->execute([$ticket_id]);
$t = $stmt->fetch();
if (!$t) respond(404, ["ok"=>false,"error"=>"Ticket not found"]);

if ($u["role"] === "user" && (int)$t["user_id"] !== (int)$u["id"]) respond(403, ["ok"=>false,"error"=>"Forbidden"]);
if ($u["role"] === "technician" && (int)$t["assigned_to"] !== (int)$u["id"]) respond(403, ["ok"=>false,"error"=>"Forbidden"]);

$stmt = $pdo->prepare("
  SELECT c.id, c.message, c.created_at, u.full_name, u.role
  FROM comments c
  JOIN users u ON u.id = c.user_id
  WHERE c.ticket_id = ?
  ORDER BY c.created_at ASC
");
$stmt->execute([$ticket_id]);

respond(200, ["ok"=>true, "comments"=>$stmt->fetchAll()]);
