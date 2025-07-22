<?php
require_once '../../config/database.php';
require_once '../../auth/verify_token.php';

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, PATCH, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization, X-HTTP-Method-Override");

// Handle preflight
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

// Handle PATCH override
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_SERVER['HTTP_X_HTTP_METHOD_OVERRIDE']) && $_SERVER['HTTP_X_HTTP_METHOD_OVERRIDE'] === 'PATCH') {
    $_SERVER['REQUEST_METHOD'] = 'PATCH';
}

if ($_SERVER['REQUEST_METHOD'] !== 'PATCH') {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Method not allowed']);
    exit;
}

// Read body
$data = json_decode(file_get_contents("php://input"), true);
$delivery_id = $data['delivery_id'] ?? null;
$status = $data['status'] ?? null;

if (!$delivery_id || !$status) {
    echo json_encode(['success' => false, 'message' => 'Missing data']);
    exit;
}

// Execute update
$stmt = $pdo->prepare("UPDATE deliveries SET status = ?, delivery_date = NOW() WHERE delivery_id = ?");
$success = $stmt->execute([$status, $delivery_id]);

echo json_encode(['success' => $success, 'message' => $success ? 'Updated' : 'Failed']);
?>
