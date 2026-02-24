<?php
declare(strict_types=1);

function json_input(): array {
  $raw = file_get_contents("php://input");
  if (!$raw) return [];
  $data = json_decode($raw, true);
  return is_array($data) ? $data : [];
}

function respond(int $code, array $payload): void {
  http_response_code($code);
  echo json_encode($payload);
  exit;
}

function require_fields(array $data, array $fields): void {
  foreach ($fields as $f) {
    if (!isset($data[$f]) || trim((string)$data[$f]) === "") {
      respond(400, ["ok" => false, "error" => "Missing field: {$f}"]);
    }
  }
}

function make_token(): string {
  return bin2hex(random_bytes(32)); // 64 chars
}

function token_hash(string $token): string {
  return hash("sha256", $token);
}

function get_bearer_token(): ?string {
  $hdr = "";

  // 1) Most common
  if (!empty($_SERVER["HTTP_AUTHORIZATION"])) {
    $hdr = $_SERVER["HTTP_AUTHORIZATION"];
  }

  // 2) Common on Apache/XAMPP
  if (!$hdr && !empty($_SERVER["REDIRECT_HTTP_AUTHORIZATION"])) {
    $hdr = $_SERVER["REDIRECT_HTTP_AUTHORIZATION"];
  }

  // 3) Fallback (works on some setups)
  if (!$hdr && function_exists("getallheaders")) {
    $headers = getallheaders();
    if (isset($headers["Authorization"])) $hdr = $headers["Authorization"];
    if (!$hdr && isset($headers["authorization"])) $hdr = $headers["authorization"];
  }

  if ($hdr && preg_match('/Bearer\s+(.+)/i', $hdr, $m)) {
    return trim($m[1]);
  }
  return null;
}

function auth_user(PDO $pdo): array {
  $token = get_bearer_token();
  if (!$token) respond(401, ["ok" => false, "error" => "No token"]);

  $hash = token_hash($token);

  $stmt = $pdo->prepare("
    SELECT u.id, u.full_name, u.email, u.role
    FROM auth_tokens t
    JOIN users u ON u.id = t.user_id
    WHERE t.token_hash = ? AND t.expires_at > NOW()
    LIMIT 1
  ");
  $stmt->execute([$hash]);
  $u = $stmt->fetch();
  if (!$u) respond(401, ["ok" => false, "error" => "Invalid/expired token"]);
  return $u;
}

function require_role(array $u, array $roles): void {
  if (!in_array($u["role"], $roles, true)) {
    respond(403, ["ok" => false, "error" => "Forbidden"]);
  }
}
