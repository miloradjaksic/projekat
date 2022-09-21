/*
SQLyog Community
MySQL - 10.4.20-MariaDB : Database - store
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `item` */

DROP TABLE IF EXISTS `item`;

CREATE TABLE `item` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `imageUrl` VARCHAR(255) NOT NULL,
  `price` INT(11) NOT NULL,
  `specification` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (JSON_VALID(`specification`)),
  `itemGroupId` INT(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_b0e27715ec6c59f16241121a2c5` (`itemGroupId`),
  CONSTRAINT `FK_b0e27715ec6c59f16241121a2c5` FOREIGN KEY (`itemGroupId`) REFERENCES `item_group` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

/*Data for the table `item` */

INSERT  INTO `item`(`id`,`name`,`description`,`imageUrl`,`price`,`specification`,`itemGroupId`) VALUES 
(1,'VERSACE Maijca','CRNO bela versace majica','https://www.fashionandfriends.com/pub/media/catalog/product/cache/67eb99f26f3721ba9aa4712a229cdf1d/V/J/VJ72GAH6RB-S061-G89-1.jpg',13999,'\"{\\\"name\\\": \\\"Timber\\\"}\"',12),
(2,'izmna','','https://localhost:8000/img/d5d6745f-8ba1-4227-8ffc-7b25dedc8588-c540477c-775c-482a-8333-165024684df9-pin_car_green.png',322,'\"{\\\"spec0\\\":\\\"afd\\\",\\\"spec1\\\":\\\"afd\\\",\\\"ve\\\":\\\"xs\\\"}\"',8),
(4,'Puma majica','','https://localhost:8000/img/2697453c-9630-4f35-a3c7-97b785a9ec11-image.jpg',2400,'\"{\\\"velcina\\\":\\\"xs\\\",\\\"boja\\\":\\\"roze\\\"}\"',4);

/*Table structure for table `item_group` */

DROP TABLE IF EXISTS `item_group`;

CREATE TABLE `item_group` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `parentGroupId` INT(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_5d7f577c313412719fec60c9207` (`parentGroupId`),
  CONSTRAINT `FK_5d7f577c313412719fec60c9207` FOREIGN KEY (`parentGroupId`) REFERENCES `item_group` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=INNODB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;

/*Data for the table `item_group` */

INSERT  INTO `item_group`(`id`,`name`,`parentGroupId`) VALUES 
(1,'Muskarci',NULL),
(2,'Zene',NULL),
(3,'odeca',2),
(4,'majice',2),
(5,'salovi',2),
(6,'pantalone',2),
(7,'polo',4),
(8,'potkosulje',4),
(9,'jednobojne',4),
(11,'Deca',NULL),
(12,'majice',1),
(13,'nesto',NULL),
(16,'grupaaa',4);

/*Table structure for table `migrations` */

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `timestamp` BIGINT(20) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

/*Data for the table `migrations` */

INSERT  INTO `migrations`(`id`,`timestamp`,`name`) VALUES 
(1,1652297977197,'createUser1652297977197'),
(2,1652301321945,'createItemGroup1652301321945'),
(3,1652301719611,'createItem1652301719611'),
(4,1652302143521,'createOrder1652302143521'),
(5,1652302359446,'createOrderItems1652302359446');

/*Table structure for table `order` */

DROP TABLE IF EXISTS `order`;

CREATE TABLE `order` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `targetLocation` LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (JSON_VALID(`targetLocation`)),
  `status` ENUM('PENDING','ACCEPTED','REJECTED','DELIVERED') NOT NULL,
  `createdAt` DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `acceptedAt` DATETIME NOT NULL,
  `rejectedAt` DATETIME NOT NULL,
  `delivereddAt` DATETIME NOT NULL,
  `userId` INT(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_caabe91507b3379c7ba73637b84` (`userId`),
  CONSTRAINT `FK_caabe91507b3379c7ba73637b84` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=INNODB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

/*Data for the table `order` */

INSERT  INTO `order`(`id`,`targetLocation`,`status`,`createdAt`,`acceptedAt`,`rejectedAt`,`delivereddAt`,`userId`) VALUES 
(1,'\"{\\\"phone\\\":\\\"+381628916761\\\",\\\"address\\\":\\\"afds\\\",\\\"apartment\\\":\\\"2\\\",\\\"floor\\\":\\\"2\\\",\\\"note\\\":\\\"afds\\\"}\"','DELIVERED','2022-06-20 23:16:14.860000','2022-06-21 00:02:22','0000-00-00 00:00:00','2022-06-21 00:02:24',1),
(2,'\"{\\\"phone\\\":\\\"0628916761\\\",\\\"address\\\":\\\"afdsas\\\",\\\"apartment\\\":\\\"2\\\",\\\"floor\\\":\\\"2\\\",\\\"note\\\":\\\"afg\\\"}\"','REJECTED','2022-06-20 23:18:54.391000','0000-00-00 00:00:00','2022-06-21 00:02:19','0000-00-00 00:00:00',1),
(3,'\"{\\\"phone\\\":\\\"+381628916761\\\",\\\"address\\\":\\\"Dubrovacka 30\\\",\\\"apartment\\\":\\\"2\\\",\\\"floor\\\":\\\"2\\\",\\\"note\\\":\\\"asdfsd\\\"}\"','DELIVERED','2022-06-28 18:48:16.679000','2022-06-28 18:50:15','0000-00-00 00:00:00','2022-06-28 18:50:21',1),
(4,'\"{\\\"phone\\\":\\\"0628916761\\\",\\\"address\\\":\\\"Dubrovacka 30\\\",\\\"apartment\\\":\\\"2\\\",\\\"floor\\\":\\\"2\\\",\\\"note\\\":\\\"fdsg\\\"}\"','PENDING','2022-06-28 18:51:03.136000','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1),
(5,'\"{\\\"phone\\\":\\\"+381628916761\\\",\\\"address\\\":\\\"Srbija\\\",\\\"apartment\\\":\\\"2\\\",\\\"floor\\\":\\\"2\\\",\\\"note\\\":\\\"afds\\\"}\"','PENDING','2022-06-28 18:51:58.543000','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1),
(6,'\"{\\\"phone\\\":\\\"0628916761\\\",\\\"address\\\":\\\"Dubrovacka 30\\\",\\\"apartment\\\":\\\"2\\\",\\\"floor\\\":\\\"2\\\",\\\"note\\\":\\\"afds\\\"}\"','PENDING','2022-06-28 18:53:34.220000','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1);

/*Table structure for table `order_item` */

DROP TABLE IF EXISTS `order_item`;

CREATE TABLE `order_item` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `itemName` VARCHAR(255) NOT NULL,
  `count` INT(11) NOT NULL,
  `itemPrice` INT(11) NOT NULL,
  `itemId` INT(11) DEFAULT NULL,
  `orderId` INT(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_e03f3ed4dab80a3bf3eca50babc` (`itemId`),
  KEY `FK_646bf9ece6f45dbe41c203e06e0` (`orderId`),
  CONSTRAINT `FK_646bf9ece6f45dbe41c203e06e0` FOREIGN KEY (`orderId`) REFERENCES `order` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_e03f3ed4dab80a3bf3eca50babc` FOREIGN KEY (`itemId`) REFERENCES `item` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=INNODB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

/*Data for the table `order_item` */

INSERT  INTO `order_item`(`id`,`itemName`,`count`,`itemPrice`,`itemId`,`orderId`) VALUES 
(1,'VERSACE Maijca',2,13999,1,1),
(2,'VERSACE Maijca',2,13999,1,2),
(3,'VERSACE Maijca',4,13999,1,3),
(4,'VERSACE Maijca',2,13999,1,4),
(5,'VERSACE Maijca',2,13999,1,5),
(6,'VERSACE Maijca',1,13999,1,6),
(7,'izmna',2,322,2,6);

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(255) NOT NULL,
  `lastName` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `phone` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `admin` TINYINT(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_e12875dfb3b1d92d7d7c5377e2` (`email`)
) ENGINE=INNODB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

/*Data for the table `user` */

INSERT  INTO `user`(`id`,`firstName`,`lastName`,`email`,`phone`,`password`,`admin`) VALUES 
(1,'Milorad','Jaksic','minja@gmail.com','0634485642','/1rBkZBCSx2I+UGe+UmuVm99EJL9j/wWOMl9pvJ/Oxg=',0),
(2,'Admin','Admin','admin@test.com','0634485642','/1rBkZBCSx2I+UGe+UmuVm99EJL9j/wWOMl9pvJ/Oxg=',1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
