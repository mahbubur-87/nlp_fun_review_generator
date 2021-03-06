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
  `category` varchar(45) NOT NULL DEFAULT 'missing',
  `price` decimal(6,2) NOT NULL,
  `currency` varchar(45) NOT NULL DEFAULT 'Euro',
  `brand` varchar(45) NOT NULL,
  `seller` varchar(45) NOT NULL,
  `shop_name` varchar(45) NOT NULL DEFAULT 'Amazon',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_product`
--

LOCK TABLES `tbl_product` WRITE;
/*!40000 ALTER TABLE `tbl_product` DISABLE KEYS */;
INSERT INTO `tbl_product` VALUES (1,'Echo Studio - Smart high fidelity speaker with 3D audio and Alexa','electronic_device.smart_speaker',169.99,'Euro','Amazon','Amazon EU Sarl','Amazon'),(2,'Ockered Battery for iPhone SE, High Capacity Replacement Battery with Tool Kit and Repair Kit, Battery Replacement Instructions, Compatible with Apple SE, 24 Months Warranty','replacement_parts.battery',12.19,'Euro','Ockered','Patricia Ann Effendi','Amazon'),(3,'Enteenly LED Strip 3 m LED TV Backlight Suitable for 40-60 Inch TVs and PC, App Control and Remote Control, RGB, USB Operated','decorative_lighting.led_strips',11.99,'Euro','Enteenly','Oobserver center','Amazon'),(4,'ROOTOK EMS Training Device','fitness.electric_stimulator',29.90,'Euro','ROOTOK','CHENGFENGYI','Amazon'),(5,'lightweight and soft shoes','men_fashion.shoes',73.81,'Euro','STEELEMENT','STEELEMENT','Amazon'),(6,'Polyester made Unisex backpack','luggage.casual_backpack',75.26,'Euro','Jack Wolfskin','Amazon','Amazon'),(7,'Climate friendly automatic dehumidifier','electronic_device.dehumidifier',34.49,'Euro','MELOPHY','ZMKJ','Amazon'),(8,'liquid fertiliser bottle, having a pump dispenser that is attached with it','plant.liquid_fertiliser',6.99,'Euro','UNDERGREEN','UNDERGREEN','Amazon');
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
  `product_id` int DEFAULT NULL,
  `service_id` int DEFAULT NULL,
  `submit_date` datetime DEFAULT NULL,
  `accept_date` datetime DEFAULT NULL,
  `locale` varchar(6) NOT NULL DEFAULT 'en_US',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_review`
--

LOCK TABLES `tbl_review` WRITE;
/*!40000 ALTER TABLE `tbl_review` DISABLE KEYS */;
INSERT INTO `tbl_review` VALUES (1,'Smart Alexa with 3D sounds','I love the Amazon brand because it maintains product quality.\n\nI rate this product 5 stars because this Dolby Digital speaker with 3D audio and Alexa has 3 dimentional sound that is very dynamic bass. It is also a perfect control through vocal and smart playback setting Echo Studio.\n\nWhen I was looking for Echo Studio, I looked at this product along with other similar products. The useful features of this product among other similar products are its price and built-in SmartHome hub. The price is perfect with its brand and the outlook is smart and beautiful.\n\nI have been using the Echo Studio and Alexa regularly in my master bedroom for 60 days. Another feature worth mentioning is the privacy protection and the Alexa service is hassle free.\n\nI really like this product because it is high quality and the service is satisfactory according to the product description. Therefore, I recommend others to buy this product.','ACCEPT',1,NULL,'2021-03-20 23:30:00','2021-03-22 10:12:00','en_US'),(2,'High quality iPhone replacement Battery','This product is rated 5 stars because it has some additional features compared to other Batteries. These extra features are High Capacity, Tool Kit and Repair Kit.\n\nThere are no issues with the product and the product fits properly on my iPhone. However, at first it is not working. Later it is successful with the help of Battery Replacement Instructions provided by the seller, so thanks to the seller for the Battery Replacement Instructions to be attached with the package.\n\nBecause of the smart functionalities and better quality, I like this product very much and at the same time I recommend future buyers to buy this product for their iPhone.','ACCEPT',2,NULL,'2021-03-24 09:14:00','2021-03-25 21:37:00','en_US'),(3,'Smart and Sexy LED Strips','Because of the smart and sexy look with excellent App Control, I give this product 5 stars. Compared to other LED Strips, this product has a Remote Control, RGB, USB Operated, is usefull, is good for decoration, and has a low electricity consumption.\n\nThere are no issues with the product, and the product fits my Wall Mirror just right. In addition, this product includes built-in high-sensitivity microphone, 16 million colours for brightness.\n\nBecause of the smart functionalities and better quality, I really like this product and recommend future buyers to buy this product.','ACCEPT',3,NULL,'2021-03-24 09:14:00','2021-03-25 21:46:48','en_US'),(4,'Nice, Friendly, Well English Speaking Doctor','5 stars rating for this product because\n- Easily get an appointment through Doctena\n- Relaxing environment\n- Patient caring\n- Take time to hear problems of the patient\n- Price is affordable\n- Give a perfect solution for each problem\n\nConsidering above attractive features and multi-purpose functionalities, I like this product and give personal recommendation to buy this product.','ACCEPT',NULL,1,'2021-03-29 16:45:35','2021-03-29 16:45:35','en_US'),(5,'Useful EMS Training Device','5 stars rating for this product because\n- Safe electric frequencies that are low, soft and has massage effect.\n- Suitable for most body parts such as abdomen, waist, arms, shoulders, back, thighs, calves and buttocks.\n- Can be used parallely during other works like cooking, studying etc.\n- Have multiple moods that are perfect for me.\n- Price is affordable.\n- Good quality product with informative instruction book.\n\nConsidering above attractive features and multi-purpose functionalities, I like this product and give personal recommendation to buy this product.','ACCEPT',4,NULL,'2021-04-14 09:49:54','2021-04-15 09:49:54','en_US'),(6,'Break curse and remove negative energy','I give this service a 5 star rating because its good and the negative energy removal is effective for daily work. Now I can enjoy everyday life with this protective shield. I like this negative energy removal and also the quality is very good. So I recommend others to buy this service.','ACCEPT',NULL,2,'2021-04-18 09:02:36','2021-04-18 09:06:36','en_US'),(7,'Comfortable and Smart Cycling Shoe ','I give this product a 5 star rating because its good and the adjustable smart buckles with hooks is time saving, easy manageable for quick outdoor preparation. Now I can enjoy cycling as well as jogging with this ligtweight and soft shoes. I like this cool cycling shoe and also the quality is very good. So I recommend others to buy this product.','ACCEPT',5,NULL,'2021-04-24 09:51:02','2021-04-25 09:51:02','en_US'),(8,'Good Looking and Environment Friendly Backpack','I love the Jack Wolfskin brand because it maintains product quality.\n\nI rate this product 5 stars because these Polyester made Unisex backpack has perfect dimensions with notebook case that is very helpful for taking notebook and other objects. It is also a perfect travel backpack and office-grade casual backpack.\n\nWhen I was looking for casual backpack, I looked at this product along with other similar products. The useful features of this product among other similar products are its price and various compartments and pockets. The price is perfect with its brand and the outlook is smart and beautiful.\n\nI have been using the slim fit backpack regularly for 365 days in rainy weather and also in snow, cold weather. Another noteable feature is Snuggle Up Plus and the service of the Jack Wolfskin Backpack is trouble-free.\n\nI really like this product because it is high quality and the service is satisfactory according to the product description. Therefore, I recommend others to buy this product.','ACCEPT',6,NULL,'2021-04-24 10:26:22','2021-04-25 10:26:22','en_US'),(9,'Smooth and noise free automatic dehumidifier','I love the MELOPHY brand because it maintains product quality.\n\nI rate this product 5 stars because this Climate friendly automatic dehumidifier has noise canceling that is very useful. It is also a perfect low energy consumptive and dirt, mould protective dehumidifiers.\n\nWhen I was looking for dehumidifiers, I looked at this product along with other similar products. The useful features of this product among other similar products are its price and good air quality controller. The price is perfect with its brand and the outlook is smart and beautiful.\n\nI have been using the super dehumidification device regularly for 6 days in my master bedroom. Another notable feature is light indicator and the service of the smart automatic dehumidifier is trouble-free.\n\nI really like this product because it is high quality and the service is satisfactory according to the product description. Therefore, I recommend others to buy this product.','SUBMIT',7,NULL,'2021-05-01 12:27:12',NULL,'en_US'),(10,'Hight quality organic liquid fertiliser','I give this product a 5 star rating because its good and the organic liquid fertiliser is combination of all important nutrients for optimal growth. Now I can enjoy fertilising my plant with this liquid fertiliser bottle, having a pump dispenser that is attached with it. I like this all in one solution and also the quality is very good. So I recommend others to buy this product.','SUBMIT',8,NULL,'2021-05-01 12:31:50',NULL,'en_US');
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
-- Table structure for table `tbl_service`
--

DROP TABLE IF EXISTS `tbl_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_service` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) DEFAULT NULL,
  `provider` varchar(45) DEFAULT NULL,
  `provider_platform` varchar(45) DEFAULT NULL,
  `category` varchar(45) DEFAULT NULL,
  `street` varchar(200) DEFAULT NULL,
  `house_number` varchar(45) DEFAULT NULL,
  `postal_code` int DEFAULT NULL,
  `city` varchar(45) DEFAULT 'Berlin',
  `country` varchar(45) DEFAULT 'Germany',
  `phone` varchar(45) DEFAULT NULL,
  `website` varchar(200) DEFAULT NULL,
  `map_coordinates` varchar(45) DEFAULT NULL COMMENT 'longitude and latitude',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_service`
--

LOCK TABLES `tbl_service` WRITE;
/*!40000 ALTER TABLE `tbl_service` DISABLE KEYS */;
INSERT INTO `tbl_service` VALUES (1,'Doctor CheckUp at Dr. med. Franziska Schindler','Dr. med. Franziska Schindler','Doctena','health.physician','Tauentzienstrasse','1',10789,'Berlin','Germany','03036284638','https://en.doctena.de/doctor/Dr_med_Franziska_Schindler-284811','52.502385196853005, 13.342056886175168'),(2,'protective shield','destinyy','Fiverr','lifestyle.spellcasting','?','?',-1,'Berlin','Germany','?','https://www.fiverr.com/destinyy/break-curse-and-remove-negative-energy','?');
/*!40000 ALTER TABLE `tbl_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_service_vocabulary`
--

DROP TABLE IF EXISTS `tbl_service_vocabulary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_service_vocabulary` (
  `id` int NOT NULL AUTO_INCREMENT,
  `service_id` int NOT NULL,
  `vocabulary_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_service_vocabulary`
--

LOCK TABLES `tbl_service_vocabulary` WRITE;
/*!40000 ALTER TABLE `tbl_service_vocabulary` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_service_vocabulary` ENABLE KEYS */;
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

-- Dump completed on 2021-05-01 13:21:11
