ALTER TABLE tbl_transaksi
    MODIFY COLUMN metode_pembayaran
        ENUM('tunai', 'transfer', 'qris', 'duitku') NOT NULL DEFAULT 'tunai',
    ADD COLUMN duitku_order_id VARCHAR(50) NULL,
    ADD COLUMN duitku_reference VARCHAR(255) NULL,
    ADD COLUMN duitku_payment_url VARCHAR(1000) NULL,
    ADD COLUMN duitku_payment_method CHAR(2) NULL,
    ADD UNIQUE KEY uq_transaksi_duitku_order_id (duitku_order_id);
