<?php
require __DIR__ . "/config.php";
require __DIR__ . "/helpers.php";

$u = auth_user($pdo);
require_role($u, ["technician","admin"]);

$data = json_input();
require_fields($data, ["ticket_id", "status"]);

$ticket_id = (int)$data["ticket_id"];
$status = $data["status"];

$allowed = ["open","assigned","in_progress","resolved","closed"];
if (!in_array($status, $allowed, true)) respond(400, ["ok"=>false,"error"=>"Bad status"]);

if ($u["role"] === "technician") {
  // Tech can only update their assigned tickets
  $stmt = $pdo->prepare("SELECT assigned_to FROM tickets WHERE id=?");
  $stmt->execute([$ticket_id]);
  $t = $stmt->fetch();
  if (!$t || (int)$t["assigned_to"] !== (int)$u["id"]) respond(403, ["ok"=>false,"error"=>"Forbidden"]);
}

if ($status === "resolved") {
  $pdo->prepare("UPDATE tickets SET status=?, resolved_at=NOW() WHERE id=?")->execute([$status, $ticket_id]);
} else {
  $pdo->prepare("UPDATE tickets SET status=? WHERE id=?")->execute([$status, $ticket_id]);
}

respond(200, ["ok"=>true]);
