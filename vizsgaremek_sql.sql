-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Gép: localhost:3306
-- Létrehozás ideje: 2026. Feb 27. 10:35
-- Kiszolgáló verziója: 5.7.24
-- PHP verzió: 8.3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `vizsgaremek_sql`
--

DELIMITER $$
--
-- Eljárások
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `clearBasket` (IN `idIN` INT)   BEGIN 
	UPDATE `basket_product` SET
	`is_deleted`=1, `deleted_at`=CURRENT_TIMESTAMP 
    WHERE
    basket_product.basket_id = idIN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteAuthor` (IN `idIN` INT)   BEGIN 
	UPDATE `author` 
    SET 
    `is_deleted`= 1,
    `deleted_at`= CURRENT_TIMESTAMP 
    WHERE
    author.id = idIN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteBookById` (IN `idIN` INT)   BEGIN 
	UPDATE `book` 
    SET 
    `is_deleted`=1,`deleted_at`=CURRENT_TIMESTAMP 	
    WHERE
    book.id = idIN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteGenre` (IN `idIN` INT)   BEGIN 
	UPDATE `genre` SET 
    `is_deleted`=1,
    `deleted_at`=CURRENT_TIMESTAMP 
    WHERE
    genre.id = idIN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteProductFromBasket` (IN `idIN` INT)   BEGIN 
	UPDATE `basket_product` SET
	`is_deleted`=1, `deleted_at`=CURRENT_TIMESTAMP 
    WHERE
    basket_product.id = idIN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deletePublisher` (IN `idIN` INT)   BEGIN 
	UPDATE `publisher` 
    SET 
    `is_deleted`= 1,
    `deleted_at`= CURRENT_TIMESTAMP 
    WHERE
    publisher.id = idIN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteReviewById` (IN `idIN` INT)   BEGIN
	UPDATE `review` SET 
    `is_deleted`= 1,
    `deleted_at`= CURRENT_TIMESTAMP 
    WHERE 
    review.id = idIN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteUserById` (IN `idIN` INT)   BEGIN
	UPDATE `user` 
    SET 
    `is_deleted`=1,
    `deleted_at`=CURRENT_TIMESTAMP 
    WHERE 
    user.id = idIN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAddressTypeById` (IN `idIN` INT)   BEGIN 
	SELECT * FROM address_type
    WHERE 
    address_type.id = idIN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllAuthor` ()   BEGIN 
	SELECT * FROM author
    WHERE 
    author.is_deleted = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllBookIdByAuthor` (IN `authorIdIN` INT)   BEGIN
	SELECT b.id FROM book b 
    INNER JOIN book_author ba ON 
    b.id = ba.book_id
    INNER JOIN author a ON 
    a.id = ba.author_id 
    WHERE 
    b.is_deleted = 0 
    AND 
    a.id = authorIdIN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllBooksOrderByName` ()   BEGIN
	SELECT * FROM book
    WHERE 
    book.is_deleted = 0 
    ORDER BY book.title;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllBooksOrderByPrice` ()   BEGIN 
	SELECT * FROM book
    WHERE 
    book.is_deleted = 0 
    ORDER BY book.price;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllBooksOrderByPublishYear` ()   BEGIN 
	SELECT * FROM book
    WHERE 
    book.is_deleted = 0
    ORDER BY book.publishing_year;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllGenre` ()   BEGIN 
	SELECT * FROM genre 
    WHERE 
    genre.is_deleted = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllPublisher` ()   BEGIN 
	SELECT * FROM publisher
    WHERE
    publisher.is_deleted = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAuthorById` (IN `idIN` INT)   BEGIN
	SELECT * FROM author
    WHERE 
    author.id = idIN 
    AND 
    author.is_deleted = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getBasketById` (IN `idIN` INT)   BEGIN 
	SELECT * FROM basket
    WHERE 
    basket.id = idIN
    AND
    basket.is_deleted = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getBasketByUserId` (IN `userIdIN` INT)   BEGIN 
	SELECT * FROM basket 
    WHERE 
    basket.user_id = userIdIN 
    AND 
    basket.is_deleted = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getBasketProductById` (IN `idIN` INT)   BEGIN 
	SELECT * FROM basket_product
    WHERE 
    basket_product.id = idIN 
    AND 
    basket_product.is_deleted = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getBookById` (IN `idIN` INT)   BEGIN 
	SELECT * FROM book 
    WHERE
    book.is_deleted = 0
    AND 
    book.id = idIN
    ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getGenreById` (IN `idIN` INT)   BEGIN 
	SELECT * FROM genre
    WHERE 
    genre.id = idIN 
    AND 
    genre.is_deleted = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getMostSuccessfullyBooks` ()   BEGIN 
	SELECT * FROM book LIMIT 3;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getOrderHistoriesByEmail` (IN `emailIN` VARCHAR(255))   BEGIN 
	SELECT * FROM order_history oh 
    WHERE 
    oh.email = emailIN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getOrderHistoryById` (IN `idIN` INT)   BEGIN 
	SELECT * FROM order_history
    WHERE 
    order_history.id = idIN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getOrderHistoryByUserId` (IN `userIdIN` INT)   BEGIN 
	SELECT * FROM order_history
    WHERE 
    order_history.user_id = userIdIN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getPaymentMethodById` (IN `idIN` INT)   BEGIN 
	SELECT * FROM payment_method
    WHERE 
    payment_method.id = idIN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getPublisherById` (IN `idIN` INT)   BEGIN 
	SELECT * FROM publisher 
    WHERE 
    publisher.id = idIN
    AND 
    publisher.is_deleted = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getReviewById` (IN `idIN` INT)   BEGIN 
	SELECT * FROM review
    WHERE 
    review.id = idIN
    AND 
    review.is_deleted = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserByEmail` (IN `emailIN` VARCHAR(255))   BEGIN
	SELECT * FROM user u 
    WHERE 
    u.email = emailIN
    AND 
    u.is_deleted = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserById` (IN `idIN` INT)   BEGIN 
	SELECT * FROM user u 
    WHERE 
    u.id = idIN AND 
    u.is_deleted = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserByUsername` (IN `usernameIN` VARCHAR(255))   BEGIN 
	SELECT * FROM user u
    WHERE 
    u.username = usernameIN
     AND 
    u.is_deleted = 0;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `address_type`
--

CREATE TABLE `address_type` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `address_type`
--

INSERT INTO `address_type` (`id`, `name`) VALUES
(1, 'Home'),
(2, 'Office'),
(3, 'akna'),
(4, 'alja'),
(5, 'almáskert'),
(6, 'alsó'),
(7, 'alsósor'),
(8, 'aluljáró'),
(9, 'autópálya'),
(10, 'autóversenypálya'),
(11, 'állomás'),
(12, 'árok'),
(13, 'átjáró'),
(14, 'barakképület'),
(15, 'bánya'),
(16, 'bányatelep'),
(17, 'bekötőút'),
(18, 'benzinkút'),
(19, 'bérc'),
(20, 'bisztró'),
(21, 'bokor'),
(22, 'burgundia'),
(23, 'büfé'),
(24, 'camping'),
(25, 'campingsor'),
(26, 'centrum'),
(27, 'célgazdaság'),
(28, 'csapás'),
(29, 'csarnok'),
(30, 'csárda'),
(31, 'cser'),
(32, 'domb'),
(33, 'dunapart'),
(34, 'dunasor'),
(35, 'dűlő'),
(36, 'dűlője'),
(37, 'dűlők'),
(38, 'dűlőút'),
(39, 'egyesület'),
(40, 'egyéb'),
(41, 'elágazás'),
(42, 'erdészház'),
(43, 'erdészlak'),
(44, 'erdő'),
(45, 'erdősarok'),
(46, 'erdősor'),
(47, 'épület'),
(48, 'épületek'),
(49, 'észak'),
(50, 'étterem'),
(51, 'falu'),
(52, 'farm'),
(53, 'fasor'),
(54, 'fasora'),
(55, 'feketeerdő'),
(56, 'feketeföldek'),
(57, 'felső'),
(58, 'felsősor'),
(59, 'fennsík'),
(60, 'fogadó'),
(61, 'fok'),
(62, 'forduló'),
(63, 'forrás'),
(64, 'föld'),
(65, 'földek'),
(66, 'földje'),
(67, 'főtér'),
(68, 'főút'),
(69, 'fürdő'),
(70, 'fürdőhely'),
(71, 'fürésztelepe'),
(72, 'gazdaság'),
(73, 'gát'),
(74, 'gátőrház'),
(75, 'gátsor'),
(76, 'gimnázium'),
(77, 'gödör'),
(78, 'gulyakút'),
(79, 'gyár'),
(80, 'gyártelep'),
(81, 'halom'),
(82, 'határ'),
(83, 'határátkelőhely'),
(84, 'határrész'),
(85, 'határsor'),
(86, 'határút'),
(87, 'hatházak'),
(88, 'hát'),
(89, 'ház'),
(90, 'háza'),
(91, 'házak'),
(92, 'hegy'),
(93, 'hegyhát'),
(94, 'hegyhát dűlő'),
(95, 'hely'),
(96, 'hivatal'),
(97, 'híd'),
(98, 'hídfő'),
(99, 'horgásztanya'),
(100, 'hotel'),
(101, 'I'),
(102, 'I.'),
(103, 'II.'),
(104, 'III'),
(105, 'III.'),
(106, 'intézet'),
(107, 'ipari park'),
(108, 'ipartelep'),
(109, 'iparterület'),
(110, 'irodaház'),
(111, 'iskola'),
(112, 'IV'),
(113, 'IV.'),
(114, 'IX'),
(115, 'jánoshegy'),
(116, 'járás'),
(117, 'juhászház'),
(118, 'kapcsolóház'),
(119, 'kapu'),
(120, 'kastély'),
(121, 'kálvária'),
(122, 'kemping'),
(123, 'kert'),
(124, 'kertek'),
(125, 'kertek-köze'),
(126, 'kertsor'),
(127, 'kertváros'),
(128, 'kerület'),
(129, 'kikötő'),
(130, 'kilátó'),
(131, 'kishajtás'),
(132, 'kitérő'),
(133, 'kocsiszín'),
(134, 'kolónia'),
(135, 'korzó'),
(136, 'kórház'),
(137, 'körönd'),
(138, 'körtér'),
(139, 'körút'),
(140, 'körútja'),
(141, 'körvasútsor'),
(142, 'körzet'),
(143, 'köz'),
(144, 'köze'),
(145, 'középsor'),
(146, 'központ'),
(147, 'kút'),
(148, 'kútház'),
(149, 'Külkerület'),
(150, 'kültelek'),
(151, 'külterület'),
(152, 'külterülete'),
(153, 'lakás'),
(154, 'lakások'),
(155, 'lakóház'),
(156, 'lakókert'),
(157, 'lakónegyed'),
(158, 'lakópark'),
(159, 'lakótelep'),
(160, 'laktanya'),
(161, 'legelő'),
(162, 'lejáró'),
(163, 'lejtő'),
(164, 'lépcső'),
(165, 'liget'),
(166, 'lovasiskola'),
(167, 'magánút'),
(168, 'major'),
(169, 'malom'),
(170, 'malomsor'),
(171, 'megálló'),
(172, 'mellékköz'),
(173, 'mező'),
(174, 'mélyút'),
(175, 'munkásszálló'),
(176, 'műút'),
(177, 'nagymajor'),
(178, 'nagyút'),
(179, 'nádgazdaság'),
(180, 'negyed'),
(181, 'nyaraló'),
(182, 'oldal'),
(183, 'országút'),
(184, 'otthon'),
(185, 'otthona'),
(186, 'öböl'),
(187, 'öregszőlők'),
(188, 'ösvény'),
(189, 'ötház'),
(190, 'övezet'),
(191, 'őrház'),
(192, 'őrházak'),
(193, 'pagony'),
(194, 'pallag'),
(195, 'palota'),
(196, 'park'),
(197, 'parkfalu'),
(198, 'parkja'),
(199, 'parkoló'),
(200, 'part'),
(201, 'pavilonsor'),
(202, 'pálya'),
(203, 'pályafenntartás'),
(204, 'pályaudvar'),
(205, 'piac'),
(206, 'pihenő'),
(207, 'pihenőhely'),
(208, 'pihenőpark'),
(209, 'pince'),
(210, 'pinceköz'),
(211, 'pincesor'),
(212, 'présházak'),
(213, 'puszta'),
(214, 'rakodó'),
(215, 'rakpart'),
(216, 'repülőtér'),
(217, 'rész'),
(218, 'rét'),
(219, 'rétek'),
(220, 'rév'),
(221, 'ring'),
(222, 'sarok'),
(223, 'sertéstelep'),
(224, 'sétatér'),
(225, 'sétány'),
(226, 'sikátor'),
(227, 'sor'),
(228, 'sora'),
(229, 'sportpálya'),
(230, 'sporttelep'),
(231, 'stadion'),
(232, 'strand'),
(233, 'strandfürdő'),
(234, 'sugárút'),
(235, 'szakiskola'),
(236, 'szállás'),
(237, 'szálló'),
(238, 'szárító'),
(239, 'szárnyasliget'),
(240, 'szektor'),
(241, 'szer'),
(242, 'szél'),
(243, 'széle'),
(244, 'sziget'),
(245, 'szigete'),
(246, 'szivattyútelep'),
(247, 'szög'),
(248, 'szőlő'),
(249, 'szőlőhegy'),
(250, 'szőlők'),
(251, 'szőlőkert'),
(252, 'szőlős'),
(253, 'szőlősor'),
(254, 'tag'),
(255, 'tanya'),
(256, 'tanyaközpont'),
(257, 'tanyák'),
(258, 'tavak'),
(259, 'tábor'),
(260, 'tároló'),
(261, 'társasház'),
(262, 'teherpályaudvar'),
(263, 'telek'),
(264, 'telep'),
(265, 'telepek'),
(266, 'település'),
(267, 'temető'),
(268, 'tere'),
(269, 'terményraktár'),
(270, 'terület'),
(271, 'teteje'),
(272, 'tető'),
(273, 'téglagyár'),
(274, 'tér'),
(275, 'tormás'),
(276, 'torony'),
(277, 'tó'),
(278, 'tópart'),
(279, 'tömb'),
(280, 'TSZ'),
(281, 'turistaház'),
(282, 'udvar'),
(283, 'udvara'),
(284, 'utca'),
(285, 'utcája'),
(286, 'újfalu'),
(287, 'újsor'),
(288, 'újtelep'),
(289, 'út'),
(290, 'útfél'),
(291, 'útgyűrű'),
(292, 'útja'),
(293, 'üdülő'),
(294, 'üdülő központ'),
(295, 'üdülő park'),
(296, 'üdülők'),
(297, 'üdülőközpont'),
(298, 'üdülőpart'),
(299, 'üdülő-part'),
(300, 'üdülősor'),
(301, 'üdülő-sor'),
(302, 'üdülőtelep'),
(303, 'üdülő-telep'),
(304, 'üdülőterület'),
(305, 'üzem'),
(306, 'üzletház'),
(307, 'üzletsor'),
(308, 'V'),
(309, 'V.'),
(310, 'vadászház'),
(311, 'varroda'),
(312, 'vasútállomás'),
(313, 'vasúti megálló'),
(314, 'vasúti őrház'),
(315, 'vasútsor'),
(316, 'vám'),
(317, 'vár'),
(318, 'város'),
(319, 'vásártér'),
(320, 'vendéglő'),
(321, 'vég'),
(322, 'VI'),
(323, 'VI.'),
(324, 'VII'),
(325, 'VII.'),
(326, 'VIII'),
(327, 'VIII.'),
(328, 'villa'),
(329, 'villasor'),
(330, 'vízmű'),
(331, 'vízmű telep'),
(332, 'víztároló'),
(333, 'völgy'),
(334, 'X'),
(335, 'X.'),
(336, 'zsilip'),
(337, 'zug');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `author`
--

CREATE TABLE `author` (
  `id` int(11) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `author`
--

INSERT INTO `author` (`id`, `first_name`, `middle_name`, `last_name`, `is_deleted`, `deleted_at`) VALUES
(1, 'John', NULL, 'Writer', 0, NULL),
(2, 'Emily', 'A.', 'Johnson', 0, NULL),
(3, 'John', NULL, 'Miller', 0, NULL),
(4, 'Emma', 'Grace', 'Thompson', 0, NULL),
(5, 'Peter', NULL, 'Anderson', 0, NULL),
(6, 'Michael', 'James', 'Brown', 0, NULL),
(7, 'Helen', NULL, 'Wilson', 0, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `basket`
--

CREATE TABLE `basket` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `total_price` int(11) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `basket`
--

INSERT INTO `basket` (`id`, `user_id`, `last_modified`, `total_price`, `is_deleted`, `deleted_at`) VALUES
(1, 2, '2025-12-02 09:40:40', 3500, 0, NULL),
(2, 3, '2025-12-02 09:40:40', 4200, 0, NULL),
(3, NULL, NULL, NULL, NULL, NULL),
(4, 11, NULL, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `basket_product`
--

CREATE TABLE `basket_product` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `basket_id` int(11) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `added_at` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `basket_product`
--

INSERT INTO `basket_product` (`id`, `product_id`, `basket_id`, `amount`, `added_at`, `is_deleted`, `deleted_at`) VALUES
(9, 17, 4, 1, '2026-02-08 16:41:19', 1, '2026-02-15 08:25:45'),
(10, 17, 4, 1, '2026-02-15 10:11:31', 1, '2026-02-27 10:52:27'),
(11, 16, 4, 1, '2026-02-15 10:11:34', 1, '2026-02-16 17:44:42'),
(12, 15, 4, 1, '2026-02-15 10:14:21', 1, '2026-02-27 10:52:07'),
(13, 14, 4, 1, '2026-02-15 10:14:25', 1, '2026-02-27 10:52:06'),
(14, 17, 4, 1, '2026-02-27 09:10:27', 1, '2026-02-27 10:52:06'),
(15, 17, 4, 1, '2026-02-27 09:10:28', 1, '2026-02-27 10:52:06'),
(16, 2, 4, 1, '2026-02-27 09:10:33', 1, '2026-02-27 10:52:05'),
(17, 2, 4, 1, '2026-02-27 09:10:34', 1, '2026-02-27 10:52:05'),
(18, 2, 4, 1, '2026-02-27 09:10:36', 1, '2026-02-27 10:52:05'),
(19, 2, 4, 1, '2026-02-27 09:10:36', 1, '2026-02-27 10:52:05'),
(20, 1, 4, 1, '2026-02-27 10:46:36', 1, '2026-02-27 10:51:59'),
(21, 1, 4, 1, '2026-02-27 10:46:37', 1, '2026-02-27 10:52:00'),
(22, 1, 4, 1, '2026-02-27 10:46:37', 1, '2026-02-27 10:52:00'),
(23, 2, 4, 1, '2026-02-27 10:51:39', 1, '2026-02-27 10:52:01'),
(24, 2, 4, 1, '2026-02-27 10:51:41', 1, '2026-02-27 10:52:01'),
(25, 2, 4, 1, '2026-02-27 10:51:42', 1, '2026-02-27 10:52:01'),
(26, 2, 4, 1, '2026-02-27 10:51:42', 1, '2026-02-27 10:52:01'),
(27, 2, 4, 1, '2026-02-27 10:51:43', 1, '2026-02-27 10:52:02'),
(28, 2, 4, 1, '2026-02-27 10:51:45', 1, '2026-02-27 10:52:02'),
(29, 2, 4, 1, '2026-02-27 10:51:46', 1, '2026-02-27 10:52:02'),
(30, 2, 4, 1, '2026-02-27 10:51:47', 1, '2026-02-27 10:52:02'),
(31, 2, 4, 1, '2026-02-27 10:51:47', 1, '2026-02-27 10:52:03'),
(32, 2, 4, 1, '2026-02-27 10:51:47', 1, '2026-02-27 10:52:03'),
(33, 2, 4, 1, '2026-02-27 10:51:47', 1, '2026-02-27 10:52:03'),
(34, 2, 4, 1, '2026-02-27 10:51:47', 1, '2026-02-27 10:52:03'),
(35, 2, 4, 1, '2026-02-27 10:51:48', 1, '2026-02-27 10:52:04'),
(36, 2, 4, 1, '2026-02-27 10:51:48', 1, '2026-02-27 10:52:04'),
(37, 2, 4, 1, '2026-02-27 10:51:48', 1, '2026-02-27 10:52:04'),
(38, 2, 4, 1, '2026-02-27 10:51:48', 1, '2026-02-27 10:52:04'),
(39, 2, 4, 1, '2026-02-27 10:52:32', 1, '2026-02-27 10:52:50'),
(40, 2, 4, 39, '2026-02-27 10:52:33', 1, '2026-02-27 10:53:07'),
(41, 2, 4, 1, '2026-02-27 10:52:40', 1, '2026-02-27 10:52:51'),
(42, 2, 4, 1, '2026-02-27 10:52:41', 1, '2026-02-27 10:52:52'),
(43, 2, 4, 1, '2026-02-27 10:52:41', 1, '2026-02-27 10:52:53'),
(44, 16, 4, 1, '2026-02-27 10:53:16', 0, NULL),
(45, 16, 4, 1, '2026-02-27 10:53:17', 0, NULL),
(46, 10, 4, 1, '2026-02-27 10:53:44', 0, NULL),
(47, 10, 4, 1, '2026-02-27 10:53:45', 0, NULL),
(48, 10, 4, 1, '2026-02-27 10:53:45', 0, NULL),
(49, 1, 4, 1, '2026-02-27 11:30:37', 0, NULL),
(50, 1, 4, 1, '2026-02-27 11:30:38', 0, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `billing_detail`
--

CREATE TABLE `billing_detail` (
  `id` int(11) NOT NULL,
  `post_code` int(11) DEFAULT NULL,
  `town` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `address_type_id` int(11) DEFAULT NULL,
  `house_number` int(11) DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `company_tax_number` varchar(255) DEFAULT NULL,
  `other` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `billing_detail`
--

INSERT INTO `billing_detail` (`id`, `post_code`, `town`, `address`, `address_type_id`, `house_number`, `company_name`, `company_tax_number`, `other`) VALUES
(1, 1234, 'Budapest', 'Main street', 1, 12, NULL, NULL, NULL),
(2, 5678, 'Debrecen', 'Market street', 2, 5, 'Tech Ltd.', 'HU12345678', NULL),
(3, 32, 'asf', 'asf', NULL, 32, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `book`
--

CREATE TABLE `book` (
  `id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` longtext,
  `ISBN` varchar(255) DEFAULT NULL,
  `publishing_year` int(4) NOT NULL,
  `cover_image_path` varchar(1111) NOT NULL DEFAULT 'asd',
  `stock_quantity` int(11) NOT NULL,
  `publisher_id` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `book`
--

INSERT INTO `book` (`id`, `title`, `description`, `ISBN`, `publishing_year`, `cover_image_path`, `stock_quantity`, `publisher_id`, `price`, `is_deleted`, `deleted_at`, `created_at`) VALUES
(1, 'Harry Potter and the Sorcerer\'s Storm', 'Harry korai éveit követi a Hogwartsban, amikor egy titokzatos mágikus vihar kezd terjedni. Furcsa események történnek az iskolában, és Harrynek barátaival fel kell tárnia a vihar forrását. Ha nem sikerül, a varázsló- és a mugli világ egyaránt veszélybe kerülhet.', 'ISBN123456', 2002, 'http://localhost:8080/coverImg/hp1.jpg', 18, 1, 3500, 0, NULL, '2026-01-22 21:02:28'),
(2, 'Harry Potter and the Chamber of Secrets', 'Harry visszatér a Hogwartsba a második évére, ahol egy rejtélyes erő támadja a diákokat és kővé változtatja őket. Harry nyomokat talál egy rejtett kamráról és egy sötét titokról. Az iskola múltja veszélybe kerül, miközben a félelem nő.', 'ISBN987654', 1998, 'http://localhost:8080/coverImg/hp2.jpg', 78, 2, 4200, 0, NULL, '2026-01-22 21:02:28'),
(3, 'Harry Potter and the Prisoner of Azkaban', 'Harry harmadik évében megtudja, hogy Sirius Black, egy veszélyes fogoly megszökött az Azkabánból, és talán őt keresi. Ahogy múltbéli titkok kerülnek felszínre, Harry felfedezi az igazságot az árulásról, barátságról és saját történetéről.', 'ISBN123001', 1999, 'http://localhost:8080/coverImg/hp3.jpg', 15, 3, 3990, 0, NULL, '2026-01-22 21:02:28'),
(4, 'Harry Potter and the Goblet of Fire', 'Harry negyedik évében váratlanul kiválasztják a veszélyes Tűz Serlege Tornára. Halálos kihívásokkal néz szembe, miközben egy sötétebb fenyegetés kezd emelkedni. A kaland sokkoló és életre szóló összecsapáshoz vezet.', 'ISBN123002', 2000, 'http://localhost:8080/coverImg/hp4.jpg', 15, 5, 4490, 0, NULL, '2026-01-22 21:02:28'),
(5, 'Harry Potter and the Order of the Phoenix', 'Harry ötödik évében Voldemort visszatérését sokan nem hiszik el, miközben egy szigorú új hatalom veszi át az iskola irányítását. A feszültség nő, és Harry titkos csoportot hoz létre. Céljuk felkészülni a veszélyekre és szembenézni a terjedő sötétséggel.', 'ISBN123003', 2003, 'http://localhost:8080/coverImg/hp5.jpg', 15, 2, 4290, 0, NULL, '2026-01-22 21:02:28'),
(6, 'Harry Potter and the Half-Blood Prince', 'Harry hatodik évében felfedez egy régi bájitalkönyvet, amelyet a titokzatos „Félvér Herceg” jelöl. Többet tud meg Voldemort múltjáról, és Dumbledore-ral együtt felkészülnek a közelgő végső harcra.', 'ISBN123004', 2005, 'http://localhost:8080/coverImg/hp6.jpg', 15, 6, 4990, 0, NULL, '2026-01-22 21:02:28'),
(7, 'Harry Potter and the Deathly Hallows', 'Harry elhagyja a Hogwartsot Ronnal és Hermionéval, hogy megsemmisítse Voldemort Horcruxait. A varázslóvilág a sötétségbe süllyed, miközben Harry végső harcot vív a gonosz ellen. Barátság, bátorság és áldozat formálja sorsukat.', 'ISBN123005', 2007, 'http://localhost:8080/coverImg/hp7.jpg', 15, 1, 3890, 0, NULL, '2026-01-22 21:02:28'),
(8, 'Dune', 'Arrakis sivatagos bolygóján Paul Atreides családja a drága fűszer, a melange birtoklásáért küzd. Árulás, politikai játszmák és konfliktusok közepette Paulnak el kell fogadnia sorsát. A bolygó és népe jövője forog kockán.', 'ISBN123006', 1965, 'http://localhost:8080/coverImg/dune.jpg', 15, 7, 4190, 0, NULL, '2026-01-22 21:02:28'),
(9, 'Children of Dune', 'Paul Atreides örökösei próbálják fenntartani hatalmukat Arrakison, miközben politikai összeesküvések és ökológiai kihívások fenyegetnek. Misztikus látomások és új képességek alakítják a bolygó és lakói sorsát.', 'ISBN123007', 1976, 'http://localhost:8080/coverImg/dune2.jpg', 15, 4, 4690, 0, NULL, '2026-01-22 21:02:28'),
(10, 'Dune: The Prophet', 'Tizenkét évvel Dune után Paul Atreides a galaxis uralkodója. Politikai összeesküvések, vallási fanatizmus és személyes veszteségek próbára teszik. Paulnak meg kell védenie látomását és Arrakis jövőjét.', 'ISBN123008', 1969, 'http://localhost:8080/coverImg/dune3.jpg', 15, 3, 3790, 0, NULL, '2026-01-22 21:02:28'),
(11, 'God Emperor of Dune', 'Évezredekkel Dune Messiah után Leto II szinte halhatatlan lényként uralja a galaxist. Kemény uralma az emberiség távoli jövőjét célozza, miközben az irányítás, a próféták és az áldozatok egyensúlyát keresi.', 'ISBN123009', 1981, 'http://localhost:8080/coverImg/dune4.jpg', 15, 5, 3490, 0, NULL, '2026-01-22 21:02:28'),
(12, 'The Great Gatsby', 'A Roaring Twenties idején Jay Gatsby, egy gazdag és titokzatos férfi, a házas Daisy Buchanan után vágyakozik. A történet a szerelemről, ambícióról és az amerikai álomról szól. A fényűzés és erkölcsi romlás hátterében bontakozik ki a cselekmény.', 'ISBN123010', 1925, 'http://localhost:8080/coverImg/gatsby.jpg', 15, 2, 4090, 0, NULL, '2026-01-22 21:02:28'),
(13, 'The Hobbit', 'Bilbo Baggins, egy békés hobbit, egy kalandos küldetésre indul, hogy segítse a törpéket, akik vissza akarják szerezni hazájukat Smaug sárkánytól. Útja során trollokkal, goblinokkal és varázslatos lényekkel találkozik, ami örökre megváltoztatja életét.', 'ISBN123011', 1937, 'http://localhost:8080/coverImg/hobbit.jpg', 15, 6, 3890, 0, NULL, '2026-01-22 21:02:28'),
(14, 'The Lord of the Rings', 'Frodo Baggins veszélyes küldetésre indul, hogy megsemmisítse az Egy Gyűrűt és legyőzze Sauront. A Társaság tagjaival epikus csatákkal, veszélyes tájakkal és bátorságpróbákkal szembesül. Középfölde sorsa forog kockán.', 'ISBN123012', 1955, 'http://localhost:8080/coverImg/lord1.jpg', 15, 1, 3690, 0, NULL, '2026-01-22 21:02:28'),
(15, 'The Return of the King', 'A The Lord of the Rings utolsó része a Középfölde végső csatáit követi. Frodo küzdelme az Egy Gyűrű megsemmisítéséért, a bátorság, barátság és áldozat története formálja a királyságok sorsát. A sötétség feletti végső győzelem bontakozik ki.', 'ISBN123013', 1955, 'http://localhost:8080/coverImg/lord2.jpg', 15, 7, 3590, 0, NULL, '2026-01-22 21:02:28'),
(16, 'A Dance with Dragons', 'Westeros világában rivális frakciók harcolnak a hatalomért. Jon Snow a Fal védelméért küzd, míg Daenerys Targaryen próbálja irányítani Meereent. Politikailag intrikák, árulások és háborúk formálják a Hét Királyság sorsát.', 'ISBN123014', 2011, 'http://localhost:8080/coverImg/dance.jpg', 15, 4, 3290, 0, NULL, '2026-01-22 21:02:28'),
(17, 'A Game of Thrones', 'A Hét Királyság nemesi családjai a Vastrónért küzdenek, miközben a Falon túl sötét erők gyülekeznek. Politikailag intrikák, árulások és háborúk közepette a döntések halálos következményekkel járhatnak. A hatalmi harcok alakítják a birodalom sorsát.', 'ISBN123015', 1996, 'http://localhost:8080/coverImg/thrones1.jpg', 19, 2, 3390, 0, NULL, '2026-01-22 21:02:28');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `book_author`
--

CREATE TABLE `book_author` (
  `id` int(11) NOT NULL,
  `book_id` int(11) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `book_author`
--

INSERT INTO `book_author` (`id`, `book_id`, `author_id`, `is_deleted`, `deleted_at`) VALUES
(1, 1, 1, 0, NULL),
(2, 2, 2, 0, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `book_genre`
--

CREATE TABLE `book_genre` (
  `id` int(11) NOT NULL,
  `book_id` int(11) DEFAULT NULL,
  `genre_id` int(11) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `book_genre`
--

INSERT INTO `book_genre` (`id`, `book_id`, `genre_id`, `is_deleted`, `deleted_at`) VALUES
(1, 1, 1, 0, NULL),
(2, 1, 3, 0, NULL),
(3, 2, 2, 0, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `genre`
--

CREATE TABLE `genre` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `genre`
--

INSERT INTO `genre` (`id`, `name`, `is_deleted`, `deleted_at`) VALUES
(1, 'Adventure', 0, NULL),
(2, 'Education', 0, NULL),
(3, 'Fantasy', 0, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `order_history`
--

CREATE TABLE `order_history` (
  `id` int(11) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `billing_detail_id` int(11) DEFAULT NULL,
  `transport_detail_id` int(11) DEFAULT NULL,
  `payment_method_id` int(11) DEFAULT NULL,
  `status_id` int(11) NOT NULL,
  `ordered_at` datetime DEFAULT NULL,
  `canceled_at` datetime DEFAULT NULL,
  `is_canceled` tinyint(1) DEFAULT NULL,
  `canceler_user_id` int(11) DEFAULT NULL,
  `canceler_email` varchar(255) DEFAULT NULL,
  `canceler_v_code` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `order_history`
--

INSERT INTO `order_history` (`id`, `first_name`, `last_name`, `phone`, `email`, `user_id`, `billing_detail_id`, `transport_detail_id`, `payment_method_id`, `status_id`, `ordered_at`, `canceled_at`, `is_canceled`, `canceler_user_id`, `canceler_email`, `canceler_v_code`) VALUES
(1, 'John', 'Doe', '111222333', 'john@example.com', 11, 1, 1, 1, 1, '2025-12-02 09:42:37', NULL, 0, NULL, NULL, NULL),
(2, 'Jane', 'Smith', '444555666', 'jane@example.com', 11, 2, 2, 2, 1, '2025-12-02 09:42:37', '2025-12-02 09:42:37', 1, 1, 'admin@example.com', 'ABC123'),
(3, 'asf', 'asf', '06706285232', 'sasd@gmail.com', 11, 3, 3, 2, 1, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `order_history_product`
--

CREATE TABLE `order_history_product` (
  `id` int(11) NOT NULL,
  `order_history_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `order_history_product`
--

INSERT INTO `order_history_product` (`id`, `order_history_id`, `product_id`, `amount`) VALUES
(1, 1, 1, 1),
(2, 2, 2, 1),
(3, NULL, 17, 1),
(4, NULL, 17, 1),
(5, NULL, 16, 1),
(6, NULL, 15, 1),
(7, NULL, 14, 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `payment_method`
--

CREATE TABLE `payment_method` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `payment_method`
--

INSERT INTO `payment_method` (`id`, `name`) VALUES
(1, 'Credit Card'),
(2, 'PayPal'),
(3, 'Bank Transfer');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `publisher`
--

CREATE TABLE `publisher` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `isbn_sign` varchar(11) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `publisher`
--

INSERT INTO `publisher` (`id`, `name`, `email`, `phone`, `isbn_sign`, `is_deleted`, `deleted_at`) VALUES
(1, 'Penguin Books', 'contact@penguin.com', '12345678', '', 0, NULL),
(2, 'HarperCollins', 'info@harpercollins.com', '87654321', '', 0, NULL),
(3, 'Silver Leaf Publishing', 'contact@silverleaf.com', '001555123456', '', 0, NULL),
(4, 'North Star Books', 'info@northstarbooks.com', '001555123457', '', 0, NULL),
(5, 'Blue Horizon Press', 'support@bluehorizonpress.com', '001555123458', '', 0, NULL),
(6, 'Oak Tree Publishing', 'hello@oaktreepublishing.com', '001555123459', '', 0, NULL),
(7, 'Riverstone Media', 'office@riverstonemedia.com', '001555123460', '', 0, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `review`
--

CREATE TABLE `review` (
  `id` int(11) NOT NULL,
  `review_text` varchar(255) DEFAULT NULL,
  `rating` float DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `is_anonymus` tinyint(1) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `review`
--

INSERT INTO `review` (`id`, `review_text`, `rating`, `user_id`, `product_id`, `is_anonymus`, `is_deleted`, `deleted_at`) VALUES
(1, 'Nagyon jó könyv!', 4.5, 2, 1, 0, 0, NULL),
(2, 'Hasznos SQL tananyag!', 5, 3, 2, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `role`
--

CREATE TABLE `role` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `role`
--

INSERT INTO `role` (`id`, `name`, `is_deleted`, `deleted_at`) VALUES
(1, 'ROLE_admin', 0, NULL),
(2, 'ROLE_user', 0, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `status`
--

CREATE TABLE `status` (
  `id` int(11) NOT NULL,
  `name` varchar(111) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `status`
--

INSERT INTO `status` (`id`, `name`) VALUES
(1, 'Szállitás alatt'),
(2, 'Lemondott'),
(3, 'Kiszálitott');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `transport_detail`
--

CREATE TABLE `transport_detail` (
  `id` int(11) NOT NULL,
  `post_code` int(11) DEFAULT NULL,
  `town` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `address_type_id` int(11) DEFAULT NULL,
  `house_number` int(11) DEFAULT NULL,
  `other` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `transport_detail`
--

INSERT INTO `transport_detail` (`id`, `post_code`, `town`, `address`, `address_type_id`, `house_number`, `other`) VALUES
(1, 1234, 'Budapest', 'Main street', 1, 12, NULL),
(2, 5678, 'Debrecen', 'Market street', 2, 5, 'Leave package at reception'),
(3, 13, 'asfa', 'asfasf', 16, 23, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` longtext,
  `role_id` int(11) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `register_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `pfp_path` varchar(1111) NOT NULL DEFAULT 'asd',
  `v_code` varchar(1111) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `password`, `role_id`, `last_login`, `register_at`, `is_deleted`, `deleted_at`, `pfp_path`, `v_code`) VALUES
(1, 'admin', 'admin@example.com', 'hashed_pw_1', 1, '2025-12-02 09:37:05', '2025-12-02 08:37:05', 0, NULL, 'asd', ''),
(2, 'john_doe', 'john@example.com', 'hashed_pw_2', 2, '2025-12-02 09:37:05', '2025-12-02 08:37:05', 0, NULL, 'asd', ''),
(3, 'jane_smith', 'jane@example.com', 'hashed_pw_3', 2, '2025-12-02 09:37:05', '2025-12-02 08:37:05', 0, NULL, 'asd', ''),
(4, 'admin2', 'admin2@example.com', 'hashed_pw_4', 1, NULL, '2026-01-08 09:36:36', 0, NULL, 'asd', ''),
(5, 'john_smith', 'john.smith@example.com', 'hashed_pw_5', 2, NULL, '2026-01-08 09:36:36', 0, NULL, 'asd', ''),
(6, 'emma_johnson', 'emma.johnson@example.com', 'hashed_pw_6', 2, NULL, '2026-01-08 09:36:36', 0, NULL, 'asd', ''),
(7, 'michael_brown', 'michael.brown@example.com', 'hashed_pw_7', 2, NULL, '2026-01-08 09:36:36', 0, NULL, 'asd', ''),
(9, 'olivia_wilson', 'olivia.wilson@example.com', 'hashed_pw_8', 2, NULL, '2026-01-08 09:39:01', 0, NULL, 'asd', ''),
(11, 'testElek', 'asd@gmail.com', '$argon2id$v=19$m=4096,t=3,p=1$xevbL65AfAo3cPoTOnNecA$m96Mv15eQLkKHmFwDuxAVYkC6kVKLoaE/b84iArXrn0', 1, '2026-02-27 11:30:32', '2026-02-08 17:08:10', 0, NULL, 'default', NULL);

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `address_type`
--
ALTER TABLE `address_type`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `author`
--
ALTER TABLE `author`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `basket`
--
ALTER TABLE `basket`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- A tábla indexei `basket_product`
--
ALTER TABLE `basket_product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `basket_id` (`basket_id`);

--
-- A tábla indexei `billing_detail`
--
ALTER TABLE `billing_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `address_type_id` (`address_type_id`);

--
-- A tábla indexei `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`id`),
  ADD KEY `publisher_id` (`publisher_id`);

--
-- A tábla indexei `book_author`
--
ALTER TABLE `book_author`
  ADD PRIMARY KEY (`id`),
  ADD KEY `book_id` (`book_id`),
  ADD KEY `author_id` (`author_id`);

--
-- A tábla indexei `book_genre`
--
ALTER TABLE `book_genre`
  ADD PRIMARY KEY (`id`),
  ADD KEY `book_id` (`book_id`),
  ADD KEY `genre_id` (`genre_id`);

--
-- A tábla indexei `genre`
--
ALTER TABLE `genre`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `order_history`
--
ALTER TABLE `order_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `canceler_user_id` (`canceler_user_id`),
  ADD KEY `billing_detail_id` (`billing_detail_id`),
  ADD KEY `transport_detail_id` (`transport_detail_id`),
  ADD KEY `payment_method_id` (`payment_method_id`),
  ADD KEY `sta` (`status_id`);

--
-- A tábla indexei `order_history_product`
--
ALTER TABLE `order_history_product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_history_id` (`order_history_id`),
  ADD KEY `product_id` (`product_id`);

--
-- A tábla indexei `payment_method`
--
ALTER TABLE `payment_method`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `publisher`
--
ALTER TABLE `publisher`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- A tábla indexei `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `transport_detail`
--
ALTER TABLE `transport_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `address_type_id` (`address_type_id`);

--
-- A tábla indexei `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role_id` (`role_id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `address_type`
--
ALTER TABLE `address_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=338;

--
-- AUTO_INCREMENT a táblához `author`
--
ALTER TABLE `author`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT a táblához `basket`
--
ALTER TABLE `basket`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `basket_product`
--
ALTER TABLE `basket_product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT a táblához `billing_detail`
--
ALTER TABLE `billing_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `book`
--
ALTER TABLE `book`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT a táblához `book_author`
--
ALTER TABLE `book_author`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `book_genre`
--
ALTER TABLE `book_genre`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `genre`
--
ALTER TABLE `genre`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `order_history`
--
ALTER TABLE `order_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `order_history_product`
--
ALTER TABLE `order_history_product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT a táblához `payment_method`
--
ALTER TABLE `payment_method`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `publisher`
--
ALTER TABLE `publisher`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT a táblához `review`
--
ALTER TABLE `review`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `role`
--
ALTER TABLE `role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `status`
--
ALTER TABLE `status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `transport_detail`
--
ALTER TABLE `transport_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `basket`
--
ALTER TABLE `basket`
  ADD CONSTRAINT `basket_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Megkötések a táblához `basket_product`
--
ALTER TABLE `basket_product`
  ADD CONSTRAINT `basket_product_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `book` (`id`),
  ADD CONSTRAINT `basket_product_ibfk_2` FOREIGN KEY (`basket_id`) REFERENCES `basket` (`id`);

--
-- Megkötések a táblához `billing_detail`
--
ALTER TABLE `billing_detail`
  ADD CONSTRAINT `billing_detail_ibfk_1` FOREIGN KEY (`address_type_id`) REFERENCES `address_type` (`id`);

--
-- Megkötések a táblához `book`
--
ALTER TABLE `book`
  ADD CONSTRAINT `book_ibfk_2` FOREIGN KEY (`publisher_id`) REFERENCES `publisher` (`id`);

--
-- Megkötések a táblához `book_author`
--
ALTER TABLE `book_author`
  ADD CONSTRAINT `book_author_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `book` (`id`),
  ADD CONSTRAINT `book_author_ibfk_2` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`);

--
-- Megkötések a táblához `book_genre`
--
ALTER TABLE `book_genre`
  ADD CONSTRAINT `book_genre_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `book` (`id`),
  ADD CONSTRAINT `book_genre_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genre` (`id`);

--
-- Megkötések a táblához `order_history`
--
ALTER TABLE `order_history`
  ADD CONSTRAINT `order_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `order_history_ibfk_2` FOREIGN KEY (`canceler_user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `order_history_ibfk_3` FOREIGN KEY (`billing_detail_id`) REFERENCES `billing_detail` (`id`),
  ADD CONSTRAINT `order_history_ibfk_4` FOREIGN KEY (`transport_detail_id`) REFERENCES `transport_detail` (`id`),
  ADD CONSTRAINT `order_history_ibfk_5` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`id`),
  ADD CONSTRAINT `sta` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`);

--
-- Megkötések a táblához `order_history_product`
--
ALTER TABLE `order_history_product`
  ADD CONSTRAINT `order_history_product_ibfk_1` FOREIGN KEY (`order_history_id`) REFERENCES `order_history` (`id`),
  ADD CONSTRAINT `order_history_product_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `book` (`id`);

--
-- Megkötések a táblához `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `review_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `review_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `book` (`id`);

--
-- Megkötések a táblához `transport_detail`
--
ALTER TABLE `transport_detail`
  ADD CONSTRAINT `transport_detail_ibfk_1` FOREIGN KEY (`address_type_id`) REFERENCES `address_type` (`id`);

--
-- Megkötések a táblához `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
