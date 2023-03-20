-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `id_user` INT NOT NULL AUTO_INCREMENT,
  `number` VARCHAR(30) NOT NULL,
  `name` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE INDEX `id_profile_UNIQUE` (`id_user` ASC) VISIBLE,
  UNIQUE INDEX `number_UNIQUE` (`number` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`profile`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`profile` (
  `name` VARCHAR(60) NULL,
  `phone` INT NULL,
  `birthday` DATE NULL,
  `photo` BLOB NULL,
  `id_profile` INT NOT NULL,
  `user_id` INT NOT NULL,
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE,
  UNIQUE INDEX `user_id_UNIQUE` (`id_profile` ASC) VISIBLE,
  PRIMARY KEY (`id_profile`, `user_id`),
  INDEX `fk_profile_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_profile_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`media`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`media` (
  `id_media` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NULL,
  `photo` BLOB NULL,
  `video` BLOB NULL,
  PRIMARY KEY (`id_media`),
  UNIQUE INDEX `id_media_UNIQUE` (`id_media` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`status` (
  `id_status` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NULL,
  `media_id_media` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id_status`, `media_id_media`, `user_id`),
  UNIQUE INDEX `id_status_UNIQUE` (`id_status` ASC) VISIBLE,
  INDEX `fk_status_media_idx` (`media_id_media` ASC) VISIBLE,
  INDEX `fk_status_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_status_media`
    FOREIGN KEY (`media_id_media`)
    REFERENCES `mydb`.`media` (`id_media`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_status_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`profile` (`id_profile`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`messages` (
  `id_messages` INT NOT NULL AUTO_INCREMENT,
  `text` VARCHAR(120) NULL,
  `date` DATETIME NULL,
  `user_from` INT NOT NULL,
  `user_to` INT NOT NULL,
  PRIMARY KEY (`id_messages`, `user_from`, `user_to`),
  UNIQUE INDEX `id_messages_UNIQUE` (`id_messages` ASC) VISIBLE,
  INDEX `fk_messages_user1_idx` (`user_from` ASC) VISIBLE,
  INDEX `fk_messages_user2_idx` (`user_to` ASC) VISIBLE,
  CONSTRAINT `fk_messages_user1`
    FOREIGN KEY (`user_from`)
    REFERENCES `mydb`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_messages_user2`
    FOREIGN KEY (`user_to`)
    REFERENCES `mydb`.`user` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
