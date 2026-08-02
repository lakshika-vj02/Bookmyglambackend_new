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
-- Table structure for table `artists`
--

DROP TABLE IF EXISTS `artists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artists` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `specialty` varchar(150) DEFAULT NULL COMMENT 'e.g. Bridal Makeup, Hair Styling',
  `bio` text,
  `profile_image` varchar(255) DEFAULT NULL,
  `rating` decimal(3,2) DEFAULT '0.00',
  `experience_years` int DEFAULT '0',
  `user_id` int DEFAULT NULL COMMENT 'FK → users.id (if artist has login)',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `location` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_artists_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artists`
--

LOCK TABLES `artists` WRITE;
/*!40000 ALTER TABLE `artists` DISABLE KEYS */;
INSERT INTO `artists` VALUES (1,'Priya Sharma','priya@bookmyglam.com','9876543210','female','Bridal Makeup',NULL,'artist1.jpg',4.80,5,NULL,1,'2026-07-06 06:16:38','Udaipur'),(2,'Neha Kapoor','neha@bookmyglam.com','9876543211','female','Hair Styling',NULL,'artist2.jpg',4.70,7,NULL,1,'2026-07-06 06:16:38','Jaipur'),(3,'Anjali Singh','anjali@bookmyglam.com','9876543212','female','Skin Care',NULL,'artist3.jpg',4.60,4,NULL,1,'2026-07-06 06:16:38','Jodhpur'),(4,'Pooja Mehta','pooja@bookmyglam.com','9876543213','female','Nail Art',NULL,'artist4.jpg',4.50,3,NULL,1,'2026-07-06 06:16:38','Kota'),(5,'Ritika Gupta','ritika@bookmyglam.com','9876543214','female','Mehendi',NULL,'artist5.jpg',4.90,6,NULL,1,'2026-07-06 06:16:38','Ajmer'),(6,'Simran Kaur','simran@bookmyglam.com','9876543215','female','Bridal Makeup',NULL,'artist6.jpg',4.75,8,NULL,1,'2026-07-06 06:16:38','Udaipur');
/*!40000 ALTER TABLE `artists` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-18 17:30:50
