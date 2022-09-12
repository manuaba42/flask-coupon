/*
SQLyog Ultimate v12.4.3 (64 bit)
MySQL - 10.4.8-MariaDB : Database - db_coupon
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


/*Table structure for table `categories` */

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

/*Data for the table `categories` */

insert  into `categories`(`id`,`category`) values 
(1,'fashion'),
(2,'lifestyle');

/*Table structure for table `featured_product` */

DROP TABLE IF EXISTS `featured_product`;

CREATE TABLE `featured_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `featured` varchar(500) DEFAULT NULL,
  `id_product` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `featured_product` */

/*Table structure for table `offers` */

DROP TABLE IF EXISTS `offers`;

CREATE TABLE `offers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discount_amount` int(11) DEFAULT NULL,
  `discount_desc` varchar(50) DEFAULT NULL,
  `category` enum('one','all') DEFAULT NULL,
  `discount_code` varchar(100) DEFAULT NULL,
  `discount_link` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

/*Data for the table `offers` */

insert  into `offers`(`id`,`discount_amount`,`discount_desc`,`category`,`discount_code`,`discount_link`) values 
(1,15,'WEEKENDER DUFFLE','one','CANVDUFF239','https://duffleandco.com/collections/best-sellers-1/products/copy-of-weekender-duffle');

/*Table structure for table `product` */

DROP TABLE IF EXISTS `product`;

CREATE TABLE `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name_brand` varchar(255) DEFAULT NULL,
  `tagline` varchar(255) DEFAULT NULL,
  `about` varchar(1000) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

/*Data for the table `product` */

insert  into `product`(`id`,`name_brand`,`tagline`,`about`,`location`) values 
(1,'duffle&co','Duffle&co empowers artisans craftsmen and their families from Indonesia and India through handcrafted luxury bags that don’t compromise your values.','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin consectetur, enim ultricies dignissim iaculis, diam magna rhoncus risus, id luctus mi tortor ut justo. Proin pretium nulla sed enim varius, vitae fringilla nunc accumsan. Donec eget aliquam erat. Ut diam libero, commodo commodo augue a, malesuada luctus ligula. Donec euismod lacus ante, sed ultrices mauris fringilla vel. Nam pretium elit sed mi sodales, at venenatis augue ullamcorper. Nulla euismod rhoncus dignissim. Aliquam consequat risus massa, at aliquam dui faucibus et. Sed ut ullamcorper ex. Integer in est sit amet mauris pharetra egestas vitae eu nisi. Nulla eget dictum ipsum. Nam sodales justo feugiat enim sollicitudin, at placerat ex cursus.','welington, tauranga'),
(2,'nisa','Organic Cotton Underwear made by women from refugee background.','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin consectetur, enim ultricies dignissim iaculis, diam magna rhoncus risus, id luctus mi tortor ut justo. Proin pretium nulla sed enim varius, vitae fringilla nunc accumsan. Donec eget aliquam erat. Ut diam libero, commodo commodo augue a, malesuada luctus ligula. Donec euismod lacus ante, sed ultrices mauris fringilla vel. Nam pretium elit sed mi sodales, at venenatis augue ullamcorper. Nulla euismod rhoncus dignissim. Aliquam consequat risus massa, at aliquam dui faucibus et. Sed ut ullamcorper ex. Integer in est sit amet mauris pharetra egestas vitae eu nisi. Nulla eget dictum ipsum. Nam sodales justo feugiat enim sollicitudin, at placerat ex cursus.','auckland'),
(3,'reform','Reform is committed to developing high quality, innovative, safe and affordable','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin consectetur, enim ultricies dignissim iaculis, diam magna rhoncus risus, id luctus mi tortor ut justo. Proin pretium nulla sed enim varius, vitae fringilla nunc accumsan. Donec eget aliquam erat. Ut diam libero, commodo commodo augue a, malesuada luctus ligula. Donec euismod lacus ante, sed ultrices mauris fringilla vel. Nam pretium elit sed mi sodales, at venenatis augue ullamcorper. Nulla euismod rhoncus dignissim. Aliquam consequat risus massa, at aliquam dui faucibus et. Sed ut ullamcorper ex. Integer in est sit amet mauris pharetra egestas vitae eu nisi. Nulla eget dictum ipsum. Nam sodales justo feugiat enim sollicitudin, at placerat ex cursus.','mellbourne'),
(4,'moss','Moss is a brand all about conscious wellbeing, full of natural and organic ingredients and packaged in reusable glass jars.','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin consectetur, enim ultricies dignissim iaculis, diam magna rhoncus risus, id luctus mi tortor ut justo. Proin pretium nulla sed enim varius, vitae fringilla nunc accumsan. Donec eget aliquam erat. Ut diam libero, commodo commodo augue a, malesuada luctus ligula. Donec euismod lacus ante, sed ultrices mauris fringilla vel. Nam pretium elit sed mi sodales, at venenatis augue ullamcorper. Nulla euismod rhoncus dignissim. Aliquam consequat risus massa, at aliquam dui faucibus et. Sed ut ullamcorper ex. Integer in est sit amet mauris pharetra egestas vitae eu nisi. Nulla eget dictum ipsum. Nam sodales justo feugiat enim sollicitudin, at placerat ex cursus.','welington');

/*Table structure for table `product_category` */

DROP TABLE IF EXISTS `product_category`;

CREATE TABLE `product_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_product` int(11) DEFAULT NULL,
  `id_categories` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_product` (`id_product`),
  KEY `id_categories` (`id_categories`),
  CONSTRAINT `product_category_ibfk_1` FOREIGN KEY (`id_product`) REFERENCES `product` (`id`),
  CONSTRAINT `product_category_ibfk_2` FOREIGN KEY (`id_categories`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

/*Data for the table `product_category` */

insert  into `product_category`(`id`,`id_product`,`id_categories`) values 
(1,1,1),
(2,1,2);

/*Table structure for table `product_offer` */

DROP TABLE IF EXISTS `product_offer`;

CREATE TABLE `product_offer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_product` int(11) DEFAULT NULL,
  `id_offer` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_product` (`id_product`),
  KEY `id_offer` (`id_offer`),
  CONSTRAINT `product_offer_ibfk_1` FOREIGN KEY (`id_product`) REFERENCES `product` (`id`),
  CONSTRAINT `product_offer_ibfk_2` FOREIGN KEY (`id_offer`) REFERENCES `offers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

/*Data for the table `product_offer` */

insert  into `product_offer`(`id`,`id_product`,`id_offer`) values 
(1,1,1);

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

/*Data for the table `user` */

insert  into `user`(`id`,`username`,`email`,`password`) values 
(3,'yoga','ssedanayoga3@gmail.com','$2b$12$cgsap4ymMdsbfUZ5xTzYcuPtIwu5OQrSwfG157BQcmvGe2hFQAMka'),
(4,'yoga','ssedanayoga3@gmail.com','$2b$12$gi3YxzxcfmgnFnslujf5aOZNLoXMICoHHlK5aT1xkLuji5l1SWV66'),
(5,'tugusaditya@yahoo.com','tugusaditya@yahoo.com','$2b$12$oAgFbq8TRQUoR1O3o0TpJunnpCfyN91hMUM4aVz9b0V8LyDokDF8S');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
