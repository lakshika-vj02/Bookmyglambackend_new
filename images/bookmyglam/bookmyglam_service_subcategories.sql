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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-18 17:30:52
