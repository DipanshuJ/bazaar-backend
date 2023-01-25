
create database master;
use master;
create table user(
    id INT PRIMARY KEY AUTO_INCREMENT,
    email varchar(255) UNIQUE,
    password varchar(1024) NOT NULL
);

INSERT INTO user VALUES (1, 'adarshrawat.run@gmail.com', '12345678');

create database client1;
use client1;

CREATE TABLE user(
	user_id 	INT PRIMARY KEY AUTO_INCREMENT,
    name 		VARCHAR(255) NOT NULL,
    email 		VARCHAR(255) NOT NULL UNIQUE,
    password 	VARCHAR(255) NOT NULL
);

CREATE TABLE address(
	user_id 	INT NOT NULL,
    address_id 	INT PRIMARY KEY AUTO_INCREMENT,
    street1 	VARCHAR(255) NOT NULL,
    street2 	VARCHAR(255),
    city 		VARCHAR(50) NOT NULL,
    state		VARCHAR(50) NOT NULL,
    country 	VARCHAR(50) NOT NULL,
    zipcode 	DECIMAL(6) NOT NULL,
    phone 		VARCHAR(20) NOT NULL,
	CONSTRAINT address_user_id_fk FOREIGN KEY ( user_id )
        REFERENCES user ( user_id )
		ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE category (
    category_id 	INT PRIMARY KEY AUTO_INCREMENT,
    category_name 	VARCHAR(255) NOT NULL
);

CREATE TABLE product (
    product_id 		INT PRIMARY KEY AUTO_INCREMENT,
    name 			VARCHAR(255) NOT NULL,
    price 			DECIMAL(10, 2) NOT NULL,
    category_id     INT,
    description     VARCHAR(255),
    stock    		INT NOT NULL,
	CONSTRAINT product_category_id_fk FOREIGN KEY ( category_id )
        REFERENCES category ( category_id )
		ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE product_image (
    product_id   INT,
    image_url    VARCHAR(255),
    PRIMARY KEY  ( product_id, image_url )
);

-- CREATE TABLE payment_option(
-- 	payment_id 	INT PRIMARY KEY AUTO_INCREMENT,
--     desciption 	VARCHAR(200) NOT NULL
-- );


CREATE TABLE user_order(
    order_id              INT PRIMARY KEY AUTO_INCREMENT,
    buyer_id              INT,
    address_id 			  INT NOT NULL,
    total_price           DECIMAL(10, 2) NOT NULL,
    shipping_price        DECIMAL(4, 2) NOT NULL,
    order_date            DATETIME DEFAULT CURRENT_TIMESTAMP,
    shipping_date         DATETIME,
    delievered_date		  DATETIME,
    order_status          DECIMAL(1) DEFAULT 1,
    CONSTRAINT user_order_buyer_id_fk FOREIGN KEY ( buyer_id )
        REFERENCES user ( user_id )
		ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT user_order_address_id_fk FOREIGN KEY ( address_id )
        REFERENCES address ( address_id )
		ON DELETE NO ACTION ON UPDATE CASCADE
	
);
-- In order status, 1-order placed, 2-order-shipped, 3-order delievered

CREATE TABLE order_product (
    order_id     INT,
    product_id   INT,
    quantity INT NOT NULL,
    price INT NOT NULL,
    PRIMARY KEY ( order_id,
                  product_id ),
	CONSTRAINT order_product_order_id_fk FOREIGN KEY ( order_id )
        REFERENCES user_order ( order_id )
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT order_product_product_id_fk FOREIGN KEY ( product_id )
        REFERENCES product ( product_id )
		ON DELETE RESTRICT ON UPDATE CASCADE
);



insert into product (name, price, description, stock) values ("Samsung Galaxy M13", 14500, "This is Samsung Smartphone", 100), 
("Samsung Galaxy S22", 35000, "This is FlagShip Smartphone", 100);

insert into user (name, email, password) values ('Karik', 'kartik@gmail.com', '12345678'),
('Akshat Kotwalla', 'akshat@gmail.com', '12345678'),
('Tanish Jain', 'tanish@gmail.com', '12345678');

insert into address (user_id, street1, city, state, country, zipcode, phone) values
(1, "Murai Mohalla", 'Indore', 'Madhya Pradesh', 'India', 45120, '2145789632'),
(2, "Choti Gwaltoli", "Bhopal", "Madhya Pradesh", "India", 45470, '2222244444'),
(3, "Teen Imli", "Patna", "Bihar", 'India', 45810, '3333355555');


 insert into user_order (buyer_id, address_id, total_price, shipping_price) values 
 (1, 1, 4500, 50),
 (1, 1, 4000, 50),
 (3, 3, 50000, 50);