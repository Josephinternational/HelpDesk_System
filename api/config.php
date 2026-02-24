<?php
declare(strict_types=1);

header("Content-Type: application/json; charset=utf-8");

$DB_HOST = "localhost";
$DB_NAME = "helpdesk_db";
$DB_USER = "root";
$DB_PASS = ""; // XAMPP default

// Set to true only when debugging on your PC
$DEBUG = true;

try {
  $dsn = "mysql:host={$DB_HOST};dbname={$DB_NAME};charset=utf8mb4";

  $pdo = new PDO($dsn, $DB_USER, $DB_PASS, [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES => false,
    PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8mb4"
  ]);

} catch (Throwable $e) {
  http_response_code(500);
  echo json_encode([
    "ok" => false,
    "error" => "Database connection failed",
    "details" => $DEBUG ? $e->getMessage() : null
  ]);
  exit;
}
