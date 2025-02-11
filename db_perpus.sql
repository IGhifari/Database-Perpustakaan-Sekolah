-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 11, 2025 at 02:57 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_perpus`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `DaftarBukuLengkap` ()   BEGIN
    SELECT b.Id_Buku, b.JudulBuku, b.Penulis, b.Kategori, b.Stok
    FROM buku b
    LEFT JOIN peminjaman p ON b.Id_Buku = p.Id_Buku
    WHERE p.Id_Buku IS NULL OR p.status IN ('Dipinjam', 'Dikembalikan');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DaftarSiswaLengkap` ()   BEGIN
    SELECT s.Id_Siswa, s.Nama, s.Kelas
    FROM siswa s
    LEFT JOIN peminjaman p ON s.Id_Siswa = p.Id_Siswa
    WHERE p.Id_Siswa IS NULL OR p.Status IN ('Dipinjam', 'Dikembalikan');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DaftarSiswaPeminjam` ()   BEGIN
    SELECT DISTINCT s.Id_Siswa, s.Nama, s.Kelas
    FROM siswa s
    JOIN peminjaman p ON s.Id_Siswa = p.Id_Siswa
    WHERE p.Status IN ('Dipinjam', 'Dikembalikan');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteBuku` (IN `Id_BukuBaru` INT)   BEGIN
	DELETE FROM buku WHERE Id_Buku = Id_BukuBaru;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeletePeminjaman` (IN `Id_PeminjamanBaru` INT)   BEGIN
	DELETE FROM peminjaman WHERE Id_Peminjaman = Id_PeminjamanBaru;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteSiswa` (IN `Id_SiswaBaru` INT)   BEGIN
	DELETE FROM siswa WHERE Id_Siswa = Id_SiswaBaru;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertBuku` (IN `JudulBukuBaru` VARCHAR(50), IN `PenulisBaru` VARCHAR(20), IN `KategoriBaru` VARCHAR(20), IN `StokBaru` INT)   BEGIN
	INSERT INTO buku(JudulBuku,Penulis,Kategori,Stok) VALUES(JudulBukuBaru,PenulisBaru,KategoriBaru,StokBaru);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertPeminjaman` (IN `Id_SiswaBaru` INT, IN `Id_BukuBaru` INT, IN `TanggalPinjamBaru` DATE, IN `TanggalKembaliBaru` DATE, IN `StatusBaru` ENUM("Dipinjam",'Dikembalikan'))   BEGIN
	INSERT INTO peminjaman(Id_Siswa,Id_Buku,TanggalPinjam,TanggalKembali,Status) VALUES(Id_SiswaBaru,Id_BukuBaru,TanggalPinjamBaru,TanggalKembaliBaru,StatusBaru);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertSiswa` (IN `NamaBaru` VARCHAR(50), IN `KelasBaru` VARCHAR(15))   BEGIN
	INSERT INTO siswa(Nama,Kelas) VALUES(NamaBaru,KelasBaru);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `KembalikanBuku` (IN `p_id_peminjaman` INT)   BEGIN
    UPDATE peminjaman 
    SET TanggalKembali = CURRENT_DATE, status = 'Dikembalikan'
    WHERE Id_Peminjaman = p_id_peminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectBuku` ()   BEGIN
 SELECT * FROM buku;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectPeminjaman` ()   BEGIN
 SELECT * FROM peminjaman;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectSiswa` ()   BEGIN
 SELECT * FROM siswa;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateBuku` (IN `Id_BukuBaru` INT, IN `JudulBukuBaru` VARCHAR(50), IN `PenulisBaru` VARCHAR(20), IN `KategoriBaru` VARCHAR(20), IN `StokBaru` INT)   BEGIN
	UPDATE buku SET JudulBuku=JudulBukuBaru,Penulis=PenulisBaru,Kategori=KategoriBaru,Stok=StokBaru WHERE Id_Buku = Id_BukuBaru;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdatePeminjaman` (IN `Id_PeminjamanBaru` INT, IN `Id_SiswaBaru` INT, IN `Id_BukuBaru` INT, IN `TanggalPinjamBaru` DATE, IN `TanggalKembaliBaru` DATE, IN `StatusBaru` ENUM("Dipinjam","Dikembalikan"))   BEGIN
	UPDATE peminjaman SET Id_Siswa=Id_SiswaBaru, Id_Buku=Id_BukuBaru, TanggalPinjam=TanggalPinjamBaru,TanggalKembali=TanggalKembaliBaru, Status=StatusBaru WHERE Id_Peminjaman = Id_PeminjamanBaru;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateSiswa` (IN `Id_SiswaBaru` INT, IN `NamaBaru` VARCHAR(50), IN `KelasBaru` VARCHAR(15))   BEGIN
	UPDATE siswa SET Nama=NamaBaru, Kelas=KelasBaru WHERE Id_Siswa = Id_SiswaBaru;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `buku`
--

CREATE TABLE `buku` (
  `Id_Buku` int NOT NULL,
  `JudulBuku` varchar(50) DEFAULT NULL,
  `Penulis` varchar(20) DEFAULT NULL,
  `Kategori` varchar(20) DEFAULT NULL,
  `Stok` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `buku`
--

INSERT INTO `buku` (`Id_Buku`, `JudulBuku`, `Penulis`, `Kategori`, `Stok`) VALUES
(1, 'Algoritma Dan Pemrograman', 'Andi Wijaya', 'Teknologi', 5),
(2, 'Dasar-Dasar Database', 'Budi Sansoto', 'Teknologi', 7),
(3, 'Matematika Diskrit', 'Rina Sari', 'Matematika', 4),
(4, 'Sejarah Dunia', 'John Smith', 'Sejarah', 3),
(5, 'Pemrograman Web dengan PHP', 'Eko Prasetyo', 'Teknologi', 8),
(6, 'Sistem Operasi', 'Dian Kurniawan', 'Teknologi', 6),
(7, 'Jaringan Komputer', 'Ahmad Fauzi', 'Teknologi', 5),
(8, 'Cerita Rakyat Nusantara', 'Lestari Dewi', 'Sastra', 9),
(9, 'Bahasa Inggris untuk Pemula', 'Jane Doe', 'Bahasa', 10),
(10, 'Biologi Dasar', 'Budi Rahman', 'Sains', 7),
(11, 'Kimia Organik', 'Siti Aminah', 'Sains', 5),
(12, 'Teknik Elektro', 'Ridwan Hakim', 'Teknik', 6),
(13, 'Fisika Modern', 'Albert Einstein', 'Sains', 4),
(14, 'Manajemen Waktu', 'Steven Covey', 'Pengembangan', 8),
(15, 'Strategi Belajar Efektif', 'Tony Buzan', 'Pendidikan', 6);

-- --------------------------------------------------------

--
-- Table structure for table `peminjaman`
--

CREATE TABLE `peminjaman` (
  `Id_Peminjaman` int NOT NULL,
  `Id_Siswa` int DEFAULT NULL,
  `Id_Buku` int DEFAULT NULL,
  `TanggalPinjam` date DEFAULT NULL,
  `TanggalKembali` date DEFAULT NULL,
  `Status` enum('Dipinjam','Dikembalikan') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `peminjaman`
--

INSERT INTO `peminjaman` (`Id_Peminjaman`, `Id_Siswa`, `Id_Buku`, `TanggalPinjam`, `TanggalKembali`, `Status`) VALUES
(1, 11, 2, '2025-01-01', '2025-01-08', 'Dipinjam'),
(2, 2, 5, '2025-01-02', '2025-01-09', 'Dikembalikan'),
(3, 3, 8, '2025-01-03', '2025-01-10', 'Dipinjam'),
(4, 4, 10, '2025-01-04', '2025-01-11', 'Dikembalikan'),
(5, 5, 3, '2025-01-05', '2025-01-12', 'Dikembalikan'),
(6, 15, 7, '2025-02-01', '2025-02-08', 'Dipinjam'),
(7, 7, 1, '2025-01-29', '2025-02-05', 'Dikembalikan'),
(8, 8, 9, '2025-02-03', '2025-02-08', 'Dipinjam'),
(9, 13, 4, '2025-01-27', '2025-02-03', 'Dikembalikan'),
(10, 10, 11, '2025-02-25', '2025-02-08', 'Dipinjam');

--
-- Triggers `peminjaman`
--
DELIMITER $$
CREATE TRIGGER `KurangiStokBuku` AFTER INSERT ON `peminjaman` FOR EACH ROW BEGIN
    UPDATE buku 
    SET Stok = Stok - 1
    WHERE Id_Buku = NEW.id_buku AND NEW.status='Dipinjam';
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `TambahStokBuku` AFTER UPDATE ON `peminjaman` FOR EACH ROW BEGIN
    IF NEW.status = 'Dikembalikan' AND OLD.status != 'Dikembalikan' THEN
        UPDATE buku
        SET Stok = Stok + 1
        WHERE Id_Buku = NEW.Id_Buku;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `siswa`
--

CREATE TABLE `siswa` (
  `Id_Siswa` int NOT NULL,
  `Nama` varchar(50) DEFAULT NULL,
  `Kelas` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `siswa`
--

INSERT INTO `siswa` (`Id_Siswa`, `Nama`, `Kelas`) VALUES
(1, 'Andi Saputra', 'X-RPL'),
(2, 'Budi Wijaya', 'X-TKJ'),
(3, 'Citra Lestari', 'XI-RPL'),
(4, 'Dewi Kurniawan', 'XI-TKJ'),
(5, 'Eko Prasetyo', 'XII-RPL'),
(6, 'Farhan Maulana', 'XII-TKJ'),
(7, 'Gita Permata', 'X-RPL'),
(8, 'Hadi Sucipto', 'X-TKJ'),
(9, 'Intan Permadi', 'XI-RPL'),
(10, 'Joko Santoso', 'XI-TKJ'),
(11, 'Kartika Sari', 'XII-RPL'),
(12, 'Lintang Putri', 'XII-TKJ'),
(13, 'Muhammad Rizky', 'X-RPL'),
(14, 'Novi Andriana', 'X-TKJ'),
(15, 'Olivia Hernanda', 'XI-RPL');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`Id_Buku`);

--
-- Indexes for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`Id_Peminjaman`);

--
-- Indexes for table `siswa`
--
ALTER TABLE `siswa`
  ADD PRIMARY KEY (`Id_Siswa`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `buku`
--
ALTER TABLE `buku`
  MODIFY `Id_Buku` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `Id_Peminjaman` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `siswa`
--
ALTER TABLE `siswa`
  MODIFY `Id_Siswa` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
