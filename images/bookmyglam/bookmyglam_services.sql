-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: bookmyglam
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `description` text,
  `category` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `image` varchar(255) DEFAULT NULL,
  `duration` int DEFAULT NULL COMMENT 'Duration in minutes',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_services_category` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,'Bridal Makeup','HD Bridal Makeup with trial','Bridal Makeup',8000.00,'bridal.jpg',180,1,'2026-07-06 06:16:38'),(2,'Party Makeup','Glam party makeup look','Bridal Makeup',2500.00,'party.jpg',90,1,'2026-07-06 06:16:38'),(3,'HD Makeup','High definition flawless makeup','Bridal Makeup',3500.00,'hd.jpg',60,1,'2026-07-06 06:16:38'),(4,'Hair Cut & Styling','Haircut with blow dry','Hair Styling',800.00,'hair.jpg',45,1,'2026-07-06 06:16:38'),(5,'Hair Color','Full head global hair coloring','Hair Styling',3000.00,'haircolor.jpg',120,1,'2026-07-06 06:16:38'),(6,'Hair Straightening','Permanent hair straightening','Hair Styling',4000.00,'hairstraight.jpg',150,1,'2026-07-06 06:16:38'),(7,'Facial','Deep cleansing facial','Skin Care',1200.00,'bridall.jpg',60,1,'2026-07-06 06:16:38'),(8,'Manicure - French','Classic french manicure','Nail Art',600.00,'french.jpg',45,1,'2026-07-06 06:16:38'),(9,'Manicure - Gel','Long lasting gel nail polish','Nail Art',800.00,'gel.jpg',60,1,'2026-07-06 06:16:38'),(10,'Nail Art - Gold','Premium gold nail art designs','Nail Art',1200.00,'Nail Gold Designs.jpg',75,1,'2026-07-06 06:16:38'),(11,'Bridal Mehendi','Full hands bridal mehendi','Mehendi',3500.00,NULL,120,1,'2026-07-06 06:16:38'),(12,'Waxing - Full Body','Full body chocolate waxing','Waxing',1500.00,'wax.jpg',90,1,'2026-07-06 06:16:38'),(13,'Hair Wash','Professional hair washing services.','Hair',0.00,'hairwash.jpg',NULL,1,'2026-07-09 10:55:50'),(14,'Hair Spa','Hair nourishment and treatment services.','Hair',0.00,NULL,NULL,1,'2026-07-09 10:55:50');
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-18 17:30:51
