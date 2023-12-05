-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema little_lemon_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema little_lemon_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `little_lemon_db` DEFAULT CHARACTER SET utf8 ;
USE `little_lemon_db` ;

-- -----------------------------------------------------
-- Table `little_lemon_db`.`Staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `little_lemon_db`.`Staff` ;

CREATE TABLE IF NOT EXISTS `little_lemon_db`.`Staff` (
  `staffID` INT NOT NULL AUTO_INCREMENT,
  `staffFirstName` VARCHAR(45) NOT NULL,
  `staffLastName` VARCHAR(45) NOT NULL,
  `Role` VARCHAR(45) NOT NULL,
  `Salary` VARCHAR(45) NOT NULL,
  `contactNumber` VARCHAR(45) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`staffID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`Bookings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `little_lemon_db`.`Bookings` ;

CREATE TABLE IF NOT EXISTS `little_lemon_db`.`Bookings` (
  `bookingID` INT NOT NULL AUTO_INCREMENT,
  `bookingDate` DATE NOT NULL,
  `staffID` INT NOT NULL,
  `bookingslot` TIME NOT NULL,
  `tableNo` INT NOT NULL,
  `comment` VARCHAR(255) NULL,
  PRIMARY KEY (`bookingID`),
  INDEX `booking_staff_fk_idx` (`staffID` ASC) VISIBLE,
  CONSTRAINT `booking_staff_fk`
    FOREIGN KEY (`staffID`)
    REFERENCES `little_lemon_db`.`Staff` (`staffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`MenuItem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `little_lemon_db`.`MenuItem` ;

CREATE TABLE IF NOT EXISTS `little_lemon_db`.`MenuItem` (
  `menuItemID` INT NOT NULL AUTO_INCREMENT,
  `courseName` VARCHAR(45) NULL,
  `StarterName` VARCHAR(45) NULL,
  `DesertName` VARCHAR(45) NULL,
  `price` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`menuItemID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`Menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `little_lemon_db`.`Menu` ;

CREATE TABLE IF NOT EXISTS `little_lemon_db`.`Menu` (
  `menuID` INT NOT NULL AUTO_INCREMENT,
  `itemID` INT NOT NULL,
  `menuName` VARCHAR(45) NOT NULL,
  `cuisine` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`menuID`),
  INDEX `menu_menuitem_fk_idx` (`itemID` ASC) VISIBLE,
  CONSTRAINT `menu_menuitem_fk`
    FOREIGN KEY (`itemID`)
    REFERENCES `little_lemon_db`.`MenuItem` (`menuItemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`Order_delivery`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `little_lemon_db`.`Order_delivery` ;

CREATE TABLE IF NOT EXISTS `little_lemon_db`.`Order_delivery` (
  `order_deliveryID` INT NOT NULL AUTO_INCREMENT,
  `orderID` INT NOT NULL,
  `status` ENUM('received', 'in process', 'out of delivery', 'delivered') NOT NULL,
  `deliveryDate` DATE NULL,
  `address` VARCHAR(255) NOT NULL,
  `comment` VARCHAR(255) NULL,
  PRIMARY KEY (`order_deliveryID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`Customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `little_lemon_db`.`Customers` ;

CREATE TABLE IF NOT EXISTS `little_lemon_db`.`Customers` (
  `customerID` INT NOT NULL AUTO_INCREMENT,
  `customerFirstName` VARCHAR(45) NOT NULL,
  `customerLastName` VARCHAR(45) NOT NULL,
  `contactNumber` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NULL,
  `Address` VARCHAR(255) NULL,
  PRIMARY KEY (`customerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`Orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `little_lemon_db`.`Orders` ;

CREATE TABLE IF NOT EXISTS `little_lemon_db`.`Orders` (
  `orderID` INT NOT NULL AUTO_INCREMENT,
  `customerID` INT NOT NULL,
  `staffID` INT NOT NULL,
  `orderDate` DATE NULL DEFAULT (CURRENT_DATE),
  `menuID` INT NOT NULL,
  `quantity` INT NOT NULL,
  `tableNo` INT NULL,
  `type` ENUM('dine in', 'delivery') NULL DEFAULT 'dine in',
  `bill_amount` DECIMAL(10,2) NOT NULL,
  `delivery_id` INT NULL,
  `comment` VARCHAR(255) NULL,
  PRIMARY KEY (`orderID`),
  INDEX `order_staff_fk_idx` (`staffID` ASC) VISIBLE,
  INDEX `order_menu_fk_idx` (`menuID` ASC) VISIBLE,
  INDEX `order_delivery_fk_idx` (`delivery_id` ASC) VISIBLE,
  INDEX `order_customer_fk_idx` (`customerID` ASC) VISIBLE,
  CONSTRAINT `order_staff_fk`
    FOREIGN KEY (`staffID`)
    REFERENCES `little_lemon_db`.`Staff` (`staffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `order_menu_fk`
    FOREIGN KEY (`menuID`)
    REFERENCES `little_lemon_db`.`Menu` (`menuID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `order_delivery_fk`
    FOREIGN KEY (`delivery_id`)
    REFERENCES `little_lemon_db`.`Order_delivery` (`order_deliveryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `order_customer_fk`
    FOREIGN KEY (`customerID`)
    REFERENCES `little_lemon_db`.`Customers` (`customerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
