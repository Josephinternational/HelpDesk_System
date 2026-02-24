<?php
require __DIR__ . "/config.php";
require __DIR__ . "/helpers.php";

$u = auth_user($pdo);
require_role($u, ["admin"]);

$from = $_GET["from"] ?? date("Y-m-01");
$to   = $_GET["to"] ?? date("Y-m-d");

$stmt = $pdo->prepare("
  SELECT status, COUNT(*) AS total
  FROM tickets
  WHERE DATE(created_at) BETWEEN ? AND ?
  GROUP BY status
");
$stmt->execute([$from, $to]);
$byStatus = $stmt->fetchAll();

$stmt2 = $pdo->prepare("
  SELECT tech.full_name AS technician, COUNT(*) AS assigned_count
  FROM tickets t
  JOIN users tech ON tech.id = t.assigned_to
  WHERE DATE(t.created_at) BETWEEN ? AND ?
  GROUP BY tech.id
  ORDER BY assigned_count DESC
");
$stmt2->execute([$from, $to]);
$byTech = $stmt2->fetchAll();

respond(200, ["ok"=>true, "by_status"=>$byStatus, "by_technician"=>$byTech]);
