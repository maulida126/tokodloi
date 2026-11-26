<?php

function duitkuConfig(): array
{
    $apiKey = getenv('DUITKU_API_KEY');
    $baseUrl = rtrim((string)getenv('DUITKU_BASE_URL'), '/');
    $environment = strtolower((string)(getenv('DUITKU_ENV') ?: 'sandbox'));
    $merchantCode = (string)(getenv('DUITKU_MERCHANT_CODE') ?: 'DS38587');
    $paymentMethod = (string)(getenv('DUITKU_PAYMENT_METHOD') ?: 'SP');

    if ($baseUrl === '' && $environment === 'sandbox') {
        $hostHeader = (string)($_SERVER['HTTP_HOST'] ?? '');
        $hostParts = parse_url('http://' . $hostHeader);
        $hostName = strtolower((string)($hostParts['host'] ?? ''));
        if (in_array($hostName, ['localhost', '127.0.0.1', '::1'], true)) {
            $scheme = !empty($_SERVER['HTTPS']) && strtolower((string)$_SERVER['HTTPS']) !== 'off'
                ? 'https'
                : 'http';
            $directory = str_replace('\\', '/', dirname((string)($_SERVER['SCRIPT_NAME'] ?? '')));
            $baseUrl = $scheme . '://' . $hostHeader . ($directory === '/' ? '' : rtrim($directory, '/'));
        }
    }

    return [
        'api_key' => $apiKey === false ? '' : trim($apiKey),
        'base_url' => $baseUrl,
        'environment' => $environment,
        'merchant_code' => trim($merchantCode),
        'payment_method' => trim($paymentMethod),
    ];
}

function duitkuIsConfigured(): bool
{
    $config = duitkuConfig();
    $baseUrl = filter_var($config['base_url'], FILTER_VALIDATE_URL);
    $parts = $baseUrl ? parse_url($baseUrl) : false;

    return $config['api_key'] !== ''
        && $config['merchant_code'] !== ''
        && $config['payment_method'] !== ''
        && in_array($config['environment'], ['sandbox', 'production'], true)
        && is_array($parts)
        && (
            strtolower($parts['scheme'] ?? '') === 'https'
            || (
                $config['environment'] === 'sandbox'
                && strtolower($parts['scheme'] ?? '') === 'http'
                && in_array(strtolower($parts['host'] ?? ''), ['localhost', '127.0.0.1', '::1'], true)
            )
        )
        && !empty($parts['host'])
        && function_exists('curl_init');
}

function duitkuPaymentMethodCategory(string $paymentMethod): ?string
{
    $categories = [
        'QRIS' => ['SP', 'NQ', 'SQ'],
        'Virtual Account' => ['BC', 'M2', 'VA', 'I1', 'B1', 'BT', 'A1', 'AG', 'NC', 'BR', 'S1', 'DM', 'BV'],
        'E-Wallet' => ['OV', 'SA', 'LF', 'LA', 'DA', 'SL', 'OL'],
    ];

    foreach ($categories as $category => $codes) {
        if (in_array($paymentMethod, $codes, true)) {
            return $category;
        }
    }

    return null;
}

function duitkuPaymentMethodLabel(string $paymentMethod): string
{
    $labels = [
        'SP' => 'QRIS ShopeePay',
        'NQ' => 'QRIS Nobu',
        'SQ' => 'QRIS Nusapay',
        'BC' => 'BCA Virtual Account',
        'M2' => 'Mandiri Virtual Account',
        'VA' => 'Maybank Virtual Account',
        'I1' => 'BNI Virtual Account',
        'B1' => 'CIMB Niaga Virtual Account',
        'BT' => 'Permata Virtual Account',
        'A1' => 'ATM Bersama',
        'AG' => 'Artha Graha Virtual Account',
        'NC' => 'Neo Commerce Virtual Account',
        'BR' => 'BRIVA',
        'S1' => 'Sahabat Sampoerna Virtual Account',
        'DM' => 'Danamon Virtual Account',
        'BV' => 'BSI Virtual Account',
        'OV' => 'OVO',
        'SA' => 'ShopeePay',
        'LF' => 'LinkAja',
        'LA' => 'LinkAja',
        'DA' => 'DANA',
        'SL' => 'ShopeePay Account Link',
        'OL' => 'OVO Account Link',
    ];

    return $labels[$paymentMethod] ?? 'Duitku';
}

function duitkuGetPaymentMethods(int $paymentAmount): array
{
    $config = duitkuConfig();
    if (!duitkuIsConfigured()) {
        throw new RuntimeException('Konfigurasi Duitku belum lengkap.');
    }
    if ($paymentAmount < 1) {
        throw new RuntimeException('Jumlah transaksi untuk memuat metode pembayaran tidak valid.');
    }

    $datetime = date('Y-m-d H:i:s');
    $signature = hash_hmac(
        'sha256',
        $config['merchant_code'] . $paymentAmount . $datetime,
        $config['api_key']
    );
    $host = $config['environment'] === 'production'
        ? 'https://passport.duitku.com'
        : 'https://sandbox.duitku.com';
    $response = duitkuPostJson(
        $host . '/webapi/api/merchant/paymentmethod/getpaymentmethod',
        [
            'merchantcode' => $config['merchant_code'],
            'amount' => $paymentAmount,
            'datetime' => $datetime,
            'signature' => $signature,
        ]
    );

    if (($response['responseCode'] ?? '') !== '00' || !is_array($response['paymentFee'] ?? null)) {
        $message = $response['responseMessage'] ?? 'Daftar metode pembayaran tidak tersedia.';
        if (!is_string($message)) {
            $message = 'Daftar metode pembayaran tidak tersedia.';
        }
        throw new RuntimeException(substr(strip_tags($message), 0, 200));
    }

    $methods = [];
    foreach ($response['paymentFee'] as $method) {
        if (!is_array($method)
            || !isset($method['paymentMethod'], $method['paymentName'])
            || !is_string($method['paymentMethod'])
            || !is_string($method['paymentName'])
        ) {
            continue;
        }
        $code = strtoupper(trim($method['paymentMethod']));
        $category = duitkuPaymentMethodCategory($code);
        if ($category === null) {
            continue;
        }
        $methods[] = [
            'code' => $code,
            'name' => trim($method['paymentName']),
            'category' => $category,
        ];
    }

    usort($methods, static function (array $first, array $second): int {
        $categoryOrder = ['QRIS' => 0, 'Virtual Account' => 1, 'E-Wallet' => 2];
        $categoryDifference = $categoryOrder[$first['category']] <=> $categoryOrder[$second['category']];
        return $categoryDifference !== 0
            ? $categoryDifference
            : strcasecmp($first['name'], $second['name']);
    });

    return $methods;
}

function duitkuBuildItemDetails(array $products, int $taxAmount, int $paymentAmount): array
{
    if (!$products || $taxAmount < 0 || $paymentAmount <= 0 || $taxAmount > $paymentAmount) {
        throw new RuntimeException('Rincian pembayaran Duitku tidak valid.');
    }

    $lines = [];
    $floorSubtotal = 0;
    foreach ($products as $product) {
        $quantity = filter_var($product['jumlah'] ?? null, FILTER_VALIDATE_INT);
        $unitPrice = isset($product['harga']) && is_numeric($product['harga'])
            ? (float)$product['harga']
            : NAN;
        if ($quantity === false || $quantity < 1 || !is_finite($unitPrice) || $unitPrice <= 0) {
            throw new RuntimeException('Rincian barang untuk pembayaran Duitku tidak valid.');
        }

        $lineAmount = $unitPrice * $quantity;
        $lineFloor = (int)floor($lineAmount);
        $lines[] = [
            'name' => substr((string)($product['nama_produk'] ?? 'Produk') . ' x ' . $quantity, 0, 255),
            'amount' => $lineFloor,
            'fraction' => $lineAmount - $lineFloor,
        ];
        $floorSubtotal += $lineFloor;
    }

    $targetSubtotal = $paymentAmount - $taxAmount;
    $remainingRupiah = $targetSubtotal - $floorSubtotal;
    if ($remainingRupiah < 0 || $remainingRupiah > count($lines)) {
        throw new RuntimeException('Total rincian barang tidak cocok dengan tagihan Duitku.');
    }

    $lineOrder = array_keys($lines);
    usort($lineOrder, static function (int $first, int $second) use ($lines): int {
        return $lines[$second]['fraction'] <=> $lines[$first]['fraction'];
    });
    for ($index = 0; $index < $remainingRupiah; $index++) {
        $lines[$lineOrder[$index]]['amount']++;
    }

    $items = [];
    foreach ($lines as $line) {
        if ($line['amount'] > 0) {
            $items[] = [
                'name' => $line['name'],
                'price' => $line['amount'],
                'quantity' => 1,
            ];
        }
    }
    if ($taxAmount > 0) {
        $items[] = [
            'name' => 'Pajak',
            'price' => $taxAmount,
            'quantity' => 1,
        ];
    }

    $itemTotal = array_sum(array_map(
        static fn(array $item): int => $item['price'] * $item['quantity'],
        $items
    ));
    if ($itemTotal !== $paymentAmount) {
        throw new RuntimeException('Total rincian barang tidak cocok dengan tagihan Duitku.');
    }

    return $items;
}

function duitkuCreatePayment(
    string $merchantOrderId,
    int $paymentAmount,
    string $selectedPaymentMethod,
    string $email,
    string $customerName,
    string $username,
    array $items
): array {
    $config = duitkuConfig();
    if (!duitkuIsConfigured()) {
        throw new RuntimeException('Konfigurasi Duitku belum lengkap.');
    }
    $availableMethods = duitkuGetPaymentMethods($paymentAmount);
    if (!in_array($selectedPaymentMethod, array_column($availableMethods, 'code'), true)) {
        throw new RuntimeException('Metode pembayaran Duitku yang dipilih sudah tidak tersedia.');
    }
    $itemTotal = array_sum(array_map(
        static fn(array $item): int => (int)$item['price'] * (int)$item['quantity'],
        $items
    ));
    if ($itemTotal !== $paymentAmount) {
        throw new RuntimeException('Total rincian barang tidak cocok dengan tagihan Duitku.');
    }

    $firstName = trim($customerName);
    $lastName = '';
    $nameParts = preg_split('/\s+/', $firstName, 2);
    if (is_array($nameParts) && count($nameParts) === 2) {
        [$firstName, $lastName] = $nameParts;
    }
    $vaName = substr(trim($customerName), 0, 20);
    $signature = hash_hmac(
        'sha256',
        $config['merchant_code'] . $merchantOrderId . $paymentAmount,
        $config['api_key']
    );
    $params = [
        'merchantCode' => $config['merchant_code'],
        'paymentAmount' => $paymentAmount,
        'paymentMethod' => $selectedPaymentMethod,
        'merchantOrderId' => $merchantOrderId,
        'productDetails' => 'Pembayaran TokoKu ' . $merchantOrderId,
        'merchantUserInfo' => substr($username, 0, 255),
        'customerVaName' => $vaName !== '' ? $vaName : 'Pelanggan TokoKu',
        'email' => $email,
        'itemDetails' => $items,
        'customerDetail' => [
            'firstName' => $firstName,
            'lastName' => $lastName,
            'email' => $email,
        ],
        'callbackUrl' => $config['base_url'] . '/duitku_callback.php',
        'returnUrl' => $config['base_url'] . '/pembayaran_duitku.php?order=' . rawurlencode($merchantOrderId) . '&return=1',
        'signature' => $signature,
        'expiryPeriod' => 60,
    ];

    $host = $config['environment'] === 'production'
        ? 'https://passport.duitku.com'
        : 'https://sandbox.duitku.com';
    $response = duitkuPostJson($host . '/webapi/api/merchant/v2/inquiry', $params);

    if (($response['statusCode'] ?? '') !== '00') {
        $statusMessage = $response['statusMessage'] ?? $response['Message'] ?? 'Unknown error';
        if (!is_string($statusMessage)) {
            $statusMessage = 'Unknown error';
        }
        $statusMessage = substr(preg_replace('/[\r\n\t]+/', ' ', strip_tags($statusMessage)), 0, 200);
        throw new RuntimeException(
            'Duitku menolak transaksi (status ' . (string)($response['statusCode'] ?? 'unknown') . '): ' . $statusMessage
        );
    }

    if (empty($response['reference'])
        || empty($response['paymentUrl'])
        || filter_var($response['paymentUrl'], FILTER_VALIDATE_URL) === false
        || strtolower((string)parse_url($response['paymentUrl'], PHP_URL_SCHEME)) !== 'https'
    ) {
        throw new RuntimeException('Duitku tidak mengembalikan tautan pembayaran yang valid.');
    }

    return [
        'reference' => (string)$response['reference'],
        'payment_url' => (string)$response['paymentUrl'],
    ];
}

function duitkuPostJson(string $url, array $params): array
{
    $payload = json_encode($params);
    if ($payload === false) {
        throw new RuntimeException('Request Duitku tidak dapat dikodekan.');
    }
    $curl = curl_init($url);
    if ($curl === false) {
        throw new RuntimeException('Tidak dapat memulai koneksi ke Duitku.');
    }

    curl_setopt_array($curl, [
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => $payload,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_HTTPHEADER => ['Content-Type: application/json'],
        CURLOPT_CONNECTTIMEOUT => 5,
        CURLOPT_TIMEOUT => 20,
        CURLOPT_SSL_VERIFYPEER => true,
        CURLOPT_SSL_VERIFYHOST => 2,
    ]);

    $body = curl_exec($curl);
    $httpCode = (int)curl_getinfo($curl, CURLINFO_HTTP_CODE);
    $curlError = curl_error($curl);
    curl_close($curl);

    if ($body === false) {
        throw new RuntimeException('Koneksi Duitku gagal: ' . $curlError);
    }
    if ($httpCode !== 200) {
        $errorResponse = json_decode($body, true);
        $errorMessage = is_array($errorResponse)
            ? ($errorResponse['Message'] ?? $errorResponse['message'] ?? $errorResponse['statusMessage'] ?? '')
            : '';
        if (!is_string($errorMessage)) {
            $errorMessage = '';
        }
        $errorMessage = substr(preg_replace('/[\r\n\t]+/', ' ', strip_tags($errorMessage)), 0, 200);
        $apiKey = duitkuConfig()['api_key'];
        if ($apiKey !== '') {
            $errorMessage = str_replace($apiKey, '[redacted]', $errorMessage);
        }
        throw new RuntimeException(
            'Duitku mengembalikan HTTP ' . $httpCode
            . ($errorMessage !== '' ? ': ' . $errorMessage : '.')
        );
    }

    $response = json_decode($body, true);
    if (!is_array($response)) {
        throw new RuntimeException('Respons Duitku tidak valid.');
    }

    return $response;
}

function duitkuCheckPayment(string $merchantOrderId): array
{
    $config = duitkuConfig();
    if (!duitkuIsConfigured()) {
        throw new RuntimeException('Konfigurasi Duitku belum lengkap.');
    }

    $signature = hash_hmac(
        'sha256',
        $config['merchant_code'] . $merchantOrderId,
        $config['api_key']
    );
    $host = $config['environment'] === 'production'
        ? 'https://passport.duitku.com'
        : 'https://sandbox.duitku.com';

    $response = duitkuPostJson($host . '/webapi/api/merchant/transactionStatus', [
        'merchantCode' => $config['merchant_code'],
        'merchantOrderId' => $merchantOrderId,
        'signature' => $signature,
    ]);
    if (!isset($response['merchantOrderId'])
        || !is_string($response['merchantOrderId'])
        || !hash_equals($merchantOrderId, $response['merchantOrderId'])
    ) {
        throw new RuntimeException('Respons pemeriksaan transaksi Duitku tidak cocok.');
    }

    return $response;
}
