<?php
require_once __DIR__ . '/config.php';
require_once __DIR__ . '/duitku.php';

header('Content-Type: application/json; charset=utf-8');

if (($_SESSION['role'] ?? '') !== 'pelanggan' || empty($_SESSION['id_pelanggan'])) {
    http_response_code(403);
    echo json_encode(['message' => 'Akses tidak diizinkan.']);
    exit;
}
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['message' => 'Method not allowed']);
    exit;
}
if (!validCsrfToken($_POST['csrf_token'] ?? null)) {
    http_response_code(400);
    echo json_encode(['message' => 'Form sudah kedaluwarsa.']);
    exit;
}

$amount = filter_var($_POST['amount'] ?? null, FILTER_VALIDATE_INT);
if ($amount === false || $amount < 1) {
    http_response_code(400);
    echo json_encode(['message' => 'Jumlah transaksi tidak valid.']);
    exit;
}

try {
    echo json_encode(['methods' => duitkuGetPaymentMethods($amount)], JSON_INVALID_UTF8_SUBSTITUTE);
} catch (RuntimeException $e) {
    error_log('TokoKu Duitku payment methods failed: ' . $e->getMessage());
    http_response_code(503);
    echo json_encode(['message' => 'Daftar metode pembayaran belum tersedia.']);
}
