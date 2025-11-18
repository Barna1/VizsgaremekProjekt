-- -----------------------------------------------------
-- TABLE: role
-- -----------------------------------------------------
CREATE TABLE role (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    is_deleted BOOLEAN,
    deleted_at DATETIME
);

-- -----------------------------------------------------
-- TABLE: user
-- -----------------------------------------------------
CREATE TABLE user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255),
    email VARCHAR(255),
    password LONGTEXT,
    role_id INT,
    last_login DATETIME,
    register_at TIMESTAMP,
    is_deleted BOOLEAN,
    deleted_at DATETIME,
    FOREIGN KEY (role_id) REFERENCES role(id)
);

-- -----------------------------------------------------
-- TABLE: publisher
-- -----------------------------------------------------
CREATE TABLE publisher (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(255)
);

-- -----------------------------------------------------
-- TABLE: photo
-- -----------------------------------------------------
CREATE TABLE photo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    photo_1_path LONGTEXT,
    photo_2_path LONGTEXT,
    photo_3_path LONGTEXT,
    photo_4_path LONGTEXT,
    photo_5_path LONGTEXT,
    is_deleted BOOLEAN,
    deleted_at DATETIME
);

-- -----------------------------------------------------
-- TABLE: book
-- -----------------------------------------------------
CREATE TABLE book (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255),
    description LONGTEXT,
    ISBN VARCHAR(255),
    photo_list_id INT,
    publisher_id INT,
    price INT,
    is_deleted BOOLEAN,
    deleted_at DATETIME,
    FOREIGN KEY (photo_list_id) REFERENCES photo(id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(id)
);

-- -----------------------------------------------------
-- TABLE: genre
-- -----------------------------------------------------
CREATE TABLE genre (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    is_deleted BOOLEAN,
    deleted_at DATETIME
);

-- -----------------------------------------------------
-- TABLE: book_genre
-- -----------------------------------------------------
CREATE TABLE book_genre (
    id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT,
    genre_id INT,
    is_deleted BOOLEAN,
    deleted_at DATETIME,
    FOREIGN KEY (book_id) REFERENCES book(id),
    FOREIGN KEY (genre_id) REFERENCES genre(id)
);

-- -----------------------------------------------------
-- TABLE: author
-- -----------------------------------------------------
CREATE TABLE author (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255),
    middle_name VARCHAR(255),
    last_name VARCHAR(255),
    is_deleted BOOLEAN,
    deleted_at DATETIME
);

-- -----------------------------------------------------
-- TABLE: book_author
-- -----------------------------------------------------
CREATE TABLE book_author (
    id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT,
    author_id INT,
    is_deleted BOOLEAN,
    deleted_at DATETIME,
    FOREIGN KEY (book_id) REFERENCES book(id),
    FOREIGN KEY (author_id) REFERENCES author(id)
);

-- -----------------------------------------------------
-- TABLE: review
-- -----------------------------------------------------
CREATE TABLE review (
    id INT PRIMARY KEY AUTO_INCREMENT,
    review_text VARCHAR(255),
    rating FLOAT,
    user_id INT,
    product_id INT,
    is_anonymus BOOLEAN,
    is_deleted BOOLEAN,
    deleted_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES user(id),
    FOREIGN KEY (product_id) REFERENCES book(id)
);

-- -----------------------------------------------------
-- TABLE: basket
-- -----------------------------------------------------
CREATE TABLE basket (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    last_modified DATETIME,
    total_price INT,
    is_deleted BOOLEAN,
    deleted_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES user(id)
);

-- -----------------------------------------------------
-- TABLE: basket_product
-- -----------------------------------------------------
CREATE TABLE basket_product (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    basket_id INT,
    amount INT,
    added_at DATETIME,
    is_deleted BOOLEAN,
    deleted_at DATETIME,
    FOREIGN KEY (product_id) REFERENCES book(id),
    FOREIGN KEY (basket_id) REFERENCES basket(id)
);

-- -----------------------------------------------------
-- TABLE: payment_method
-- -----------------------------------------------------
CREATE TABLE payment_method (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255)
);

-- -----------------------------------------------------
-- TABLE: address_type
-- -----------------------------------------------------
CREATE TABLE address_type (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255)
);

-- -----------------------------------------------------
-- TABLE: billing_detail
-- -----------------------------------------------------
CREATE TABLE billing_detail (
    id INT PRIMARY KEY AUTO_INCREMENT,
    post_code INT,
    town VARCHAR(255),
    address VARCHAR(255),
    address_type_id INT,
    house_number INT,
    company_name VARCHAR(255),
    company_tax_number VARCHAR(255),
    other VARCHAR(255),
    FOREIGN KEY (address_type_id) REFERENCES address_type(id)
);

-- -----------------------------------------------------
-- TABLE: transport_detail
-- -----------------------------------------------------
CREATE TABLE transport_detail (
    id INT PRIMARY KEY AUTO_INCREMENT,
    post_code INT,
    town VARCHAR(255),
    address VARCHAR(255),
    address_type_id INT,
    house_number INT,
    other VARCHAR(255),
    FOREIGN KEY (address_type_id) REFERENCES address_type(id)
);

-- -----------------------------------------------------
-- TABLE: order_history
-- -----------------------------------------------------
CREATE TABLE order_history (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    phone VARCHAR(255),
    email VARCHAR(255),
    user_id INT,
    billing_detail_id INT,
    transport_detail_id INT,
    payment_method_id INT,
    ordered_at DATETIME,
    canceled_at DATETIME,
    is_canceled BOOLEAN,
    canceler_user_id INT,
    canceler_email VARCHAR(255),
    canceler_v_code VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES user(id),
    FOREIGN KEY (canceler_user_id) REFERENCES user(id),
    FOREIGN KEY (billing_detail_id) REFERENCES billing_detail(id),
    FOREIGN KEY (transport_detail_id) REFERENCES transport_detail(id),
    FOREIGN KEY (payment_method_id) REFERENCES payment_method(id)
);

-- -----------------------------------------------------
-- TABLE: order_history_product
-- -----------------------------------------------------
CREATE TABLE order_history_product (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_history_id INT,
    product_id INT,
    amount INT,
    FOREIGN KEY (order_history_id) REFERENCES order_history(id),
    FOREIGN KEY (product_id) REFERENCES book(id)
);
