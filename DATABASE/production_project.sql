-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 22, 2024 at 04:52 PM
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
-- Database: `production_project`
--

-- --------------------------------------------------------

--
-- Table structure for table `ad_in`
--

CREATE TABLE `ad_in` (
  `id` int(11) NOT NULL,
  `use_r` varchar(50) NOT NULL,
  `pas` varchar(50) NOT NULL,
  `stage` text NOT NULL,
  `fullname` varchar(50) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `ad_in`
--

INSERT INTO `ad_in` (`id`, `use_r`, `pas`, `stage`, `fullname`, `phone`, `address`) VALUES
(2, 'inno@gmail.com', '1234', 'Postpartum', 'Dr. Devkota', '08164269945', 'koteshwor'),
(3, 'postpartummothers2024@gmail.com', 'jiya@1234', 'Postpartum', 'priya', '9807654332', 'koteshwor'),
(4, 'jiyayadav102@gmail.com', 'jiys#23456', 'Postpartum', 'Dr. Saroj k.', '9825677123', 'New baneshwor');

--
-- Triggers `ad_in`
--
DELIMITER $$
CREATE TRIGGER `after_deleteadmin_trigger` BEFORE DELETE ON `ad_in` FOR EACH ROW BEGIN
    DECLARE doctor_name VARCHAR(255);
    DECLARE doctor_email VARCHAR(255);

    -- Get the name and email of the doctor being deleted
    SELECT fullname, use_r INTO doctor_name, doctor_email
    FROM ad_in
    WHERE id = OLD.id;

    -- Insert into changes_report table
    INSERT INTO changes_report (table_name, operation, rows_affected, description, name, email)
    VALUES ('ad_in', 'DELETE', 1, 'A doctor is removed', doctor_name, doctor_email);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insertadmin_trigger` AFTER INSERT ON `ad_in` FOR EACH ROW BEGIN
    INSERT INTO changes_report (table_name, operation, rows_affected, description, name, email)
    VALUES ('ad_in', 'INSERT', 1, 'New doctor registered', NEW.fullname, NEW.use_r);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `book_app`
--

CREATE TABLE `book_app` (
  `id` int(11) NOT NULL,
  `dept` varchar(20) NOT NULL,
  `fullname` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `appdate` varchar(50) NOT NULL,
  `apptime` varchar(50) NOT NULL,
  `appnote` varchar(10000) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'Not Approved',
  `phone` varchar(30) NOT NULL,
  `docname` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `book_app`
--

INSERT INTO `book_app` (`id`, `dept`, `fullname`, `email`, `appdate`, `apptime`, `appnote`, `status`, `phone`, `docname`) VALUES
(96, 'Post-Partum', 'yadav Sahil Yadav', 'ms21jiya@gmail.com', '2024-06-05', '16:05', 'fghk', 'Not Approved', '9876543213', 'Innocent Chiemerie'),
(106, 'Post-Partum', 'yadav tiya', 'gcgintl.00@gmail.com', '2029-01-01', '02:02', 'jhgf', 'Not Approved', '9876512344', 'priya'),
(107, 'Post-Partum', 'yadav tiya', 'gcgintl.00@gmail.com', '2024-05-16', '03:02', 'mm', 'Not Approved', '9876512344', 'priya'),
(108, 'Post-Partum', 'yadav tiya', 'gcgintl.00@gmail.com', '2038-10-12', '04:19', 'oiuygf', 'Not Approved', '9876512344', 'priya'),
(111, 'Post-Partum', 'yadav jiya', 'gcgintl.00@gmail.com', '2024-05-24', '06:15', 'I am very sick.', 'Approved', '9825677123', 'Dr. Saroj k.');

--
-- Triggers `book_app`
--
DELIMITER $$
CREATE TRIGGER `after_approvedapp_trigger` AFTER UPDATE ON `book_app` FOR EACH ROW BEGIN
    INSERT INTO report_bookapp (table_name,operation, description, name, email,docname, appdate, apptime,status)
    VALUES ('book_app', 'UPDATE', 'Appointment is approved', NEW.fullname, NEW.email, NEW.docname, NEW.appdate, NEW.apptime,NEW.status);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_bookapp_trigger` AFTER INSERT ON `book_app` FOR EACH ROW BEGIN
    INSERT INTO report_bookapp (table_name, operation, description, name, email, docname, appdate, apptime)
    VALUES ('book_app', 'INSERT', 'New appointment booked', NEW.fullname, NEW.email, NEW.docname, NEW.appdate, NEW.apptime);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `changes_report`
--

CREATE TABLE `changes_report` (
  `id` int(11) NOT NULL,
  `table_name` varchar(255) DEFAULT NULL,
  `operation` varchar(10) DEFAULT NULL,
  `rows_affected` int(11) DEFAULT NULL,
  `change_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `description` varchar(200) NOT NULL,
  `email` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `changes_report`
--

INSERT INTO `changes_report` (`id`, `table_name`, `operation`, `rows_affected`, `change_time`, `description`, `email`, `name`) VALUES
(10, 'usr', 'INSERT', 1, '2024-05-13 17:48:11', 'New mother registered', 'gntl.00@gmail.com', 'jiya'),
(17, 'usr', 'INSERT', 1, '2024-05-14 04:18:11', 'New mother registered', 'ms21jiya@gmail.com', 'jiya'),
(18, 'usr', 'DELETE', 1, '2024-05-14 04:26:25', 'A mother is removed', 'ms21jiya@gmail.com', 'jiya'),
(38, 'usr', 'INSERT', 1, '2024-05-16 09:57:40', 'New mother registered', 'postpartummothers2024@gmail.co', 'jiya'),
(39, 'usr', 'DELETE', 1, '2024-05-16 10:08:02', 'A mother is removed', 'postpartummothers2024@gmail.co', 'jiya'),
(40, 'usr', 'INSERT', 1, '2024-05-16 10:08:51', 'New mother registered', 'jiyayadav102@gmail.com', 'kkkk'),
(43, 'usr', 'DELETE', 1, '2024-05-20 05:59:54', 'A mother is removed', 'tim123@gmail.com', 'Tim'),
(47, 'usr', 'INSERT', 1, '2024-05-21 14:58:20', 'New mother registered', 'jiyayadav102@gmail.com', 'Jiya'),
(48, 'usr', 'DELETE', 1, '2024-05-22 05:26:49', 'A mother is removed', 'jiyayadav102@gmail.com', 'Jiya'),
(49, 'usr', 'INSERT', 1, '2024-05-22 05:27:40', 'New mother registered', 'jiyayadav102@gmail.com', 'Jiya');

-- --------------------------------------------------------

--
-- Table structure for table `change_log`
--

CREATE TABLE `change_log` (
  `change_id` int(11) NOT NULL,
  `table_name` varchar(255) NOT NULL,
  `change_type` enum('insert','update','delete') NOT NULL,
  `change_description` text DEFAULT NULL,
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chats`
--

CREATE TABLE `chats` (
  `id` int(20) NOT NULL,
  `user` varchar(50) NOT NULL,
  `message` varchar(10000) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `sender` varchar(70) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chats`
--

INSERT INTO `chats` (`id`, `user`, `message`, `timestamp`, `sender`) VALUES
(9, 'jiya', 'Hi doctor. How can I cope with postpartum anxiety?', '2024-05-21 19:16:55', 'Mother'),
(12, 'jiya', 'Hi there. Engaging in self-care activities such as getting enough rest, eating nutritiously, and practicing relaxation techniques like deep breathing or meditation can also help manage symptoms. It\'s important to communicate openly about feelings and seek help if symptoms worsen or persist.', '2024-05-21 19:20:47', 'Doctor');

-- --------------------------------------------------------

--
-- Table structure for table `chatuser`
--

CREATE TABLE `chatuser` (
  `id` int(30) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` int(30) NOT NULL,
  `fullname` varchar(100) NOT NULL,
  `user_id` int(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chatuser`
--

INSERT INTO `chatuser` (`id`, `email`, `phone`, `fullname`, `user_id`) VALUES
(35, 'jiyayadav102@gmail.com', 2147483647, 'Yadav Jiya ', 0);

-- --------------------------------------------------------

--
-- Table structure for table `chat_messages`
--

CREATE TABLE `chat_messages` (
  `id` int(30) NOT NULL,
  `user_id` int(20) NOT NULL,
  `fullname` varchar(100) NOT NULL,
  `message` varchar(2000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chat_messages`
--

INSERT INTO `chat_messages` (`id`, `user_id`, `fullname`, `message`) VALUES
(1, 4, 'tiya yadav', 'xcvbbg65f4de4wesdvby7g4e4wsevhjguc4vuhjcyku 6c5vi 7rd7cvt tv8f7 c56vrthg jfghj');

-- --------------------------------------------------------

--
-- Table structure for table `imm_uze`
--

CREATE TABLE `imm_uze` (
  `id` int(8) NOT NULL,
  `vaccage` varchar(500) NOT NULL,
  `dose` varchar(200) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `stage` varchar(100) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `vaccname` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `imm_uze`
--

INSERT INTO `imm_uze` (`id`, `vaccage`, `dose`, `description`, `stage`, `timestamp`, `vaccname`) VALUES
(7, 'Any time during pregnancy, preferably before flu s', 'Single dose annually', 'Protects against the influenza virus, which can cause severe respiratory illness.', 'Postpartum', '2024-05-21 15:21:48', 'Influenza (Flu) Vaccine'),
(8, '1st dose: Birth ,2nd dose: 1-2 months ,3rd dose: 6', '3 doses', 'Child Vaccination:Protects against hepatitis B virus, which can cause liver disease.', 'Postpartum', '2024-05-21 15:23:38', 'Hepatitis B (HepB) Vaccine'),
(9, '1st dose: 2 months ,2nd dose: 4 months ,(3rd dose ', '2 or 3 doses, depending on the brand.', 'Child Vaccination: Protects against rotavirus, which can cause severe diarrhea and vomiting', 'Postpartum', '2024-05-21 15:24:33', 'Rotavirus (RV) Vaccine'),
(10, '1st dose: 2 months ,2nd dose: 4 months, 3rd dose: 6 months, 4th dose: 15-18 months,5th dose: 4-6 years', '5 doses.', 'Child Vaccination:  Protects against diphtheria, tetanus, and pertussis.', 'Postpartum', '2024-05-21 15:26:35', 'Diphtheria, Tetanus, and acellular Pertussis (DTaP) Vaccine'),
(11, 'Age: 2-dose series: Start at 11-12 years (second dose 6-12 months after the first) 3-dose series: Start at 15 years or older (second dose 1-2 months after the first, third dose 6 months after the first)', 'Dose: 2 or 3 doses, depending on the starting age.', 'Protects against human papillomavirus, which can cause cervical cancer and other cancers.', 'Postpartum', '2024-05-22 05:52:09', 'Human Papillomavirus (HPV) Vaccine');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `user` varchar(50) NOT NULL,
  `message` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `user`, `message`, `timestamp`) VALUES
(56, 'Mom', 'Hi there', '2024-05-21 18:59:04'),
(57, 'Mom', 'How are you doing. Can you share something about your post partum journey?', '2024-05-21 18:59:57');

-- --------------------------------------------------------

--
-- Table structure for table `no_te`
--

CREATE TABLE `no_te` (
  `id` int(11) NOT NULL,
  `user_id` varchar(200) NOT NULL,
  `note` text NOT NULL,
  `date` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `no_te`
--

INSERT INTO `no_te` (`id`, `user_id`, `note`, `date`) VALUES
(1, 'PN/2024/5139337', 'food', '16 May, 2024');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expTime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`id`, `email`, `token`, `expTime`) VALUES
(1, 'giya@gmail.com', '1f7d80dfa7a87ee102937dee474e3ae2eb7ecfca625697c230d9d747994b839229ca657e30a2bc2c7a6236d53af271bc4b7e', '2024-05-20 10:11:01'),
(2, 'giya@gmail.com', '9f8c347e52d0f16de314d1628feb9167153f1c1be6535f0bc680e4ce4b529f6b9a4e12342ff6f27a5d6028cf5e2471fbac1d', '2024-05-20 10:58:12'),
(3, 'jiyayadav102@gmail.com', '6930ed3e5c351afc257e00e443be753db5e96356ee209999a9a958148aeaddd782708d23d940199fe332395968de7b28f281', '2024-05-20 11:06:05'),
(4, 'jiyayadav102@gmail.com', '537400', '2024-05-20 11:37:52');

-- --------------------------------------------------------

--
-- Table structure for table `pd_f`
--

CREATE TABLE `pd_f` (
  `id` int(11) NOT NULL,
  `level` varchar(50) NOT NULL,
  `title` text NOT NULL,
  `path` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `pd_f`
--

INSERT INTO `pd_f` (`id`, `level`, `title`, `path`) VALUES
(1, 'Nursery 2 Diamond', 'Language 1', 'pdf/LANGUAGE WEEK I.docx'),
(2, 'Nursery 2 Diamond', 'Grammer', 'pdf/ENGLISH GRAMMAR 2.pdf'),
(3, 'Nursery 2 Diamond', 'Bible', 'pdf/CRK- JESUS IS WITH US.docx'),
(4, 'Postnatal', 'nbg', 'pdf/s12905-022-01996-4.pdf'),
(6, 'Postpartum', 'Postpartum_WHO', 'pdf/WHO_POSTPARTUM.pdf');

-- --------------------------------------------------------

--
-- Table structure for table `pick_off`
--

CREATE TABLE `pick_off` (
  `id` int(11) NOT NULL,
  `user_id` varchar(200) NOT NULL,
  `link_in` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `pick_off`
--

INSERT INTO `pick_off` (`id`, `user_id`, `link_in`) VALUES
(17, 'PN/2021/7267118', '#'),
(18, 'PN/2024/1466616', 'php/tryit/?uniqlearn=5dc6cf15f63df21b7caf3858107a662d'),
(19, 'PN/2024/2557571', '#'),
(20, 'PN/2024/7802477', '#'),
(21, 'PN/2024/4590509', '#'),
(22, 'PN/2024/5746187', '#'),
(23, 'PN/2024/1795044', '#'),
(24, 'PN/2024/2976332', '#'),
(25, 'PN/2024/1386548', '#'),
(26, 'PN/2024/1145149', '#'),
(27, 'PN/2024/1510015', '#'),
(28, 'PN/2024/6649696', '#'),
(29, 'PN/2024/8693099', '#'),
(30, 'PN/2024/9339090', '#'),
(31, 'PN/2024/5753295', '#'),
(32, 'PN/2024/2992440', '#'),
(33, 'PN/2024/3738165', '#'),
(34, 'PN/2024/8346809', '#'),
(35, 'PN/2024/3882176', '#'),
(36, 'PN/2024/6775856', '#'),
(37, 'PN/2024/6884207', '#'),
(38, 'PN/2024/249838', '#'),
(39, 'PN/2024/8574691', '#'),
(40, 'PN/2024/6778873', '#'),
(41, 'PN/2024/8496615', '#'),
(42, 'PN/2024/3776918', '#'),
(43, 'PN/2024/5511806', '#'),
(44, 'PN/2024/5139337', '#'),
(45, 'PN/2024/4152520', '#'),
(46, 'PN/2024/6752404', '#');

-- --------------------------------------------------------

--
-- Table structure for table `que_st`
--

CREATE TABLE `que_st` (
  `id` int(11) NOT NULL,
  `stage` varchar(30) NOT NULL,
  `title` varchar(100) NOT NULL,
  `question` varchar(10000) NOT NULL,
  `fullname` varchar(70) NOT NULL,
  `questdate` varchar(100) NOT NULL,
  `email` varchar(20) NOT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'No Reply',
  `ans` varchar(10000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `que_st`
--

INSERT INTO `que_st` (`id`, `stage`, `title`, `question`, `fullname`, `questdate`, `email`, `status`, `ans`) VALUES
(12, 'Postpartum', 'Postpartum Hemorrhage', 'Description: Excessive bleeding after childbirth, which can be life-threatening.\r\nSymptoms: Heavy bleeding, dizziness, weakness, and low blood pressure.', 'Yadav jiya', '21 May, 2024', 'jiyayadav102@gmail.c', 'Replied', 'Meditation'),
(13, 'Postpartum', 'Postpartum Hemorrhage', 'Description: Excessive bleeding after childbirth, which can be life-threatening.\r\nSymptoms: Heavy bleeding, dizziness, weakness, and low blood pressure.', 'Yadav jiya', '21 May, 2024', 'jiyayadav102@gmail.c', 'Replied', 'Meditation');

-- --------------------------------------------------------

--
-- Table structure for table `report_bookapp`
--

CREATE TABLE `report_bookapp` (
  `id` int(30) NOT NULL,
  `table_name` varchar(255) NOT NULL,
  `operation` varchar(255) NOT NULL,
  `change_time` timestamp(6) NOT NULL DEFAULT current_timestamp(6) ON UPDATE current_timestamp(6),
  `description` varchar(200) NOT NULL,
  `appdate` varchar(100) NOT NULL,
  `apptime` varchar(100) NOT NULL,
  `docname` varchar(60) NOT NULL,
  `phone` varchar(30) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `status` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `report_bookapp`
--

INSERT INTO `report_bookapp` (`id`, `table_name`, `operation`, `change_time`, `description`, `appdate`, `apptime`, `docname`, `phone`, `name`, `email`, `status`) VALUES
(4, 'book_app', 'UPDATE', '2024-05-13 16:07:27.906781', 'Appointment is approved', '2024-05-16', '16:26', 'Innocent Chiemerie', '', 'yadav jiya', 'jack@gmail.com', 'Approved'),
(5, 'book_app', 'INSERT', '2024-05-14 06:20:05.803799', 'New appointment booked', '2024-06-05', '16:05', 'Innocent Chiemerie', '', 'yadav Sahil Yadav', 'ms21jiya@gmail.com', ''),
(11, 'book_app', 'INSERT', '2024-05-14 17:59:07.048739', 'New appointment booked', '2024-06-26', '03:45', 'Innocent Chiemerie', '', 'yadav jiya', 'jack@gmail.com', ''),
(12, 'book_app', 'INSERT', '2024-05-14 18:05:49.324304', 'New appointment booked', '2024-11-05', '04:54', 'Innocent Chiemerie', '', 'yadav jiya', 'jack@gmail.com', ''),
(13, 'book_app', 'INSERT', '2024-05-16 05:09:34.414012', 'New appointment booked', '2024-05-29', '04:58', 'Innocent Chiemerie', '', 'yadav jiya', 'jack@gmail.com', ''),
(14, 'book_app', 'INSERT', '2024-05-16 05:10:44.630360', 'New appointment booked', '2030-11-20', '13:57', 'Innocent Chiemerie', '', 'yadav jiya', 'jack@gmail.com', ''),
(15, 'book_app', 'INSERT', '2024-05-16 05:14:22.778746', 'New appointment booked', '2029-01-01', '02:02', 'priya', '', 'yadav tiya', 'gcgintl.00@gmail.com', ''),
(16, 'book_app', 'INSERT', '2024-05-16 05:15:30.397907', 'New appointment booked', '2024-05-16', '03:02', 'priya', '', 'yadav tiya', 'gcgintl.00@gmail.com', ''),
(17, 'book_app', 'INSERT', '2024-05-16 05:28:43.484471', 'New appointment booked', '2038-10-12', '04:19', 'priya', '', 'yadav tiya', 'gcgintl.00@gmail.com', ''),
(20, 'book_app', 'UPDATE', '2024-05-18 17:39:14.310669', 'Appointment is approved', '2024-05-08', '19:30', '', '', 'yadav jiya', 'gcgintl.00@gmail.com', 'Approved'),
(21, 'book_app', 'UPDATE', '2024-05-20 08:59:49.972085', 'Appointment is approved', '2024-05-08', '19:30', '', '', 'yadav jiya', 'gcgintl.00@gmail.com', 'Not Approved'),
(22, 'book_app', 'UPDATE', '2024-05-20 08:59:52.710704', 'Appointment is approved', '2024-05-08', '19:30', '', '', 'yadav jiya', 'gcgintl.00@gmail.com', 'Approved'),
(23, 'book_app', 'UPDATE', '2024-05-21 13:49:50.650055', 'Appointment is approved', '2024-05-08', '19:30', '', '', 'yadav jiya', 'gcgintl.00@gmail.com', 'Not Approved'),
(24, 'book_app', 'INSERT', '2024-05-21 19:26:29.457338', 'New appointment booked', '2024-05-24', '06:15', 'Dr. Saroj k.', '', 'yadav jiya', 'gcgintl.00@gmail.com', ''),
(25, 'book_app', 'INSERT', '2024-05-22 06:02:11.714347', 'New appointment booked', '2024-06-05', '02:50', 'Dr. Saroj k.', '', 'yadav tiya', 'gcgintl.00@gmail.com', ''),
(26, 'book_app', 'UPDATE', '2024-05-22 06:14:57.292000', 'Appointment is approved', '2024-05-24', '06:15', 'Dr. Saroj k.', '', 'yadav jiya', 'gcgintl.00@gmail.com', 'Approved'),
(27, 'book_app', 'UPDATE', '2024-05-22 06:15:25.601803', 'Appointment is approved', '2024-05-24', '06:15', 'Dr. Saroj k.', '', 'yadav jiya', 'gcgintl.00@gmail.com', 'Not Approved'),
(28, 'book_app', 'UPDATE', '2024-05-22 06:15:40.136667', 'Appointment is approved', '2024-05-24', '06:15', 'Dr. Saroj k.', '', 'yadav jiya', 'gcgintl.00@gmail.com', 'Approved');

-- --------------------------------------------------------

--
-- Table structure for table `s_admin`
--

CREATE TABLE `s_admin` (
  `id` int(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  `password` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `s_admin`
--

INSERT INTO `s_admin` (`id`, `email`, `name`, `password`) VALUES
(1, 'superadmin123@gmail.com', 'Jiya yadav', 'jiya@123456');

-- --------------------------------------------------------

--
-- Table structure for table `text_tutor`
--

CREATE TABLE `text_tutor` (
  `id` int(11) NOT NULL,
  `level` varchar(50) NOT NULL,
  `topic` text NOT NULL,
  `body` text NOT NULL,
  `uniqlearn` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `text_tutor`
--

INSERT INTO `text_tutor` (`id`, `level`, `topic`, `body`, `uniqlearn`) VALUES
(4, 'Postpartum', 'Breast feeding', 'Breastfeeding is a crucial aspect of the postpartum journey, offering a multitude of benefits for both the mother and the newborn. It is not merely a means of providing nutrition but also establishes a profound emotional connection between the mother and her baby. During the postpartum period, breastfeeding plays a pivotal role in ensuring the optimal growth and development of the newborn while aiding in the recovery and well-being of the mother.\r\n\r\nFirst and foremost, breast milk is nature&#039;s perfect food for infants, uniquely tailored to meet their nutritional needs. It contains essential nutrients, antibodies, and enzymes that support the baby&#039;s immune system and protect against infections and illnesses. The composition of breast milk changes dynamically to adapt to the evolving needs of the growing baby, providing the ideal balance of proteins, fats, carbohydrates, and vitamins.\r\n\r\nMoreover, breastfeeding fosters a deep bond between the mother and her child, promoting emotional attachment and security. The act of breastfeeding releases hormones such as oxytocin, often referred to as the &quot;love hormone,&quot; which induces feelings of relaxation, happiness, and maternal instinct. This intimate interaction during breastfeeding helps establish a strong emotional connection, laying the foundation for a nurturing and supportive relationship.\r\n\r\nIn addition to the numerous benefits for the baby, breastfeeding offers significant advantages for the mother&#039;s health and well-being during the postpartum period. It stimulates the release of oxytocin, which aids in uterine contractions and helps the uterus return to its pre-pregnancy size, reducing the risk of postpartum hemorrhage and promoting faster recovery after childbirth. Breastfeeding also helps mothers shed pregnancy weight more effectively by burning calories and promoting the contraction of the uterus.\r\n\r\nFurthermore, breastfeeding has long-term health benefits for mothers, including a reduced risk of breast and ovarian cancer, osteoporosis, and cardiovascular diseases. Women who breastfeed also experience a lower incidence of postpartum depression and anxiety, attributed to the release of oxytocin and the nurturing bond established during breastfeeding. The act of breastfeeding provides mothers with a sense of accomplishment and empowerment, enhancing their self-esteem and confidence in their ability to care for their baby.\r\n\r\nDespite its numerous advantages, breastfeeding can pose challenges for some mothers during the postpartum period. Issues such as sore nipples, engorgement, low milk supply, and difficulty latching may arise, requiring patience, support, and guidance from healthcare professionals and lactation consultants. It is essential for mothers to seek assistance and resources to overcome breastfeeding obstacles and ensure a positive breastfeeding experience for both themselves and their baby.\r\n\r\nIn conclusion, breastfeeding plays a vital role in the postpartum journey, offering a myriad of benefits for both mother and child. It provides the ideal nutrition for infants, fosters emotional bonding, supports maternal health and well-being, and contributes to long-term disease prevention. Despite the challenges that may arise, the rewards of breastfeeding are immeasurable, creating lasting memories and nurturing relationships that endure far beyond the postpartum period.', '5dc6cf15f63df21b7caf3858107a662d'),
(5, 'Postpartum', 'Controlling Postpartum Depression: Strategies and Tips', 'Introduction\r\nPostpartum depression (PPD) is a complex condition affecting new mothers, characterized by emotional, physical, and behavioral changes that occur after childbirth. Recognizing and managing PPD is crucial for the well-being of both the mother and the baby. This article will explore various strategies to help control postpartum depression, offering practical tips and advice for new mothers and their families.\r\n\r\nUnderstanding Postpartum Depression\r\nDefinition: PPD is a form of depression that occurs after childbirth. It can range from mild to severe and may start within a few days to a year after delivery.\r\nSymptoms: Common symptoms include sadness, anxiety, irritability, fatigue, changes in sleeping and eating patterns, and difficulty bonding with the baby.\r\nCauses: Factors contributing to PPD include hormonal changes, history of depression, emotional stress, and lack of support.\r\nProfessional Help and Therapy\r\nSeek Medical Advice: Consulting with a healthcare provider is the first step. They can diagnose PPD and recommend appropriate treatments, such as medication or therapy.\r\nTherapy Options: Cognitive-behavioral therapy (CBT) and interpersonal therapy (IPT) are effective forms of psychotherapy for PPD.\r\nMedication: Antidepressants may be prescribed to manage severe symptoms. It&#039;s important to discuss the risks and benefits with a doctor, especially if breastfeeding.\r\nBuilding a Support System\r\nFamily and Friends: Having a strong support network can significantly impact recovery. Don’t hesitate to ask for help with baby care and household chores.\r\nSupport Groups: Joining a PPD support group provides a platform to share experiences and receive encouragement from others facing similar challenges.\r\nPartner Involvement: Partners should be actively involved in the care process, offering emotional support and understanding.\r\nLifestyle Changes\r\nHealthy Diet: Eating a balanced diet rich in nutrients can improve mood and energy levels. Include plenty of fruits, vegetables, whole grains, and lean proteins.\r\nRegular Exercise: Physical activity, such as walking or postnatal yoga, can boost endorphin levels, helping to alleviate depressive symptoms.\r\nSleep Hygiene: Prioritize sleep by establishing a routine, napping when the baby naps, and seeking help to manage nighttime feedings.\r\nSelf-Care and Mindfulness\r\nMe Time: Dedicate time to activities you enjoy, whether it&#039;s reading, taking a bath, or practicing a hobby.\r\nMindfulness Practices: Techniques such as meditation, deep breathing exercises, and mindfulness can reduce stress and promote mental well-being.\r\nAvoid Isolation: Engage in social activities and stay connected with loved ones, even if it&#039;s through phone calls or virtual meetings.\r\nWhen to Seek Immediate Help\r\nEmergency Signs: If you experience thoughts of harming yourself or your baby, seek immediate help from a healthcare provider or emergency services.\r\nCrisis Resources: Familiarize yourself with local crisis hotlines and emergency resources available in your community.', '75e7eb9f5a47dfbf594fd138647987e7');

-- --------------------------------------------------------

--
-- Table structure for table `user_responses`
--

CREATE TABLE `user_responses` (
  `id` int(10) NOT NULL,
  `response_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `user_ip` int(20) NOT NULL,
  `total_score` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_responses`
--

INSERT INTO `user_responses` (`id`, `response_date`, `user_ip`, `total_score`) VALUES
(64, '2024-05-21 17:07:26', 0, 11),
(65, '2024-05-21 17:19:06', 0, 12),
(66, '2024-05-21 18:55:38', 0, 15);

-- --------------------------------------------------------

--
-- Table structure for table `usr`
--

CREATE TABLE `usr` (
  `id` int(11) NOT NULL,
  `user_id` varchar(20) NOT NULL,
  `sname` varchar(20) NOT NULL,
  `fname` varchar(20) NOT NULL,
  `mname` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `stage` varchar(15) NOT NULL,
  `state` varchar(20) NOT NULL,
  `addr` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `user` varchar(20) NOT NULL,
  `pass` varchar(20) NOT NULL,
  `passhash` varchar(100) NOT NULL,
  `profile_p` varchar(100) NOT NULL,
  `vaccage` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `usr`
--

INSERT INTO `usr` (`id`, `user_id`, `sname`, `fname`, `mname`, `email`, `stage`, `state`, `addr`, `phone`, `user`, `pass`, `passhash`, `profile_p`, `vaccage`) VALUES
(1, 'PN/2021/7267118', 'Onyejiri', 'Gift', 'chibuzo', 'gift@yahoo.com', 'Postpartum', 'Imo', 'No 10, mela street', '08104618161', 'chigift', '12345', '$2y$10$dWQfP.YgDBURxgYOO15vYOoEkECW/aQ51a9Vs1CKOYNJqnmnsP6yC', '', NULL),
(2, 'PN/2024/1466616', 'yadav', 'jiya', '', 'jack@gmail.com', 'Postpartum', 'Bagmati', 'koteshwor', '9876543213', 'jiya', 'jiya@12345', '$2y$10$fnkOfg6DE1l20ELQz1W1ruLS92cwVijz2fWVA1dAHAGXL5Y/nPeaq', '', 1),
(5, 'PN/2024/4590509', 'yadav', 'jiya', '', 'gcg@gmail.com', 'Postpartum', '', '', '9876512344', 'jiya', 'gcg@12345', '$2y$10$1uLgb6uyRmeQxdulNFRxkuhFEsedTM6NJc9jf97ynsdgb1.6vsyCO', '', NULL),
(6, 'PN/2024/5746187', 'yadav', 'tiya', '', 'gcgintl.00@gmail.com', 'Postpartum', 'Bagmati', 'koteshwor', '9876512344', 'tiya', 'jiya@2345678', '$2y$10$sY8Wkk38HfJptj72IBXLMOYPfLlmH2XyvW2G/.1iqu.v8bmqBPLOy', 'users/gcgintl.00@gmail.com/about-02.jpg', 1),
(8, 'PN/2024/2976332', 'rai', 'jiya', '', 'giiiii123@gmail.com', 'Postpartum', '', '', '9876567890', 'Tanna', 'giii@12345', '$2y$10$n02JnVEgg7aMQzuRA/nQ6.e3.NZqx7KubNu//37WnUgYu2kK2ekj.', '', NULL),
(9, 'PN/2024/1386548', 'yadav', 'tiya', '', 'vgfju@gmail.com', 'Postpartum', '', '', '0987654332', 'ria', 'ria@123456', '$2y$10$u8EBU9uItKiVsTZl0vCn9OoqZkNP/0ed6K.37wowWY80dotuJzARa', '', NULL),
(12, 'PN/2024/6649696', 'gfdsz', 'jiya', '', 'gntl.00@gmail.com', 'Postpartum', '', '', '0987654432', 'ria', 'jiya@123456', '$2y$10$iX8mA278KA.7KAqUlZY2u.wbmrZRhY3XzY1dXR7fZRjCSMXpK.FVa', '', NULL),
(24, 'PN/2024/6778873', 'yadav', 'Sahil Yadav', '', 'ms21jiya@gmail.com', 'Postpartum', '', '', '9876543213', 'priya', 'ms21@gmail.com', '$2y$10$AxIatfGL.0okQGkqPSV6HOLj.xZ2g0DuPTeEVVWvm5hcgJj0E9MlS', '', NULL),
(30, 'PN/2024/6752404', 'yadav', 'Jiya', '', 'jiyayadav102@gmail.com', 'Postpartum', '', '', '987896544', 'jiya', 'oooo@19900', '$2y$10$//asHkPlLkrcQg6xvkdhaunqb.Gh.17jEk1pTbWV3UgNyt8e8cx9G', '', NULL);

--
-- Triggers `usr`
--
DELIMITER $$
CREATE TRIGGER `after_deleteuser_trigger` BEFORE DELETE ON `usr` FOR EACH ROW BEGIN
    DECLARE user_name VARCHAR(255);
    DECLARE user_email VARCHAR(255);

    -- Get the name and email of the doctor being deleted
    SELECT fname, email INTO user_name, user_email
    FROM usr
    WHERE id = OLD.id;

    -- Insert into changes_report table
    INSERT INTO changes_report (table_name, operation, rows_affected, description, name, email)
    VALUES ('usr', 'DELETE', 1, 'A mother is removed', user_name, user_email);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insertuser_trigger` AFTER INSERT ON `usr` FOR EACH ROW BEGIN
    INSERT INTO changes_report (table_name, operation, rows_affected, description, name, email)
    VALUES ('usr', 'INSERT', 1, 'New mother registered', NEW.fname, NEW.email);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `vidl_ink`
--

CREATE TABLE `vidl_ink` (
  `id` int(11) NOT NULL,
  `level` varchar(50) NOT NULL,
  `title` varchar(100) NOT NULL,
  `vid_link` varchar(1000) NOT NULL,
  `sta_ge` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `vidl_ink`
--

INSERT INTO `vidl_ink` (`id`, `level`, `title`, `vid_link`, `sta_ge`) VALUES
(3, 'Postnatal', 'pojk', 'https://www.youtube.com/watch?v=2ocA-zS3SoI', 'Stage 1'),
(4, 'Postpartum', 'Postpartum Depression - What it Really Looks Like', 'https://www.youtube.com/watch?v=1n46HPsYsHM', 'Stage 1');

-- --------------------------------------------------------

--
-- Table structure for table `vi_d`
--

CREATE TABLE `vi_d` (
  `id` int(11) NOT NULL,
  `level` varchar(50) NOT NULL,
  `title` text NOT NULL,
  `vid_path` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `vi_d`
--

INSERT INTO `vi_d` (`id`, `level`, `title`, `vid_path`) VALUES
(3, 'Postpartum', 'Postpartum Depression', 'vid/Symptoms_of_Postpartum_Depression.mp4');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ad_in`
--
ALTER TABLE `ad_in`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `book_app`
--
ALTER TABLE `book_app`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `changes_report`
--
ALTER TABLE `changes_report`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `change_log`
--
ALTER TABLE `change_log`
  ADD PRIMARY KEY (`change_id`);

--
-- Indexes for table `chats`
--
ALTER TABLE `chats`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chatuser`
--
ALTER TABLE `chatuser`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chat_messages`
--
ALTER TABLE `chat_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `imm_uze`
--
ALTER TABLE `imm_uze`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `no_te`
--
ALTER TABLE `no_te`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pd_f`
--
ALTER TABLE `pd_f`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pick_off`
--
ALTER TABLE `pick_off`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `que_st`
--
ALTER TABLE `que_st`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `report_bookapp`
--
ALTER TABLE `report_bookapp`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `s_admin`
--
ALTER TABLE `s_admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `text_tutor`
--
ALTER TABLE `text_tutor`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_responses`
--
ALTER TABLE `user_responses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `usr`
--
ALTER TABLE `usr`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vidl_ink`
--
ALTER TABLE `vidl_ink`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vi_d`
--
ALTER TABLE `vi_d`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ad_in`
--
ALTER TABLE `ad_in`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `book_app`
--
ALTER TABLE `book_app`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=113;

--
-- AUTO_INCREMENT for table `changes_report`
--
ALTER TABLE `changes_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `change_log`
--
ALTER TABLE `change_log`
  MODIFY `change_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chats`
--
ALTER TABLE `chats`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `chatuser`
--
ALTER TABLE `chatuser`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `chat_messages`
--
ALTER TABLE `chat_messages`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `imm_uze`
--
ALTER TABLE `imm_uze`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `no_te`
--
ALTER TABLE `no_te`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `pd_f`
--
ALTER TABLE `pd_f`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `pick_off`
--
ALTER TABLE `pick_off`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `que_st`
--
ALTER TABLE `que_st`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `report_bookapp`
--
ALTER TABLE `report_bookapp`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `s_admin`
--
ALTER TABLE `s_admin`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `text_tutor`
--
ALTER TABLE `text_tutor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user_responses`
--
ALTER TABLE `user_responses`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT for table `usr`
--
ALTER TABLE `usr`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `vidl_ink`
--
ALTER TABLE `vidl_ink`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `vi_d`
--
ALTER TABLE `vi_d`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
