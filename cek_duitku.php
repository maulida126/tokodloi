<?php

echo "API KEY: ";
echo getenv('DUITKU_API_KEY') ? 'TERBACA' : 'TIDAK TERBACA';

echo "<br>BASE URL: ";
echo getenv('DUITKU_BASE_URL') ?: 'TIDAK TERBACA';