<?php
require_once __DIR__ . '/config.php';
require_once __DIR__ . '/duitku.php';

if (($_SESSION['role'] ?? '') !== 'pelanggan' || empty($_SESSION['id_pelanggan'])) {
    header('Location: index.php');
    exit;
}

$orderId = $_GET['order'] ?? $_GET['merchantOrderId'] ?? '';
if (!is_string($orderId) || $orderId === '') {
    http_response_code(400);
    exit('Nomor pesanan tidak valid.');
}

$stmt = $conn->prepare(
    "SELECT id_transaksi, total_belanja, status_pembayaran, duitku_order_id,
            duitku_reference, duitku_payment_url, duitku_payment_method
     FROM tbl_transaksi
     WHERE duitku_order_id = ? AND id_pelanggan = ? AND metode_pembayaran = 'duitku'
     LIMIT 1"
);
$idPelanggan = (int)$_SESSION['id_pelanggan'];
$stmt->bind_param('si', $orderId, $idPelanggan);
$stmt->execute();
$transaksi = $stmt->get_result()->fetch_assoc();
$stmt->close();

if (!$transaksi) {
    http_response_code(404);
    exit('Pesanan Duitku tidak ditemukan.');
}

$statusPembayaran = $transaksi['status_pembayaran'];
$pesanStatus = '';
$tipePesanStatus = 'info';
$perluPeriksaStatus = isset($_GET['cek']) || isset($_GET['return']) || isset($_GET['resultCode']);

if ($statusPembayaran === 'menunggu_verifikasi' && $perluPeriksaStatus) {
    try {
        $statusDuitku = duitkuCheckPayment($orderId);
        $jumlahCocok = isset($statusDuitku['amount'])
            && (int)round((float)$statusDuitku['amount']) === (int)round((float)$transaksi['total_belanja']);
        $referensiCocok = isset($statusDuitku['reference'])
            && is_string($statusDuitku['reference'])
            && is_string($transaksi['duitku_reference'])
            && hash_equals($transaksi['duitku_reference'], $statusDuitku['reference']);

        if (($statusDuitku['statusCode'] ?? '') === '00' && $jumlahCocok && $referensiCocok) {
            $idTransaksi = (int)$transaksi['id_transaksi'];
            $stmtUpdate = $conn->prepare(
                "UPDATE tbl_transaksi
                 SET status_pembayaran = 'terverifikasi',
                     diverifikasi_pada = COALESCE(diverifikasi_pada, NOW())
                 WHERE id_transaksi = ?
                   AND metode_pembayaran = 'duitku'
                   AND status_pembayaran = 'menunggu_verifikasi'"
            );
            $stmtUpdate->bind_param('i', $idTransaksi);
            $stmtUpdate->execute();
            $stmtUpdate->close();
            $statusPembayaran = 'terverifikasi';
        } elseif (($statusDuitku['statusCode'] ?? '') === '00') {
            error_log('TokoKu Duitku payment verification mismatch for order ' . $orderId);
            $pesanStatus = 'Pembayaran belum dapat diverifikasi. Silakan coba periksa kembali.';
            $tipePesanStatus = 'warning';
        } else {
            $pesanStatus = 'Pembayaran belum terkonfirmasi. Setelah membayar, pilih Periksa status pembayaran.';
            $tipePesanStatus = 'warning';
        }
    } catch (mysqli_sql_exception $e) {
        throw $e;
    } catch (RuntimeException $e) {
        error_log('TokoKu Duitku payment check failed: ' . $e->getMessage());
        $pesanStatus = 'Status pembayaran belum dapat diperiksa. Coba lagi beberapa saat.';
        $tipePesanStatus = 'warning';
    }
}

if ($statusPembayaran === 'terverifikasi') {
    $idTransaksi = (int)$transaksi['id_transaksi'];
    $_SESSION['notifikasi_pembayaran_berhasil'] = $idTransaksi;
    header('Location: detail_transaksi.php?id=' . $idTransaksi);
    exit;
}

$paymentUrl = (string)($transaksi['duitku_payment_url'] ?? '');
$paymentUrlValid = filter_var($paymentUrl, FILTER_VALIDATE_URL) !== false
    && strtolower((string)parse_url($paymentUrl, PHP_URL_SCHEME)) === 'https';
$kodeMetode = (string)($transaksi['duitku_payment_method'] ?? '');
$namaMetode = $kodeMetode !== '' ? duitkuPaymentMethodLabel($kodeMetode) : 'Duitku';
?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pembayaran #<?= (int)$transaksi['id_transaksi'] ?> - TokoKu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css?v=<?= (int)filemtime(__DIR__ . '/style.css') ?>">
</head>
<body class="duitku-payment-page">
<?php include 'navbar.php'; ?>
<main class="duitku-payment-container">
    <a class="duitku-payment-back" href="belanja.php#pesanan">
        <i class="bi bi-arrow-left"></i> Kembali ke pesanan
    </a>

    <section class="duitku-payment-card">
        <div class="duitku-payment-icon"><i class="bi bi-shield-check"></i></div>
        <span class="duitku-payment-eyebrow">PEMBAYARAN AMAN DENGAN DUITKU</span>
        <h1>Selesaikan pembayaran</h1>
        <p class="duitku-payment-intro">Pesanan tersimpan. Lanjutkan pembayaran melalui halaman resmi Duitku.</p>

        <?php if ($pesanStatus !== ''): ?>
            <div class="alert alert-<?= htmlspecialchars($tipePesanStatus) ?>"><?= htmlspecialchars($pesanStatus) ?></div>
        <?php endif; ?>

        <div class="duitku-payment-summary">
            <div><span>Nomor pesanan</span><strong>#<?= (int)$transaksi['id_transaksi'] ?></strong></div>
            <div><span>Metode pembayaran</span><strong><?= htmlspecialchars($namaMetode) ?></strong></div>
            <div class="duitku-payment-total"><span>Total pembayaran</span><strong><?= rupiah($transaksi['total_belanja']) ?></strong></div>
        </div>

        <div class="duitku-payment-pending">
            <i class="bi bi-hourglass-split"></i>
            <span><strong>Menunggu pembayaran</strong><small>Status akan diperbarui setelah Duitku mengonfirmasi pembayaran.</small></span>
        </div>

        <div class="duitku-payment-actions">
            <?php if ($paymentUrlValid): ?>
                <a class="duitku-payment-primary" href="<?= htmlspecialchars($paymentUrl, ENT_QUOTES, 'UTF-8') ?>">
                    Bayar sekarang <i class="bi bi-box-arrow-up-right"></i>
                </a>
            <?php else: ?>
                <div class="alert alert-warning mb-0">Tautan pembayaran tidak tersedia. Hubungi toko untuk melanjutkan pesanan.</div>
            <?php endif; ?>
            <a class="duitku-payment-secondary" href="pembayaran_duitku.php?order=<?= rawurlencode($orderId) ?>&amp;cek=1">
                <i class="bi bi-arrow-clockwise"></i> Periksa status pembayaran
            </a>
        </div>
        <p class="duitku-payment-footnote">Jika pembayaran berhasil, halaman struk transaksi akan terbuka otomatis.</p>
    </section>
</main>
</body>
</html>
