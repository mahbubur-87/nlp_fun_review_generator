-- MySQL dump 10.13  Distrib 8.0.23, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: db_DRIFT
-- ------------------------------------------------------
-- Server version	8.0.23-0ubuntu0.20.04.1

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
-- Table structure for table `tbl_product`
--

DROP TABLE IF EXISTS `tbl_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `price` decimal(6,2) NOT NULL,
  `currency` varchar(45) NOT NULL DEFAULT 'Euro',
  `brand` varchar(45) NOT NULL,
  `seller` varchar(45) NOT NULL,
  `shop_name` varchar(45) NOT NULL DEFAULT 'Amazon',
  `category` varchar(45) NOT NULL DEFAULT 'missing',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_product`
--

LOCK TABLES `tbl_product` WRITE;
/*!40000 ALTER TABLE `tbl_product` DISABLE KEYS */;
INSERT INTO `tbl_product` VALUES (1,'Echo Studio - Smart high fidelity speaker with 3D audio and Alexa',169.99,'Euro','Amazon','Amazon EU Sarl','Amazon','electronic_device.smart_speaker'),(2,'Ockered Battery for iPhone SE, High Capacity Replacement Battery with Tool Kit and Repair Kit, Battery Replacement Instructions, Compatible with Apple SE, 24 Months Warranty',12.19,'Euro','Ockered','Patricia Ann Effendi','Amazon','replacement_parts.battery'),(3,'Enteenly LED Strip 3 m LED TV Backlight Suitable for 40-60 Inch TVs and PC, App Control and Remote Control, RGB, USB Operated',11.99,'Euro','Enteenly','Oobserver center','Amazon','decorative_lighting.led_strips'),(4,'Doctor CheckUp at Dr. med. Franziska Schindler',46.57,'Euro','Doctena','Dr. med. Franziska Schindler','Doctena','health.physician');
/*!40000 ALTER TABLE `tbl_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_product_vocabulary`
--

DROP TABLE IF EXISTS `tbl_product_vocabulary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_product_vocabulary` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `vocabulary_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_product_vocabulary`
--

LOCK TABLES `tbl_product_vocabulary` WRITE;
/*!40000 ALTER TABLE `tbl_product_vocabulary` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_product_vocabulary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_review`
--

DROP TABLE IF EXISTS `tbl_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_review` (
  `id` int NOT NULL AUTO_INCREMENT,
  `header` varchar(200) DEFAULT NULL,
  `body` varchar(2000) DEFAULT NULL,
  `status` varchar(45) NOT NULL DEFAULT 'SUBMIT',
  `product_id` int NOT NULL,
  `submit_date` datetime DEFAULT NULL,
  `accept_date` datetime DEFAULT NULL,
  `locale` varchar(6) NOT NULL DEFAULT 'en_US',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_review`
--

LOCK TABLES `tbl_review` WRITE;
/*!40000 ALTER TABLE `tbl_review` DISABLE KEYS */;
INSERT INTO `tbl_review` VALUES (1,'Smart Alexa with 3D sounds','I love the Amazon brand because it maintains product quality.\n\nI rate this product 5 stars because this Dolby Digital speaker with 3D audio and Alexa has 3 dimentional sound that is very dynamic bass. It is also a perfect control through vocal and smart playback setting Echo Studio.\n\nWhen I was looking for Echo Studio, I looked at this product along with other similar products. The useful features of this product among other similar products are its price and built-in SmartHome hub. The price is perfect with its brand and the outlook is smart and beautiful.\n\nI have been using the Echo Studio and Alexa regularly in my master bedroom for 60 days. Another feature worth mentioning is the privacy protection and the Alexa service is hassle free.\n\nI really like this product because it is high quality and the service is satisfactory according to the product description. Therefore, I recommend others to buy this product.','ACCEPT',1,'2021-03-20 23:30:00','2021-03-22 10:12:00','en_US'),(2,'High quality iPhone replacement Battery','This product is rated 5 stars because it has some additional features compared to other Batteries. These extra features are High Capacity, Tool Kit and Repair Kit.\n\nThere are no issues with the product and the product fits properly on my iPhone. However, at first it is not working. Later it is successful with the help of Battery Replacement Instructions provided by the seller, so thanks to the seller for the Battery Replacement Instructions to be attached with the package.\n\nBecause of the smart functionalities and better quality, I like this product very much and at the same time I recommend future buyers to buy this product for their iPhone.','ACCEPT',2,'2021-03-24 09:14:00','2021-03-25 21:37:00','en_US'),(3,'Smart and Sexy LED Strips','Because of the smart and sexy look with excellent App Control, I give this product 5 stars. Compared to other LED Strips, this product has a Remote Control, RGB, USB Operated, is usefull, is good for decoration, and has a low electricity consumption.\n\nThere are no issues with the product, and the product fits my Wall Mirror just right. In addition, this product includes built-in high-sensitivity microphone, 16 million colours for brightness.\n\nBecause of the smart functionalities and better quality, I really like this product and recommend future buyers to buy this product.','ACCEPT',3,'2021-03-24 09:14:00','2021-03-25 21:46:48','en_US'),(4,'Nice, Friendly, Well English Speaking Doctor','5 stars rating for this product because\n- Easily get an appointment through Doctena\n- Relaxing environment\n- Patient caring\n- Take time to hear problems of the patient\n- Price is affordable\n- Give a perfect solution for each problem\n\nConsidering above attractive features and multi-purpose functionalities, I like this product and give personal recommendation to buy this product.','SUBMIT',4,'2021-03-29 16:45:35',NULL,'en_US');
/*!40000 ALTER TABLE `tbl_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_review_vocabulary`
--

DROP TABLE IF EXISTS `tbl_review_vocabulary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_review_vocabulary` (
  `id` int NOT NULL AUTO_INCREMENT,
  `review_id` int NOT NULL,
  `vocabulary_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_review_vocabulary`
--

LOCK TABLES `tbl_review_vocabulary` WRITE;
/*!40000 ALTER TABLE `tbl_review_vocabulary` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_review_vocabulary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_vocabulary`
--

DROP TABLE IF EXISTS `tbl_vocabulary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_vocabulary` (
  `id` int NOT NULL AUTO_INCREMENT,
  `word` varchar(69) NOT NULL,
  `synonym_1` varchar(69) NOT NULL,
  `synonym_2` varchar(69) NOT NULL,
  `synonym_3` varchar(69) DEFAULT NULL,
  `synonym_4` varchar(69) DEFAULT NULL,
  `synonym_5` varchar(69) DEFAULT NULL,
  `synonym_6` varchar(69) DEFAULT NULL,
  `meaning` varchar(69) NOT NULL,
  `locale` varchar(6) NOT NULL DEFAULT 'en_US',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_vocabulary`
--

LOCK TABLES `tbl_vocabulary` WRITE;
/*!40000 ALTER TABLE `tbl_vocabulary` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_vocabulary` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-29 17:06:57
