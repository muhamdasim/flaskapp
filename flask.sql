-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 09, 2021 at 07:56 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(300) NOT NULL,
  `email` varchar(300) NOT NULL,
  `password` varchar(300) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'test','qasimriaz814@gmail.com','flask');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(100) NOT NULL,
  `message` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


--
-- Dumping data for table `contact`
--

LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
INSERT INTO `contact` VALUES (8,'Muhammad','homatij540@sweatmail.com','hey','hey'),(9,'Muhammad','innocentqasim791@gmail.com','asdasdsadads','asdasdsadads'),(10,'Muhammad','homatij540@sweatmail.com','asdasdasd','asdasdasd'),(11,'Muhammad','homatij540@sweatmail.com','asdasdasd','asdasdasd'),(12,'Muhammad','qasimriaz814@gmail.com','fuck you','fuck you'),(13,'Muhammad','fa17-bcs-199@cuiwah.edu.pk','dsfsdf','dsfsdf'),(18,'Muhammad','qasimriaz814@gmail.com','amdfkamsfkmafkmaskfmaskfmalkfmldnsgjndflbgdfj','amdfkamsfkmafkmaskfmaskfmalkfmldnsgjndflbgdfj'),(19,'Muhammad','qasimriaz814@gmail.com','aasdsdasdasdasd','aasdsdasdasdasd'),(20,'Muhammad','qasimriaz814@gmail.com','03215142274','asdasdasdasd'),(21,'SYED','muhamdasim.business@gmail.com','12552525','dasdas\r\n'),(22,'Iain Munro','iainhmunro@gmail.com','4036714665','Test'),(23,'Iain Munro','iainhmunro@gmail.com','4036714665','Test'),(24,'Muhammad Qasim','qasimriaz814@gmail.com','03215142274','fuck '),(25,'Iain Munro','iainhmunro@gmail.com','4036714665','test');
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoices` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `active_status` tinyint(1) NOT NULL DEFAULT '1',
  `payment_status` tinyint(1) DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `duration` varchar(300) NOT NULL,
  `plan_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `plan_id` (`plan_id`),
  KEY `user_has_invoice` (`user_id`),
  CONSTRAINT `plan_id` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_has_invoice` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


--
-- Dumping data for table `invoices`
--

LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
INSERT INTO `invoices` VALUES (1,1,1,1,'2021-10-22 18:10:57','30',20),(25,37,1,0,'2021-10-28 16:54:29','1',21),(26,38,1,0,'2021-10-28 16:57:59','1',21),(31,43,1,0,'2021-10-28 18:46:27','1',21),(32,44,1,0,'2021-10-29 12:10:16','12',22),(33,45,1,0,'2021-10-29 13:14:42','1',22),(34,46,1,0,'2021-10-29 13:35:25','1',21),(35,47,1,0,'2021-10-29 13:37:35','12',22),(36,48,1,0,'2021-10-29 14:31:24','12',22),(37,49,1,0,'2021-10-29 19:21:21','12',22),(38,50,1,0,'2021-10-29 19:38:21','1',21),(39,51,1,0,'2021-10-30 14:35:40','1',22),(40,52,1,0,'2021-10-30 14:47:09','1',19),(42,54,1,0,'2021-10-30 19:11:54','12',21),(43,55,1,0,'2021-10-30 20:42:45','12',22),(44,56,1,0,'2021-11-01 17:11:04','1',22),(45,57,1,0,'2021-11-01 17:13:47','12',22),(46,58,1,0,'2021-11-01 20:41:59','1',19),(47,59,1,0,'2021-11-01 20:42:51','12',22),(48,60,1,0,'2021-11-03 19:16:42','1',20),(49,61,1,0,'2021-11-04 15:15:46','1',20),(50,62,1,0,'2021-11-05 19:31:47','1',19);
/*!40000 ALTER TABLE `invoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plans`
--

DROP TABLE IF EXISTS `plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plans` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(300) NOT NULL,
  `price` int NOT NULL,
  `description` varchar(1000) NOT NULL,
  `num_searches` int NOT NULL DEFAULT '0',
  `discount` float NOT NULL,
  `limits` varchar(45) DEFAULT NULL,
  `active_status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


--
-- Dumping data for table `plans`
--

LOCK TABLES `plans` WRITE;
/*!40000 ALTER TABLE `plans` DISABLE KEYS */;
INSERT INTO `plans` VALUES (19,'Learner',20,'• 5 Searches per month\r\n• 10 Results Max\r\n• Export details',5,0,'10',1),(20,'Basic',30,'• 10 Searches per month\r\n• 50 Results Max\r\n• Export details',10,5,'50',1),(21,'Pro User',40,'• 20 Searches per month\r\n• 100 Results Max\r\n• Export details',20,10,'100',1),(22,'Expert',50,'• 100 Searches per month\r\n• 250 Results Max\r\n• Export details',100,15,'250',1);
/*!40000 ALTER TABLE `plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `query`
--

DROP TABLE IF EXISTS `query`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `query` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Date` datetime DEFAULT NULL,
  `keyword` varchar(300) NOT NULL,
  `status` int NOT NULL DEFAULT '0',
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `query_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `query`
--

LOCK TABLES `query` WRITE;
/*!40000 ALTER TABLE `query` DISABLE KEYS */;
INSERT INTO `query` VALUES (89,'2021-11-04 18:58:01','codeaza',1,1),(90,'2021-11-04 20:46:14','barber calgary',1,60),(91,'2021-11-04 22:25:44','restraunts in islamabad',1,37),(92,'2021-11-04 22:27:12','codeaza in islamabad',1,37),(93,'2021-11-04 22:53:44','barber calgary',0,60),(94,'2021-11-05 10:33:14','testas',1,1),(95,'2021-11-05 10:34:58','testas',1,1),(96,'2021-11-05 10:35:15','testas',1,1),(97,'2021-11-05 10:53:40','Movie theatres calgary',0,60),(98,'2021-11-05 13:18:10','test',0,1),(99,'2021-11-05 13:21:18','work zone in islamabad',1,1),(100,'2021-11-05 13:25:16','work zone in islamabad',1,1),(101,'2021-11-05 19:32:12','restaurants near me',1,62),(102,'2021-11-05 20:26:49','codeaza',1,60),(103,'2021-11-05 20:27:16','software house in islamabad',1,60);
/*!40000 ALTER TABLE `query` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reset`
--

DROP TABLE IF EXISTS `reset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reset` (
  `id` int NOT NULL AUTO_INCREMENT,
  `secret` varchar(300) NOT NULL,
  `time` date NOT NULL,
  `admin_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_id` (`admin_id`),
  CONSTRAINT `admin_id` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


--
-- Dumping data for table `reset`
--

LOCK TABLES `reset` WRITE;
/*!40000 ALTER TABLE `reset` DISABLE KEYS */;
INSERT INTO `reset` VALUES (3,'rwka','2021-10-20',1),(4,'uzowrogis','2021-10-29',1),(5,'vexbjegsocn','2021-10-29',1),(6,'xwyphptjxypg','2021-10-31',1);
/*!40000 ALTER TABLE `reset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `result`
--

DROP TABLE IF EXISTS `result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `result` (
  `id` int NOT NULL AUTO_INCREMENT,
  `filename` varchar(300) NOT NULL,
  `result` varchar(300) NOT NULL,
  `query_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `query_id` (`query_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `result`
--

LOCK TABLES `result` WRITE;
/*!40000 ALTER TABLE `result` DISABLE KEYS */;
/*!40000 ALTER TABLE `result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `script_result`
--

DROP TABLE IF EXISTS `script_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `script_result` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(300) NOT NULL,
  `Phone` varchar(300) NOT NULL,
  `Website` varchar(300) NOT NULL,
  `address` varchar(300) NOT NULL,
  `street` varchar(300) NOT NULL,
  `City` varchar(300) NOT NULL,
  `state` varchar(300) NOT NULL,
  `Zip` varchar(300) NOT NULL,
  `country` varchar(300) NOT NULL,
  `No_of_Photos` varchar(300) NOT NULL,
  `user_id` int DEFAULT NULL,
  `query_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `query_id` (`query_id`),
  CONSTRAINT `script_result_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `script_result_ibfk_2` FOREIGN KEY (`query_id`) REFERENCES `query` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=404 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


--
-- Dumping data for table `script_result`
--

LOCK TABLES `script_result` WRITE;
/*!40000 ALTER TABLE `script_result` DISABLE KEYS */;
INSERT INTO `script_result` VALUES (299,'Magnum Barbershop','+1 403-475-8588','','1019 17 Ave SW #102, Calgary, AB T2T 0A7, Canada','1019 17 Ave SW #102',' Calgary','AB','T2T',' Canada','0',60,90),(300,'Denim & Smith Barbershop - Springborough Professional Centre','+1 403-453-3230','','30 Springborough Blvd SW, Calgary, AB T3H 5M6, Canada','30 Springborough Blvd SW',' Calgary','AB','T3H',' Canada','0',60,90),(301,'Centuries barber shop','+1 403-991-6638','','Canada, Alberta, Calgary, Spruce Center SW邮政编码: T3C 3B3','Canada',' Alberta','Calgary','',' Spruce Center SW邮政编码: T3C 3B3','0',60,90),(302,'The Barber Shop','+1 587-353-7688','','3630 Brentwood Rd NW #304, Calgary, AB T2L 1K8, Canada','3630 Brentwood Rd NW #304',' Calgary','AB','T2L',' Canada','0',60,90),(303,'kith&kin Barbershop + Solesalon','+1 403-452-4590','','1040 12 Ave SW Unit C, Calgary, AB T2R 0J6, Canada','1040 12 Ave SW Unit C',' Calgary','AB','T2R',' Canada','0',60,90),(304,'Kensington Barbers','+1 587-352-9800','','109 19 St NW, Calgary, AB T2N 2H8, Canada','109 19 St NW',' Calgary','AB','T2N',' Canada','0',60,90),(305,'Sunshine Barber','+1 403-903-3946','','3601 B17 Ave SE, Calgary, AB T2A 0R8, Canada','3601 B17 Ave SE',' Calgary','AB','T2A',' Canada','0',60,90),(306,'Tommy Gun\'s Original Barbershop','+1 587-231-0335','','3625 Shaganappi Trail NW Unit W107, Calgary, AB T3A 0E2, Canada','3625 Shaganappi Trail NW Unit W107',' Calgary','AB','T3A',' Canada','0',60,90),(307,'Tommy Gun\'s Original Barbershop','+1 587-231-0335','','3625 Shaganappi Trail NW Unit W107, Calgary, AB T3A 0E2, Canada','3625 Shaganappi Trail NW Unit W107',' Calgary','AB','T3A',' Canada','0',60,90),(308,'Denim and Smith Barbershops - Crowfoot','+1 403-452-7593','','150 Crowfoot Crescent NW #325, Calgary, AB T3G 2W1, Canada','150 Crowfoot Crescent NW #325',' Calgary','AB','T3G',' Canada','0',60,90),(309,'Raoul Barbershop','+1 403-616-9651','','3517 17 Ave SE #200a, Calgary, AB T2A 0R5, Canada','3517 17 Ave SE #200a',' Calgary','AB','T2A',' Canada','0',60,90),(310,'Sids Hair Studio & Barber Shop','+1 403-452-3731','','1336 12 Ave SW, Calgary, AB T3C 0P5, Canada','1336 12 Ave SW',' Calgary','AB','T3C',' Canada','0',60,90),(311,'Mirrors Hair Salon and Esthetics','+1 403-719-0999','','939 6 Ave SW, Calgary, AB T2P 0V7, Canada','939 6 Ave SW',' Calgary','AB','T2P',' Canada','0',60,90),(312,'Great Clips','+1 403-278-8033','','1221 Canyon Meadows Dr SE, Calgary, AB T2J 6G2, Canada','1221 Canyon Meadows Dr SE',' Calgary','AB','T2J',' Canada','0',60,90),(313,'Great Clips','+1 403-278-8033','','1221 Canyon Meadows Dr SE, Calgary, AB T2J 6G2, Canada','1221 Canyon Meadows Dr SE',' Calgary','AB','T2J',' Canada','0',60,90),(314,'The Monal Islamabad','+92 51 2898066','','9KM Pir Sohawa Rd, Islamabad, Islamabad Capital Territory, Pakistan','9KM Pir Sohawa Rd',' Islamabad','Islamabad','Capital',' Pakistan','0',37,91),(315,'Pan-Asian, Islamabad Club','+92 51 8435650','','Muree Road, Shakar Parian, Islamabad, Islamabad Capital Territory, Pakistan','Muree Road',' Shakar Parian','Islamabad','',' Pakistan','0',37,91),(316,'Pan-Asian, Islamabad Club','+92 51 8435650','','Muree Road, Shakar Parian, Islamabad, Islamabad Capital Territory, Pakistan','Muree Road',' Shakar Parian','Islamabad','',' Pakistan','0',37,91),(317,'Khan Restaurant','+92 300 2603292','','MXMQ+99H, F-11 Markaz F 11 Markaz F-11, Islamabad, Islamabad Capital Territory, Pakistan','MXMQ+99H',' F-11 Markaz F 11 Markaz F-11','Islamabad','',' Pakistan','0',37,91),(318,'Khan Restaurant','+92 300 2603292','','MXMQ+99H, F-11 Markaz F 11 Markaz F-11, Islamabad, Islamabad Capital Territory, Pakistan','MXMQ+99H',' F-11 Markaz F 11 Markaz F-11','Islamabad','',' Pakistan','0',37,91),(319,'Codeaza Technologies','','','Work Zone, MPCHS E-11/3 MPCHS E 11/3 E-11, Islamabad, Islamabad Capital Territory 44000, Pakistan','Work Zone',' MPCHS E-11/3 MPCHS E 11/3 E-11','Islamabad','',' Pakistan','0',37,92),(320,'Serai Bistro','+92 51 8431762','','Street 31, Ramna 4 Diplomatic Enclave, Islamabad, Islamabad Capital Territory, Pakistan','Street 31',' Ramna 4 Diplomatic Enclave','Islamabad','',' Pakistan','0',37,91),(321,'Codeaza Technologies','','','Work Zone, MPCHS E-11/3 MPCHS E 11/3 E-11, Islamabad, Islamabad Capital Territory 44000, Pakistan','Work Zone',' MPCHS E-11/3 MPCHS E 11/3 E-11','Islamabad','',' Pakistan','0',37,92),(322,'Serai Bistro','+92 51 8431762','','Street 31, Ramna 4 Diplomatic Enclave, Islamabad, Islamabad Capital Territory, Pakistan','Street 31',' Ramna 4 Diplomatic Enclave','Islamabad','',' Pakistan','0',37,91),(323,'Shaheen Market','+92 51 2650999','','P2GX+X45, E-7, Islamabad, Islamabad Capital Territory, Pakistan','P2GX+X45',' E-7','Islamabad','',' Pakistan','0',37,91),(324,'Shaheen Market','+92 51 2650999','','P2GX+X45, E-7, Islamabad, Islamabad Capital Territory, Pakistan','P2GX+X45',' E-7','Islamabad','',' Pakistan','0',37,91),(325,'KABUL RESTAURANT','+92 51 2650952','','P393+RC3, F-7 Markaz F 7 Markaz F-7, Islamabad, Islamabad Capital Territory, Pakistan','P393+RC3',' F-7 Markaz F 7 Markaz F-7','Islamabad','',' Pakistan','0',37,91),(326,'KABUL RESTAURANT','+92 51 2650952','','P393+RC3, F-7 Markaz F 7 Markaz F-7, Islamabad, Islamabad Capital Territory, Pakistan','P393+RC3',' F-7 Markaz F 7 Markaz F-7','Islamabad','',' Pakistan','0',37,91),(327,'Bismillah Tikka & Chargha House','+92 51 2280302','','Madina Market،، Street 21, F-8/2 Block 5 F-8, Islamabad, Islamabad Capital Territory, Pakistan','Madina Market،، Street 21',' F-8/2 Block 5 F-8','Islamabad','',' Pakistan','0',37,91),(328,'Bismillah Tikka & Chargha House','+92 51 2280302','','Madina Market،، Street 21, F-8/2 Block 5 F-8, Islamabad, Islamabad Capital Territory, Pakistan','Madina Market،، Street 21',' F-8/2 Block 5 F-8','Islamabad','',' Pakistan','0',37,91),(329,'Tandoori Restaurant','+92 51 5788896','','Sector E DHA Phase 1, Rawalpindi, Islamabad Capital Territory 46000, Pakistan','Sector E DHA Phase 1',' Rawalpindi','Islamabad','Capital',' Pakistan','0',37,91),(330,'Tandoori Restaurant','+92 51 5788896','','Sector E DHA Phase 1, Rawalpindi, Islamabad Capital Territory 46000, Pakistan','Sector E DHA Phase 1',' Rawalpindi','Islamabad','Capital',' Pakistan','0',37,91),(331,'Wildmen Restaurant','+92 51 5146018','','G4XJ+8QV, Bahria Town Phase IV Phase 4 Bahria Town, Rawalpindi, Islamabad, Punjab, Pakistan','G4XJ+8QV',' Bahria Town Phase IV Phase 4 Bahria Town','Rawalpindi','',' Pakistan','0',37,91),(332,'Wildmen Restaurant','+92 51 5146018','','G4XJ+8QV, Bahria Town Phase IV Phase 4 Bahria Town, Rawalpindi, Islamabad, Punjab, Pakistan','G4XJ+8QV',' Bahria Town Phase IV Phase 4 Bahria Town','Rawalpindi','',' Pakistan','0',37,91),(333,'Janaan Afghan Restaurant جانان افغان ریسٹورنٹ','+92 302 0958637','','M2V7+X6F, F-10 Markaz F 10/3 F-10, Islamabad, Islamabad Capital Territory, Pakistan','M2V7+X6F',' F-10 Markaz F 10/3 F-10','Islamabad','',' Pakistan','0',37,91),(334,'Janaan Afghan Restaurant جانان افغان ریسٹورنٹ','+92 302 0958637','','M2V7+X6F, F-10 Markaz F 10/3 F-10, Islamabad, Islamabad Capital Territory, Pakistan','M2V7+X6F',' F-10 Markaz F 10/3 F-10','Islamabad','',' Pakistan','0',37,91),(335,'Haleem Ghar','+92 51 111 425 336','','Ground Floor Ginza Center، Jinnah Ave, G 7/2 Blue Area, Islamabad, Islamabad Capital Territory 44000, Pakistan','Ground Floor Ginza Center، Jinnah Ave',' G 7/2 Blue Area','Islamabad','',' Pakistan','0',37,91),(336,'Char Grill Central','+92 331 8662228','','Gol Market, Shop 5، F-7/3 F 7/3 F-7, Islamabad, Islamabad Capital Territory, Pakistan','Gol Market',' Shop 5، F-7/3 F 7/3 F-7','Islamabad','',' Pakistan','0',37,91),(337,'Char Grill Central','+92 331 8662228','','Gol Market, Shop 5، F-7/3 F 7/3 F-7, Islamabad, Islamabad Capital Territory, Pakistan','Gol Market',' Shop 5، F-7/3 F 7/3 F-7','Islamabad','',' Pakistan','0',37,91),(338,'BABA JEE NEW SHINWARI','+92 51 2325334','','G9/4 Street 55, G-9/4 G 9/4 G-9, Islamabad, Islamabad Capital Territory, Pakistan','G9/4 Street 55',' G-9/4 G 9/4 G-9','Islamabad','',' Pakistan','0',37,91),(339,'BABA JEE NEW SHINWARI','+92 51 2325334','','G9/4 Street 55, G-9/4 G 9/4 G-9, Islamabad, Islamabad Capital Territory, Pakistan','G9/4 Street 55',' G-9/4 G 9/4 G-9','Islamabad','',' Pakistan','0',37,91),(340,'Rayyan\'s Fast Food','+92 51 2855496','','33, Al Babar Centre، Park Rd, Islamabad, Pakistan','33',' Al Babar Centre، Park Rd','Islamabad','',' Pakistan','0',37,91),(341,'Roasters Coffee House & Grill','','','1 Agha Khan Rd, F-6 Markaz F 6 Markaz F-6, Islamabad, Islamabad Capital Territory, Pakistan','1 Agha Khan Rd',' F-6 Markaz F 6 Markaz F-6','Islamabad','',' Pakistan','0',37,91),(342,'Roasters Coffee House & Grill','','','1 Agha Khan Rd, F-6 Markaz F 6 Markaz F-6, Islamabad, Islamabad Capital Territory, Pakistan','1 Agha Khan Rd',' F-6 Markaz F 6 Markaz F-6','Islamabad','',' Pakistan','0',37,91),(343,'Black Rock Cafe','+92 51 2163133','','IMH، Plot 16, Street 88, Shop 03 FF Near، F.E.C.H.S. FECHS E 11/3 E-11, Islamabad, Islamabad Capital Territory, Pakistan','IMH، Plot 16',' Street 88','Shop','03',' Pakistan','0',37,91),(344,'Black Rock Cafe','+92 51 2163133','','IMH، Plot 16, Street 88, Shop 03 FF Near، F.E.C.H.S. FECHS E 11/3 E-11, Islamabad, Islamabad Capital Territory, Pakistan','IMH، Plot 16',' Street 88','Shop','03',' Pakistan','0',37,91),(345,'Pizza Max - Rawalpindi','+92 51 111 629 111','','68 High Street Box Park, Food court, Bahria Springs, opp. Green Valley Premium Hyper Market, Phase 7 Bahria Town, Rawalpindi, Pakistan','68 High Street Box Park',' Food court','Bahria','Springs',' Pakistan','0',37,91),(346,'Pizza Max - Rawalpindi','+92 51 111 629 111','','68 High Street Box Park, Food court, Bahria Springs, opp. Green Valley Premium Hyper Market, Phase 7 Bahria Town, Rawalpindi, Pakistan','68 High Street Box Park',' Food court','Bahria','Springs',' Pakistan','0',37,91),(347,'Magnum Barbershop','+1 403-475-8588','','1019 17 Ave SW #102, Calgary, AB T2T 0A7, Canada','1019 17 Ave SW #102',' Calgary','AB','T2T',' Canada','0',60,93),(348,'Denim & Smith Barbershop - Springborough Professional Centre','+1 403-453-3230','','30 Springborough Blvd SW, Calgary, AB T3H 5M6, Canada','30 Springborough Blvd SW',' Calgary','AB','T3H',' Canada','0',60,93),(349,'ARCpoint Labs of Columbus Metro','(614) 484-5115','','1335 Dublin Rd #118E, Columbus, OH 43215','1335 Dublin Rd #118E',' Columbus','OH','43215',' OH 43215','0',1,98),(350,'CDL Testing Inc','(614) 351-7680','','4060 Perimeter Dr, Columbus, OH 43228','4060 Perimeter Dr',' Columbus','OH','43228',' OH 43228','0',1,98),(351,'WorkZone E-11','+92 309 1009790','','Street 36 Silk Bank Plaza Lower Basement WorkZone, MPCHS E 11/3 E-11, Islamabad, Islamabad Capital Territory, Pakistan','Street 36 Silk Bank Plaza Lower Basement WorkZone',' MPCHS E 11/3 E-11','Islamabad','',' Pakistan','0',1,99),(352,'WorkZone E-11','+92 309 1009790','','Street 36 Silk Bank Plaza Lower Basement WorkZone, MPCHS E 11/3 E-11, Islamabad, Islamabad Capital Territory, Pakistan','Street 36 Silk Bank Plaza Lower Basement WorkZone',' MPCHS E 11/3 E-11','Islamabad','',' Pakistan','0',1,99),(353,'WorkZone E-11','+92 309 1009790','','Street 36 Silk Bank Plaza Lower Basement WorkZone, MPCHS E 11/3 E-11, Islamabad, Islamabad Capital Territory, Pakistan','Street 36 Silk Bank Plaza Lower Basement WorkZone',' MPCHS E 11/3 E-11','Islamabad','',' Pakistan','0',1,100),(354,'WorkZone E-11','+92 309 1009790','','Street 36 Silk Bank Plaza Lower Basement WorkZone, MPCHS E 11/3 E-11, Islamabad, Islamabad Capital Territory, Pakistan','Street 36 Silk Bank Plaza Lower Basement WorkZone',' MPCHS E 11/3 E-11','Islamabad','',' Pakistan','0',1,100),(355,'Pizza Rustica','(614) 754-1459','','17 S High St, Columbus, OH 43215','17 S High St',' Columbus','OH','43215',' OH 43215','0',62,101),(356,'Pat and Gracie\'s','(614) 914-8484','','340 E Gay St, Columbus, OH 43215','340 E Gay St',' Columbus','OH','43215',' OH 43215','0',62,101),(357,'Ash & Em','(614) 390-1288','','541 S High St, Columbus, OH 43215','541 S High St',' Columbus','OH','43215',' OH 43215','0',62,101),(358,'South Village Grille','(614) 826-0491','','197 Thurman Ave, Columbus, OH 43206','197 Thurman Ave',' Columbus','OH','43206',' OH 43206','0',62,101),(359,'High Bank Distillery Co','(614) 826-5347','','1051 Goodale Blvd, Columbus, OH 43212','1051 Goodale Blvd',' Columbus','OH','43212',' OH 43212','0',62,101),(360,'Madison Soul Food Kitchen','(614) 252-1657','','1731 Greenway Ave, Columbus, OH 43203','1731 Greenway Ave',' Columbus','OH','43203',' OH 43203','0',62,101),(361,'Mad Greek','(614) 338-0000','','4210 E Broad St, Columbus, OH 43213','4210 E Broad St',' Columbus','OH','43213',' OH 43213','0',62,101),(362,'L.Ginger Asian Fusion & Hibachi','(614) 228-2318','','Inside Capitol Square, 65 E State St, Columbus, OH 43215','Inside Capitol Square',' 65 E State St','Columbus','',' OH 43215','0',62,101),(363,'Smith & Wollensky','(614) 416-2400','','4145 The Strand W, Columbus, OH 43219','4145 The Strand W',' Columbus','OH','43219',' OH 43219','0',62,101),(364,'Goodale Station','(614) 227-9400','','77 E Nationwide Blvd, Columbus, OH 43215','77 E Nationwide Blvd',' Columbus','OH','43215',' OH 43215','0',62,101),(365,'Indian Oven','(614) 220-9390','','427 E Main St, Columbus, OH 43215','427 E Main St',' Columbus','OH','43215',' OH 43215','0',62,101),(366,'Bellys Hip Hop Eatery','(614) 754-9400','','1584 Kohr Pl, Columbus, OH 43211','1584 Kohr Pl',' Columbus','OH','43211',' OH 43211','0',62,101),(367,'Chili\'s Grill & Bar','(614) 761-2101','','3675 W Dublin Granville Rd, Columbus, OH 43235','3675 W Dublin Granville Rd',' Columbus','OH','43235',' OH 43235','0',62,101),(368,'Drunch Eatery + Bar','(614) 420-2121','','995 N 4th St, Columbus, OH 43201','995 N 4th St',' Columbus','OH','43201',' OH 43201','0',62,101),(369,'Windward Passage','(614) 451-2497','','4739 Reed Rd, Columbus, OH 43220','4739 Reed Rd',' Columbus','OH','43220',' OH 43220','0',62,101),(370,'MacKenzie River Pizza, Grill & Pub','(614) 840-9466','','1515 Polaris Pkwy, Columbus, OH 43240','1515 Polaris Pkwy',' Columbus','OH','43240',' OH 43240','0',62,101),(371,'Chick-fil-A','(614) 438-5845','','1500 Polaris Pkwy Ste FC4, Columbus, OH 43240','1500 Polaris Pkwy Ste FC4',' Columbus','OH','43240',' OH 43240','0',62,101),(372,'Delaney\'s Diner','(614) 626-2006','','6150 E Main St, Columbus, OH 43213','6150 E Main St',' Columbus','OH','43213',' OH 43213','0',62,101),(373,'Hellas Carryout','(614) 792-5494','','9346 Dublin Rd, Powell, OH 43065','9346 Dublin Rd',' Powell','OH','43065',' OH 43065','0',62,101),(374,'Denny\'s','(740) 965-1541','','7735 State Rd, OH-37, Berkshire, OH 43074','7735 State Rd',' OH-37','Berkshire','',' OH 43074','0',62,101),(375,'Denny\'s','(740) 965-1541','','7735 State Rd, OH-37, Berkshire, OH 43074','7735 State Rd',' OH-37','Berkshire','',' OH 43074','0',62,101),(376,'QDOBA Mexican Eats','(812) 376-1005','','1665 N National Rd, Columbus, IN 47201','1665 N National Rd',' Columbus','IN','47201',' IN 47201','0',62,101),(377,'Retechnic Software House Islamabad','+92 313 1570989','','plot#19-C,Flat#02,Third Floor,tricone tower, Islamabad, 44000, Pakistan','plot#19-C','Flat#02','Third','Floor',' Pakistan','0',60,103),(378,'Retechnic Software House Islamabad','+92 313 1570989','','plot#19-C,Flat#02,Third Floor,tricone tower, Islamabad, 44000, Pakistan','plot#19-C','Flat#02','Third','Floor',' Pakistan','0',60,103),(379,'Techuire','+92 333 8322151','','Office # 501, plaza 153-O, 5th floor, Civic Center Bahria Town, Rawalpindi, Islamabad, Punjab 44000, Pakistan','Office # 501',' plaza 153-O','5th','floor',' Pakistan','0',60,103),(380,'Techuire','+92 333 8322151','','Office # 501, plaza 153-O, 5th floor, Civic Center Bahria Town, Rawalpindi, Islamabad, Punjab 44000, Pakistan','Office # 501',' plaza 153-O','5th','floor',' Pakistan','0',60,103),(381,'Islamabad Soft','+92 300 2737054','','Office No 16, 1st Floor, Mujahid Plaza, Jinnah Ave, near Sonehri Bank, G 7/2 Blue Area, Islamabad, Islamabad Capital Territory, Pakistan','Office No 16',' 1st Floor','Mujahid','Plaza',' Pakistan','0',60,103),(382,'Islamabad Soft','+92 300 2737054','','Office No 16, 1st Floor, Mujahid Plaza, Jinnah Ave, near Sonehri Bank, G 7/2 Blue Area, Islamabad, Islamabad Capital Territory, Pakistan','Office No 16',' 1st Floor','Mujahid','Plaza',' Pakistan','0',60,103),(383,'Whinstone (Pvt.) Ltd.','+92 51 8731327','','Software Technology Park, I-9/3 I 9/3 I-9, Islamabad, Islamabad Capital Territory 44000, Pakistan','Software Technology Park',' I-9/3 I 9/3 I-9','Islamabad','',' Pakistan','0',60,103),(384,'Whinstone (Pvt.) Ltd.','+92 51 8731327','','Software Technology Park, I-9/3 I 9/3 I-9, Islamabad, Islamabad Capital Territory 44000, Pakistan','Software Technology Park',' I-9/3 I 9/3 I-9','Islamabad','',' Pakistan','0',60,103),(385,'web development company in Islamabad | WebComers','+92 300 9002225','','House # 242 Street 55, I-8/3 I 8/2 I-8, Islamabad, Islamabad Capital Territory 44000, Pakistan','House # 242 Street 55',' I-8/3 I 8/2 I-8','Islamabad','',' Pakistan','0',60,103),(386,'web development company in Islamabad | WebComers','+92 300 9002225','','House # 242 Street 55, I-8/3 I 8/2 I-8, Islamabad, Islamabad Capital Territory 44000, Pakistan','House # 242 Street 55',' I-8/3 I 8/2 I-8','Islamabad','',' Pakistan','0',60,103),(387,'ATIKASOL','','','Pakland Square, G-8 Markaz G 8 Markaz G-8, Islamabad, Islamabad Capital Territory 44000, Pakistan','Pakland Square',' G-8 Markaz G 8 Markaz G-8','Islamabad','',' Pakistan','0',60,103),(388,'ATIKASOL','','','Pakland Square, G-8 Markaz G 8 Markaz G-8, Islamabad, Islamabad Capital Territory 44000, Pakistan','Pakland Square',' G-8 Markaz G 8 Markaz G-8','Islamabad','',' Pakistan','0',60,103),(389,'Infinity Bits','+92 312 6649839','','Office 304, CUBATOR 1ne, Park Rd, near COMSATS University, Islamabad, Islamabad Capital Territory 44000, Pakistan','Office 304',' CUBATOR 1ne','Park','Rd',' Pakistan','0',60,103),(390,'Infinity Bits','+92 312 6649839','','Office 304, CUBATOR 1ne, Park Rd, near COMSATS University, Islamabad, Islamabad Capital Territory 44000, Pakistan','Office 304',' CUBATOR 1ne','Park','Rd',' Pakistan','0',60,103),(391,'Discretelogix (Private) Limited','+92 51 8443637','','Service Rd N, I-9/3 I 9/3 I-9, Islamabad, Islamabad Capital Territory 44000, Pakistan','Service Rd N',' I-9/3 I 9/3 I-9','Islamabad','',' Pakistan','0',60,103),(392,'Vizteck Solutions','+92 51 2728804','','Floor 2, Building 145, Block C، Civic Center Bahria Town Phase 4 Bahria Town, Rawalpindi, Islamabad, Punjab 46000, Pakistan','Floor 2',' Building 145','Block','C،',' Pakistan','0',60,103),(393,'Vizteck Solutions','+92 51 2728804','','Floor 2, Building 145, Block C، Civic Center Bahria Town Phase 4 Bahria Town, Rawalpindi, Islamabad, Punjab 46000, Pakistan','Floor 2',' Building 145','Block','C،',' Pakistan','0',60,103),(394,'The Right Software pvt Ltd.','','','Office # 1/08, 3rd Floor, Silk Center, Murree Rd, Block B Satellite Town, Rehmanabad, Rawalpindi, Punjab 44000, Pakistan','Office # 1/08',' 3rd Floor','Silk','Center',' Pakistan','0',60,103),(395,'The Right Software pvt Ltd.','','','Office # 1/08, 3rd Floor, Silk Center, Murree Rd, Block B Satellite Town, Rehmanabad, Rawalpindi, Punjab 44000, Pakistan','Office # 1/08',' 3rd Floor','Silk','Center',' Pakistan','0',60,103),(396,'Red Buffer','+92 51 4436371','','Plot 408 Service Rd E, I-9/3 I 9/3 I-9, Islamabad, Islamabad Capital Territory 44000, Pakistan','Plot 408 Service Rd E',' I-9/3 I 9/3 I-9','Islamabad','',' Pakistan','0',60,103),(397,'Red Buffer','+92 51 4436371','','Plot 408 Service Rd E, I-9/3 I 9/3 I-9, Islamabad, Islamabad Capital Territory 44000, Pakistan','Plot 408 Service Rd E',' I-9/3 I 9/3 I-9','Islamabad','',' Pakistan','0',60,103),(398,'Enabling Systems (Private) Limited.','+92 51 8436890','','Mid City Mall, First Floor, Near Sadiqabad Stop, Benazir Bhutto Rd, Block B Satellite Town, Rawalpindi, Punjab 46000, Pakistan','Mid City Mall',' First Floor','Near','Sadiqabad',' Pakistan','0',60,103),(399,'Enabling Systems (Private) Limited.','+92 51 8436890','','Mid City Mall, First Floor, Near Sadiqabad Stop, Benazir Bhutto Rd, Block B Satellite Town, Rawalpindi, Punjab 46000, Pakistan','Mid City Mall',' First Floor','Near','Sadiqabad',' Pakistan','0',60,103),(400,'New Vision Technologies','+92 334 5614920','','office no 2 2rd floor Hong Kong Plaza Market 5th Commercial، Street،, Rawalpindi, 46000, Pakistan','office no 2 2rd floor Hong Kong Plaza Market 5th Commercial، Street،',' Rawalpindi','46000','',' Pakistan','0',60,103),(401,'New Vision Technologies','+92 334 5614920','','office no 2 2rd floor Hong Kong Plaza Market 5th Commercial، Street،, Rawalpindi, 46000, Pakistan','office no 2 2rd floor Hong Kong Plaza Market 5th Commercial، Street،',' Rawalpindi','46000','',' Pakistan','0',60,103),(402,'Ericsson Pakistan Private Limited','+92 51 8318270','','3rd Floor, Low Rise Building، Saudi-Pak Towers, Jinnah Ave, Block L F 7/4 Blue Area, Islamabad, Islamabad Capital Territory 44000, Pakistan','3rd Floor',' Low Rise Building، Saudi-Pak Towers','Jinnah','Ave',' Pakistan','0',60,103),(403,'Ericsson Pakistan Private Limited','+92 51 8318270','','3rd Floor, Low Rise Building، Saudi-Pak Towers, Jinnah Ave, Block L F 7/4 Blue Area, Islamabad, Islamabad Capital Territory 44000, Pakistan','3rd Floor',' Low Rise Building، Saudi-Pak Towers','Jinnah','Ave',' Pakistan','0',60,103);
/*!40000 ALTER TABLE `script_result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testimonials`
--

DROP TABLE IF EXISTS `testimonials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `testimonials` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(300) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `designation` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;


--
-- Dumping data for table `testimonials`
--

LOCK TABLES `testimonials` WRITE;
/*!40000 ALTER TABLE `testimonials` DISABLE KEYS */;
INSERT INTO `testimonials` VALUES (8,'Kimberly Hodges','\"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\"','Director'),(10,'Muhammad Qasim','\"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\"','Director'),(11,'Iain Munro','New Testimonial','Helper');
/*!40000 ALTER TABLE `testimonials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(300) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `address1` varchar(255) NOT NULL,
  `address2` varchar(255) NOT NULL,
  `email` varchar(300) NOT NULL,
  `password` varchar(300) NOT NULL,
  `current_invoice` int DEFAULT NULL,
  `active_status` tinyint(1) NOT NULL DEFAULT '1',
  `date_joined` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username_2` (`username`),
  UNIQUE KEY `username_4` (`username`,`email`),
  UNIQUE KEY `noTwoUsersCanHaveSameInvoice` (`current_invoice`),
  KEY `username_3` (`username`,`email`),
  CONSTRAINT `user_has_current_invoice` FOREIGN KEY (`current_invoice`) REFERENCES `invoices` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'asim','Muhammad','Qasim','Flat No s12','Rawalpini','asim@codeaza.com','1234',NULL,1,'2021-10-22 18:07:44'),(37,'hhaarriiss','Haris','Manzoor','House # 232/A block G.M Abad','','harrissmanzoor22@gmail.com','1234',25,1,'2021-10-28 16:54:29'),(38,'hhaarriis','Haris','Manzoor','House # 232/A block G.M Abad','','harrissmanzoor22@gmail.commmmm','1234',26,1,'2021-10-28 16:57:59'),(43,'admidfdsfdsfdsfs','Haris','Manzoor','House # 232/A block G.M Abad','','harrissmanzoor22@gmail.comdsfdsfs','1234',31,1,'2021-10-28 18:46:27'),(44,'hhaarriissasasasasasaa','Haris','Manzoor','House # 232/A block G.M Abad','','harrissmanzoor22@gmail.comasasasasasa','1234',32,1,'2021-10-29 12:10:16'),(45,'hhaarriisslksjdflkjdslfkjsdlkfj','Haris','Manzoor','House # 232/A block G.M Abad','','harrissmanzoor22@gmail.com1234lkdjfldkj','1234',33,1,'2021-10-29 13:14:42'),(46,'hhaarriiss11111','Haris','Manzoor','House # 232/A block G.M Abad','','harrissmanzoor22@gmail.com121ljkljd','1234',34,1,'2021-10-29 13:35:25'),(47,'hhaarriisszzz','Haris','Manzoor','House # 232/A block G.M Abad','','harrissmanzoor22@gmail.comzzz','1234',35,1,'2021-10-29 13:37:35'),(48,'hhaarriissaaaa','Haris','Manzoor','House # 232/A block G.M Abad','','harrissmanzoor22@gmail.comaaaa','1234',36,1,'2021-10-29 14:31:24'),(49,'haarriis111111lkfjdslkjf','Haris','Manzoor','House no 232/A Block GM Abad','','i180428@nu.edu.pkkajskajs','1234',37,1,'2021-10-29 19:21:21'),(50,'abcdtestcodeaza','Haris','Manzoor','House no 232/A Block GM Abad','','abcdtest@codeaza.com','1234',38,1,'2021-10-29 19:38:21'),(51,'pwinter','Peter','Winter','8140 9th Ave, SW','','iainhmunro@gmail.com','1234',39,1,'2021-10-30 14:35:40'),(52,'mmunro','Mackenzie','Munro','8140 9th Ave, SW','','mackenziemunro5@gmail.com','1234',40,1,'2021-10-30 14:47:09'),(54,'ksmith','kim','Smith','8140 9th Ave, SW','','ksmith@gmail.com','1234',42,1,'2021-10-30 19:11:54'),(55,'kharwood','Kevin','Harwood','8140 9th Ave, SW','','kevin@gmail.com','1234',43,1,'2021-10-30 20:42:45'),(56,'psmith','Paul','Smith','8140 9th Ave, SW','','psmith@gmail.com','1234',44,1,'2021-11-01 17:11:04'),(57,'ismith','Iain','Smith','8140 9th Ave, SW','','ismith@gmail.com','1234',45,1,'2021-11-01 17:13:47'),(58,'jmunro','June','Munro','8140 9th Ave, SW','','jmunro@gmail.com','1234',46,1,'2021-11-01 20:41:59'),(59,'cmunro','Colin','Munro','8140 9th Ave, SW','','cmunro@gmail.com','1234',47,1,'2021-11-01 20:42:51'),(60,'bmartin','Bill','Martin','8140 9th Ave, SW','','bmartin@gmail.com','1234',48,1,'2021-11-03 19:16:42'),(61,'dmunro','Dolma','Munro','8140 9th Ave, SW','','dmunro@gmail.com','1234',49,1,'2021-11-04 15:15:46'),(62,'amitchell','Andy','Mitchell','8140 9th Ave, SW','','amithchell@gmail.com','1234',50,1,'2021-11-05 19:31:47');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-06 22:07:33
