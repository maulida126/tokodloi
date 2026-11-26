<?php
require_once __DIR__ . '/config.php';
require_once __DIR__ . '/duitku.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    exit('Method not allowed');
}

$config = duitkuConfig();
$merchantCode = isset($_POST['merchantCode']) && is_string($_POST['merchantCode']) ? $_POST['merchantCode'] : '';
$amount = isset($_POST['amount']) && is_string($_POST['amount']) ? $_POST['amount'] : '';
$merchantOrderId = isset($_POST['merchantOrderId']) && is_string($_POST['merchantOrderId']) ? $_POST['merchantOrderId'] : '';
$signature = isset($_POST['signature']) && is_string($_POST['signature']) ? $_POST['signature'] : '';
$reference = isset($_POST['reference']) && is_string($_POST['reference']) ? $_POST['reference'] : '';
$paymentCode = isset($_POST['paymentCode']) && is_string($_POST['paymentCode']) ? $_POST['paymentCode'] : '';
$resultCode = isset($_POST['resultCode']) && is_string($_POST['resultCode']) ? $_POST['resultCode'] : '';

if (!duitkuIsConfigured()
    || $merchantCode !== $config['merchant_code']
    || $paymentCode === ''
    || !ctype_digit($amount)
    || $merchantOrderId === ''
    || $signature === ''
    || $reference === ''
) {
    http_response_code(400);
    exit('Invalid callback');
}

$expectedSignature = hash_hmac(
    'sha256',
    $merchantCode . $amount . $merchantOrderId,
    $config['api_key']
);
if (!hash_equals($expectedSignature, $signature)) {
    http_response_code(400);
    exit('Invalid signature');
}

$stmt = $conn->prepare(
    "SELECT id_transaksi, total_belanja, duitku_reference, duitku_payment_method
     FROM tbl_transaksi
     WHERE duitku_order_id = ? AND metode_pembayaran = 'duitku'
     LIMIT 1"
);
$stmt->bind_param('s', $merchantOrderId);
$stmt->execute();
$transaksi = $stmt->get_result()->fetch_assoc();
$stmt->close();

$metodeDuitkuTransaksi = $transaksi && !empty($transaksi['duitku_payment_method'])
    ? $transaksi['duitku_payment_method']
    : $config['payment_method'];
if (!$transaksi
    || $paymentCode !== $metodeDuitkuTransaksi
    || (int)round((float)$transaksi['total_belanja']) !== (int)$amount
    || $transaksi['duitku_reference'] === null
    || !hash_equals((string)$transaksi['duitku_reference'], $reference)
) {
    http_response_code(400);
    exit('Transaction mismatch');
}

if ($resultCode === '00') {
    $idTransaksi = (int)$transaksi['id_transaksi'];
    $stmt = $conn->prepare(
        "UPDATE tbl_transaksi
         SET status_pembayaran = 'terverifikasi',
             diverifikasi_pada = COALESCE(diverifikasi_pada, NOW())
         WHERE id_transaksi = ?
           AND metode_pembayaran = 'duitku'
           AND status_pembayaran = 'menunggu_verifikasi'"
    );
    $stmt->bind_param('i', $idTransaksi);
    $stmt->execute();
    $stmt->close();
}

http_response_code(200);
echo 'OK';
