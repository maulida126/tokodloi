<?php

require_once __DIR__ . '/duitku.php';

header('Content-Type: text/plain; charset=UTF-8');
echo 'Duitku gateway: ' . (duitkuIsConfigured() ? 'SIAP' : 'BELUM SIAP') . PHP_EOL;