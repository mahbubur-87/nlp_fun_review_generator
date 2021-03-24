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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_product`
--

LOCK TABLES `tbl_product` WRITE;
/*!40000 ALTER TABLE `tbl_product` DISABLE KEYS */;
INSERT INTO `tbl_product` VALUES (2,'test',24.02,'Euro','Amazon','Amazon','Amazon','missing'),(3,'test',24.02,'Euro','Amazon','Amazon','Amazon','missing'),(4,'test',24.02,'Euro','Amazon','Amazon','Amazon','missing'),(5,'test',24.02,'Euro','Amazon','Amazon','Amazon','missing');
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
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `locale` varchar(6) NOT NULL DEFAULT 'en_US',
  PRIMARY KEY (`id`),
  KEY `fk_tbl_review_1_idx` (`product_id`),
  CONSTRAINT `fk_tbl_review_1` FOREIGN KEY (`product_id`) REFERENCES `tbl_product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_review`
--

LOCK TABLES `tbl_review` WRITE;
/*!40000 ALTER TABLE `tbl_review` DISABLE KEYS */;
INSERT INTO `tbl_review` VALUES (2,'Sexy LED Strips','The price seems to be higher than its features. However, the product is good and the most important thing that I satisfy using this product. So I give this product 5 stars.','SUBMIT',2,'2021-03-21 02:43:21','2021-03-21 02:43:21','en_US'),(4,'High quality iPhone replacement Battery','This product is rated 5 stars because it has some additional features compared to other Batteries. These extra features are High Capacity, Tool Kit and Repair Kit.\n\nThere are no issues with the product and the product fits properly on my iPhone. However, at first it is not working. Later it is successful with the help of Battery Replacement Instructions provided by the seller, so thanks to the seller for the Battery Replacement Instructions to be attached with the package.\n\nBecause of the smart functionalities and better quality, I like this product very much and at the same time I recommend future buyers to buy this product for their iPhone.','SUBMIT',4,'2021-03-24 09:26:47','2021-03-24 09:26:47','en_US'),(5,'Smart and Sexy LED Strips','Because of the smart and sexy look with excellent App Control, I give this product 5 stars. Compared to other LED Strips, this product has a Remote Control, RGB, USB Operated, is usefull, is good for decoration, and has a low electricity consumption.\n\nThere are no issues with the product, and the product fits my Wall Mirror just right. In addition, this product includes built-in high-sensitivity microphone, 16 million colours for brightness.\n\nBecause of the smart functionalities and better quality, I really like this product and recommend future buyers to buy this product.','SUBMIT',5,'2021-03-24 09:38:49','2021-03-24 09:38:49','en_US');
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

-- Dump completed on 2021-03-24 11:04:34
