<?php
require __DIR__ . "/config.php";
require __DIR__ . "/helpers.php";

$u = auth_user($pdo);
$id = (int)($_GET["id"] ?? 0);
if ($id <= 0) respond(400, ["ok"=>false,"error"=>"Missing id"]);

$stmt = $pdo->prepare("
  SELECT t.*, c.name AS category,
         u.full_name AS requester, u.email AS requester_email,
         tech.full_name AS technician
  FROM tickets t
  JOIN categories c ON c.id = t.category_id
  JOIN users u ON u.id = t.user_id
  LEFT JOIN users tech ON tech.id = t.assigned_to
  WHERE t.id = ?
  LIMIT 1
");
$stmt->execute([$id]);
$t = $stmt->fetch();
if (!$t) respond(404, ["ok"=>false,"error"=>"Not found"]);

if ($u["role"] === "user" && (int)$t["user_id"] !== (int)$u["id"]) respond(403, ["ok"=>false,"error"=>"Forbidden"]);
if ($u["role"] === "technician" && (int)$t["assigned_to"] !== (int)$u["id"]) respond(403, ["ok"=>false,"error"=>"Forbidden"]);

respond(200, ["ok" => true, "ticket" => $t]);
