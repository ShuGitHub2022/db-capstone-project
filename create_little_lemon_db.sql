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
-- Table `little_lemon_db`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`Customers` (
  `customerID` INT NOT NULL AUTO_INCREMENT,
  `customerFirstName` VARCHAR(45) NOT NULL,
  `customerLastName` VARCHAR(45) NOT NULL,
  `contactNumber` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `AddressID` INT NOT NULL,
  PRIMARY KEY (`customerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`addresses` (
  `addressID` INT NOT NULL AUTO_INCREMENT,
  `customerID` INT NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL DEFAULT 'USA',
  `zipcode` VARCHAR(10) NOT NULL,
  `addressType` VARCHAR(45) NOT NULL DEFAULT 'Home',
  PRIMARY KEY (`addressID`),
  INDEX `address_customer_fk_idx` (`customerID` ASC) VISIBLE,
  CONSTRAINT `address_customer_fk`
    FOREIGN KEY (`customerID`)
    REFERENCES `little_lemon_db`.`Customers` (`customerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`Staff` (
  `staffID` INT NOT NULL AUTO_INCREMENT,
  `staffFirstName` VARCHAR(45) NOT NULL,
  `staffLastName` VARCHAR(45) NOT NULL,
  `Role` VARCHAR(45) NOT NULL,
  `Salary` VARCHAR(45) NOT NULL,
  `contactNumber` VARCHAR(45) NOT NULL,
  `addressID` INT NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`staffID`),
  INDEX `staff_address_fk_idx` (`addressID` ASC) VISIBLE,
  CONSTRAINT `staff_address_fk`
    FOREIGN KEY (`addressID`)
    REFERENCES `little_lemon_db`.`addresses` (`addressID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`Bookings` (
  `bookingID` INT NOT NULL AUTO_INCREMENT,
  `bookingDate` DATE NOT NULL,
  `customerID` INT NOT NULL,
  `staffID` INT NOT NULL,
  `bookingslot` TIME NOT NULL,
  `tableNo` INT NOT NULL,
  `comment` VARCHAR(255) NULL,
  PRIMARY KEY (`bookingID`),
  INDEX `booking_staff_fk_idx` (`staffID` ASC) VISIBLE,
  INDEX `booking_customer.fk_idx` (`customerID` ASC) VISIBLE,
  CONSTRAINT `booking_staff_fk`
    FOREIGN KEY (`staffID`)
    REFERENCES `little_lemon_db`.`Staff` (`staffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `booking_customer.fk`
    FOREIGN KEY (`customerID`)
    REFERENCES `little_lemon_db`.`Customers` (`customerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`MenuItem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`MenuItem` (
  `menuItemID` INT NOT NULL AUTO_INCREMENT,
  `menuID` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `type` ENUM('starters', 'courses', 'drinks', 'dessert') NOT NULL,
  `price` DECIMAL(3,2) NOT NULL,
  `discount` DECIMAL(3,2) NULL,
  PRIMARY KEY (`menuItemID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`Menu` (
  `menuID` INT NOT NULL AUTO_INCREMENT,
  `itemID` INT NOT NULL,
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
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`Order_delivery` (
  `order_deliveryID` INT NOT NULL AUTO_INCREMENT,
  `orderID` INT NOT NULL,
  `status` ENUM('received', 'in process', 'out of delivery', 'delivered') NOT NULL,
  `deliveryDate` DATE NULL,
  PRIMARY KEY (`order_deliveryID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`Orders` (
  `orderID` INT NOT NULL AUTO_INCREMENT,
  `customerID` INT NOT NULL,
  `staffID` INT NOT NULL,
  `orderDate` DATE NOT NULL,
  `menuID` INT NOT NULL,
  `quantity` INT NOT NULL,
  `type` ENUM('dine in', 'delivery') NOT NULL,
  `bill_amount` DECIMAL(10,2) NOT NULL,
  `delivery_id` INT NULL,
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
    ON DELETE NO ACTION
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
