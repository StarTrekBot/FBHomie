SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `smarthomie` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `smarthomie` ;

-- -----------------------------------------------------
-- Table `smarthomie`.`devicetype`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smarthomie`.`devicetype` ;

CREATE TABLE IF NOT EXISTS `smarthomie`.`devicetype` (
  `iddevicetype` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`iddevicetype`),
  UNIQUE INDEX `iddevicetype_UNIQUE` (`iddevicetype` ASC),
  UNIQUE INDEX `type_UNIQUE` (`type` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smarthomie`.`deviceoem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smarthomie`.`deviceoem` ;

CREATE TABLE IF NOT EXISTS `smarthomie`.`deviceoem` (
  `iddeviceoem` INT NOT NULL AUTO_INCREMENT,
  `oem` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`iddeviceoem`),
  UNIQUE INDEX `iddeviceoem_UNIQUE` (`iddeviceoem` ASC),
  UNIQUE INDEX `oem_UNIQUE` (`oem` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smarthomie`.`deviceoemname`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smarthomie`.`deviceoemname` ;

CREATE TABLE IF NOT EXISTS `smarthomie`.`deviceoemname` (
  `iddeviceoemname` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`iddeviceoemname`),
  UNIQUE INDEX `iddeviceoemname_UNIQUE` (`iddeviceoemname` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smarthomie`.`devicestate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smarthomie`.`devicestate` ;

CREATE TABLE IF NOT EXISTS `smarthomie`.`devicestate` (
  `iddevicestate` INT NOT NULL AUTO_INCREMENT,
  `state` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`iddevicestate`),
  UNIQUE INDEX `iddevicestate_UNIQUE` (`iddevicestate` ASC),
  UNIQUE INDEX `state_UNIQUE` (`state` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smarthomie`.`device`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smarthomie`.`device` ;

CREATE TABLE IF NOT EXISTS `smarthomie`.`device` (
  `iddevice` INT NOT NULL AUTO_INCREMENT,
  `deviceid` BIGINT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `iddevicetype` INT NOT NULL,
  `iddeviceoem` INT NOT NULL,
  `iddeviceoemname` INT NOT NULL,
  `iddevicestate` INT NOT NULL,
  PRIMARY KEY (`iddevice`),
  UNIQUE INDEX `iddevice_UNIQUE` (`iddevice` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  INDEX `fk_device_devicetype_idx` (`iddevicetype` ASC),
  INDEX `fk_device_deviceoem1_idx` (`iddeviceoem` ASC),
  INDEX `fk_device_deviceoemname1_idx` (`iddeviceoemname` ASC),
  INDEX `fk_device_devicestate1_idx` (`iddevicestate` ASC),
  UNIQUE INDEX `deviceid_UNIQUE` (`deviceid` ASC),
  CONSTRAINT `fk_device_devicetype`
    FOREIGN KEY (`iddevicetype`)
    REFERENCES `smarthomie`.`devicetype` (`iddevicetype`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_device_deviceoem1`
    FOREIGN KEY (`iddeviceoem`)
    REFERENCES `smarthomie`.`deviceoem` (`iddeviceoem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_device_deviceoemname1`
    FOREIGN KEY (`iddeviceoemname`)
    REFERENCES `smarthomie`.`deviceoemname` (`iddeviceoemname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_device_devicestate1`
    FOREIGN KEY (`iddevicestate`)
    REFERENCES `smarthomie`.`devicestate` (`iddevicestate`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smarthomie`.`devicesensortype`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smarthomie`.`devicesensortype` ;

CREATE TABLE IF NOT EXISTS `smarthomie`.`devicesensortype` (
  `iddevicesensortype` INT NOT NULL AUTO_INCREMENT,
  `sensortype` VARCHAR(45) NOT NULL,
  `sensorunit` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`iddevicesensortype`),
  UNIQUE INDEX `iddevicesensortype_UNIQUE` (`iddevicesensortype` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smarthomie`.`devicesensor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smarthomie`.`devicesensor` ;

CREATE TABLE IF NOT EXISTS `smarthomie`.`devicesensor` (
  `iddevicesensor` INT NOT NULL AUTO_INCREMENT,
  `sensorname` VARCHAR(45) NOT NULL,
  `sensorvalue` DOUBLE NOT NULL,
  `iddevicesensortype` INT NOT NULL,
  PRIMARY KEY (`iddevicesensor`),
  UNIQUE INDEX `iddevicesensor_UNIQUE` (`iddevicesensor` ASC),
  INDEX `fk_devicesensor_devicesensortype1_idx` (`iddevicesensortype` ASC),
  CONSTRAINT `fk_devicesensor_devicesensortype1`
    FOREIGN KEY (`iddevicesensortype`)
    REFERENCES `smarthomie`.`devicesensortype` (`iddevicesensortype`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `smarthomie`.`devicesensorlist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `smarthomie`.`devicesensorlist` ;

CREATE TABLE IF NOT EXISTS `smarthomie`.`devicesensorlist` (
  `iddevicesensorlist` INT NOT NULL,
  `iddevice` INT NOT NULL,
  `iddevicesensor` INT NOT NULL,
  PRIMARY KEY (`iddevicesensorlist`),
  INDEX `fk_devicesensorlist_device1_idx` (`iddevice` ASC),
  INDEX `fk_devicesensorlist_devicesensor1_idx` (`iddevicesensor` ASC),
  CONSTRAINT `fk_devicesensorlist_device1`
    FOREIGN KEY (`iddevice`)
    REFERENCES `smarthomie`.`device` (`iddevice`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_devicesensorlist_devicesensor1`
    FOREIGN KEY (`iddevicesensor`)
    REFERENCES `smarthomie`.`devicesensor` (`iddevicesensor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
