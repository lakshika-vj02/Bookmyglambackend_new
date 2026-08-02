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
-- Table structure for table `artist_services`
--

DROP TABLE IF EXISTS `artist_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artist_services` (
  `id` int NOT NULL AUTO_INCREMENT,
  `artist_id` int NOT NULL,
  `subcategory_id` int NOT NULL,
  `duration` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `artist_id` (`artist_id`),
  KEY `subcategory_id` (`subcategory_id`),
  CONSTRAINT `artist_services_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`),
  CONSTRAINT `artist_services_ibfk_2` FOREIGN KEY (`subcategory_id`) REFERENCES `service_subcategories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist_services`
--

LOCK TABLES `artist_services` WRITE;
/*!40000 ALTER TABLE `artist_services` DISABLE KEYS */;
INSERT INTO `artist_services` VALUES (1,1,1,'90 mins'),(2,1,2,'120 mins'),(3,1,5,'60 mins'),(4,2,1,'120 mins'),(5,2,9,'75 mins'),(6,3,2,'90 mins'),(7,3,4,'90 mins'),(8,3,6,'45 mins'),(17,4,7,NULL),(18,4,8,NULL),(19,4,9,NULL),(20,5,10,NULL),(21,5,11,NULL),(22,6,1,NULL),(23,6,2,NULL),(24,6,5,NULL),(25,6,7,NULL);
/*!40000 ALTER TABLE `artist_services` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Table structure for table `booking_services`
--

DROP TABLE IF EXISTS `booking_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_services` (
  `id` int NOT NULL AUTO_INCREMENT,
  `booking_id` int NOT NULL,
  `service_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `booking_id` (`booking_id`),
  KEY `service_id` (`service_id`),
  CONSTRAINT `booking_services_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`),
  CONSTRAINT `booking_services_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `service_subcategories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_services`
--

LOCK TABLES `booking_services` WRITE;
/*!40000 ALTER TABLE `booking_services` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT 'FK → users.id',
  `artist_id` int DEFAULT NULL COMMENT 'FK → artists.id',
  `booking_date` date NOT NULL,
  `time_slot` varchar(20) DEFAULT NULL COMMENT 'e.g. 10:00 AM',
  `address` text COMMENT 'Home/location address',
  `status` enum('pending','confirmed','completed','cancelled') NOT NULL DEFAULT 'pending',
  `total_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `notes` text,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `customer_name` varchar(100) DEFAULT NULL,
  `customer_phone` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_bookings_user_id` (`user_id`),
  KEY `idx_bookings_artist_id` (`artist_id`),
  KEY `idx_bookings_date` (`booking_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `image` varchar(255) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Bridal Makeup','Complete bridal makeup packages',NULL,1,'2026-07-06 06:16:38'),(2,'Hair Styling','Haircut, coloring, and styling',NULL,1,'2026-07-06 06:16:38'),(3,'Skin Care','Facials, cleanups, and skin treatments',NULL,1,'2026-07-06 06:16:38'),(4,'Nail Art','Manicure, pedicure, and nail art',NULL,1,'2026-07-06 06:16:38'),(5,'Mehendi','Bridal and festive mehendi designs',NULL,1,'2026-07-06 06:16:38'),(6,'Waxing','Full body and threading services',NULL,1,'2026-07-06 06:16:38');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `booking_id` int NOT NULL COMMENT 'FK → bookings.id',
  `user_id` int NOT NULL COMMENT 'FK → users.id',
  `amount` decimal(10,2) NOT NULL,
  `payment_mode` enum('cash','online','card','upi') NOT NULL DEFAULT 'online',
  `payment_status` enum('pending','success','failed','refunded') NOT NULL DEFAULT 'pending',
  `transaction_id` varchar(200) DEFAULT NULL,
  `paid_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_payments_booking_id` (`booking_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT 'FK → users.id',
  `artist_id` int DEFAULT NULL COMMENT 'FK → artists.id',
  `service_id` int DEFAULT NULL COMMENT 'FK → services.id',
  `booking_id` int DEFAULT NULL COMMENT 'FK → bookings.id',
  `rating` tinyint NOT NULL DEFAULT '5' COMMENT '1 to 5 stars',
  `comment` text,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_reviews_user_id` (`user_id`),
  KEY `idx_reviews_artist_id` (`artist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_subcategories`
--

DROP TABLE IF EXISTS `service_subcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_subcategories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `service_id` int NOT NULL,
  `subcategory_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `price` decimal(10,2) DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `duration` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `service_id` (`service_id`),
  CONSTRAINT `service_subcategories_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_subcategories`
--

LOCK TABLES `service_subcategories` WRITE;
/*!40000 ALTER TABLE `service_subcategories` DISABLE KEYS */;
INSERT INTO `service_subcategories` VALUES (1,1,'HD Makeup','Professional HD bridal makeup with flawless finish.',4500.00,'hd-bridal-makeup.jpg',1,'90 mins'),(2,1,'Airbrush Makeup','Premium airbrush bridal makeup for a lightweight look.',6500.00,'air_brush_makeup.jpg',1,'120 mins'),(3,1,'Matte Makeup','Long-lasting matte bridal makeup for oily skin.',5000.00,NULL,1,'90 mins'),(4,1,'Dewy Makeup','Natural dewy bridal makeup for glowing skin.',5500.00,NULL,1,'90 mins'),(5,2,'HD Party Makeup','Long-lasting HD party makeup',3500.00,'hdparty.jpg',1,'60 mins'),(6,2,'Airbrush Party Makeup','Premium airbrush party look',5000.00,'airbrushparty.jpg',1,'75 mins'),(7,2,'Smokey Eye Makeup','Party makeup with smokey eye look',3000.00,'smokey.jpg',1,'45 mins'),(8,7,'Deep Cleansing Facial','Removes dirt and impurities for healthy skin.',1500.00,'deep-cleansing.jpg',1,'45 mins'),(9,7,'Gold Facial','Enhances skin glow with gold-infused facial treatment.',2500.00,'gold-facial.jpg',1,'60 mins'),(10,7,'Diamond Facial','Premium facial for radiant and youthful skin.',3000.00,'diamond-facial.jpg',1,'75 mins'),(11,7,'Fruit Facial','Natural fruit-based facial for fresh and hydrated skin.',1200.00,'fruit-facial.jpg',1,'45 mins'),(12,7,'Anti-Aging Facial','Reduces fine lines and improves skin elasticity.',3500.00,'anti-aging.jpg',1,'75 mins'),(18,12,'Full Arms Waxing','Complete waxing for both arms.',500.00,'full-arms.jpg',1,'30 mins'),(19,12,'Half Arms Waxing','Waxing from wrist to elbow.',300.00,'half-arms.jpg',1,'20 mins'),(20,12,'Full Legs Waxing','Complete waxing for both legs.',800.00,'full-legs.jpg',1,'45 mins'),(21,12,'Half Legs Waxing','Waxing from ankle to knee.',450.00,'half-legs.jpg',1,'30 mins'),(22,12,'Underarms Waxing','Smooth underarm waxing service.',250.00,'underarms.jpg',1,'15 mins'),(23,12,'Full Body Waxing','Complete body waxing service.',2500.00,'full-body.jpg',1,'90 mins'),(47,4,'Basic Hair Cut','Regular haircut for all hair types.',500.00,'basic-haircut.jpg',1,'30 mins'),(48,4,'Layer Cut','Layered haircut for added volume and style.',700.00,'layer-cut.jpg',1,'45 mins'),(49,4,'Step Cut','Step-cut hairstyle with defined layers.',800.00,'step-cut.jpg',1,'45 mins'),(50,4,'Bob Cut','Classic short bob hairstyle.',900.00,'bob-cut.jpg',1,'45 mins'),(51,4,'U Cut','U-shaped haircut for long hair.',700.00,'u-cut.jpg',1,'45 mins'),(52,4,'V Cut','V-shaped haircut for long hair.',700.00,'v-cut.jpg',1,'45 mins'),(53,13,'Hair Wash','Professional hair wash.',300.00,'hair-wash.jpg',1,'20 mins'),(54,13,'Hair Wash & Blow Dry','Hair wash with blow drying.',600.00,'hair-wash-blowdry.jpg',1,'40 mins'),(55,13,'Deep Cleansing Wash','Deep cleansing scalp and hair wash.',500.00,'deep-cleansing.jpg',1,'30 mins'),(56,14,'Keratin Spa','Keratin-based hair spa treatment.',1800.00,'keratin-spa.jpg',1,'90 mins'),(57,14,'Protein Spa','Protein-rich hair spa treatment.',1500.00,'protein-spa.jpg',1,'75 mins'),(58,14,'Anti Hair Fall Spa','Hair spa for reducing hair fall.',1700.00,'anti-hairfall-spa.jpg',1,'75 mins'),(59,14,'Dandruff Control Spa','Hair spa for dandruff control.',1600.00,'dandruff-spa.jpg',1,'75 mins');
/*!40000 ALTER TABLE `service_subcategories` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `gender` varchar(20) NOT NULL,
  `phone_no` varchar(20) NOT NULL,
  `role` enum('user','artist','admin') NOT NULL DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Admin','admin@bookmyglam.com','admin123','male','9999999999','admin','2026-07-06 06:16:38'),(2,'vinita','v@gamil.com','lakshika','female','1234567890','user','2026-07-16 05:07:56'),(3,'jaya','j@gmail.com','lak123','female','1234567890','user','2026-07-16 11:28:47'),(4,'lavi','l@gmail.com','lakshika','female','1234567890','user','2026-07-16 18:48:26'),(5,'deepak','Lakshika@vijayvargiya','hello','female','1234567890','admin','2026-07-17 05:28:35'),(8,'lakshika vijayvargiya','D@gmail.com','lakshika ','female','1234567890','user','2026-07-17 05:34:38'),(10,'janvi','janvigmail.com','lakshika','female','1234567890','user','2026-07-17 09:21:04'),(11,'vijay','vijay','123','male','1234567890','user','2026-07-17 09:22:09'),(12,'khushi','khushi','khushi','female','1234567890','user','2026-07-17 09:24:20'),(13,'anjali jain','anjali','123','female','1234567890','user','2026-07-17 10:20:47'),(15,'laks','dd@gmail.com','Lakshika@123','female','8306032732','user','2026-07-17 12:27:46'),(16,'jevan','jeeven@gmail.com','Lakshika@123','female','8306032732','user','2026-07-17 12:48:22');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-18 17:35:03
