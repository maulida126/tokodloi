-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 26, 2026 at 07:44 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_tokoku`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_cabang`
--

CREATE TABLE `tbl_cabang` (
  `id_cabang` int(11) NOT NULL,
  `nama_cabang` varchar(100) DEFAULT NULL,
  `kota` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_cabang`
--

INSERT INTO `tbl_cabang` (`id_cabang`, `nama_cabang`, `kota`) VALUES
(1, 'Cabang Utama', 'Ponorogo'),
(2, 'Cabang Timur', 'Madiun'),
(3, 'Cabang Barat', 'Magetan'),
(4, 'Cabang Selatan', 'Pacitan');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_detail_transaksi`
--

CREATE TABLE `tbl_detail_transaksi` (
  `id_detail` int(11) NOT NULL,
  `id_transaksi` int(11) DEFAULT NULL,
  `nama_produk` varchar(100) DEFAULT NULL,
  `barcode` varchar(32) DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `harga` decimal(12,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_detail_transaksi`
--

INSERT INTO `tbl_detail_transaksi` (`id_detail`, `id_transaksi`, `nama_produk`, `barcode`, `jumlah`, `harga`) VALUES
(1, 1, 'Buku Tulis', 'TK00000001', 5, 5000.00),
(2, 1, 'Pulpen', 'TK00000006', 2, 3000.00),
(3, 2, 'Pensil', 'TK00000005', 10, 2000.00),
(4, 2, 'Penghapus', 'TK00000003', 5, 3000.00),
(5, 3, 'Buku Gambar', 'TK00000002', 3, 10000.00),
(6, 4, 'Tas Sekolah', 'TK00000008', 2, 250000.00),
(7, 5, 'Buku Tulis', 'TK00000001', 4, 5000.00),
(8, 6, 'Pulpen', 'TK00000006', 10, 3000.00),
(9, 7, 'Sepatu', 'TK00000007', 1, 450000.00),
(10, 8, 'Pensil', 'TK00000005', 5, 2000.00),
(11, 9, 'Buku Gambar', 'TK00000002', 2, 10000.00),
(12, 10, 'Tas Sekolah', 'TK00000008', 1, 275000.00),
(13, 11, 'Penggaris', 'TK00000004', 5, 5000.00),
(14, 12, 'Pulpen', 'TK00000006', 5, 3000.00),
(15, 13, 'Buku Tulis', 'TK00000001', 6, 5000.00),
(16, 14, 'Pensil', 'TK00000005', 10, 2000.00),
(17, 15, 'Sepatu', 'TK00000007', 1, 275000.00),
(18, 16, 'Tas Sekolah', 'TK00000008', 1, 350000.00),
(19, 17, 'Penghapus', 'TK00000003', 10, 2000.00),
(20, 18, 'Buku Gambar', 'TK00000002', 3, 10000.00),
(21, 19, 'Pulpen', 'TK00000006', 5, 3500.00),
(22, 20, 'Tas Sekolah', 'TK00000008', 2, 250000.00),
(23, 25, 'Buku Tulis', 'TK00000001', 1, 5000.00),
(24, 25, 'Buku Gambar', 'TK00000002', 1, 10000.00),
(25, 25, 'Penghapus', 'TK00000003', 1, 2000.00),
(26, 25, 'Penggaris', 'TK00000004', 1, 5000.00),
(27, 25, 'Pensil', 'TK00000005', 1, 2000.00),
(28, 25, 'Pulpen', 'TK00000006', 1, 3000.00),
(29, 25, 'Sepatu', 'TK00000007', 1, 275000.00),
(30, 25, 'Tas Sekolah', 'TK00000008', 1, 250000.00),
(31, 26, 'Sepatu', 'TK00000007', 1, 275000.00),
(32, 26, 'Tas Sekolah', 'TK00000008', 1, 250000.00),
(33, 27, 'Buku Tulis', 'TK00000001', 1, 5000.00),
(34, 27, 'Buku Gambar', 'TK00000002', 1, 10000.00),
(35, 27, 'Penggaris', 'TK00000004', 1, 5000.00),
(36, 27, 'Sepatu', 'TK00000007', 1, 275000.00),
(37, 27, 'Tas Sekolah', 'TK00000008', 1, 250000.00),
(38, 28, 'Buku Tulis', 'TK00000001', 1, 5000.00),
(39, 28, 'Buku Gambar', 'TK00000002', 4, 10000.00),
(40, 29, 'Pulpen', 'TK00000006', 1, 3000.00),
(41, 30, 'Sepatu', 'TK00000007', 1, 275000.00),
(42, 31, 'Sepatu', 'TK00000007', 1, 275000.00),
(43, 31, 'Tas Sekolah', 'TK00000008', 1, 250000.00),
(44, 32, 'Buku Tulis', 'TK00000001', 1, 5000.00),
(45, 32, 'Buku Gambar', 'TK00000002', 1, 10000.00),
(46, 32, 'Penggaris', 'TK00000004', 1, 5000.00),
(47, 33, 'Sepatu', 'TK00000007', 4, 275000.00),
(48, 34, 'Penggaris', 'TK00000004', 1, 5000.00),
(49, 34, 'Pensil', 'TK00000005', 1, 2000.00),
(50, 34, 'Pulpen', 'TK00000006', 1, 3000.00),
(51, 35, 'Buku Gambar', 'TK00000002', 3, 10000.00),
(52, 36, 'Pulpen', 'TK00000006', 4, 3000.00),
(53, 37, 'Buku Tulis', 'TK00000001', 1, 5000.00),
(54, 38, 'Buku Tulis', 'TK00000001', 1, 5000.00),
(56, 40, 'Penggaris', 'TK00000004', 1, 5000.00),
(57, 40, 'Sepatu', 'TK00000007', 1, 275000.00),
(58, 41, 'Penggaris', 'TK00000004', 1, 5000.00),
(59, 41, 'Sepatu', 'TK00000007', 1, 275000.00),
(60, 42, 'Buku Tulis', 'TK00000001', 1, 5000.00),
(61, 43, 'Buku Tulis', 'TK00000001', 1, 5000.00),
(62, 44, 'Buku Tulis', 'TK00000001', 1, 5000.00),
(63, 45, 'Buku Tulis', 'TK00000001', 1, 5000.00),
(64, 46, 'Buku Tulis', 'TK00000001', 1, 5000.00),
(65, 47, 'Buku Tulis', 'TK00000001', 1, 5000.00),
(66, 48, 'Buku Tulis', 'TK00000001', 1, 5000.00),
(67, 49, 'Buku Tulis', 'TK00000001', 1, 5000.00),
(68, 50, 'Buku Tulis', 'TK00000001', 1, 5000.00),
(69, 51, 'Buku Tulis', 'TK00000001', 1, 5000.00),
(70, 52, 'Pulpen', 'TK00000006', 1, 3000.00),
(71, 53, 'Pulpen', 'TK00000006', 1, 3000.00),
(72, 54, 'Pulpen', 'TK00000006', 1, 3000.00),
(75, 56, 'Sepatu', 'TK00000007', 1, 275000.00),
(76, 57, 'Sepatu', 'TK00000007', 1, 275000.00),
(78, 59, 'Tas Sekolah', 'TK00000008', 2, 250000.00),
(79, 60, 'Sepatu', 'TK00000007', 1, 275000.00),
(80, 61, 'Sepatu', 'TK00000007', 1, 275000.00),
(81, 61, 'Tas Sekolah', 'TK00000008', 1, 250000.00),
(82, 62, 'Sepatu', 'TK00000007', 2, 275000.00);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_pelanggan`
--

CREATE TABLE `tbl_pelanggan` (
  `id_pelanggan` int(11) NOT NULL,
  `nama_pelanggan` varchar(100) DEFAULT NULL,
  `kota` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_pelanggan`
--

INSERT INTO `tbl_pelanggan` (`id_pelanggan`, `nama_pelanggan`, `kota`) VALUES
(1, 'Andi', 'Ponorogo'),
(2, 'Budi', 'Madiun'),
(3, 'Citra', 'Surabaya'),
(4, 'Andi', 'Ponorogo'),
(5, 'Budi', 'Madiun'),
(6, 'Citra', 'Surabaya'),
(7, 'Dewi', 'Malang'),
(8, 'Eko', 'Kediri'),
(9, 'Fajar', 'Jombang'),
(10, 'Gita', 'Nganjuk'),
(11, 'Hani', 'Magetan'),
(12, 'Indra', 'Ngawi'),
(13, 'Joko', 'Pacitan'),
(14, 'Dewi', 'Ponorogo'),
(15, 'nanalu', 'ponorogo');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_produk`
--

CREATE TABLE `tbl_produk` (
  `id_produk` int(11) NOT NULL,
  `nama_produk` varchar(100) NOT NULL,
  `harga` decimal(12,2) NOT NULL,
  `stok` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `gambar` varchar(255) DEFAULT NULL,
  `aktif` tinyint(1) NOT NULL DEFAULT 1,
  `barcode` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_produk`
--

INSERT INTO `tbl_produk` (`id_produk`, `nama_produk`, `harga`, `stok`, `gambar`, `aktif`, `barcode`) VALUES
(1, 'Buku Tulis', 5000.00, 9, 'assets/product-images/476557003be3ef96efeaa8412ca6ca1e.jpg', 1, 'TK00000001'),
(2, 'Buku Gambar', 10000.00, 13, 'assets/product-images/7bbc5bdaf33e431a647f826e3173c440.jpg', 1, 'TK00000002'),
(3, 'Penghapus', 2000.00, 18, 'assets/product-images/e78416abc822990fd2d4489a425691b0.jpg', 1, 'TK00000003'),
(4, 'Penggaris', 5000.00, 9, 'assets/product-images/1049bc1e4f153402a26d5c8d8c3247ee.jpg', 1, 'TK00000004'),
(5, 'Pensil', 2000.00, 11, 'assets/product-images/4e88b2f9b9d57fb62048756f18024bb4.jpg', 1, 'TK00000005'),
(6, 'Pulpen', 3000.00, 3, 'assets/product-images/ecef1f211d70bb3df5aa2fac0a049c0e.jpg', 1, 'TK00000006'),
(7, 'Sepatu', 275000.00, 4, 'assets/product-images/d9d928624dea268bfba440f8a4a1a234.jpg', 1, 'TK00000007'),
(8, 'Tas Sekolah', 250000.00, 2, 'assets/product-images/3b00e8ec355069044946c8ad8baff7ac.jpg', 1, 'TK00000008');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_transaksi`
--

CREATE TABLE `tbl_transaksi` (
  `id_transaksi` int(11) NOT NULL,
  `tanggal` date DEFAULT NULL,
  `id_pelanggan` int(11) DEFAULT NULL,
  `id_user` int(11) DEFAULT NULL,
  `total_belanja` decimal(12,2) DEFAULT NULL,
  `metode_pembayaran` enum('tunai','transfer','qris','duitku') NOT NULL DEFAULT 'tunai',
  `status_pembayaran` enum('menunggu_verifikasi','terverifikasi') NOT NULL DEFAULT 'terverifikasi',
  `diverifikasi_oleh` int(11) DEFAULT NULL,
  `diverifikasi_pada` datetime DEFAULT NULL,
  `persentase_pajak` decimal(5,2) NOT NULL DEFAULT 0.00,
  `total_pajak` decimal(12,2) NOT NULL DEFAULT 0.00,
  `duitku_order_id` varchar(50) DEFAULT NULL,
  `duitku_reference` varchar(255) DEFAULT NULL,
  `duitku_payment_url` varchar(1000) DEFAULT NULL,
  `duitku_payment_method` char(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_transaksi`
--

INSERT INTO `tbl_transaksi` (`id_transaksi`, `tanggal`, `id_pelanggan`, `id_user`, `total_belanja`, `metode_pembayaran`, `status_pembayaran`, `diverifikasi_oleh`, `diverifikasi_pada`, `persentase_pajak`, `total_pajak`, `duitku_order_id`, `duitku_reference`, `duitku_payment_url`, `duitku_payment_method`) VALUES
(1, '2026-10-01', 1, NULL, 250000.00, 'tunai', 'terverifikasi', NULL, NULL, 0.00, 0.00, NULL, NULL, NULL, NULL),
(2, '2026-10-02', 2, NULL, 350000.00, 'tunai', 'terverifikasi', NULL, NULL, 0.00, 0.00, NULL, NULL, NULL, NULL),
(3, '2026-10-03', 1, NULL, 150000.00, 'tunai', 'terverifikasi', NULL, NULL, 0.00, 0.00, NULL, NULL, NULL, NULL),
(4, '2026-10-04', 3, NULL, 500000.00, 'tunai', 'terverifikasi', NULL, NULL, 0.00, 0.00, NULL, NULL, NULL, NULL),
(5, '2026-10-01', 1, NULL, 250000.00, 'tunai', 'terverifikasi', NULL, NULL, 0.00, 0.00, NULL, NULL, NULL, NULL),
(6, '2026-10-02', 2, NULL, 350000.00, 'tunai', 'terverifikasi', NULL, NULL, 0.00, 0.00, NULL, NULL, NULL, NULL),
(7, '2026-10-03', 1, NULL, 150000.00, 'tunai', 'terverifikasi', NULL, NULL, 0.00, 0.00, NULL, NULL, NULL, NULL),
(8, '2026-10-04', 3, NULL, 500000.00, 'tunai', 'terverifikasi', NULL, NULL, 0.00, 0.00, NULL, NULL, NULL, NULL),
(9, '2026-10-05', 4, NULL, 200000.00, 'tunai', 'terverifikasi', NULL, NULL, 0.00, 0.00, NULL, NULL, NULL, NULL),
(10, '2026-10-06', 5, NULL, 300000.00, 'tunai', 'terverifikasi', NULL, NULL, 0.00, 0.00, NULL, NULL, NULL, NULL),
(11, '2026-10-07', 6, NULL, 450000.00, 'tunai', 'terverifikasi', NULL, NULL, 0.00, 0.00, NULL, NULL, NULL, NULL),
(12, '2026-10-08', 7, NULL, 175000.00, 'tunai', 'terverifikasi', NULL, NULL, 0.00, 0.00, NULL, NULL, NULL, NULL),
(13, '2026-10-09', 8, NULL, 225000.00, 'tunai', 'terverifikasi', NULL, NULL, 0.00, 0.00, NULL, NULL, NULL, NULL),
(14, '2026-10-10', 9, NULL, 400000.00, 'tunai', 'terverifikasi', NULL, NULL, 0.00, 0.00, NULL, NULL, NULL, NULL),
(15, '2026-10-11', 10, NULL, 275000.00, 'tunai', 'terverifikasi', NULL, NULL, 0.00, 0.00, NULL, NULL, NULL, NULL),
(16, '2026-10-12', 2, NULL, 125000.00, 'tunai', 'terverifikasi', NULL, NULL, 0.00, 0.00, NULL, NULL, NULL, NULL),
(17, '2026-10-13', 3, NULL, 325000.00, 'tunai', 'terverifikasi', NULL, NULL, 0.00, 0.00, NULL, NULL, NULL, NULL),
(18, '2026-10-14', 4, NULL, 150000.00, 'tunai', 'terverifikasi', NULL, NULL, 0.00, 0.00, NULL, NULL, NULL, NULL),
(19, '2026-10-15', 5, NULL, 275000.00, 'tunai', 'terverifikasi', NULL, NULL, 0.00, 0.00, NULL, NULL, NULL, NULL),
(20, '2026-10-16', 6, NULL, 350000.00, 'tunai', 'terverifikasi', NULL, NULL, 0.00, 0.00, NULL, NULL, NULL, NULL),
(21, '2026-10-17', 7, NULL, 200000.00, 'tunai', 'terverifikasi', NULL, NULL, 0.00, 0.00, NULL, NULL, NULL, NULL),
(22, '2026-10-18', 8, NULL, 300000.00, 'tunai', 'terverifikasi', NULL, NULL, 0.00, 0.00, NULL, NULL, NULL, NULL),
(23, '2026-10-19', 9, NULL, 175000.00, 'tunai', 'terverifikasi', NULL, NULL, 0.00, 0.00, NULL, NULL, NULL, NULL),
(24, '2026-10-20', 10, NULL, 500000.00, 'tunai', 'terverifikasi', NULL, NULL, 0.00, 0.00, NULL, NULL, NULL, NULL),
(25, '2026-11-23', 15, NULL, 552000.00, 'tunai', 'terverifikasi', NULL, NULL, 0.00, 0.00, NULL, NULL, NULL, NULL),
(26, '2026-11-23', 15, NULL, 525000.00, 'tunai', 'terverifikasi', NULL, NULL, 0.00, 0.00, NULL, NULL, NULL, NULL),
(27, '2026-11-23', 15, NULL, 604950.00, 'tunai', 'terverifikasi', NULL, NULL, 11.00, 59950.00, NULL, NULL, NULL, NULL),
(28, '2026-11-23', 15, NULL, 49950.00, 'qris', 'terverifikasi', NULL, NULL, 11.00, 4950.00, NULL, NULL, NULL, NULL),
(29, '2026-11-23', 4, NULL, 3330.00, 'qris', 'terverifikasi', NULL, NULL, 11.00, 330.00, NULL, NULL, NULL, NULL),
(30, '2026-11-23', 15, NULL, 305250.00, 'tunai', 'terverifikasi', NULL, NULL, 11.00, 30250.00, NULL, NULL, NULL, NULL),
(31, '2026-11-23', 12, NULL, 582750.00, 'tunai', 'terverifikasi', NULL, NULL, 11.00, 57750.00, NULL, NULL, NULL, NULL),
(32, '2026-11-25', 4, 3, 22200.00, 'tunai', 'terverifikasi', NULL, NULL, 11.00, 2200.00, NULL, NULL, NULL, NULL),
(33, '2026-11-25', 15, 3, 1221000.00, 'tunai', 'terverifikasi', NULL, NULL, 11.00, 121000.00, NULL, NULL, NULL, NULL),
(34, '2026-11-25', 11, 3, 11100.00, 'tunai', 'terverifikasi', NULL, NULL, 11.00, 1100.00, NULL, NULL, NULL, NULL),
(35, '2026-11-25', 15, NULL, 33300.00, 'qris', 'terverifikasi', NULL, NULL, 11.00, 3300.00, NULL, NULL, NULL, NULL),
(36, '2026-11-25', 15, 1, 13320.00, 'qris', 'terverifikasi', 1, '2026-11-25 13:07:00', 11.00, 1320.00, NULL, NULL, NULL, NULL),
(37, '2026-11-26', 15, 1, 5550.00, 'qris', 'terverifikasi', 1, '2026-11-26 08:32:39', 11.00, 550.00, NULL, NULL, NULL, NULL),
(38, '2026-11-26', 15, 1, 5550.00, 'qris', 'terverifikasi', 1, '2026-11-26 08:49:09', 11.00, 550.00, NULL, NULL, NULL, NULL),
(40, '2026-11-26', 15, NULL, 310800.00, 'duitku', 'menunggu_verifikasi', NULL, NULL, 11.00, 30800.00, 'TK202611260345100000000040', 'DS3858726BAK4Q6MCKINKGBW', 'https://sandbox.duitku.com/topup/topupdirectv2.aspx?ref=SP26TEWHDE56SQQDVIV', NULL),
(41, '2026-11-26', 15, NULL, 310800.00, 'duitku', 'menunggu_verifikasi', NULL, NULL, 11.00, 30800.00, 'TK202611260345120000000041', 'DS3858726BQHQ4JVPEUZ4KHF', 'https://sandbox.duitku.com/topup/topupdirectv2.aspx?ref=SP26M1TG7ITND5D1DWD', NULL),
(42, '2026-11-26', 15, NULL, 5550.00, 'duitku', 'menunggu_verifikasi', NULL, NULL, 11.00, 550.00, 'TK202611260414460000000042', 'DS3858726UHJCSUCJCIOMC5J', 'https://sandbox.duitku.com/topup/topupdirectv2.aspx?ref=SP26VQBW3PT6ITQ5TGT', NULL),
(43, '2026-11-26', 15, NULL, 5550.00, 'duitku', 'menunggu_verifikasi', NULL, NULL, 11.00, 550.00, 'TK202611260414480000000043', 'DS385872684F5LGB0KMXZ7IH', 'https://sandbox.duitku.com/topup/topupdirectv2.aspx?ref=SP26MJAEMFCTRYQJW3B', NULL),
(44, '2026-11-26', 15, NULL, 5550.00, 'duitku', 'menunggu_verifikasi', NULL, NULL, 11.00, 550.00, 'TK202611260414500000000044', 'DS3858726R2KF7W45VUX2FMF', 'https://sandbox.duitku.com/topup/topupdirectv2.aspx?ref=SP26558XVXICQBVO0QY', NULL),
(45, '2026-11-26', 15, NULL, 5550.00, 'duitku', 'menunggu_verifikasi', NULL, NULL, 11.00, 550.00, 'TK202611260414550000000045', 'DS3858726RMIBBBA313TP73G', 'https://sandbox.duitku.com/topup/topupdirectv2.aspx?ref=SP26GXOZDH4ETE31A8T', NULL),
(46, '2026-11-26', 15, NULL, 5550.00, 'duitku', 'menunggu_verifikasi', NULL, NULL, 11.00, 550.00, 'TK202611260414570000000046', 'DS3858726ISVCNPVGU7UJSTE', 'https://sandbox.duitku.com/topup/topupdirectv2.aspx?ref=SP26D1HXDQU5PX5XVQF', NULL),
(47, '2026-11-26', 15, NULL, 5550.00, 'duitku', 'menunggu_verifikasi', NULL, NULL, 11.00, 550.00, 'TK202611260414590000000047', 'DS3858726WU8Q4SAVYKZBOSM', 'https://sandbox.duitku.com/topup/topupdirectv2.aspx?ref=SP26VQ3S6PI6CD2Z374', NULL),
(48, '2026-11-26', 15, NULL, 5550.00, 'duitku', 'menunggu_verifikasi', NULL, NULL, 11.00, 550.00, 'TK202611260415010000000048', 'DS3858726GH6D25MNJN841FU', 'https://sandbox.duitku.com/topup/topupdirectv2.aspx?ref=SP26SCUDDDZQSRTZ8M6', NULL),
(49, '2026-11-26', 15, NULL, 5550.00, 'duitku', 'menunggu_verifikasi', NULL, NULL, 11.00, 550.00, 'TK202611260415050000000049', 'DS3858726D1L50067XINB8AM', 'https://sandbox.duitku.com/topup/topupdirectv2.aspx?ref=SP263ZOWU5ZCE4T4FBH', NULL),
(50, '2026-11-26', 15, NULL, 5550.00, 'duitku', 'menunggu_verifikasi', NULL, NULL, 11.00, 550.00, 'TK202611260415100000000050', 'DS3858726HI4IVDFLTZBY0C4', 'https://sandbox.duitku.com/topup/topupdirectv2.aspx?ref=SP26JUNGGJG34712TNG', NULL),
(51, '2026-11-26', 15, NULL, 5550.00, 'duitku', 'menunggu_verifikasi', NULL, NULL, 11.00, 550.00, 'TK202611260415130000000051', 'DS3858726F6MKY6C4APK8GAT', 'https://sandbox.duitku.com/topup/topupdirectv2.aspx?ref=SP26RWOB7X46SY44AFF', NULL),
(52, '2026-11-26', 15, NULL, 3330.00, 'duitku', 'menunggu_verifikasi', NULL, NULL, 11.00, 330.00, 'TK202611260419110000000052', 'DS3858726V05UPJMZRJQ6AC8', 'https://sandbox.duitku.com/topup/topupdirectv2.aspx?ref=SP26K31UMFAY07BC20H', NULL),
(53, '2026-11-26', 15, NULL, 3330.00, 'duitku', 'menunggu_verifikasi', NULL, NULL, 11.00, 330.00, 'TK202611260419130000000053', 'DS3858726WN6RUWQ64ZD1ACJ', 'https://sandbox.duitku.com/topup/topupdirectv2.aspx?ref=SP26DGY6N5QDDSOX3RL', NULL),
(54, '2026-11-26', 15, NULL, 3330.00, 'duitku', 'terverifikasi', NULL, '2026-11-26 10:20:18', 11.00, 330.00, 'TK202611260419160000000054', 'DS3858726V4JBKIGYD7F2HND', 'https://sandbox.duitku.com/topup/topupdirectv2.aspx?ref=SP26N6D012Q4P4DEDEQ', NULL),
(56, '2026-11-26', 15, NULL, 305250.00, 'duitku', 'menunggu_verifikasi', NULL, NULL, 11.00, 30250.00, 'TK202611260518030000000056', 'DS3858726S2UT8KD0SPFMTWR', 'https://sandbox.duitku.com/topup/topupdirectv2.aspx?ref=BR26TYFPL1PY1FKO031', 'BR'),
(57, '2026-11-26', 15, NULL, 305250.00, 'duitku', 'terverifikasi', NULL, '2026-11-26 11:20:59', 11.00, 30250.00, 'TK202611260519590000000057', 'DS3858726I6RZOW7JDZEMHYK', 'https://sandbox.duitku.com/topup/topupdirectv2.aspx?ref=BR267GC415YQWLWWUZI', 'BR'),
(59, '2026-11-26', 15, NULL, 555000.00, 'duitku', 'terverifikasi', NULL, '2026-11-26 12:37:43', 11.00, 55000.00, 'TK202611260635570000000059', 'DS38587263XL2U5SH7M7YA7H', 'https://sandbox.duitku.com/topup/topupdirectv2.aspx?ref=BR26JTQP4Q7WVAHPSWR', 'BR'),
(60, '2026-11-26', 15, NULL, 305250.00, 'duitku', 'terverifikasi', NULL, '2026-11-26 12:38:42', 11.00, 30250.00, 'TK202611260638080000000060', 'DS3858726QSW8S815T7VL53Y', 'https://sandbox.duitku.com/topup/topupdirectv2.aspx?ref=BR26AKRKLGJ4W0LH3UC', 'BR'),
(61, '2026-11-26', 15, NULL, 582750.00, 'duitku', 'terverifikasi', NULL, '2026-11-26 13:02:30', 11.00, 57750.00, 'TK202611260700520000000061', 'DS38587261MO1XAEXAD2F07H', 'https://sandbox.duitku.com/topup/topupdirectv2.aspx?ref=BR262C8WRF4GNAF2J22', 'BR'),
(62, '2026-11-26', 15, NULL, 610500.00, 'duitku', 'terverifikasi', NULL, '2026-11-26 13:21:50', 11.00, 60500.00, 'TK202611260720450000000062', 'DS3858726QGAPQM08CTY2I4I', 'https://sandbox.duitku.com/topup/topupdirectv2.aspx?ref=I1265QK2PF360MQTWY8', 'I1');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user`
--

CREATE TABLE `tbl_user` (
  `id_user` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','kasir','pelanggan') NOT NULL DEFAULT 'pelanggan',
  `id_pelanggan` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_user`
--

INSERT INTO `tbl_user` (`id_user`, `nama`, `username`, `password`, `role`, `id_pelanggan`, `created_at`) VALUES
(1, 'Administrator', 'admin', '$2y$10$PKteaysSbOSRA41UZkCKt.bvEzRdJae78562OE1J0w8heb60VYT82', 'admin', NULL, '2026-11-23 04:26:32'),
(2, 'nanalu', 'nanalu', '$2y$10$Rm.gUEgFcXXx6u7ELKi4guOfRKQlsJrm49haf2tQ0GuQdH.Qi7hp6', 'pelanggan', 15, '2026-11-23 04:34:34'),
(3, 'maulida', 'maulida', '$2y$10$k/aQDzpcaOrDe6vNvWORAex2qCT525NXN.bm857bkWTkThnEd4bnq', 'kasir', NULL, '2026-11-23 04:34:55'),
(4, 'kasir2', 'kasir2', '$2y$10$hPF.yfdEO/BVGy8CA4tGzu/sj1clQ0wg9fvZdjeNWjlxoYfS/376u', 'kasir', NULL, '2026-11-25 03:33:40');

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_pelanggan`
-- (See below for the actual view)
--
CREATE TABLE `view_pelanggan` (
`id_pelanggan` int(11)
,`nama_pelanggan` varchar(100)
,`kota` varchar(50)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_total_belanja`
-- (See below for the actual view)
--
CREATE TABLE `view_total_belanja` (
`id_pelanggan` int(11)
,`nama_pelanggan` varchar(100)
,`total_transaksi` bigint(21)
,`total_belanja` decimal(34,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_transaksi_pelanggan`
-- (See below for the actual view)
--
CREATE TABLE `view_transaksi_pelanggan` (
`id_transaksi` int(11)
,`tanggal` date
,`nama_pelanggan` varchar(100)
,`kota` varchar(50)
,`total_belanja` decimal(12,2)
);

-- --------------------------------------------------------

--
-- Structure for view `view_pelanggan`
--
DROP TABLE IF EXISTS `view_pelanggan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_pelanggan`  AS SELECT `tbl_pelanggan`.`id_pelanggan` AS `id_pelanggan`, `tbl_pelanggan`.`nama_pelanggan` AS `nama_pelanggan`, `tbl_pelanggan`.`kota` AS `kota` FROM `tbl_pelanggan` ;

-- --------------------------------------------------------

--
-- Structure for view `view_total_belanja`
--
DROP TABLE IF EXISTS `view_total_belanja`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_total_belanja`  AS SELECT `p`.`id_pelanggan` AS `id_pelanggan`, `p`.`nama_pelanggan` AS `nama_pelanggan`, count(`t`.`id_transaksi`) AS `total_transaksi`, coalesce(sum(`t`.`total_belanja`),0) AS `total_belanja` FROM (`tbl_pelanggan` `p` left join `tbl_transaksi` `t` on(`p`.`id_pelanggan` = `t`.`id_pelanggan`)) GROUP BY `p`.`id_pelanggan`, `p`.`nama_pelanggan` ;

-- --------------------------------------------------------

--
-- Structure for view `view_transaksi_pelanggan`
--
DROP TABLE IF EXISTS `view_transaksi_pelanggan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_transaksi_pelanggan`  AS SELECT `t`.`id_transaksi` AS `id_transaksi`, `t`.`tanggal` AS `tanggal`, `p`.`nama_pelanggan` AS `nama_pelanggan`, `p`.`kota` AS `kota`, `t`.`total_belanja` AS `total_belanja` FROM (`tbl_transaksi` `t` join `tbl_pelanggan` `p` on(`t`.`id_pelanggan` = `p`.`id_pelanggan`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_cabang`
--
ALTER TABLE `tbl_cabang`
  ADD PRIMARY KEY (`id_cabang`);

--
-- Indexes for table `tbl_detail_transaksi`
--
ALTER TABLE `tbl_detail_transaksi`
  ADD PRIMARY KEY (`id_detail`),
  ADD KEY `id_transaksi` (`id_transaksi`);

--
-- Indexes for table `tbl_pelanggan`
--
ALTER TABLE `tbl_pelanggan`
  ADD PRIMARY KEY (`id_pelanggan`);

--
-- Indexes for table `tbl_produk`
--
ALTER TABLE `tbl_produk`
  ADD PRIMARY KEY (`id_produk`),
  ADD UNIQUE KEY `uq_tbl_produk_nama` (`nama_produk`),
  ADD UNIQUE KEY `uq_tbl_produk_barcode` (`barcode`);

--
-- Indexes for table `tbl_transaksi`
--
ALTER TABLE `tbl_transaksi`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD UNIQUE KEY `uq_transaksi_duitku_order_id` (`duitku_order_id`),
  ADD KEY `id_pelanggan` (`id_pelanggan`),
  ADD KEY `fk_transaksi_kasir` (`id_user`);

--
-- Indexes for table `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `uq_tbl_user_id_pelanggan` (`id_pelanggan`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_cabang`
--
ALTER TABLE `tbl_cabang`
  MODIFY `id_cabang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_detail_transaksi`
--
ALTER TABLE `tbl_detail_transaksi`
  MODIFY `id_detail` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT for table `tbl_pelanggan`
--
ALTER TABLE `tbl_pelanggan`
  MODIFY `id_pelanggan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `tbl_produk`
--
ALTER TABLE `tbl_produk`
  MODIFY `id_produk` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tbl_transaksi`
--
ALTER TABLE `tbl_transaksi`
  MODIFY `id_transaksi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_detail_transaksi`
--
ALTER TABLE `tbl_detail_transaksi`
  ADD CONSTRAINT `tbl_detail_transaksi_ibfk_1` FOREIGN KEY (`id_transaksi`) REFERENCES `tbl_transaksi` (`id_transaksi`);

--
-- Constraints for table `tbl_transaksi`
--
ALTER TABLE `tbl_transaksi`
  ADD CONSTRAINT `fk_transaksi_kasir` FOREIGN KEY (`id_user`) REFERENCES `tbl_user` (`id_user`) ON DELETE SET NULL,
  ADD CONSTRAINT `tbl_transaksi_ibfk_1` FOREIGN KEY (`id_pelanggan`) REFERENCES `tbl_pelanggan` (`id_pelanggan`);

--
-- Constraints for table `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD CONSTRAINT `fk_tbl_user_pelanggan` FOREIGN KEY (`id_pelanggan`) REFERENCES `tbl_pelanggan` (`id_pelanggan`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
