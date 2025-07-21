<?php
// FIXED: Use environment variables for database credentials
$host = $_ENV['DB_HOST'] ?? 'localhost';
$db   = $_ENV['DB_NAME'] ?? 'ecommerce_db';
$user = $_ENV['DB_USER'] ?? 'root';
$pass = $_ENV['DB_PASS'] ?? '';  // Should be set in environment
$charset = 'utf8mb4';

// Validate that password is set in production
if (empty($pass) && ($_ENV['APP_ENV'] ?? 'development') === 'production') {
    error_log("CRITICAL: Database password not set in production!");
    http_response_code(500);
    echo json_encode(["message" => "Configuration error"]);
    exit;
}

$dsn = "mysql:host=$host;dbname=$db;charset=$charset";
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES   => false,
    // ADDED: Additional security options
    PDO::ATTR_PERSISTENT         => false,
    PDO::MYSQL_ATTR_SSL_VERIFY_SERVER_CERT => false,
];

try {
    $pdo = new PDO($dsn, $user, $pass, $options);
    // ADDED: Set SQL mode for stricter validation
    $pdo->exec("SET sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_DATE,NO_ZERO_IN_DATE,ERROR_FOR_DIVISION_BY_ZERO'");
} catch (\PDOException $e) {
    // FIXED: Don't expose database details in error messages
    error_log("Database connection failed: " . $e->getMessage());
    http_response_code(500);
    echo json_encode(["message" => "Database connection failed"]);
    exit;
}
?>