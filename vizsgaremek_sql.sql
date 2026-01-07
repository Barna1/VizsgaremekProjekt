-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Gép: localhost:3306
-- Létrehozás ideje: 2026. Jan 07. 17:01
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
(2, 'Office');

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
(2, 'Emily', 'A.', 'Johnson', 0, NULL);

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
(2, 3, '2025-12-02 09:40:40', 4200, 0, NULL);

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
  `is_deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `basket_product`
--

INSERT INTO `basket_product` (`id`, `product_id`, `basket_id`, `amount`, `added_at`, `is_deleted`, `deleted_at`) VALUES
(1, 1, 1, 1, '2025-12-02 09:40:51', 0, NULL),
(2, 2, 2, 1, '2025-12-02 09:40:51', 0, NULL);

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
(2, 5678, 'Debrecen', 'Market street', 2, 5, 'Tech Ltd.', 'HU12345678', NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `book`
--

CREATE TABLE `book` (
  `id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` longtext,
  `ISBN` varchar(255) DEFAULT NULL,
  `photo_list_id` int(11) DEFAULT NULL,
  `publisher_id` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `book`
--

INSERT INTO `book` (`id`, `title`, `description`, `ISBN`, `photo_list_id`, `publisher_id`, `price`, `is_deleted`, `deleted_at`) VALUES
(1, 'The Great Adventure', 'Adventure novel description', 'ISBN123456', 1, 1, 3500, 0, NULL),
(2, 'Learning SQL', 'Database learning book', 'ISBN987654', 2, 2, 4200, 0, NULL);

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

INSERT INTO `order_history` (`id`, `first_name`, `last_name`, `phone`, `email`, `user_id`, `billing_detail_id`, `transport_detail_id`, `payment_method_id`, `ordered_at`, `canceled_at`, `is_canceled`, `canceler_user_id`, `canceler_email`, `canceler_v_code`) VALUES
(1, 'John', 'Doe', '111222333', 'john@example.com', 2, 1, 1, 1, '2025-12-02 09:42:37', NULL, 0, NULL, NULL, NULL),
(2, 'Jane', 'Smith', '444555666', 'jane@example.com', 3, 2, 2, 2, '2025-12-02 09:42:37', '2025-12-02 09:42:37', 1, 1, 'admin@example.com', 'ABC123');

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
(2, 2, 2, 1);

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
-- Tábla szerkezet ehhez a táblához `photo`
--

CREATE TABLE `photo` (
  `id` int(11) NOT NULL,
  `photo_1_path` longtext,
  `photo_2_path` longtext,
  `photo_3_path` longtext,
  `photo_4_path` longtext,
  `photo_5_path` longtext,
  `is_deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `photo`
--

INSERT INTO `photo` (`id`, `photo_1_path`, `photo_2_path`, `photo_3_path`, `photo_4_path`, `photo_5_path`, `is_deleted`, `deleted_at`) VALUES
(1, '/img/book1_1.jpg', '/img/book1_2.jpg', NULL, NULL, NULL, 0, NULL),
(2, '/img/book2_1.jpg', NULL, NULL, NULL, NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `publisher`
--

CREATE TABLE `publisher` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `publisher`
--

INSERT INTO `publisher` (`id`, `name`, `email`, `phone`) VALUES
(1, 'Penguin Books', 'contact@penguin.com', '12345678'),
(2, 'HarperCollins', 'info@harpercollins.com', '87654321');

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
(1, 'Admin', 0, NULL),
(2, 'User', 0, NULL);

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
(2, 5678, 'Debrecen', 'Market street', 2, 5, 'Leave package at reception');

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
  `is_deleted` tinyint(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `password`, `role_id`, `last_login`, `register_at`, `is_deleted`, `deleted_at`) VALUES
(1, 'admin', 'admin@example.com', 'hashed_pw_1', 1, '2025-12-02 09:37:05', '2025-12-02 08:37:05', 0, NULL),
(2, 'john_doe', 'john@example.com', 'hashed_pw_2', 2, '2025-12-02 09:37:05', '2025-12-02 08:37:05', 0, NULL),
(3, 'jane_smith', 'jane@example.com', 'hashed_pw_3', 2, '2025-12-02 09:37:05', '2025-12-02 08:37:05', 0, NULL);

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
  ADD KEY `photo_list_id` (`photo_list_id`),
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
  ADD KEY `payment_method_id` (`payment_method_id`);

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
-- A tábla indexei `photo`
--
ALTER TABLE `photo`
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `author`
--
ALTER TABLE `author`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `basket`
--
ALTER TABLE `basket`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `basket_product`
--
ALTER TABLE `basket_product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `billing_detail`
--
ALTER TABLE `billing_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `book`
--
ALTER TABLE `book`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `order_history_product`
--
ALTER TABLE `order_history_product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `payment_method`
--
ALTER TABLE `payment_method`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `photo`
--
ALTER TABLE `photo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `publisher`
--
ALTER TABLE `publisher`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
-- AUTO_INCREMENT a táblához `transport_detail`
--
ALTER TABLE `transport_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  ADD CONSTRAINT `book_ibfk_1` FOREIGN KEY (`photo_list_id`) REFERENCES `photo` (`id`),
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
  ADD CONSTRAINT `order_history_ibfk_5` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`id`);

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
