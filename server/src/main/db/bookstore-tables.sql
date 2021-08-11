SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'TRADITIONAL';

DROP SCHEMA IF EXISTS `XuBookstore`;
CREATE SCHEMA IF NOT EXISTS `XuBookstore`
    DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

USE `XuBookstore`;

-- -----------------------------------------------------
-- Table `XuBookstore`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `XuBookstore`.`customer`;

CREATE TABLE IF NOT EXISTS `XuBookstore`.`customer`
(
    `customer_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name`        VARCHAR(45)  NOT NULL,
    `email`       VARCHAR(45)  NOT NULL,
    `phone`       VARCHAR(45)  NOT NULL,
    `address`     VARCHAR(45)  NOT NULL,
    `cc_number`   VARCHAR(19)  NOT NULL,
    `cc_exp_Date`   VARCHAR(10)  NOT NULL,
    PRIMARY KEY (`customer_id`)
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 1001
    COMMENT = 'maintains customer details';


-- -----------------------------------------------------
-- Table `XuBookstore`.`customer_order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `XuBookstore`.`customer_order`;

CREATE TABLE IF NOT EXISTS `XuBookstore`.`customer_order`
(
    `customer_order_id`            INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `customer_id`         INT UNSIGNED NOT NULL,
    `amount`              INT UNSIGNED NOT NULL,
    `date_created`        TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `confirmation_number` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`customer_order_id`),
    INDEX `fk_order_customer` (`customer_id` ASC),
    CONSTRAINT `fk_order_customer`
        FOREIGN KEY (`customer_id`)
            REFERENCES `XuBookstore`.`customer` (`customer_id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 1001
    COMMENT = 'maintains customer order details';


-- -----------------------------------------------------
-- Table `XuBookstore`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `XuBookstore`.`category`;

CREATE TABLE IF NOT EXISTS `XuBookstore`.`category`
(
    `category_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name`        VARCHAR(45)  NOT NULL,
    PRIMARY KEY (`category_id`)
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 1001
    COMMENT = 'contains book categories, e.g., romantic, novel, etc.';


-- -----------------------------------------------------
-- Table `XuBookstore`.`book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `XuBookstore`.`book`;

CREATE TABLE IF NOT EXISTS `XuBookstore`.`book`
(
    `book_id`  INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `title`        VARCHAR(45)  NOT NULL,
    `author`      VARCHAR(45)  NOT NULL,
    `price`       INT UNSIGNED NOT NULL,
    `is_public`   TINYINT     NOT NULL,
    `category_id` INT UNSIGNED NOT NULL,

    PRIMARY KEY (`book_id`),
    INDEX `fk_product_category` (`category_id` ASC),
    CONSTRAINT `fk_product_category`
        FOREIGN KEY (`category_id`)
            REFERENCES `XuBookstore`.`category` (`category_id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB
    AUTO_INCREMENT = 1001
    COMMENT = 'contains product details';


-- -----------------------------------------------------
-- Table `XuBookstore`.`order_line_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `XuBookstore`.`customer_order_line_item`;

CREATE TABLE IF NOT EXISTS `XuBookstore`.`customer_order_line_item`
(
    `customer_order_id` INT UNSIGNED      NOT NULL,
    `book_id`        INT UNSIGNED      NOT NULL,
    `quantity`          SMALLINT UNSIGNED NOT NULL DEFAULT 1,
    PRIMARY KEY (`customer_order_id`, `book_id`),
    INDEX `fk_order_line_item_order` (`customer_order_id` ASC),
    INDEX `fk_order_line_item_product` (`book_id` ASC),
    CONSTRAINT `fk_order_line_item_order`
        FOREIGN KEY (`customer_order_id`)
            REFERENCES `XuBookstore`.`customer_order` (`customer_order_id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_ordered_product_product`
        FOREIGN KEY (`book_id`)
            REFERENCES `XuBookstore`.`book` (`book_id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB
    COMMENT = 'matches products with customer orders and records their quantity';



SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;
