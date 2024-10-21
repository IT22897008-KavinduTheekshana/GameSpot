-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: gamespot
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `games`
--

DROP TABLE IF EXISTS `games`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `games` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(450) NOT NULL,
  `genre` varchar(450) NOT NULL,
  `price` double NOT NULL,
  `cover_image` varchar(450) NOT NULL,
  `description` text,
  `download_link` varchar(450) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `games`
--

LOCK TABLES `games` WRITE;
/*!40000 ALTER TABLE `games` DISABLE KEYS */;
INSERT INTO `games` VALUES (3,'Overwatch','Shooter',39.99,'overwatch.jpeg','Team-based multiplayer first-person shooter.','http://example.com/download/overwatch'),(4,'Spider-Man','Action-Adventure',59.99,'SpiderMan.jpeg','Experience the life of a superhero in New York City as Spider-Man. Swing through the streets and fight iconic villains.','https://www.playstation.com/en-us/games/spider-man/'),(5,'Call of Duty','First-Person Shooter',49.99,'COD.jpeg','Join the fight in this fast-paced, tactical first-person shooter that continues to push the boundaries of multiplayer gaming.','https://www.callofduty.com/'),(6,'God of War','Action-Adventure',39.99,'godofwar.jpeg','Embark on a journey with Kratos and his son, Atreus, as they navigate the world of Norse mythology and battle against gods and monsters.','https://www.playstation.com/en-us/games/god-of-war/'),(7,'Far Cry','First-Person Shooter',44.99,'FarCry.jpeg','Explore an open world filled with danger and excitement as you fight against various factions in a battle for survival.','https://www.ubisoft.com/en-us/game/far-cry/'),(8,'Assassin\'s Creed','Action-Adventure',54.99,'Assassin\'sCreed.jpeg','Step into the shoes of a master assassin and experience historical events through the eyes of different characters across various time periods.','https://www.ubisoft.com/en-us/game/assassins-creed/'),(9,'Senua\'s Saga','Action-Adventure',39.99,'Senua\'sSaga.jpeg','Join Senua on her haunting journey through the Viking heartland, confronting her fears and battling her inner demons.','https://www.hellblade.com/senuasaga/');
/*!40000 ALTER TABLE `games` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-19 23:02:10
