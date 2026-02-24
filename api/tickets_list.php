<?php
require __DIR__ . "/config.php";
require __DIR__ . "/helpers.php";

$u = auth_user($pdo);

$status = $_GET["status"] ?? "";
$search = $_GET["q"] ?? "";

$where = [];
$params = [];

if ($status !== "") {
  $where[] = "t.status = ?";
  $params[] = $status;
}
if ($search !== "") {
  $where[] = "(t.ticket_no LIKE ? OR t.title LIKE ?)";
  $params[] = "%$search%";
  $params[] = "%$search%";
}

if ($u["role"] === "user") {
  $where[] = "t.user_id = ?";
  $params[] = $u["id"];
}
if ($u["role"] === "technician") {
  $where[] = "t.assigned_to = ?";
  $params[] = $u["id"];
}

$sqlWhere = $where ? ("WHERE " . implode(" AND ", $where)) : "";

$stmt = $pdo->prepare("
  SELECT t.id, t.ticket_no, t.title, t.priority, t.status, t.created_at, t.updated_at,
         c.name AS category,
         u.full_name AS requester,
         tech.full_name AS technician
  FROM tickets t
  JOIN categories c ON c.id = t.category_id
  JOIN users u ON u.id = t.user_id
  LEFT JOIN users tech ON tech.id = t.assigned_to
  $sqlWhere
  ORDER BY t.created_at DESC
  LIMIT 200
");
$stmt->execute($params);

respond(200, ["ok" => true, "tickets" => $stmt->fetchAll()]);
