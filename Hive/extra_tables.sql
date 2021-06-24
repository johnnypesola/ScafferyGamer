--
-- Table structure for table `safe_zones`
--

DROP TABLE IF EXISTS `safe_zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `safe_zones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `instance_id` int(11) NOT NULL,
  `x` int(11) DEFAULT NULL,
  `y` int(11) DEFAULT NULL,
  `radius` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1 COMMENT='List of safe zones by instance ID, name, position and radius';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `safe_zones`
--

LOCK TABLES `safe_zones` WRITE;
/*!40000 ALTER TABLE `safe_zones` DISABLE KEYS */;
INSERT INTO `safe_zones` VALUES (1,'Trader City Lenzburg',24,8246,15485,50),(2,'Trader City Emmen',24,15506,13229,100),(3,'Trader City Schratten',24,12399,5074,75),(4,'Bandit Vendor',24,10398,8279,50),(5,'Hero Vendor',24,5149,4864,50),(6,'West Wholesaler',24,2122,7807,50),(7,'North Wholesaler',24,5379,16103,50),(8,'Nordic Boats',24,6772,16983,50),(9,'Pauls Boats',24,16839,5264,50),(10,'AWOLs Airfield',24,15128,16421,75),(11,'Trader City Stary',11,6325,7807,100),(12,'Trader City Bash',11,4063,11664,100),(13,'Trader City Klen',11,11447,11364,100),(14,'Bandit Vendor',11,1606,7803,100),(15,'Hero Vendor',11,12944,12766,100),(16,'Airplane Dealer',11,12060,12638,100);
/*!40000 ALTER TABLE `safe_zones` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-08 12:33:40

