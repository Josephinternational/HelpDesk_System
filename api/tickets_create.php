<?php
require __DIR__ . "/config.php";
require __DIR__ . "/helpers.php";

$u = auth_user($pdo);
require_role($u, ["user"]);

$data = json_input();
require_fields($data, ["category_id", "title", "description", "priority"]);

$category_id = (int)$data["category_id"];
$title = trim($data["title"]);
$desc = trim($data["description"]);
$priority = $data["priority"];

$allowedP = ["low","medium","high"];
if (!in_array($priority, $allowedP, true)) respond(400, ["ok"=>false,"error"=>"Bad priority"]);

$ticketNo = "TCK-" . date("Ymd") . "-" . strtoupper(bin2hex(random_bytes(3)));

$pdo->prepare("
  INSERT INTO tickets (ticket_no, user_id, category_id, title, description, priority)
  VALUES (?,?,?,?,?,?)
")->execute([$ticketNo, $u["id"], $category_id, $title, $desc, $priority]);

respond(201, ["ok" => true, "ticket_no" => $ticketNo]);
