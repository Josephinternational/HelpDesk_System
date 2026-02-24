<?php
require __DIR__ . "/config.php";

echo json_encode([
  "ok" => true,
  "message" => "Database connected successfully"
]);
