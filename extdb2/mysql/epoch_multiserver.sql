--
-- DayZ Epoch 1.0.6.1 for extDB2
--
-- ONLY RUN THIS FILE IF CREATING A NEW DATABASE.
-- EXISTING 1051 DATABASES SHOULD USE 1.0.6_UPDATES.SQL INSTEAD AND THEN RUN 1.0.6.1_UPDATES.SQL.
-- EXISTING 106 DATABASES SHOULD USE 1.0.6.1_UPDATES.SQL INSTEAD.
--

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------------
-- Table structure for table `character_data`
-- ----------------------------------

CREATE TABLE IF NOT EXISTS `character_data` (
  `character_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `player_uid` varchar(32) NOT NULL,
  `instance_id` int(11) NOT NULL,
  `datestamp` datetime DEFAULT NULL,
  `last_login` datetime NOT NULL,
  `inventory_magazines` text NOT NULL,
  `inventory_weapons` text NOT NULL,
  `inventory_onback` varchar(64) NOT NULL DEFAULT '',
  `backpack` varchar(64) NOT NULL,
  `backpack_magazines` text NOT NULL,
  `backpack_weapons` text NOT NULL,
  `ws_napf_x` double(13,5) NOT NULL DEFAULT '0.00000',
  `ws_napf_y` double(13,5) NOT NULL DEFAULT '0.00000',
  `ws_napf_z` double(13,5) NOT NULL DEFAULT '0.00000',
  `ws_napf_dir` double(13,5) NOT NULL DEFAULT '0.00000',
  `ws_cherno_x` double(13,5) NOT NULL DEFAULT '0.00000',
  `ws_cherno_y` double(13,5) NOT NULL DEFAULT '0.00000',
  `ws_cherno_z` double(13,5) NOT NULL DEFAULT '0.00000',
  `ws_cherno_dir` double(13,5) NOT NULL DEFAULT '0.00000',
  `med_dead` tinyint(4) NOT NULL,
  `med_unconscious` tinyint(4) NOT NULL,
  `med_infected` tinyint(4) NOT NULL,
  `med_injured` tinyint(4) NOT NULL,
  `med_inpain` tinyint(4) NOT NULL,
  `med_cardiac` tinyint(4) NOT NULL,
  `med_lowblood` tinyint(4) NOT NULL,
  `med_bloodqty` int(11) NOT NULL,
  `med_wounds` text NOT NULL,
  `med_hit_legs` double(13,5) NOT NULL,
  `med_hit_arms` double(13,5) NOT NULL,
  `med_unconscious_time` double(13,5) NOT NULL,
  `med_blood_type` varchar(3) NOT NULL DEFAULT '?',
  `med_rh_factor` tinyint(4) NOT NULL DEFAULT '0',
  `med_messing` varchar(32) NOT NULL,
  `med_blood_testdone` tinyint(4) NOT NULL DEFAULT '0',
  `alive` tinyint(4) unsigned NOT NULL DEFAULT '1',
  `generation` int(11) unsigned NOT NULL DEFAULT '1',
  `last_ate` datetime NOT NULL,
  `last_drank` datetime NOT NULL,
  `kills_z` int(11) unsigned NOT NULL DEFAULT '0',
  `headshots_z` int(11) unsigned NOT NULL DEFAULT '0',
  `dist_foot` int(11) NOT NULL DEFAULT '0',
  `duration` int(11) unsigned NOT NULL DEFAULT '0',
  `current_weapon` varchar(64) NOT NULL DEFAULT '',
  `current_anim` varchar(96) NOT NULL DEFAULT '',
  `current_temp` tinyint(4) unsigned NOT NULL DEFAULT '100',
  `friendlies` text NOT NULL,
  `kills_h` int(11) unsigned NOT NULL DEFAULT '0',
  `kills_b` int(11) unsigned NOT NULL DEFAULT '0',
  `humanity` int(11) NOT NULL DEFAULT '2500',
  `model` varchar(50) NOT NULL DEFAULT 'Survivor2_DZ',
  `infected` tinyint(3) NOT NULL DEFAULT '0',
  `coins` bigint(20) NOT NULL DEFAULT '0',
  `last_updated` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`character_id`),
  KEY `character_id` (`character_id`),
  KEY `char_fetch` (`player_uid`,`alive`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------------
-- Table structure for table `object_data_intermediate`
-- ----------------------------------

CREATE TABLE `object_data_intermediate` (
  `object_id` int(11) NOT NULL AUTO_INCREMENT,
  `player_uid` varchar(32) NOT NULL,
  `instance_from` int(11) unsigned NOT NULL,
  `instance_to` int(11) unsigned NOT NULL,
  `classname` varchar(50) NOT NULL DEFAULT '',
  `driver` varchar(32) NOT NULL,
  `commander` varchar(32) NOT NULL,
  `turrets` text NOT NULL,
  `cargo` text NOT NULL,
  `datestamp` datetime NOT NULL,
  `character_id` int(11) unsigned NOT NULL DEFAULT '0',
  `inventory_magazines` text NOT NULL,
  `inventory_weapons` text NOT NULL,
  `inventory_backpacks` text NOT NULL,
  `hitpoints` varchar(512) NOT NULL DEFAULT '[]',
  `fuel` double(13,5) NOT NULL DEFAULT '1.00000',
  `damage` double(13,5) NOT NULL DEFAULT '0.00000',
  `storage_coins` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`),
  KEY `player_uid` (`player_uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------------
-- Table structure for table `object_data_cherno`
-- ----------------------------------

CREATE TABLE `object_data_cherno` (
  `object_id` int(11) NOT NULL AUTO_INCREMENT,
  `object_uid` bigint(24) NOT NULL DEFAULT '0',
  `instance` int(11) unsigned NOT NULL,
  `classname` varchar(50) NOT NULL DEFAULT '',
  `datestamp` datetime NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `character_id` int(11) unsigned NOT NULL DEFAULT '0',
  `ws_x` double(13,5) NOT NULL DEFAULT '0.00000',
  `ws_y` double(13,5) NOT NULL DEFAULT '0.00000',
  `ws_z` double(13,5) NOT NULL DEFAULT '0.00000',
  `ws_dir` double(13,5) NOT NULL DEFAULT '0.00000',
  `ws_ownerpuid` varchar(32) NOT NULL DEFAULT '0',
  `ws_vect` varchar(255) NOT NULL DEFAULT '[[0,0,0],[0,0,0]]',
  `inventory_magazines` text NOT NULL,
  `inventory_weapons` text NOT NULL,
  `inventory_backpacks` text NOT NULL,
  `hitpoints` varchar(512) NOT NULL DEFAULT '[]',
  `fuel` double(13,5) NOT NULL DEFAULT '1.00000',
  `damage` double(13,5) NOT NULL DEFAULT '0.00000',
  `storage_coins` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`),
  KEY `object_uid` (`object_uid`) USING BTREE,
  KEY `instance` (`instance`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------------
-- Table structure for table `old_base_parts_cherno`
-- ----------------------------------

CREATE TABLE `old_base_parts_cherno` (
  `object_id` int(11) NOT NULL AUTO_INCREMENT,
  `object_uid` bigint(24) NOT NULL DEFAULT '0',
  `base_id` int(11) unsigned NOT NULL,
  `classname` varchar(50) NOT NULL DEFAULT '',
  `datestamp` datetime NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `character_id` int(11) unsigned NOT NULL DEFAULT '0',
  `ws_x` double(13,5) NOT NULL DEFAULT '0.00000',
  `ws_y` double(13,5) NOT NULL DEFAULT '0.00000',
  `ws_z` double(13,5) NOT NULL DEFAULT '0.00000',
  `ws_dir` double(13,5) NOT NULL DEFAULT '0.00000',
  `ws_ownerpuid` varchar(32) NOT NULL DEFAULT '0',
  `ws_vect` varchar(255) NOT NULL DEFAULT '[[0,0,0],[0,0,0]]',
  `inventory_magazines` text NOT NULL,
  `inventory_weapons` text NOT NULL,
  `inventory_backpacks` text NOT NULL,
  `hitpoints` varchar(512) NOT NULL DEFAULT '[]',
  `fuel` double(13,5) NOT NULL DEFAULT '1.00000',
  `damage` double(13,5) NOT NULL DEFAULT '0.00000',
  `storage_coins` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`),
  KEY `object_uid` (`object_uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- ----------------------------------
-- Table structure for table `object_data_napf`
-- ----------------------------------

CREATE TABLE `object_data_napf` (
  `object_id` int(11) NOT NULL AUTO_INCREMENT,
  `object_uid` bigint(24) NOT NULL DEFAULT '0',
  `instance` int(11) unsigned NOT NULL,
  `classname` varchar(50) NOT NULL DEFAULT '',
  `datestamp` datetime NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `character_id` int(11) unsigned NOT NULL DEFAULT '0',
  `ws_x` double(13,5) NOT NULL DEFAULT '0.00000',
  `ws_y` double(13,5) NOT NULL DEFAULT '0.00000',
  `ws_z` double(13,5) NOT NULL DEFAULT '0.00000',
  `ws_dir` double(13,5) NOT NULL DEFAULT '0.00000',
  `ws_ownerpuid` varchar(32) NOT NULL DEFAULT '0',
  `ws_vect` varchar(255) NOT NULL DEFAULT '[[0,0,0],[0,0,0]]',
  `inventory_magazines` text NOT NULL,
  `inventory_weapons` text NOT NULL,
  `inventory_backpacks` text NOT NULL,
  `hitpoints` varchar(512) NOT NULL DEFAULT '[]',
  `fuel` double(13,5) NOT NULL DEFAULT '1.00000',
  `damage` double(13,5) NOT NULL DEFAULT '0.00000',
  `storage_coins` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`),
  KEY `object_uid` (`object_uid`) USING BTREE,
  KEY `instance` (`instance`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------------
-- Table structure for table `old_base_parts_napf`
-- ----------------------------------

CREATE TABLE `old_base_parts_napf` (
  `object_id` int(11) NOT NULL AUTO_INCREMENT,
  `object_uid` bigint(24) NOT NULL DEFAULT '0',
  `base_id` int(11) unsigned NOT NULL,
  `classname` varchar(50) NOT NULL DEFAULT '',
  `datestamp` datetime NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `character_id` int(11) unsigned NOT NULL DEFAULT '0',
  `ws_x` double(13,5) NOT NULL DEFAULT '0.00000',
  `ws_y` double(13,5) NOT NULL DEFAULT '0.00000',
  `ws_z` double(13,5) NOT NULL DEFAULT '0.00000',
  `ws_dir` double(13,5) NOT NULL DEFAULT '0.00000',
  `ws_ownerpuid` varchar(32) NOT NULL DEFAULT '0',
  `ws_vect` varchar(255) NOT NULL DEFAULT '[[0,0,0],[0,0,0]]',
  `inventory_magazines` text NOT NULL,
  `inventory_weapons` text NOT NULL,
  `inventory_backpacks` text NOT NULL,
  `hitpoints` varchar(512) NOT NULL DEFAULT '[]',
  `fuel` double(13,5) NOT NULL DEFAULT '1.00000',
  `damage` double(13,5) NOT NULL DEFAULT '0.00000',
  `storage_coins` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`),
  KEY `object_uid` (`object_uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------------
-- Table structure for table `old_bases_cherno`
-- ----------------------------------

CREATE TABLE `old_bases_cherno` (
  `base_id` int(11) NOT NULL AUTO_INCREMENT,
  `ws_x` double(13,5) NOT NULL DEFAULT '0.00000',
  `ws_y` double(13,5) NOT NULL DEFAULT '0.00000',
  `ws_z` double(13,5) NOT NULL DEFAULT '0.00000',
  `grouped` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`base_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------------
-- Table structure for table `old_bases_napf`
-- ----------------------------------

CREATE TABLE `old_bases_napf` (
  `base_id` int(11) NOT NULL AUTO_INCREMENT,
  `ws_x` double(13,5) NOT NULL DEFAULT '0.00000',
  `ws_y` double(13,5) NOT NULL DEFAULT '0.00000',
  `ws_z` double(13,5) NOT NULL DEFAULT '0.00000',
  `grouped` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`base_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------------
-- Table structure for table `player_data`
-- ----------------------------------

CREATE TABLE `player_data` (
  `player_uid` varchar(32) NOT NULL,
  `player_name` varchar(128) NOT NULL,
  `player_morality` int(11) NOT NULL DEFAULT '0',
  `player_sex` tinyint(3) NOT NULL DEFAULT '0',
  `player_group` text NOT NULL,
  `player_coins` bigint(20) NOT NULL DEFAULT '0',
  `player_bank_coins` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------------
-- Table structure for table `player_login`
-- ----------------------------------

CREATE TABLE `player_login` (
  `login_id` int(11) NOT NULL AUTO_INCREMENT,
  `player_uid` varchar(32) NOT NULL,
  `character_id` int(11) unsigned NOT NULL,
  `Datestamp` datetime NOT NULL,
  `Action` tinyint(3) NOT NULL,
  PRIMARY KEY (`login_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------------
-- Table structure for table `server_traders`
-- ----------------------------------

CREATE TABLE `server_traders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `classname` varchar(128) NOT NULL,
  `instance` int(11) NOT NULL,
  `status` varchar(32) NOT NULL,
  `static` text,
  `desc` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=utf8;

-- ----------------------------------
-- Table structure for table `safe_zones`
-- ----------------------------------

CREATE TABLE IF NOT EXISTS `safe_zones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `instance_id` int(11) NOT NULL,
  `x` int(11) DEFAULT NULL,
  `y` int(11) DEFAULT NULL,
  `radius` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1 COMMENT='List of safe zones by instance ID, name, position and radius';

-- ----------------------------------
-- Dumping data for table `server_traders`
-- ----------------------------------

INSERT INTO `server_traders` VALUES (1,'CIV_EuroMan01_EP1',11,'friendly',NULL,'Weapons Trader - Bash');
INSERT INTO `server_traders` VALUES(2,'Rocker4',11,'friendly',NULL,'Weapons Trader - Klen');
INSERT INTO `server_traders` VALUES(3,'Woodlander3',11,'friendly',NULL,'Parts Trader - Bash');
INSERT INTO `server_traders` VALUES(4,'Woodlander1',11,'friendly','','Parts Trader - Klen');
INSERT INTO `server_traders` VALUES(5,'RU_WorkWoman1',11,'friendly','[\"ItemTinBar\",\"TrashJackDaniels\",1,1,\"buy\",\"Empty Wiskey Bottle\",\"Tin Bar\",101]','Can Trader - Klen');
INSERT INTO `server_traders` VALUES(6,'RU_WorkWoman5',11,'friendly','[\"ItemTinBar\",\"TrashJackDaniels\",1,1,\"buy\",\"Empty Wiskey Bottle\",\"Tin Bar\",101]','Can Trader - Bash');
INSERT INTO `server_traders` VALUES(7,'Rita_Ensler_EP1',11,'neutral','[\"ItemTinBar\",\"TrashJackDaniels\",1,1,\"buy\",\"Empty Wiskey Bottle\",\"Tin Bar\",101]','Can Trader - Stary');
INSERT INTO `server_traders` VALUES(8,'CIV_EuroMan02_EP1',11,'friendly','','Ammo Trader - Bash');
INSERT INTO `server_traders` VALUES(9,'RU_Citizen3',11,'friendly','','Ammo Trader - Klen');
INSERT INTO `server_traders` VALUES(10,'Pilot_EP1',11,'neutral','','Ammo Trader - Stary');
INSERT INTO `server_traders` VALUES(11,'Worker3',11,'friendly','','Auto Trader - Bash');
INSERT INTO `server_traders` VALUES(12,'Profiteer4',11,'friendly','','Auto Trader - Klen');
INSERT INTO `server_traders` VALUES(13,'Dr_Hladik_EP1',11,'friendly','[\"FoodBioMeat\",\"ItemZombieParts\",1,1,\"buy\",\"Zombie Parts\",\"Bio Meat\",101]','Doctor - Bash');
INSERT INTO `server_traders` VALUES(14,'Doctor',11,'friendly','[\"FoodBioMeat\",\"ItemZombieParts\",1,1,\"buy\",\"Zombie Parts\",\"Bio Meat\",101]','Doctor - Klen');
INSERT INTO `server_traders` VALUES(15,'RU_Functionary1',11,'friendly','','Hero Traders');
INSERT INTO `server_traders` VALUES(16,'RU_Villager3',11,'neutral','','Boat Trader');
INSERT INTO `server_traders` VALUES(17,'TK_CIV_Takistani04_EP1',11,'neutral','','High End Weapons');
INSERT INTO `server_traders` VALUES(18,'RU_Citizen4',11,'neutral','','Wholesaler - Solnichniy');
INSERT INTO `server_traders` VALUES(19,'RU_Citizen1',11,'neutral','','Wholesaler - Balota');
INSERT INTO `server_traders` VALUES(20,'Functionary1',1,'friendly','','Hero Traders');
INSERT INTO `server_traders` VALUES(21,'RU_Profiteer3',1,'neutral','','High End Weapons - Khush');
INSERT INTO `server_traders` VALUES(22,'Profiteer1',1,'neutral','','High End Ammo - Khush');
INSERT INTO `server_traders` VALUES(23,'RU_Sportswoman5',1,'friendly','[\"ItemTinBar\",\"TrashJackDaniels\",1,1,\"buy\",\"Empty Wiskey Bottle\",\"Tin Bar\",101]','Can Trader - Khush');
INSERT INTO `server_traders` VALUES(24,'TK_CIV_Takistani05_EP1',1,'friendly','','Parts Trader - Khush');
INSERT INTO `server_traders` VALUES(25,'Dr_Annie_Baker_EP1',1,'friendly','[\"FoodBioMeat\",\"ItemZombieParts\",1,1,\"buy\",\"Zombie Parts\",\"Bio Meat\",101]','Doctor - Khush');
INSERT INTO `server_traders` VALUES(26,'Woodlander2',1,'friendly','','Auto Trader - Khush');
INSERT INTO `server_traders` VALUES(27,'TK_CIV_Takistani03_EP1',1,'friendly','','Car Parts - Nur');
INSERT INTO `server_traders` VALUES(28,'TK_CIV_Takistani06_EP1',1,'friendly','','Weapons Trader - Nur');
INSERT INTO `server_traders` VALUES(29,'TK_CIV_Takistani04_EP1',1,'friendly','','Ammo Trader - Nur');
INSERT INTO `server_traders` VALUES(30,'TK_CIV_Woman03_EP1',1,'friendly','[\"ItemTinBar\",\"TrashJackDaniels\",1,1,\"buy\",\"Empty Wiskey Bottle\",\"Tin Bar\",101]','Can Trader - Nur');
INSERT INTO `server_traders` VALUES(31,'TK_CIV_Woman02_EP1',1,'friendly','[\"FoodBioMeat\",\"ItemZombieParts\",1,1,\"buy\",\"Zombie Parts\",\"Bio Meat\",101]','Doctor - Nur');
INSERT INTO `server_traders` VALUES(32,'RU_Profiteer2',1,'friendly','','Auto Trader - Garm');
INSERT INTO `server_traders` VALUES(33,'TK_CIV_Takistani02_EP1',1,'friendly','','Car Parts - Garm');
INSERT INTO `server_traders` VALUES(34,'RU_Damsel4',1,'friendly','[\"ItemTinBar\",\"TrashJackDaniels\",1,1,\"buy\",\"Empty Wiskey Bottle\",\"Tin Bar\",101]','Can Trader - Garm');
INSERT INTO `server_traders` VALUES(35,'RU_Woodlander3',1,'neutral','','Wholesaler - South');
INSERT INTO `server_traders` VALUES(36,'RU_Citizen4',1,'neutral','','Wholesaler - North');
INSERT INTO `server_traders` VALUES(37,'RU_Pilot',1,'neutral','','Airplane Dealer');
INSERT INTO `server_traders` VALUES(38,'RU_Worker1',6,'neutral','','Whiskey\'s Parts Shop');
INSERT INTO `server_traders` VALUES(39,'Dr_Annie_Baker_EP1',6,'friendly','[\"FoodBioMeat\",\"ItemZombieParts\",1,1,\"buy\",\"Zombie Parts\",\"Bio Meat\",101]','Melly\'s Medical');
INSERT INTO `server_traders` VALUES(40,'CIV_EuroWoman01_EP1',6,'friendly','','Alejandria\'s General Supplies');
INSERT INTO `server_traders` VALUES(41,'ibr_lingorman2s',6,'neutral','','Blivion\'s Wholesale Items');
INSERT INTO `server_traders` VALUES(42,'Worker2',6,'friendly','','Axle\'s Repair Shop');
INSERT INTO `server_traders` VALUES(43,'TK_CIV_Woman03_EP1',6,'friendly','[\"ItemTinBar\",\"TrashJackDaniels\",1,1,\"buy\",\"Empty Wiskey Bottle\",\"Tin Bar\",101]','Stella\'s General Goods');
INSERT INTO `server_traders` VALUES(44,'ibr_lingorman3s',6,'neutral','','Clive\'s Wholesale');
INSERT INTO `server_traders` VALUES(45,'ibr_lingorman5s',6,'neutral','','Big Bob\'s Boats');
INSERT INTO `server_traders` VALUES(46,'ibr_lingorman4s',6,'friendly','','Juan\'s Tour Boats');
INSERT INTO `server_traders` VALUES(47,'ibr_lingorman2',6,'friendly','','Jd\'z Armed Boats');
INSERT INTO `server_traders` VALUES(48,'Citizen2_EP1',6,'friendly','','Green\'s Quality Cars');
INSERT INTO `server_traders` VALUES(49,'Worker1',6,'friendly','','Lyle\'s Parts');
INSERT INTO `server_traders` VALUES(50,'RU_Madam3',6,'neutral','[\"ItemTinBar\",\"TrashJackDaniels\",1,1,\"buy\",\"Empty Wiskey Bottle\",\"Tin Bar\",101]','Bag Lady Gina');
INSERT INTO `server_traders` VALUES(51,'Pilot',6,'friendly','','Chip\'s Choppers');
INSERT INTO `server_traders` VALUES(52,'CIV_EuroMan02_EP1',6,'friendly','','Jim\'s Ammo');
INSERT INTO `server_traders` VALUES(53,'CIV_EuroMan01_EP1',6,'friendly','','Joe\'s Weapons');
INSERT INTO `server_traders` VALUES(54,'ibr_lingorman7s',6,'friendly','','Rodger\'s 4x4');
INSERT INTO `server_traders` VALUES(55,'Damsel3',6,'friendly','[\"ItemTinBar\",\"TrashJackDaniels\",1,1,\"buy\",\"Empty Wiskey Bottle\",\"Tin Bar\",101]','Tina\'s Tarts');
INSERT INTO `server_traders` VALUES(56,'Rocker4',6,'friendly','','Sly\'s Moto');
INSERT INTO `server_traders` VALUES(57,'Worker4',6,'neutral','','Jim\'s Used Cars');
INSERT INTO `server_traders` VALUES(58,'ibr_lingorman7',6,'neutral','','Chucks Weapons');
INSERT INTO `server_traders` VALUES(59,'ibr_lingorman5',6,'neutral','','Buck\'s Shot');
INSERT INTO `server_traders` VALUES(60,'Citizen3_EP1',6,'neutral','','Santo\'s Wholesale');
INSERT INTO `server_traders` VALUES(61,'ibr_lingorman6',6,'friendly','','Tire Guy');
INSERT INTO `server_traders` VALUES(62,'ibr_lingorman6s',6,'friendly','','Raul\'s Parts');
INSERT INTO `server_traders` VALUES(63,'TK_CIV_Woman02_EP1',6,'neutral','','Samish Shop');
INSERT INTO `server_traders` VALUES(64,'Pilot_EP1',6,'friendly','','AWOL\'s Planes');
INSERT INTO `server_traders` VALUES(65,'TK_CIV_Worker01_EP1',6,'friendly','','Rommelo\'s Raceway');
INSERT INTO `server_traders` VALUES(66,'RU_Doctor',6,'neutral','[\"FoodBioMeat\",\"ItemZombieParts\",1,1,\"buy\",\"Zombie Parts\",\"Bio Meat\",101]','Mad Scientist ');
INSERT INTO `server_traders` VALUES(67,'TK_CIV_Woman02_EP1',4,'neutral','','Farhah\'s General Supplies');
INSERT INTO `server_traders` VALUES(68,'TK_CIV_Takistani05_EP1',4,'neutral','','Akwhell\'s Vehicles');
INSERT INTO `server_traders` VALUES(69,'TK_CIV_Takistani03_EP1',4,'neutral','','Amjad\'s Ammunition');
INSERT INTO `server_traders` VALUES(70,'TK_CIV_Takistani02_EP1',4,'neutral','','Hassan\'s Weapons');
INSERT INTO `server_traders` VALUES(71,'CIV_EuroMan01_EP1',4,'friendly','','Dan\'s Parts');
INSERT INTO `server_traders` VALUES(72,'CIV_EuroMan02_EP1',4,'friendly','','Darren\'s Auto');
INSERT INTO `server_traders` VALUES(73,'Dr_Hladik_EP1',4,'friendly','[\"FoodBioMeat\",\"ItemZombieParts\",1,1,\"buy\",\"Zombie Parts\",\"Bio Meat\",101]','Dr. House');
INSERT INTO `server_traders` VALUES(74,'CIV_EuroWoman01_EP1',4,'friendly','','Heather\'s General Supplies');
INSERT INTO `server_traders` VALUES(76,'Worker1',4,'friendly','','Greg\'s Ammunition');
INSERT INTO `server_traders` VALUES(77,'Tanny_PMC',4,'friendly','','Joe\'s Weapons');
INSERT INTO `server_traders` VALUES(78,'Profiteer4',4,'friendly','','Steven\'s Hero Shop');
INSERT INTO `server_traders` VALUES(79,'GUE_Worker2',13,'friendly','','Pete\'s Armed Choppers');
INSERT INTO `server_traders` VALUES(80,'Soldier_Sniper_KSVK_PMC',13,'friendly','','Jacks Weapons');
INSERT INTO `server_traders` VALUES(81,'Soldier_GL_PMC',13,'friendly','','Robby\'s Ammo Dump');
INSERT INTO `server_traders` VALUES(82,'GUE_Soldier_Pilot',13,'friendly','','Hanz Unarmed Choppers');
INSERT INTO `server_traders` VALUES(83,'GUE_Woodlander3',13,'friendly','','Scott\'s Repair Shop');
INSERT INTO `server_traders` VALUES(84,'Worker4',13,'neutral','','Capt. Yak');
INSERT INTO `server_traders` VALUES(85,'Reynolds_PMC',13,'neutral','','Wholesaler Reynolds');
INSERT INTO `server_traders` VALUES(86,'Soldier_Sniper_PMC',13,'friendly','','Chucks Hero Shop');
INSERT INTO `server_traders` VALUES(87,'GUE_Soldier_3',13,'friendly','','Tom\'s Armed Vehicles');
INSERT INTO `server_traders` VALUES(88,'RU_Doctor',13,'friendly','','Dr. Hammond');
INSERT INTO `server_traders` VALUES(89,'Doctor',13,'friendly','','Bones');
INSERT INTO `server_traders` VALUES(90,'UN_CDF_Soldier_Pilot_EP1',13,'friendly','','Murdock\'s Planes');
INSERT INTO `server_traders` VALUES(91,'RU_Worker4',13,'neutral','','Sven\'s Parts');
INSERT INTO `server_traders` VALUES(92,'RU_Woodlander4',13,'neutral','','Slav\'s Vehicles');
INSERT INTO `server_traders` VALUES(93,'Citizen3',13,'neutral','','Trin\'s General Supplies');
INSERT INTO `server_traders` VALUES(94,'RU_Damsel5',13,'friendly','[\"FoodBioMeat\",\"ItemZombieParts\",1,1,\"buy\",\"Zombie Parts\",\"Bio Meat\",101]','Melissa\'s General Supplies');
INSERT INTO `server_traders` VALUES(95,'Dr_Hladik_EP1',13,'neutral','[\"FoodBioMeat\",\"ItemZombieParts\",1,1,\"buy\",\"Zombie Parts\",\"Bio Meat\",101]','Dr. Vu');
INSERT INTO `server_traders` VALUES(96,'GUE_Commander',13,'neutral','','Gabriel\'s Weapons');
INSERT INTO `server_traders` VALUES(97,'GUE_Soldier_CO',13,'neutral','','Cohaagen\'s Ammunition');
INSERT INTO `server_traders` VALUES(98,'Profiteer2_EP1',13,'neutral','','Chad\'s Armed Boats');
INSERT INTO `server_traders` VALUES(99,'RU_Farmwife5',13,'neutral','','Mrs. Doubtfire');
INSERT INTO `server_traders` VALUES(100,'GUE_Woodlander1',13,'neutral','','Dante\'s Bandit Choppers');
INSERT INTO `server_traders` VALUES(101,'RU_Worker1',13,'neutral','','Javon\'s Parts');
INSERT INTO `server_traders` VALUES(102,'GUE_Soldier_2',13,'neutral','','Wholesaler Darren');
INSERT INTO `server_traders` VALUES(103,'Worker2',11,'neutral','','Airplane Dealer');
INSERT INTO `server_traders` VALUES(104,'GUE_Villager4',15,'friendly','','Bastions Parts Supplies');
INSERT INTO `server_traders` VALUES(105,'RU_Farmwife4',15,'friendly','[\"ItemTinBar\",\"TrashJackDaniels\",1,1,\"buy\",\"Empty Wiskey Bottle\",\"Tin Bar\",101]','Alda\'s General Supplies');
INSERT INTO `server_traders` VALUES(106,'RU_Farmwife3',15,'neutral','[\"ItemTinBar\",\"TrashJackDaniels\",1,1,\"buy\",\"Empty Wiskey Bottle\",\"Tin Bar\",101]','Carole\'s General Supplies');
INSERT INTO `server_traders` VALUES(107,'Dr_Hladik_EP1',15,'friendly','[\"FoodBioMeat\",\"ItemZombieParts\",1,1,\"buy\",\"Zombie Parts\",\"Bio Meat\",101]','Dr. Zoidberg');
INSERT INTO `server_traders` VALUES(108,'CIV_Contractor2_BAF',15,'friendly','','High End Ammo');
INSERT INTO `server_traders` VALUES(109,'Soldier_Sniper_PMC',15,'friendly','','High End Weapons');
INSERT INTO `server_traders` VALUES(110,'GUE_Soldier_Pilot',15,'friendly','','Rutahn\'s Vehicles.');
INSERT INTO `server_traders` VALUES(111,'GUE_Soldier_2',15,'neutral','','Rhven\'s Weapons');
INSERT INTO `server_traders` VALUES(112,'GUE_Soldier_1',15,'neutral','','Merkaba\'s Ammo');
INSERT INTO `server_traders` VALUES(113,'GUE_Soldier_CO',15,'neutral','','Robsyah\'s Choppers');
INSERT INTO `server_traders` VALUES(114,'GUE_Woodlander2',15,'friendly','','Popeye\'s Boats ');
INSERT INTO `server_traders` VALUES(115,'GUE_Soldier_Crew',15,'neutral','','Aaron\'s Vehicles');
INSERT INTO `server_traders` VALUES(116,'Woodlander2',15,'neutral','','Staven\'s Repair Shop');
INSERT INTO `server_traders` VALUES(117,'UN_CDF_Soldier_MG_EP1',15,'friendly','','Larz\'s Wholesale');
INSERT INTO `server_traders` VALUES(118,'UN_CDF_Soldier_EP1',15,'friendly','','Dateu\'s Wholesale');
INSERT INTO `server_traders` VALUES(119,'Tanny_PMC',15,'hero','','Tanner\'s Hero Supplies');
INSERT INTO `server_traders` VALUES(120,'UN_CDF_Soldier_Pilot_EP1',15,'friendly','','Piloted Vehicles');
INSERT INTO `server_traders` VALUES(121,'GUE_Soldier_Pilot',16,'friendly','','AWOL\'s Airfield');
INSERT INTO `server_traders` VALUES(122,'UN_CDF_Soldier_MG_EP1',16,'neutral','','West\'s Wholesaler');
INSERT INTO `server_traders` VALUES(123,'GUE_Soldier_Medic',16,'neutral','[\"FoodBioMeat\",\"ItemZombieParts\",1,1,\"buy\",\"Zombie Parts\",\"Bio Meat\",101]','Neutral Medic');
INSERT INTO `server_traders` VALUES(124,'GUE_Woodlander1',16,'neutral','','Stavz Ammo');
INSERT INTO `server_traders` VALUES(125,'GUE_Commander',16,'neutral','','Stevhn\'s Weapons');
INSERT INTO `server_traders` VALUES(126,'Tanny_PMC',16,'hero','','Trevors Hero Supplies.');
INSERT INTO `server_traders` VALUES(127,'BAF_Soldier_AMG_W',16,'friendly','','Roberts Ammo');
INSERT INTO `server_traders` VALUES(128,'BAF_Soldier_AAA_DDPM',16,'friendly','','Drakes Weapons');
INSERT INTO `server_traders` VALUES(129,'GUE_Soldier_3',16,'neutral','','Brians Vehicles');
INSERT INTO `server_traders` VALUES(130,'GUE_Soldier_1',16,'neutral','','Sam\'s Boats');
INSERT INTO `server_traders` VALUES(131,'BAF_Pilot_MTP',16,'hero','','Darren\'s Hero Vehicles');
INSERT INTO `server_traders` VALUES(132,'GUE_Soldier_Sab',16,'neutral','','Green\'s Air Vehicles');
INSERT INTO `server_traders` VALUES(133,'US_Soldier_Medic_EP1',16,'friendly','[\"FoodBioMeat\",\"ItemZombieParts\",1,1,\"buy\",\"Zombie Parts\",\"Bio Meat\",101]','Perry\'s Medical');
INSERT INTO `server_traders` VALUES(134,'CZ_Special_Forces_MG_DES_EP1',16,'friendly','','Kypex\'s Vehicles');
INSERT INTO `server_traders` VALUES(135,'Damsel5',16,'friendly','[\"ItemTinBar\",\"TrashJackDaniels\",1,1,\"buy\",\"Empty Wiskey Bottle\",\"Tin Bar\",101]','Melly\'s General Supplies');
INSERT INTO `server_traders` VALUES(136,'GUE_Woodlander3',16,'friendly','','Jim\'s Repair/Building Supplies');
INSERT INTO `server_traders` VALUES(137,'UN_CDF_Soldier_AAT_EP1',16,'neutral','','South West Wholesaler');
INSERT INTO `server_traders` VALUES(138,'RU_Farmwife1',16,'neutral','[\"ItemTinBar\",\"TrashJackDaniels\",1,1,\"buy\",\"Empty Wiskey Bottle\",\"Tin Bar\",101]','Bertha\'s General Supplies');
INSERT INTO `server_traders` VALUES(139,'Citizen2_EP1',16,'neutral','','Rocky\'s Parts/Building Supplies');
INSERT INTO `server_traders` VALUES(140,'CIV_Contractor1_BAF',6,'neutral','','Jeeves');
INSERT INTO `server_traders` VALUES(141,'GUE_Soldier_MG',11,'neutral','','Black Market - Olsha');
INSERT INTO `server_traders` VALUES(142,'TK_GUE_Soldier_Sniper_EP1',1,'neutral','','Apu Nahasapeemapetilon Black Market');
INSERT INTO `server_traders` VALUES(143,'Tanny_PMC',17,'hero','','Hero Vendor');
INSERT INTO `server_traders` VALUES(144,'US_Delta_Force_AR_EP1',17,'friendly','','Ammunition Friendly');
INSERT INTO `server_traders` VALUES(145,'BAF_Soldier_AAR_DDPM',17,'friendly','','Weapons Friendly');
INSERT INTO `server_traders` VALUES(146,'Drake',17,'friendly','','Friendly Vehicles');
INSERT INTO `server_traders` VALUES(147,'Damsel2',17,'neutral','[\"ItemTinBar\",\"TrashJackDaniels\",1,1,\"buy\",\"Empty Wiskey Bottle\",\"Tin Bar\",101]','General Store');
INSERT INTO `server_traders` VALUES(148,'GUE_Soldier_MG',17,'neutral','','Weapons neutral');
INSERT INTO `server_traders` VALUES(149,'GUE_Soldier_GL',17,'neutral','','Ammunition Neutral');
INSERT INTO `server_traders` VALUES(150,'TK_GUE_Soldier_5_EP1',17,'neutral','','Neutral Building/Parts');
INSERT INTO `server_traders` VALUES(151,'GUE_Soldier_2',17,'hostile','','Bandit Trader');
INSERT INTO `server_traders` VALUES(152,'Soldier_Sniper_PMC',17,'neutral','','Aircraft Dealer');
INSERT INTO `server_traders` VALUES(153,'GUE_Soldier_3',17,'neutral','','Vehicles Neutral');
INSERT INTO `server_traders` VALUES(154,'Soldier_GL_M16A2_PMC',17,'neutral','','Black Market Vendor');
INSERT INTO `server_traders` VALUES(155,'UN_CDF_Soldier_Crew_EP1',17,'friendly','','Friendly Building/Parts');
INSERT INTO `server_traders` VALUES(156,'UN_CDF_Soldier_Pilot_EP1',17,'friendly','','Friendly Vehicles 2');
INSERT INTO `server_traders` VALUES(157,'GUE_Worker2',17,'friendly','[\"ItemTinBar\",\"TrashJackDaniels\",1,1,\"buy\",\"Empty Wiskey Bottle\",\"Tin Bar\",101]','General Store 2');
INSERT INTO `server_traders` VALUES(158,'Dr_Annie_Baker_EP1',17,'friendly','[\"FoodBioMeat\",\"ItemZombieParts\",1,1,\"buy\",\"Zombie Parts\",\"Bio Meat\",101]','Medical Supplies');
INSERT INTO `server_traders` VALUES(159,'Soldier_MG_PKM_PMC',17,'friendly','','Weapons friendly 2');
INSERT INTO `server_traders` VALUES(160,'Soldier_MG_PMC',17,'friendly','','Ammunition friendly 2');
INSERT INTO `server_traders` VALUES(161,'GUE_Soldier_CO',17,'neutral','','East Wholesaler');
INSERT INTO `server_traders` VALUES(162,'Farmwife4',17,'neutral','[\"ItemTinBar\",\"TrashJackDaniels\",1,1,\"buy\",\"Empty Wiskey Bottle\",\"Tin Bar\",101]','General Store 3');
INSERT INTO `server_traders` VALUES(163,'FR_Sykes',17,'neutral','','West Wholesaler');
INSERT INTO `server_traders` VALUES(164,'GUE_Villager4',17,'neutral','','Boat Vendor');
INSERT INTO `server_traders` VALUES(165,'TK_CIV_Takistani04_EP1',17,'neutral','','Weapons neutral 2');
INSERT INTO `server_traders` VALUES(166,'Pilot_EP1',17,'neutral','','Ammunition Neutral 2');
INSERT INTO `server_traders` VALUES(167,'RU_Profiteer4',17,'neutral','','Vehicles Neutral 2');
INSERT INTO `server_traders` VALUES(168,'Woodlander3',17,'neutral','','Neutral Building/Parts');
INSERT INTO `server_traders` VALUES(169,'Dr_Hladik_EP1',17,'neutral','[\"FoodBioMeat\",\"ItemZombieParts\",1,1,\"buy\",\"Zombie Parts\",\"Bio Meat\",101]','Medical Supplies 2');
INSERT INTO `server_traders` VALUES(170,'Doctor',17,'neutral','[\"FoodBioMeat\",\"ItemZombieParts\",1,1,\"buy\",\"Zombie Parts\",\"Bio Meat\",101]','Medical Supplies 3');
INSERT INTO `server_traders` VALUES(171,'HouseWife1',17,'neutral','','Boat Trader 2');
INSERT INTO `server_traders` VALUES(172,'Citizen3_EP1',17,'neutral','','Wholesale 3');
INSERT INTO `server_traders` VALUES(173,'ibr_lingorman6',17,'friendly','','Friendly Building/parts 2');
INSERT INTO `server_traders` VALUES(174,'ibr_lingorman6s',17,'friendly','','Friendly Building/Parts 3');
INSERT INTO `server_traders` VALUES(175,'TK_CIV_Woman02_EP1',17,'neutral','','General Store 4');
INSERT INTO `server_traders` VALUES(176,'Damsel3',17,'friendly','','General Store 5');
INSERT INTO `server_traders` VALUES(177,'INS_Worker2_DZ',11,'hero','','Construction Materials - Hero');
INSERT INTO `server_traders` VALUES(178,'INS_Lopotev_DZ',17,'hostile','','Construction Materials - Bandit');
INSERT INTO `server_traders` VALUES(179,'INS_Soldier_CO_DZ',11,'superhero','','Superhero Trader');
INSERT INTO `server_traders` VALUES(180,'GUE_Woodlander1',17,'superhostile','','Supervillain Trader');

-- ----------------------------------
-- Table structure for table `traders_data`
-- ----------------------------------

CREATE TABLE `traders_data` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `item` varchar(255) NOT NULL COMMENT '[Class Name,1 = CfgMagazines | 2 = Vehicle | 3 = Weapon]',
  `qty` int(8) NOT NULL COMMENT 'amount in stock available to buy',
  `buy` varchar(255) NOT NULL COMMENT '[[Qty,Class,Type],]',
  `sell` varchar(255) NOT NULL COMMENT '[[Qty,Class,Type],]',
  `order` int(2) NOT NULL DEFAULT '0' COMMENT '# sort order for addAction menu',
  `tid` int(8) NOT NULL COMMENT 'Trader Menu ID',
  `afile` varchar(64) NOT NULL DEFAULT 'trade_items',
  PRIMARY KEY (`id`),
  UNIQUE KEY `item` (`item`,`tid`)
) ENGINE=InnoDB AUTO_INCREMENT=7919 DEFAULT CHARSET=latin1;

-- ----------------------------------
-- Dumping data for table `traders_data`
-- ----------------------------------

INSERT INTO `traders_data` VALUES (4996,'[\"Skin_CZ_Special_Forces_GL_DES_EP1_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,476,'trade_items');
INSERT INTO `traders_data` VALUES(4999,'[\"Skin_Drake_Light_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,476,'trade_items');
INSERT INTO `traders_data` VALUES(5002,'[\"Skin_Soldier_Sniper_PMC_DZ\",1]',42,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,476,'trade_items');
INSERT INTO `traders_data` VALUES(5003,'[\"Skin_FR_OHara_DZ\",1]',21,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,476,'trade_items');
INSERT INTO `traders_data` VALUES(5004,'[\"Skin_FR_Rodriguez_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,476,'trade_items');
INSERT INTO `traders_data` VALUES(5005,'[\"Skin_CZ_Soldier_Sniper_EP1_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,476,'trade_items');
INSERT INTO `traders_data` VALUES(5006,'[\"Skin_Graves_Light_DZ\",1]',21,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,476,'trade_items');
INSERT INTO `traders_data` VALUES(5007,'[\"G36_C_SD_camo\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,477,'trade_weapons');
INSERT INTO `traders_data` VALUES(5008,'[\"M4A1_AIM_SD_camo\",3]',52,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,477,'trade_weapons');
INSERT INTO `traders_data` VALUES(5012,'[\"FN_FAL_ANPVS4\",3]',39,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,477,'trade_weapons');
INSERT INTO `traders_data` VALUES(5016,'[\"30Rnd_556x45_StanagSD\",1]',27,'[4,\"ItemSilverBar10oz\",1]','[2,\"ItemSilverBar10oz\",1]',0,478,'trade_items');
INSERT INTO `traders_data` VALUES(5019,'[\"ArmoredSUV_PMC_DZE\",2]',10,'[2,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,479,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5020,'[\"Pickup_PK_TK_GUE_EP1_DZE\",2]',22,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,479,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5022,'[\"Offroad_DSHKM_Gue_DZE\",2]',29,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,479,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5026,'[\"30Rnd_556x45_Stanag\",1]',82,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,480,'trade_items');
INSERT INTO `traders_data` VALUES(5027,'[\"20Rnd_762x51_FNFAL\",1]',29,'[4,\"ItemSilverBar10oz\",1]','[2,\"ItemSilverBar10oz\",1]',0,480,'trade_items');
INSERT INTO `traders_data` VALUES(5028,'[\"100Rnd_762x51_M240\",1]',71,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,481,'trade_items');
INSERT INTO `traders_data` VALUES(5029,'[\"200Rnd_556x45_M249\",1]',50,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,481,'trade_items');
INSERT INTO `traders_data` VALUES(5030,'[\"100Rnd_762x54_PK\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,481,'trade_items');
INSERT INTO `traders_data` VALUES(5031,'[\"20Rnd_762x51_DMR\",1]',43,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,482,'trade_items');
INSERT INTO `traders_data` VALUES(5032,'[\"10Rnd_762x54_SVD\",1]',60,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,482,'trade_items');
INSERT INTO `traders_data` VALUES(5036,'[\"30rnd_9x19_MP5\",1]',29,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,483,'trade_items');
INSERT INTO `traders_data` VALUES(5037,'[\"30Rnd_9x19_MP5SD\",1]',21,'[4,\"ItemSilverBar10oz\",1]','[2,\"ItemSilverBar10oz\",1]',0,483,'trade_items');
INSERT INTO `traders_data` VALUES(5038,'[\"30Rnd_9x19_UZI\",1]',22,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,483,'trade_items');
INSERT INTO `traders_data` VALUES(5039,'[\"64Rnd_9x19_SD_Bizon\",1]',23,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,483,'trade_items');
INSERT INTO `traders_data` VALUES(5040,'[\"30Rnd_9x19_UZI_SD\",1]',41,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,483,'trade_items');
INSERT INTO `traders_data` VALUES(5041,'[\"20Rnd_B_765x17_Ball\",1]',26,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,483,'trade_items');
INSERT INTO `traders_data` VALUES(5042,'[\"15Rnd_9x19_M9\",1]',23,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,484,'trade_items');
INSERT INTO `traders_data` VALUES(5043,'[\"15Rnd_9x19_M9SD\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,484,'trade_items');
INSERT INTO `traders_data` VALUES(5044,'[\"17Rnd_9x19_glock17\",1]',25,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,484,'trade_items');
INSERT INTO `traders_data` VALUES(5045,'[\"6Rnd_45ACP\",1]',35,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,484,'trade_items');
INSERT INTO `traders_data` VALUES(5046,'[\"7Rnd_45ACP_1911\",1]',24,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,484,'trade_items');
INSERT INTO `traders_data` VALUES(5047,'[\"8Rnd_9x18_Makarov\",1]',50,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,484,'trade_items');
INSERT INTO `traders_data` VALUES(5048,'[\"8Rnd_9x18_MakarovSD\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,484,'trade_items');
INSERT INTO `traders_data` VALUES(5049,'[\"G36A_camo\",3]',29,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,485,'trade_weapons');
INSERT INTO `traders_data` VALUES(5050,'[\"G36C\",3]',20,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,485,'trade_weapons');
INSERT INTO `traders_data` VALUES(5051,'[\"G36C_camo\",3]',20,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,485,'trade_weapons');
INSERT INTO `traders_data` VALUES(5052,'[\"G36K_camo\",3]',22,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,485,'trade_weapons');
INSERT INTO `traders_data` VALUES(5054,'[\"M16A2\",3]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,485,'trade_weapons');
INSERT INTO `traders_data` VALUES(5055,'[\"M16A2GL\",3]',20,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,485,'trade_weapons');
INSERT INTO `traders_data` VALUES(5056,'[\"M16A4_ACG\",3]',27,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,485,'trade_weapons');
INSERT INTO `traders_data` VALUES(5057,'[\"M4A1\",3]',21,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,485,'trade_weapons');
INSERT INTO `traders_data` VALUES(5059,'[\"M4A1_HWS_GL_camo\",3]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,485,'trade_weapons');
INSERT INTO `traders_data` VALUES(5060,'[\"M4A3_CCO_EP1\",3]',30,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,485,'trade_weapons');
INSERT INTO `traders_data` VALUES(5061,'[\"M4A1_Aim\",3]',20,'[6,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,485,'trade_weapons');
INSERT INTO `traders_data` VALUES(5063,'[\"M249_EP1_DZ\",3]',22,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,486,'trade_weapons');
INSERT INTO `traders_data` VALUES(5064,'[\"M240_DZ\",3]',26,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,486,'trade_weapons');
INSERT INTO `traders_data` VALUES(5065,'[\"Mk_48_DZ\",3]',30,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,486,'trade_weapons');
INSERT INTO `traders_data` VALUES(5066,'[\"Pecheneg_DZ\",3]',22,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,486,'trade_weapons');
INSERT INTO `traders_data` VALUES(5067,'[\"SVD_CAMO\",3]',44,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,487,'trade_weapons');
INSERT INTO `traders_data` VALUES(5069,'[\"M40A3\",3]',33,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,487,'trade_weapons');
INSERT INTO `traders_data` VALUES(5070,'[\"M14_EP1\",3]',31,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,487,'trade_weapons');
INSERT INTO `traders_data` VALUES(5072,'[\"bizon_silenced\",3]',21,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,488,'trade_weapons');
INSERT INTO `traders_data` VALUES(5073,'[\"UZI_EP1\",3]',22,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,488,'trade_weapons');
INSERT INTO `traders_data` VALUES(5074,'[\"Sa61_EP1\",3]',20,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,488,'trade_weapons');
INSERT INTO `traders_data` VALUES(5075,'[\"MP5A5\",3]',21,'[1,\"ItemGoldBar\",1]','[2,\"ItemSilverBar10oz\",1]',0,488,'trade_weapons');
INSERT INTO `traders_data` VALUES(5076,'[\"UZI_SD_EP1\",3]',23,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,488,'trade_weapons');
INSERT INTO `traders_data` VALUES(5077,'[\"MP5SD\",3]',20,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,488,'trade_weapons');
INSERT INTO `traders_data` VALUES(5078,'[\"M9SD\",3]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,489,'trade_weapons');
INSERT INTO `traders_data` VALUES(5079,'[\"glock17_EP1\",3]',21,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,489,'trade_weapons');
INSERT INTO `traders_data` VALUES(5080,'[\"Colt1911\",3]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,489,'trade_weapons');
INSERT INTO `traders_data` VALUES(5081,'[\"M9\",3]',20,'[1,\"ItemGoldBar\",1]','[2,\"ItemSilverBar10oz\",1]',0,489,'trade_weapons');
INSERT INTO `traders_data` VALUES(5082,'[\"MakarovSD\",3]',24,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,489,'trade_weapons');
INSERT INTO `traders_data` VALUES(5083,'[\"revolver_gold_EP1\",3]',20,'[3,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,489,'trade_weapons');
INSERT INTO `traders_data` VALUES(5088,'[\"HMMWV_M1035_DES_EP1\",2]',13,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,491,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5089,'[\"HMMWV_Ambulance\",2]',11,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,491,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5090,'[\"HMMWV_Ambulance_CZ_DES_EP1\",2]',12,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,491,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5091,'[\"HMMWV_DES_EP1\",2]',14,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,491,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5092,'[\"GAZ_Vodnik_MedEvac\",2]',11,'[1,\"ItemBriefcase100oz\",1]','[5,\"ItemGoldBar10oz\",1]',0,491,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5093,'[\"KamazRefuel_DZ\",2]',13,'[7,\"ItemGoldBar10oz\",1]','[3,\"ItemGoldBar10oz\",1]',0,492,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5094,'[\"MtvrRefuel_DES_EP1_DZ\",2]',16,'[7,\"ItemGoldBar10oz\",1]','[3,\"ItemGoldBar10oz\",1]',0,492,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5095,'[\"UralRefuel_TK_EP1_DZ\",2]',13,'[7,\"ItemGoldBar10oz\",1]','[3,\"ItemGoldBar10oz\",1]',0,492,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5096,'[\"V3S_Refuel_TK_GUE_EP1_DZ\",2]',13,'[7,\"ItemGoldBar10oz\",1]','[3,\"ItemGoldBar10oz\",1]',0,492,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5097,'[\"CH_47F_EP1_DZE\",2]',60,'[5,\"ItemBriefcase100oz\",1]','[2,\"ItemBriefcase100oz\",1]',0,493,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5098,'[\"UH1H_DZE\",2]',28,'[2,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,493,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5099,'[\"Mi17_DZE\",2]',25,'[2,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,493,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5100,'[\"UH60M_EP1_DZE\",2]',24,'[2,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,493,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5101,'[\"UH1Y_DZE\",2]',22,'[2,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,493,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5116,'[\"DZ_Patrol_Pack_EP1\",2]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,496,'trade_backpacks');
INSERT INTO `traders_data` VALUES(5117,'[\"CZ_VestPouch_EP1\",2]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,496,'trade_backpacks');
INSERT INTO `traders_data` VALUES(5118,'[\"DZ_ALICE_Pack_EP1\",2]',21,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,496,'trade_backpacks');
INSERT INTO `traders_data` VALUES(5119,'[\"DZ_Assault_Pack_EP1\",2]',23,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,496,'trade_backpacks');
INSERT INTO `traders_data` VALUES(5120,'[\"DZ_Backpack_EP1\",2]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,496,'trade_backpacks');
INSERT INTO `traders_data` VALUES(5121,'[\"DZ_British_ACU\",2]',22,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,496,'trade_backpacks');
INSERT INTO `traders_data` VALUES(5122,'[\"DZ_CivilBackpack_EP1\",2]',20,'[6,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,496,'trade_backpacks');
INSERT INTO `traders_data` VALUES(5123,'[\"DZ_Czech_Vest_Puch\",2]',21,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,496,'trade_backpacks');
INSERT INTO `traders_data` VALUES(5124,'[\"DZ_TK_Assault_Pack_EP1\",2]',23,'[6,\"ItemSilverBar10oz\",1]','[3,\"ItemSilverBar10oz\",1]',0,496,'trade_backpacks');
INSERT INTO `traders_data` VALUES(5125,'[\"DZ_TerminalPack_EP1\",2]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,496,'trade_backpacks');
INSERT INTO `traders_data` VALUES(5126,'[\"DZ_GunBag_EP1\",2]',22,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,496,'trade_backpacks');
INSERT INTO `traders_data` VALUES(5127,'[\"Skin_Rocker2_DZ\",1]',28,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,497,'trade_items');
INSERT INTO `traders_data` VALUES(5128,'[\"Skin_SurvivorW2_DZ\",1]',22,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,497,'trade_items');
INSERT INTO `traders_data` VALUES(5129,'[\"Skin_Functionary1_EP1_DZ\",1]',28,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,497,'trade_items');
INSERT INTO `traders_data` VALUES(5131,'[\"Skin_Haris_Press_EP1_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,497,'trade_items');
INSERT INTO `traders_data` VALUES(5132,'[\"Skin_Priest_DZ\",1]',23,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,497,'trade_items');
INSERT INTO `traders_data` VALUES(5135,'[\"Skin_SurvivorWpink_DZ\",1]',29,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,497,'trade_items');
INSERT INTO `traders_data` VALUES(5136,'[\"Skin_SurvivorWurban_DZ\",1]',27,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,497,'trade_items');
INSERT INTO `traders_data` VALUES(5137,'[\"Skin_SurvivorWcombat_DZ\",1]',25,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,497,'trade_items');
INSERT INTO `traders_data` VALUES(5138,'[\"Skin_SurvivorWdesert_DZ\",1]',22,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,497,'trade_items');
INSERT INTO `traders_data` VALUES(5139,'[\"Skin_Survivor2_DZ\",1]',67,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,497,'trade_items');
INSERT INTO `traders_data` VALUES(5145,'[\"ItemSodaCoke\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,498,'trade_items');
INSERT INTO `traders_data` VALUES(5146,'[\"ItemSodaPepsi\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,498,'trade_items');
INSERT INTO `traders_data` VALUES(5150,'[\"ItemSodaMdew\",1]',110,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,498,'trade_items');
INSERT INTO `traders_data` VALUES(5155,'[\"ItemSodaR4z0r\",1]',20,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,498,'trade_items');
INSERT INTO `traders_data` VALUES(5156,'[\"ItemWaterbottleUnfilled\",1]',21,'[3,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,498,'trade_items');
INSERT INTO `traders_data` VALUES(5201,'[\"ItemSandbag\",1]',25,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,508,'trade_items');
INSERT INTO `traders_data` VALUES(5202,'[\"ItemTankTrap\",1]',21,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,508,'trade_items');
INSERT INTO `traders_data` VALUES(5203,'[\"ItemTentOld\",1]',20,'[4,\"ItemSilverBar10oz\",1]','[2,\"ItemSilverBar10oz\",1]',0,508,'trade_items');
INSERT INTO `traders_data` VALUES(5205,'[\"ItemWire\",1]',26,'[6,\"ItemSilverBar\",1]','[3,\"ItemSilverBar\",1]',0,508,'trade_items');
INSERT INTO `traders_data` VALUES(5206,'[\"30m_plot_kit\",1]',21,'[6,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar10oz\",1]',0,508,'trade_items');
INSERT INTO `traders_data` VALUES(5207,'[\"ItemCorrugated\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,508,'trade_items');
INSERT INTO `traders_data` VALUES(5208,'[\"ItemPole\",1]',20,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,508,'trade_items');
INSERT INTO `traders_data` VALUES(5210,'[\"ItemJerrycan\",1]',32,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,509,'trade_items');
INSERT INTO `traders_data` VALUES(5211,'[\"ItemJerrycanEmpty\",1]',22,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,509,'trade_items');
INSERT INTO `traders_data` VALUES(5212,'[\"PartEngine\",1]',21,'[5,\"ItemGoldBar\",1]','[1,\"ItemSilverBar10oz\",1]',0,509,'trade_items');
INSERT INTO `traders_data` VALUES(5213,'[\"PartVRotor\",1]',29,'[5,\"ItemGoldBar\",1]','[1,\"ItemSilverBar10oz\",1]',0,509,'trade_items');
INSERT INTO `traders_data` VALUES(5214,'[\"PartWheel\",1]',21,'[2,\"ItemGoldBar\",1]','[2,\"ItemSilverBar\",1]',0,509,'trade_items');
INSERT INTO `traders_data` VALUES(5215,'[\"PartGlass\",1]',22,'[1,\"ItemGoldBar\",1]','[1,\"ItemSilverBar\",1]',0,509,'trade_items');
INSERT INTO `traders_data` VALUES(5216,'[\"PartGeneric\",1]',20,'[2,\"ItemGoldBar\",1]','[6,\"ItemSilverBar\",1]',0,509,'trade_items');
INSERT INTO `traders_data` VALUES(5217,'[\"ItemCompass\",3]',20,'[6,\"ItemSilverBar\",1]','[3,\"ItemSilverBar\",1]',0,510,'trade_weapons');
INSERT INTO `traders_data` VALUES(5218,'[\"Binocular\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,510,'trade_weapons');
INSERT INTO `traders_data` VALUES(5219,'[\"Binocular_Vector\",3]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,510,'trade_weapons');
INSERT INTO `traders_data` VALUES(5220,'[\"ItemEtool\",3]',20,'[9,\"ItemSilverBar10oz\",1]','[6,\"ItemSilverBar10oz\",1]',0,510,'trade_weapons');
INSERT INTO `traders_data` VALUES(5221,'[\"ItemFlashlight\",3]',22,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,510,'trade_weapons');
INSERT INTO `traders_data` VALUES(5222,'[\"ItemFlashlightRed\",3]',20,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,510,'trade_weapons');
INSERT INTO `traders_data` VALUES(5223,'[\"ItemGPS\",3]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,510,'trade_weapons');
INSERT INTO `traders_data` VALUES(5224,'[\"ItemHatchet_DZE\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,510,'trade_weapons');
INSERT INTO `traders_data` VALUES(5225,'[\"ItemKnife\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,510,'trade_weapons');
INSERT INTO `traders_data` VALUES(5226,'[\"ItemMap\",3]',20,'[6,\"ItemSilverBar\",1]','[3,\"ItemSilverBar\",1]',0,510,'trade_weapons');
INSERT INTO `traders_data` VALUES(5227,'[\"ItemMatchbox_DZE\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,510,'trade_weapons');
INSERT INTO `traders_data` VALUES(5228,'[\"ItemToolbox\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,510,'trade_weapons');
INSERT INTO `traders_data` VALUES(5229,'[\"ItemWatch\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,510,'trade_weapons');
INSERT INTO `traders_data` VALUES(5230,'[\"NVGoggles\",3]',20,'[4,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,510,'trade_weapons');
INSERT INTO `traders_data` VALUES(5264,'[\"AN2_DZ\",2]',10,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,517,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5265,'[\"C130J_US_EP1_DZ\",2]',10,'[4,\"ItemBriefcase100oz\",1]','[2,\"ItemBriefcase100oz\",1]',0,517,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5266,'[\"MV22_DZ\",2]',242,'[5,\"ItemBriefcase100oz\",1]','[2,\"ItemBriefcase100oz\",1]',0,517,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5272,'[\"Mi17_Civilian_DZ\",2]',31,'[2,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,519,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5273,'[\"AH6X_DZ\",2]',11,'[6,\"ItemGoldBar10oz\",1]','[3,\"ItemGoldBar10oz\",1]',0,519,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5274,'[\"MH6J_DZ\",2]',11,'[8,\"ItemGoldBar10oz\",1]','[4,\"ItemGoldBar10oz\",1]',0,519,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5275,'[\"CSJ_GyroC\",2]',10,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,519,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5276,'[\"CSJ_GyroCover\",2]',10,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,519,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5277,'[\"CSJ_GyroP\",2]',16,'[5,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,519,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5278,'[\"Skoda\",2]',21,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,520,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5279,'[\"SkodaBlue\",2]',26,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,520,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5280,'[\"SkodaGreen\",2]',25,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,520,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5281,'[\"SkodaRed\",2]',12,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,520,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5282,'[\"VolhaLimo_TK_CIV_EP1\",2]',13,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,520,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5283,'[\"Volha_1_TK_CIV_EP1\",2]',12,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,520,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5284,'[\"Volha_2_TK_CIV_EP1\",2]',12,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,520,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5285,'[\"VWGolf\",2]',26,'[3,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,520,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5286,'[\"car_hatchback\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,520,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5287,'[\"car_sedan\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,520,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5288,'[\"GLT_M300_LT\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,520,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5289,'[\"GLT_M300_ST\",2]',11,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,520,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5290,'[\"Lada1\",2]',21,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,520,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5291,'[\"Lada1_TK_CIV_EP1\",2]',11,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,520,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5292,'[\"Lada2\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,520,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5293,'[\"Lada2_TK_CIV_EP1\",2]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,520,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5294,'[\"LadaLM\",2]',10,'[3,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,520,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5337,'[\"Saiga12K\",3]',76,'[5,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,526,'trade_weapons');
INSERT INTO `traders_data` VALUES(5338,'[\"m8_compact\",3]',20,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,526,'trade_weapons');
INSERT INTO `traders_data` VALUES(5339,'[\"m8_sharpshooter\",3]',94,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,526,'trade_weapons');
INSERT INTO `traders_data` VALUES(5340,'[\"m8_holo_sd\",3]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,526,'trade_weapons');
INSERT INTO `traders_data` VALUES(5341,'[\"m8_carbine\",3]',24,'[5,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,526,'trade_weapons');
INSERT INTO `traders_data` VALUES(5342,'[\"M24_des_EP1\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,526,'trade_weapons');
INSERT INTO `traders_data` VALUES(5344,'[\"VSS_vintorez\",3]',121,'[3,\"ItemGoldBar10oz\",1]','[4,\"ItemGoldBar\",1]',0,526,'trade_weapons');
INSERT INTO `traders_data` VALUES(5345,'[\"SVD_des_EP1\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,526,'trade_weapons');
INSERT INTO `traders_data` VALUES(5346,'[\"SVD\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,526,'trade_weapons');
INSERT INTO `traders_data` VALUES(5348,'[\"20Rnd_9x39_SP5_VSS\",1]',43,'[3,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,527,'trade_items');
INSERT INTO `traders_data` VALUES(5349,'[\"8Rnd_B_Beneli_74Slug\",1]',24,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,527,'trade_items');
INSERT INTO `traders_data` VALUES(5350,'[\"20Rnd_762x51_SB_SCAR\",1]',20,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,527,'trade_items');
INSERT INTO `traders_data` VALUES(5351,'[\"8Rnd_B_Beneli_Pellets\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,527,'trade_items');
INSERT INTO `traders_data` VALUES(5352,'[\"8Rnd_B_Saiga12_74Slug\",1]',37,'[5,\"ItemSilverBar\",1]','[3,\"ItemSilverBar\",1]',0,527,'trade_items');
INSERT INTO `traders_data` VALUES(5353,'[\"8Rnd_B_Saiga12_Pellets\",1]',20,'[5,\"ItemSilverBar\",1]','[3,\"ItemSilverBar\",1]',0,527,'trade_items');
INSERT INTO `traders_data` VALUES(5354,'[\"20Rnd_B_765x17_Ball\",1]',21,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,527,'trade_items');
INSERT INTO `traders_data` VALUES(5355,'[\"10Rnd_762x54_SVD\",1]',22,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,527,'trade_items');
INSERT INTO `traders_data` VALUES(5356,'[\"5Rnd_762x51_M24\",1]',30,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,527,'trade_items');
INSERT INTO `traders_data` VALUES(5357,'[\"30Rnd_556x45_Stanag\",1]',22,'[5,\"ItemSilverBar\",1]','[3,\"ItemSilverBar\",1]',0,527,'trade_items');
INSERT INTO `traders_data` VALUES(5358,'[\"20Rnd_762x51_FNFAL\",1]',32,'[4,\"ItemSilverBar10oz\",1]','[2,\"ItemSilverBar10oz\",1]',0,527,'trade_items');
INSERT INTO `traders_data` VALUES(5366,'[\"HandGrenade_west\",1]',204,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,529,'trade_items');
INSERT INTO `traders_data` VALUES(5367,'[\"PipeBomb\",1]',17,'[4,\"ItemBriefcase100oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,529,'trade_items');
INSERT INTO `traders_data` VALUES(5368,'[\"ItemSandbag\",1]',22,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,530,'trade_items');
INSERT INTO `traders_data` VALUES(5369,'[\"ItemTankTrap\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,530,'trade_items');
INSERT INTO `traders_data` VALUES(5370,'[\"ItemTentOld\",1]',22,'[4,\"ItemSilverBar10oz\",1]','[2,\"ItemSilverBar10oz\",1]',0,530,'trade_items');
INSERT INTO `traders_data` VALUES(5371,'[\"ItemVault\",1]',20,'[1,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,530,'trade_items');
INSERT INTO `traders_data` VALUES(5372,'[\"ItemWire\",1]',20,'[6,\"ItemSilverBar\",1]','[3,\"ItemSilverBar\",1]',0,530,'trade_items');
INSERT INTO `traders_data` VALUES(5373,'[\"30m_plot_kit\",1]',20,'[6,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar10oz\",1]',0,530,'trade_items');
INSERT INTO `traders_data` VALUES(5374,'[\"ItemCorrugated\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,530,'trade_items');
INSERT INTO `traders_data` VALUES(5375,'[\"ItemPole\",1]',20,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,530,'trade_items');
INSERT INTO `traders_data` VALUES(5376,'[\"ItemJerrycan\",1]',34,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,531,'trade_items');
INSERT INTO `traders_data` VALUES(5377,'[\"ItemJerrycanEmpty\",1]',23,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,531,'trade_items');
INSERT INTO `traders_data` VALUES(5378,'[\"PartEngine\",1]',21,'[5,\"ItemGoldBar\",1]','[1,\"ItemSilverBar10oz\",1]',0,531,'trade_items');
INSERT INTO `traders_data` VALUES(5379,'[\"PartVRotor\",1]',21,'[5,\"ItemGoldBar\",1]','[1,\"ItemSilverBar10oz\",1]',0,531,'trade_items');
INSERT INTO `traders_data` VALUES(5380,'[\"PartWheel\",1]',23,'[2,\"ItemGoldBar\",1]','[2,\"ItemSilverBar\",1]',0,531,'trade_items');
INSERT INTO `traders_data` VALUES(5381,'[\"PartGlass\",1]',20,'[1,\"ItemGoldBar\",1]','[1,\"ItemSilverBar\",1]',0,531,'trade_items');
INSERT INTO `traders_data` VALUES(5382,'[\"PartGeneric\",1]',21,'[2,\"ItemGoldBar\",1]','[6,\"ItemSilverBar\",1]',0,531,'trade_items');
INSERT INTO `traders_data` VALUES(5383,'[\"ItemCompass\",3]',21,'[6,\"ItemSilverBar\",1]','[3,\"ItemSilverBar\",1]',0,532,'trade_weapons');
INSERT INTO `traders_data` VALUES(5384,'[\"Binocular\",3]',22,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,532,'trade_weapons');
INSERT INTO `traders_data` VALUES(5385,'[\"Binocular_Vector\",3]',27,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,532,'trade_weapons');
INSERT INTO `traders_data` VALUES(5386,'[\"ItemEtool\",3]',21,'[9,\"ItemSilverBar10oz\",1]','[6,\"ItemSilverBar10oz\",1]',0,532,'trade_weapons');
INSERT INTO `traders_data` VALUES(5387,'[\"ItemFlashlight\",3]',21,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,532,'trade_weapons');
INSERT INTO `traders_data` VALUES(5388,'[\"ItemFlashlightRed\",3]',21,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,532,'trade_weapons');
INSERT INTO `traders_data` VALUES(5389,'[\"ItemGPS\",3]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,532,'trade_weapons');
INSERT INTO `traders_data` VALUES(5390,'[\"ItemHatchet_DZE\",3]',21,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,532,'trade_weapons');
INSERT INTO `traders_data` VALUES(5391,'[\"ItemKnife\",3]',29,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,532,'trade_weapons');
INSERT INTO `traders_data` VALUES(5392,'[\"ItemMap\",3]',21,'[6,\"ItemSilverBar\",1]','[3,\"ItemSilverBar\",1]',0,532,'trade_weapons');
INSERT INTO `traders_data` VALUES(5393,'[\"ItemMatchbox_DZE\",3]',25,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,532,'trade_weapons');
INSERT INTO `traders_data` VALUES(5394,'[\"ItemToolbox\",3]',22,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,532,'trade_weapons');
INSERT INTO `traders_data` VALUES(5395,'[\"ItemWatch\",3]',26,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,532,'trade_weapons');
INSERT INTO `traders_data` VALUES(5396,'[\"NVGoggles\",3]',20,'[4,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,532,'trade_weapons');
INSERT INTO `traders_data` VALUES(5409,'[\"Pickup_PK_GUE_DZE\",2]',10,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,534,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5410,'[\"Pickup_PK_INS_DZE\",2]',11,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,534,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5411,'[\"hilux1_civil_3_open_EP1\",2]',10,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,535,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5412,'[\"datsun1_civil_3_open\",2]',10,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,535,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5413,'[\"hilux1_civil_1_open\",2]',10,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,535,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5414,'[\"datsun1_civil_2_covered\",2]',10,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,535,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5415,'[\"datsun1_civil_1_open\",2]',10,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,535,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5416,'[\"hilux1_civil_2_covered\",2]',10,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,535,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5420,'[\"MMT_Civ\",2]',20,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,536,'trade_any_bicycle');
INSERT INTO `traders_data` VALUES(5421,'[\"Old_bike_TK_INS_EP1\",2]',20,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,536,'trade_any_bicycle');
INSERT INTO `traders_data` VALUES(5422,'[\"TT650_Civ\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,536,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5423,'[\"TT650_Ins\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,536,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5424,'[\"TT650_TK_CIV_EP1\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,536,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5425,'[\"ATV_CZ_EP1\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,536,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5426,'[\"ATV_US_EP1\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,536,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5427,'[\"M1030_US_DES_EP1\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,536,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5428,'[\"Old_moto_TK_Civ_EP1\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,536,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5436,'[\"DZ_Patrol_Pack_EP1\",2]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,538,'trade_backpacks');
INSERT INTO `traders_data` VALUES(5437,'[\"CZ_VestPouch_EP1\",2]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,538,'trade_backpacks');
INSERT INTO `traders_data` VALUES(5438,'[\"DZ_ALICE_Pack_EP1\",2]',20,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,538,'trade_backpacks');
INSERT INTO `traders_data` VALUES(5439,'[\"DZ_Assault_Pack_EP1\",2]',21,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,538,'trade_backpacks');
INSERT INTO `traders_data` VALUES(5440,'[\"DZ_Backpack_EP1\",2]',26,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,538,'trade_backpacks');
INSERT INTO `traders_data` VALUES(5441,'[\"DZ_British_ACU\",2]',20,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,538,'trade_backpacks');
INSERT INTO `traders_data` VALUES(5442,'[\"DZ_CivilBackpack_EP1\",2]',20,'[6,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,538,'trade_backpacks');
INSERT INTO `traders_data` VALUES(5475,'[\"ItemAntibiotic\",1]',20,'[1,\"ItemGoldBar\",1]','[2,\"ItemSilverBar10oz\",1]',0,541,'trade_items');
INSERT INTO `traders_data` VALUES(5476,'[\"ItemBandage\",1]',30,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,541,'trade_items');
INSERT INTO `traders_data` VALUES(5477,'[\"ItemBloodbag\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,541,'trade_items');
INSERT INTO `traders_data` VALUES(5478,'[\"ItemEpinephrine\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,541,'trade_items');
INSERT INTO `traders_data` VALUES(5479,'[\"ItemHeatPack\",1]',24,'[1,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,541,'trade_items');
INSERT INTO `traders_data` VALUES(5480,'[\"ItemMorphine\",1]',22,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,541,'trade_items');
INSERT INTO `traders_data` VALUES(5481,'[\"ItemPainkiller\",1]',20,'[1,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,541,'trade_items');
INSERT INTO `traders_data` VALUES(5482,'[\"HandChemBlue\",1]',21,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,542,'trade_items');
INSERT INTO `traders_data` VALUES(5483,'[\"HandChemGreen\",1]',21,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,542,'trade_items');
INSERT INTO `traders_data` VALUES(5484,'[\"HandChemRed\",1]',22,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,542,'trade_items');
INSERT INTO `traders_data` VALUES(5485,'[\"FlareGreen_M203\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,542,'trade_items');
INSERT INTO `traders_data` VALUES(5486,'[\"FlareWhite_M203\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,542,'trade_items');
INSERT INTO `traders_data` VALUES(5487,'[\"HandRoadFlare\",1]',28,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,542,'trade_items');
INSERT INTO `traders_data` VALUES(5488,'[\"SmokeShell\",1]',21,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,543,'trade_items');
INSERT INTO `traders_data` VALUES(5489,'[\"SmokeShellGreen\",1]',24,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,543,'trade_items');
INSERT INTO `traders_data` VALUES(5490,'[\"SmokeShellRed\",1]',22,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,543,'trade_items');
INSERT INTO `traders_data` VALUES(5555,'[\"bulk_15Rnd_9x19_M9SD\",1]',20,'[2,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,555,'trade_items');
INSERT INTO `traders_data` VALUES(5556,'[\"bulk_17Rnd_9x19_glock17\",1]',20,'[2,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,555,'trade_items');
INSERT INTO `traders_data` VALUES(5557,'[\"bulk_30Rnd_556x45_StanagSD\",1]',20,'[2,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,555,'trade_items');
INSERT INTO `traders_data` VALUES(5558,'[\"bulk_30Rnd_9x19_MP5SD\",1]',20,'[2,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,555,'trade_items');
INSERT INTO `traders_data` VALUES(5564,'[\"Smallboat_1\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,557,'trade_any_boat');
INSERT INTO `traders_data` VALUES(5565,'[\"Smallboat_2\",2]',26,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,557,'trade_any_boat');
INSERT INTO `traders_data` VALUES(5566,'[\"Zodiac\",2]',10,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,557,'trade_any_boat');
INSERT INTO `traders_data` VALUES(5567,'[\"Fishing_Boat\",2]',10,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,557,'trade_any_boat');
INSERT INTO `traders_data` VALUES(5568,'[\"PBX\",2]',26,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,557,'trade_any_boat');
INSERT INTO `traders_data` VALUES(5569,'[\"RHIB\",2]',24,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,558,'trade_any_boat');
INSERT INTO `traders_data` VALUES(5616,'[\"VWGolf\",2]',10,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,560,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5617,'[\"HMMWV_DZ\",2]',11,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,491,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5619,'[\"HMMWV_M998A2_SOV_DES_EP1_DZE\",2]',18,'[1,\"ItemBriefcase100oz\",1]','[5,\"ItemGoldBar10oz\",1]',0,562,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5621,'[\"HMMWV_M1151_M2_CZ_DES_EP1_DZE\",2]',18,'[4,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,562,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5622,'[\"LandRover_Special_CZ_EP1_DZE\",2]',18,'[1,\"ItemBriefcase100oz\",1]','[5,\"ItemGoldBar10oz\",1]',0,562,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5623,'[\"LandRover_MG_TK_EP1_DZE\",2]',13,'[6,\"ItemGoldBar10oz\",1]','[3,\"ItemGoldBar10oz\",1]',0,562,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5624,'[\"UAZ_MG_TK_EP1_DZE\",2]',16,'[6,\"ItemGoldBar10oz\",1]','[3,\"ItemGoldBar10oz\",1]',0,562,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5625,'[\"GAZ_Vodnik_DZE\",2]',15,'[2,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,562,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5626,'[\"Ikarus\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,563,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5627,'[\"Ikarus_TK_CIV_EP1\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,563,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5630,'[\"S1203_TK_CIV_EP1\",2]',10,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,563,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5631,'[\"S1203_ambulance_EP1\",2]',10,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,563,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5643,'[\"hilux1_civil_3_open_EP1\",2]',28,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,495,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5644,'[\"datsun1_civil_3_open\",2]',11,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,495,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5645,'[\"hilux1_civil_1_open\",2]',11,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,495,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5646,'[\"datsun1_civil_2_covered\",2]',10,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,495,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5647,'[\"datsun1_civil_1_open\",2]',10,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,495,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5648,'[\"hilux1_civil_2_covered\",2]',10,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,495,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5652,'[\"Ural_CDF\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,564,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5653,'[\"Ural_TK_CIV_EP1\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,564,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5654,'[\"Ural_UN_EP1\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,564,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5655,'[\"V3S_Open_TK_CIV_EP1\",2]',11,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,564,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5656,'[\"V3S_Open_TK_EP1\",2]',11,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,564,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5657,'[\"Kamaz\",2]',14,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,564,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5658,'[\"MTVR_DES_EP1\",2]',29,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,564,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5664,'[\"SUV_TK_CIV_EP1\",2]',11,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,565,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5665,'[\"SUV_Blue\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,565,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5666,'[\"SUV_Charcoal\",2]',20,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,565,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5667,'[\"SUV_Green\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,565,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5668,'[\"SUV_Orange\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,565,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5669,'[\"SUV_Pink\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,565,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5670,'[\"SUV_Red\",2]',11,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,565,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5671,'[\"SUV_Silver\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,565,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5672,'[\"SUV_White\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,565,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5673,'[\"SUV_Yellow\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,565,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5674,'[\"SUV_Camo\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,565,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5675,'[\"UAZ_CDF\",2]',10,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,565,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5676,'[\"UAZ_INS\",2]',10,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,565,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5677,'[\"UAZ_RU\",2]',10,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,565,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5678,'[\"UAZ_Unarmed_TK_CIV_EP1\",2]',13,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,565,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5679,'[\"UAZ_Unarmed_TK_EP1\",2]',11,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,565,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5680,'[\"UAZ_Unarmed_UN_EP1\",2]',10,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,565,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5681,'[\"SUV_TK_CIV_EP1\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,568,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5682,'[\"SUV_Blue\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,568,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5683,'[\"SUV_Charcoal\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,568,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5684,'[\"SUV_Green\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,568,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5685,'[\"SUV_Orange\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,568,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5686,'[\"SUV_Pink\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,568,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5687,'[\"SUV_Red\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,568,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5688,'[\"SUV_Silver\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,568,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5689,'[\"SUV_White\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,568,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5690,'[\"SUV_Yellow\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,568,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5691,'[\"SUV_Camo\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,568,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5692,'[\"UAZ_CDF\",2]',10,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,568,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5693,'[\"UAZ_INS\",2]',10,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,568,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5694,'[\"UAZ_RU\",2]',10,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,568,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5695,'[\"UAZ_Unarmed_TK_CIV_EP1\",2]',10,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,568,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5696,'[\"UAZ_Unarmed_TK_EP1\",2]',10,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,568,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5697,'[\"UAZ_Unarmed_UN_EP1\",2]',10,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,568,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5713,'[\"Ural_CDF\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,570,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5714,'[\"Ural_TK_CIV_EP1\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,570,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5715,'[\"Ural_UN_EP1\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,570,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5716,'[\"V3S_Open_TK_CIV_EP1\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,570,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5717,'[\"V3S_Open_TK_EP1\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,570,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5718,'[\"Kamaz\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,570,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5719,'[\"MTVR_DES_EP1\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,570,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5737,'[\"CH_47F_EP1_DZE\",2]',20,'[5,\"ItemBriefcase100oz\",1]','[2,\"ItemBriefcase100oz\",1]',0,512,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5738,'[\"UH1H_DZE\",2]',14,'[2,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,512,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5739,'[\"Mi17_DZE\",2]',18,'[2,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,512,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5740,'[\"UH60M_EP1_DZE\",2]',13,'[2,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,512,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5741,'[\"UH1Y_DZE\",2]',15,'[2,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,512,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5742,'[\"ArmoredSUV_PMC_DZE\",2]',18,'[2,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,534,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5749,'[\"Pickup_PK_TK_GUE_EP1_DZE\",2]',11,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,534,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5751,'[\"Offroad_DSHKM_Gue_DZE\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,534,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5754,'[\"HMMWV_M998A2_SOV_DES_EP1_DZE\",2]',15,'[1,\"ItemBriefcase100oz\",1]','[5,\"ItemGoldBar10oz\",1]',0,569,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5755,'[\"HMMWV_M1151_M2_CZ_DES_EP1_DZE\",2]',15,'[4,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,569,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5756,'[\"LandRover_Special_CZ_EP1_DZE\",2]',13,'[1,\"ItemBriefcase100oz\",1]','[5,\"ItemGoldBar10oz\",1]',0,569,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5757,'[\"LandRover_MG_TK_EP1_DZE\",2]',28,'[6,\"ItemGoldBar10oz\",1]','[3,\"ItemGoldBar10oz\",1]',0,569,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5758,'[\"UAZ_MG_TK_EP1_DZE\",2]',12,'[6,\"ItemGoldBar10oz\",1]','[3,\"ItemGoldBar10oz\",1]',0,569,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5759,'[\"GAZ_Vodnik_DZE\",2]',11,'[2,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,569,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5786,'[\"GNT_C185U\",2]',10,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,517,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5788,'[\"GNT_C185\",2]',11,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,517,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5789,'[\"GNT_C185R\",2]',10,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,517,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5790,'[\"GNT_C185C\",2]',10,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,517,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5801,'[\"SCAR_H_LNG_Sniper_SD\",3]',60,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,477,'trade_weapons');
INSERT INTO `traders_data` VALUES(5802,'[\"BAF_LRR_scoped\",3]',100,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,477,'trade_weapons');
INSERT INTO `traders_data` VALUES(5809,'[\"15Rnd_W1866_Slug\",1]',30,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,573,'trade_items');
INSERT INTO `traders_data` VALUES(5810,'[\"2Rnd_shotgun_74Pellets\",1]',29,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,573,'trade_items');
INSERT INTO `traders_data` VALUES(5811,'[\"2Rnd_shotgun_74Slug\",1]',32,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,573,'trade_items');
INSERT INTO `traders_data` VALUES(5812,'[\"8Rnd_B_Beneli_74Slug\",1]',25,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,573,'trade_items');
INSERT INTO `traders_data` VALUES(5813,'[\"8Rnd_B_Beneli_Pellets\",1]',23,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,573,'trade_items');
INSERT INTO `traders_data` VALUES(5815,'[\"Quiver\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,573,'trade_items');
INSERT INTO `traders_data` VALUES(5816,'[\"Winchester1866\",3]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,574,'trade_weapons');
INSERT INTO `traders_data` VALUES(5817,'[\"MR43\",3]',20,'[1,\"ItemSilverBar10oz\",1]','[8,\"ItemSilverBar\",1]',0,574,'trade_weapons');
INSERT INTO `traders_data` VALUES(5818,'[\"Crossbow_DZ\",3]',20,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,574,'trade_weapons');
INSERT INTO `traders_data` VALUES(5819,'[\"M1014\",3]',21,'[3,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,574,'trade_weapons');
INSERT INTO `traders_data` VALUES(5820,'[\"Remington870_lamp\",3]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,574,'trade_weapons');
INSERT INTO `traders_data` VALUES(5838,'[\"30Rnd_556x45_StanagSD\",1]',20,'[4,\"ItemSilverBar10oz\",1]','[2,\"ItemSilverBar10oz\",1]',0,577,'trade_items');
INSERT INTO `traders_data` VALUES(5859,'[\"VWGolf\",2]',10,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,578,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5860,'[\"ItemSodaRbull\",1]',113,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,498,'trade_items');
INSERT INTO `traders_data` VALUES(5861,'[\"ItemSodaOrangeSherbet\",1]',184,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,498,'trade_items');
INSERT INTO `traders_data` VALUES(5862,'[\"FoodCanBakedBeans\",1]',22,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,579,'trade_items');
INSERT INTO `traders_data` VALUES(5863,'[\"FoodCanFrankBeans\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,579,'trade_items');
INSERT INTO `traders_data` VALUES(5864,'[\"FoodCanPasta\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,579,'trade_items');
INSERT INTO `traders_data` VALUES(5865,'[\"FoodCanSardines\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,579,'trade_items');
INSERT INTO `traders_data` VALUES(5866,'[\"FoodMRE\",1]',20,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,579,'trade_items');
INSERT INTO `traders_data` VALUES(5867,'[\"FoodPistachio\",1]',21,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,579,'trade_items');
INSERT INTO `traders_data` VALUES(5868,'[\"FoodNutmix\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,579,'trade_items');
INSERT INTO `traders_data` VALUES(5869,'[\"FoodbaconCooked\",1]',20,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,580,'trade_items');
INSERT INTO `traders_data` VALUES(5870,'[\"FoodbeefCooked\",1]',20,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,580,'trade_items');
INSERT INTO `traders_data` VALUES(5871,'[\"FoodchickenCooked\",1]',20,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,580,'trade_items');
INSERT INTO `traders_data` VALUES(5872,'[\"FoodmuttonCooked\",1]',25,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,580,'trade_items');
INSERT INTO `traders_data` VALUES(5873,'[\"FoodrabbitCooked\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,580,'trade_items');
INSERT INTO `traders_data` VALUES(5874,'[\"ItemTroutCooked\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemSilverBar10oz\",1]',0,580,'trade_items');
INSERT INTO `traders_data` VALUES(5875,'[\"ItemSeaBassCooked\",1]',20,'[3,\"ItemGoldBar\",1]','[2,\"ItemSilverBar10oz\",1]',0,580,'trade_items');
INSERT INTO `traders_data` VALUES(5876,'[\"ItemTunaCooked\",1]',20,'[4,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,580,'trade_items');
INSERT INTO `traders_data` VALUES(5931,'[\"Skoda\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,585,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5932,'[\"SkodaBlue\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,585,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5933,'[\"SkodaGreen\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,585,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5934,'[\"SkodaRed\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,585,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5935,'[\"VolhaLimo_TK_CIV_EP1\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,585,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5936,'[\"Volha_1_TK_CIV_EP1\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,585,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5937,'[\"Volha_2_TK_CIV_EP1\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,585,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5938,'[\"VWGolf\",2]',10,'[3,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,585,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5939,'[\"car_hatchback\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,585,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5940,'[\"car_sedan\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,585,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5941,'[\"GLT_M300_LT\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,585,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5942,'[\"GLT_M300_ST\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,585,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5943,'[\"Lada1\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,585,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5944,'[\"Lada1_TK_CIV_EP1\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,585,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5945,'[\"Lada2\",2]',12,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,585,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5946,'[\"Lada2_TK_CIV_EP1\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,585,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5947,'[\"LadaLM\",2]',11,'[3,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,585,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5948,'[\"Ural_CDF\",2]',16,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,586,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5949,'[\"Ural_TK_CIV_EP1\",2]',18,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,586,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5950,'[\"Ural_UN_EP1\",2]',24,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,586,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5951,'[\"V3S_Open_TK_CIV_EP1\",2]',19,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,586,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5952,'[\"V3S_Open_TK_EP1\",2]',20,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,586,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5953,'[\"Kamaz\",2]',15,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,586,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5954,'[\"MTVR_DES_EP1\",2]',24,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,586,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5960,'[\"MMT_Civ\",2]',20,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,587,'trade_any_bicycle');
INSERT INTO `traders_data` VALUES(5961,'[\"Old_bike_TK_INS_EP1\",2]',20,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,587,'trade_any_bicycle');
INSERT INTO `traders_data` VALUES(5962,'[\"TT650_Civ\",2]',24,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,587,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5963,'[\"TT650_Ins\",2]',27,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,587,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5964,'[\"TT650_TK_CIV_EP1\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,587,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5965,'[\"ATV_CZ_EP1\",2]',13,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,587,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5966,'[\"ATV_US_EP1\",2]',11,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,587,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5967,'[\"M1030_US_DES_EP1\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,587,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5968,'[\"Old_moto_TK_Civ_EP1\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,587,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5969,'[\"Ikarus\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,588,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5970,'[\"Ikarus_TK_CIV_EP1\",2]',11,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,588,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5971,'[\"S1203_TK_CIV_EP1\",2]',20,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,588,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5972,'[\"S1203_ambulance_EP1\",2]',12,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,588,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5984,'[\"KamazRefuel_DZ\",2]',29,'[7,\"ItemGoldBar10oz\",1]','[3,\"ItemGoldBar10oz\",1]',0,589,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5985,'[\"MtvrRefuel_DES_EP1_DZ\",2]',34,'[7,\"ItemGoldBar10oz\",1]','[3,\"ItemGoldBar10oz\",1]',0,589,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5986,'[\"UralRefuel_TK_EP1_DZ\",2]',23,'[7,\"ItemGoldBar10oz\",1]','[3,\"ItemGoldBar10oz\",1]',0,589,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5987,'[\"V3S_Refuel_TK_GUE_EP1_DZ\",2]',26,'[7,\"ItemGoldBar10oz\",1]','[3,\"ItemGoldBar10oz\",1]',0,589,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5988,'[\"hilux1_civil_3_open_EP1\",2]',25,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,590,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5989,'[\"datsun1_civil_3_open\",2]',12,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,590,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5990,'[\"hilux1_civil_1_open\",2]',19,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,590,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5991,'[\"datsun1_civil_2_covered\",2]',11,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,590,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5992,'[\"datsun1_civil_1_open\",2]',11,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,590,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5993,'[\"hilux1_civil_2_covered\",2]',22,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,590,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5997,'[\"SUV_TK_CIV_EP1\",2]',20,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,591,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5998,'[\"SUV_Blue\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,591,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(5999,'[\"SUV_Charcoal\",2]',11,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,591,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6000,'[\"SUV_Green\",2]',12,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,591,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6001,'[\"SUV_Orange\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,591,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6002,'[\"SUV_Pink\",2]',11,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,591,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6003,'[\"SUV_Red\",2]',12,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,591,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6004,'[\"SUV_Silver\",2]',12,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,591,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6005,'[\"SUV_White\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,591,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6006,'[\"SUV_Yellow\",2]',11,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,591,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6007,'[\"SUV_Camo\",2]',23,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,591,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6008,'[\"UAZ_CDF\",2]',14,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,591,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6009,'[\"UAZ_INS\",2]',15,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,591,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6010,'[\"UAZ_RU\",2]',22,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,591,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6011,'[\"UAZ_Unarmed_TK_CIV_EP1\",2]',11,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,591,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6012,'[\"UAZ_Unarmed_TK_EP1\",2]',10,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,591,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6013,'[\"UAZ_Unarmed_UN_EP1\",2]',13,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,591,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6014,'[\"Ikarus\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,592,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6015,'[\"Ikarus_TK_CIV_EP1\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,592,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6016,'[\"S1203_TK_CIV_EP1\",2]',10,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,592,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6017,'[\"S1203_ambulance_EP1\",2]',10,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,592,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6047,'[\"VWGolf\",2]',10,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,593,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6069,'[\"KamazRefuel_DZ\",2]',10,'[7,\"ItemGoldBar10oz\",1]','[3,\"ItemGoldBar10oz\",1]',0,595,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6070,'[\"MtvrRefuel_DES_EP1_DZ\",2]',10,'[7,\"ItemGoldBar10oz\",1]','[3,\"ItemGoldBar10oz\",1]',0,595,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6071,'[\"UralRefuel_TK_EP1_DZ\",2]',10,'[7,\"ItemGoldBar10oz\",1]','[3,\"ItemGoldBar10oz\",1]',0,595,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6072,'[\"V3S_Refuel_TK_GUE_EP1_DZ\",2]',10,'[7,\"ItemGoldBar10oz\",1]','[3,\"ItemGoldBar10oz\",1]',0,595,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6085,'[\"HMMWV_M1035_DES_EP1\",2]',16,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,598,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6086,'[\"HMMWV_Ambulance\",2]',14,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,598,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6087,'[\"HMMWV_Ambulance_CZ_DES_EP1\",2]',13,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,598,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6088,'[\"HMMWV_DES_EP1\",2]',18,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,598,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6089,'[\"GAZ_Vodnik_MedEvac\",2]',10,'[1,\"ItemBriefcase100oz\",1]','[5,\"ItemGoldBar10oz\",1]',0,598,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6090,'[\"HMMWV_DZ\",2]',14,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,598,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6091,'[\"HMMWV_M1035_DES_EP1\",2]',10,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,599,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6092,'[\"HMMWV_Ambulance\",2]',10,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,599,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6093,'[\"HMMWV_Ambulance_CZ_DES_EP1\",2]',10,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,599,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6094,'[\"HMMWV_DES_EP1\",2]',10,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,599,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6095,'[\"GAZ_Vodnik_MedEvac\",2]',10,'[1,\"ItemBriefcase100oz\",1]','[5,\"ItemGoldBar10oz\",1]',0,599,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6096,'[\"HMMWV_DZ\",2]',10,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,599,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6097,'[\"Skoda\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,600,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6098,'[\"SkodaBlue\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,600,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6099,'[\"SkodaGreen\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,600,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6100,'[\"SkodaRed\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,600,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6101,'[\"VolhaLimo_TK_CIV_EP1\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,600,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6102,'[\"Volha_1_TK_CIV_EP1\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,600,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6103,'[\"Volha_2_TK_CIV_EP1\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,600,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6104,'[\"VWGolf\",2]',10,'[3,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,600,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6105,'[\"car_hatchback\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,600,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6106,'[\"car_sedan\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,600,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6107,'[\"GLT_M300_LT\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,600,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6108,'[\"GLT_M300_ST\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,600,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6109,'[\"Lada1\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,600,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6110,'[\"Lada1_TK_CIV_EP1\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,600,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6111,'[\"Lada2\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,600,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6112,'[\"Lada2_TK_CIV_EP1\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,600,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6113,'[\"LadaLM\",2]',10,'[3,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,600,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6114,'[\"Pickup_PK_GUE_DZE\",2]',23,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,479,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6115,'[\"Pickup_PK_INS_DZE\",2]',25,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,479,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6118,'[\"Sa58P_EP1\",3]',22,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,485,'trade_weapons');
INSERT INTO `traders_data` VALUES(6119,'[\"Sa58V_CCO_EP1\",3]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,485,'trade_weapons');
INSERT INTO `traders_data` VALUES(6120,'[\"Sa58V_EP1\",3]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,485,'trade_weapons');
INSERT INTO `traders_data` VALUES(6121,'[\"Sa58V_RCO_EP1\",3]',33,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,485,'trade_weapons');
INSERT INTO `traders_data` VALUES(6122,'[\"AKS_74_kobra\",3]',36,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,485,'trade_weapons');
INSERT INTO `traders_data` VALUES(6123,'[\"AKS_74_U\",3]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,485,'trade_weapons');
INSERT INTO `traders_data` VALUES(6124,'[\"AK_47_M\",3]',20,'[8,\"ItemGoldBar\",1]','[6,\"ItemGoldBar\",1]',0,485,'trade_weapons');
INSERT INTO `traders_data` VALUES(6125,'[\"AK_74\",3]',28,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,485,'trade_weapons');
INSERT INTO `traders_data` VALUES(6126,'[\"10x_303\",1]',57,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,573,'trade_items');
INSERT INTO `traders_data` VALUES(6127,'[\"Makarov\",3]',23,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,489,'trade_weapons');
INSERT INTO `traders_data` VALUES(6128,'[\"revolver_EP1\",3]',21,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,489,'trade_weapons');
INSERT INTO `traders_data` VALUES(6129,'[\"LeeEnfield\",3]',36,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,574,'trade_weapons');
INSERT INTO `traders_data` VALUES(6130,'[\"huntingrifle\",3]',24,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,487,'trade_weapons');
INSERT INTO `traders_data` VALUES(6131,'[\"M4SPR\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,487,'trade_weapons');
INSERT INTO `traders_data` VALUES(6132,'[\"SVD\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,487,'trade_weapons');
INSERT INTO `traders_data` VALUES(6133,'[\"SVD_des_EP1\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,487,'trade_weapons');
INSERT INTO `traders_data` VALUES(6134,'[\"M24\",3]',37,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,487,'trade_weapons');
INSERT INTO `traders_data` VALUES(6135,'[\"M24_des_EP1\",3]',21,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,487,'trade_weapons');
INSERT INTO `traders_data` VALUES(6136,'[\"ItemSodaCoke\",1]',21,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,601,'trade_items');
INSERT INTO `traders_data` VALUES(6137,'[\"ItemSodaPepsi\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,601,'trade_items');
INSERT INTO `traders_data` VALUES(6138,'[\"ItemSodaMdew\",1]',36,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,601,'trade_items');
INSERT INTO `traders_data` VALUES(6139,'[\"ItemSodaR4z0r\",1]',20,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,601,'trade_items');
INSERT INTO `traders_data` VALUES(6140,'[\"ItemWaterbottleUnfilled\",1]',20,'[3,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,601,'trade_items');
INSERT INTO `traders_data` VALUES(6141,'[\"ItemSodaRbull\",1]',48,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,601,'trade_items');
INSERT INTO `traders_data` VALUES(6142,'[\"ItemSodaOrangeSherbet\",1]',53,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,601,'trade_items');
INSERT INTO `traders_data` VALUES(6143,'[\"FN_FAL\",3]',29,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,485,'trade_weapons');
INSERT INTO `traders_data` VALUES(6144,'[\"30Rnd_545x39_AK\",1]',34,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,480,'trade_items');
INSERT INTO `traders_data` VALUES(6145,'[\"30Rnd_762x39_AK47\",1]',31,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,480,'trade_items');
INSERT INTO `traders_data` VALUES(6146,'[\"5Rnd_762x51_M24\",1]',36,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,482,'trade_items');
INSERT INTO `traders_data` VALUES(6147,'[\"5x_22_LR_17_HMR\",1]',37,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,482,'trade_items');
INSERT INTO `traders_data` VALUES(6148,'[\"G36A_camo\",3]',57,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,602,'trade_weapons');
INSERT INTO `traders_data` VALUES(6149,'[\"G36C\",3]',26,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,602,'trade_weapons');
INSERT INTO `traders_data` VALUES(6150,'[\"G36C_camo\",3]',65,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,602,'trade_weapons');
INSERT INTO `traders_data` VALUES(6151,'[\"G36K_camo\",3]',24,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,602,'trade_weapons');
INSERT INTO `traders_data` VALUES(6152,'[\"M16A2\",3]',28,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,602,'trade_weapons');
INSERT INTO `traders_data` VALUES(6153,'[\"M16A2GL\",3]',23,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,602,'trade_weapons');
INSERT INTO `traders_data` VALUES(6154,'[\"M16A4_ACG\",3]',73,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,602,'trade_weapons');
INSERT INTO `traders_data` VALUES(6155,'[\"M4A1\",3]',40,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,602,'trade_weapons');
INSERT INTO `traders_data` VALUES(6156,'[\"M4A1_HWS_GL_camo\",3]',23,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,602,'trade_weapons');
INSERT INTO `traders_data` VALUES(6157,'[\"M4A3_CCO_EP1\",3]',92,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,602,'trade_weapons');
INSERT INTO `traders_data` VALUES(6158,'[\"M4A1_Aim\",3]',21,'[6,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,602,'trade_weapons');
INSERT INTO `traders_data` VALUES(6159,'[\"Sa58P_EP1\",3]',42,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,602,'trade_weapons');
INSERT INTO `traders_data` VALUES(6160,'[\"Sa58V_CCO_EP1\",3]',37,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,602,'trade_weapons');
INSERT INTO `traders_data` VALUES(6161,'[\"Sa58V_EP1\",3]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,602,'trade_weapons');
INSERT INTO `traders_data` VALUES(6162,'[\"Sa58V_RCO_EP1\",3]',120,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,602,'trade_weapons');
INSERT INTO `traders_data` VALUES(6163,'[\"AKS_74_kobra\",3]',74,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,602,'trade_weapons');
INSERT INTO `traders_data` VALUES(6164,'[\"AKS_74_U\",3]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,602,'trade_weapons');
INSERT INTO `traders_data` VALUES(6165,'[\"AK_47_M\",3]',28,'[8,\"ItemGoldBar\",1]','[6,\"ItemGoldBar\",1]',0,602,'trade_weapons');
INSERT INTO `traders_data` VALUES(6166,'[\"AK_74\",3]',35,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,602,'trade_weapons');
INSERT INTO `traders_data` VALUES(6167,'[\"FN_FAL\",3]',53,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,602,'trade_weapons');
INSERT INTO `traders_data` VALUES(6168,'[\"M249_EP1_DZ\",3]',73,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,603,'trade_weapons');
INSERT INTO `traders_data` VALUES(6169,'[\"M240_DZ\",3]',102,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,603,'trade_weapons');
INSERT INTO `traders_data` VALUES(6170,'[\"Mk_48_DZ\",3]',90,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,603,'trade_weapons');
INSERT INTO `traders_data` VALUES(6171,'[\"Pecheneg_DZ\",3]',99,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,603,'trade_weapons');
INSERT INTO `traders_data` VALUES(6172,'[\"bizon_silenced\",3]',26,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,604,'trade_weapons');
INSERT INTO `traders_data` VALUES(6173,'[\"UZI_EP1\",3]',23,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,604,'trade_weapons');
INSERT INTO `traders_data` VALUES(6174,'[\"Sa61_EP1\",3]',20,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,604,'trade_weapons');
INSERT INTO `traders_data` VALUES(6175,'[\"MP5A5\",3]',34,'[1,\"ItemGoldBar\",1]','[2,\"ItemSilverBar10oz\",1]',0,604,'trade_weapons');
INSERT INTO `traders_data` VALUES(6176,'[\"UZI_SD_EP1\",3]',21,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,604,'trade_weapons');
INSERT INTO `traders_data` VALUES(6177,'[\"MP5SD\",3]',21,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,604,'trade_weapons');
INSERT INTO `traders_data` VALUES(6178,'[\"SVD_CAMO\",3]',114,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,605,'trade_weapons');
INSERT INTO `traders_data` VALUES(6179,'[\"M40A3\",3]',107,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,605,'trade_weapons');
INSERT INTO `traders_data` VALUES(6180,'[\"M14_EP1\",3]',134,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,605,'trade_weapons');
INSERT INTO `traders_data` VALUES(6181,'[\"huntingrifle\",3]',38,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,605,'trade_weapons');
INSERT INTO `traders_data` VALUES(6182,'[\"M4SPR\",3]',21,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,605,'trade_weapons');
INSERT INTO `traders_data` VALUES(6183,'[\"SVD\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,605,'trade_weapons');
INSERT INTO `traders_data` VALUES(6184,'[\"SVD_des_EP1\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,605,'trade_weapons');
INSERT INTO `traders_data` VALUES(6185,'[\"M24\",3]',87,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,605,'trade_weapons');
INSERT INTO `traders_data` VALUES(6186,'[\"M24_des_EP1\",3]',21,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,605,'trade_weapons');
INSERT INTO `traders_data` VALUES(6187,'[\"M9SD\",3]',31,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,606,'trade_weapons');
INSERT INTO `traders_data` VALUES(6188,'[\"glock17_EP1\",3]',22,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,606,'trade_weapons');
INSERT INTO `traders_data` VALUES(6189,'[\"Colt1911\",3]',22,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,606,'trade_weapons');
INSERT INTO `traders_data` VALUES(6190,'[\"M9\",3]',26,'[1,\"ItemGoldBar\",1]','[2,\"ItemSilverBar10oz\",1]',0,606,'trade_weapons');
INSERT INTO `traders_data` VALUES(6191,'[\"MakarovSD\",3]',27,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,606,'trade_weapons');
INSERT INTO `traders_data` VALUES(6192,'[\"revolver_gold_EP1\",3]',25,'[3,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,606,'trade_weapons');
INSERT INTO `traders_data` VALUES(6193,'[\"Makarov\",3]',26,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,606,'trade_weapons');
INSERT INTO `traders_data` VALUES(6194,'[\"revolver_EP1\",3]',24,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,606,'trade_weapons');
INSERT INTO `traders_data` VALUES(6195,'[\"Winchester1866\",3]',38,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,607,'trade_weapons');
INSERT INTO `traders_data` VALUES(6196,'[\"MR43\",3]',26,'[1,\"ItemSilverBar10oz\",1]','[8,\"ItemSilverBar\",1]',0,607,'trade_weapons');
INSERT INTO `traders_data` VALUES(6197,'[\"Crossbow_DZ\",3]',20,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,607,'trade_weapons');
INSERT INTO `traders_data` VALUES(6198,'[\"M1014\",3]',26,'[3,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,607,'trade_weapons');
INSERT INTO `traders_data` VALUES(6199,'[\"Remington870_lamp\",3]',37,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,607,'trade_weapons');
INSERT INTO `traders_data` VALUES(6200,'[\"LeeEnfield\",3]',43,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,607,'trade_weapons');
INSERT INTO `traders_data` VALUES(6201,'[\"MMT_Civ\",2]',20,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,608,'trade_any_bicycle');
INSERT INTO `traders_data` VALUES(6202,'[\"Old_bike_TK_INS_EP1\",2]',20,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,608,'trade_any_bicycle');
INSERT INTO `traders_data` VALUES(6203,'[\"TT650_Civ\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,608,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6204,'[\"TT650_Ins\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,608,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6205,'[\"TT650_TK_CIV_EP1\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,608,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6206,'[\"ATV_CZ_EP1\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,608,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6207,'[\"ATV_US_EP1\",2]',22,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,608,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6208,'[\"M1030_US_DES_EP1\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,608,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6209,'[\"Old_moto_TK_Civ_EP1\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,608,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6211,'[\"30Rnd_556x45_Stanag\",1]',33,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,609,'trade_items');
INSERT INTO `traders_data` VALUES(6212,'[\"20Rnd_762x51_FNFAL\",1]',33,'[4,\"ItemSilverBar10oz\",1]','[2,\"ItemSilverBar10oz\",1]',0,609,'trade_items');
INSERT INTO `traders_data` VALUES(6213,'[\"30Rnd_545x39_AK\",1]',93,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,609,'trade_items');
INSERT INTO `traders_data` VALUES(6214,'[\"30Rnd_762x39_AK47\",1]',80,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,609,'trade_items');
INSERT INTO `traders_data` VALUES(6215,'[\"100Rnd_762x51_M240\",1]',266,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,610,'trade_items');
INSERT INTO `traders_data` VALUES(6216,'[\"200Rnd_556x45_M249\",1]',277,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,610,'trade_items');
INSERT INTO `traders_data` VALUES(6217,'[\"100Rnd_762x54_PK\",1]',58,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,610,'trade_items');
INSERT INTO `traders_data` VALUES(6218,'[\"15Rnd_9x19_M9\",1]',37,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,611,'trade_items');
INSERT INTO `traders_data` VALUES(6219,'[\"15Rnd_9x19_M9SD\",1]',21,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,611,'trade_items');
INSERT INTO `traders_data` VALUES(6220,'[\"17Rnd_9x19_glock17\",1]',40,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,611,'trade_items');
INSERT INTO `traders_data` VALUES(6221,'[\"6Rnd_45ACP\",1]',53,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,611,'trade_items');
INSERT INTO `traders_data` VALUES(6222,'[\"7Rnd_45ACP_1911\",1]',40,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,611,'trade_items');
INSERT INTO `traders_data` VALUES(6223,'[\"8Rnd_9x18_Makarov\",1]',49,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,611,'trade_items');
INSERT INTO `traders_data` VALUES(6224,'[\"8Rnd_9x18_MakarovSD\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,611,'trade_items');
INSERT INTO `traders_data` VALUES(6225,'[\"30rnd_9x19_MP5\",1]',37,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,612,'trade_items');
INSERT INTO `traders_data` VALUES(6226,'[\"30Rnd_9x19_MP5SD\",1]',21,'[4,\"ItemSilverBar10oz\",1]','[2,\"ItemSilverBar10oz\",1]',0,612,'trade_items');
INSERT INTO `traders_data` VALUES(6227,'[\"30Rnd_9x19_UZI\",1]',52,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,612,'trade_items');
INSERT INTO `traders_data` VALUES(6228,'[\"64Rnd_9x19_SD_Bizon\",1]',31,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,612,'trade_items');
INSERT INTO `traders_data` VALUES(6229,'[\"30Rnd_9x19_UZI_SD\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,612,'trade_items');
INSERT INTO `traders_data` VALUES(6230,'[\"20Rnd_B_765x17_Ball\",1]',22,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,612,'trade_items');
INSERT INTO `traders_data` VALUES(6231,'[\"15Rnd_W1866_Slug\",1]',52,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,613,'trade_items');
INSERT INTO `traders_data` VALUES(6232,'[\"2Rnd_shotgun_74Pellets\",1]',27,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,613,'trade_items');
INSERT INTO `traders_data` VALUES(6233,'[\"2Rnd_shotgun_74Slug\",1]',26,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,613,'trade_items');
INSERT INTO `traders_data` VALUES(6234,'[\"8Rnd_B_Beneli_74Slug\",1]',41,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,613,'trade_items');
INSERT INTO `traders_data` VALUES(6235,'[\"8Rnd_B_Beneli_Pellets\",1]',24,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,613,'trade_items');
INSERT INTO `traders_data` VALUES(6236,'[\"WoodenArrow\",1]',26,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,613,'trade_items');
INSERT INTO `traders_data` VALUES(6237,'[\"Quiver\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,613,'trade_items');
INSERT INTO `traders_data` VALUES(6238,'[\"10x_303\",1]',83,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,613,'trade_items');
INSERT INTO `traders_data` VALUES(6239,'[\"20Rnd_762x51_DMR\",1]',169,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,614,'trade_items');
INSERT INTO `traders_data` VALUES(6240,'[\"10Rnd_762x54_SVD\",1]',124,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,614,'trade_items');
INSERT INTO `traders_data` VALUES(6242,'[\"5Rnd_762x51_M24\",1]',63,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,614,'trade_items');
INSERT INTO `traders_data` VALUES(6243,'[\"5x_22_LR_17_HMR\",1]',32,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,614,'trade_items');
INSERT INTO `traders_data` VALUES(6244,'[\"G36A_camo\",3]',20,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,615,'trade_weapons');
INSERT INTO `traders_data` VALUES(6245,'[\"G36C\",3]',20,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,615,'trade_weapons');
INSERT INTO `traders_data` VALUES(6246,'[\"G36C_camo\",3]',20,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,615,'trade_weapons');
INSERT INTO `traders_data` VALUES(6247,'[\"G36K_camo\",3]',20,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,615,'trade_weapons');
INSERT INTO `traders_data` VALUES(6248,'[\"M16A2\",3]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,615,'trade_weapons');
INSERT INTO `traders_data` VALUES(6249,'[\"M16A2GL\",3]',20,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,615,'trade_weapons');
INSERT INTO `traders_data` VALUES(6250,'[\"M16A4_ACG\",3]',20,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,615,'trade_weapons');
INSERT INTO `traders_data` VALUES(6251,'[\"M4A1\",3]',20,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,615,'trade_weapons');
INSERT INTO `traders_data` VALUES(6252,'[\"M4A1_HWS_GL_camo\",3]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,615,'trade_weapons');
INSERT INTO `traders_data` VALUES(6253,'[\"M4A3_CCO_EP1\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,615,'trade_weapons');
INSERT INTO `traders_data` VALUES(6254,'[\"M4A1_Aim\",3]',20,'[6,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,615,'trade_weapons');
INSERT INTO `traders_data` VALUES(6255,'[\"Sa58P_EP1\",3]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,615,'trade_weapons');
INSERT INTO `traders_data` VALUES(6256,'[\"Sa58V_CCO_EP1\",3]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,615,'trade_weapons');
INSERT INTO `traders_data` VALUES(6257,'[\"Sa58V_EP1\",3]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,615,'trade_weapons');
INSERT INTO `traders_data` VALUES(6258,'[\"Sa58V_RCO_EP1\",3]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,615,'trade_weapons');
INSERT INTO `traders_data` VALUES(6259,'[\"AKS_74_kobra\",3]',20,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,615,'trade_weapons');
INSERT INTO `traders_data` VALUES(6260,'[\"AKS_74_U\",3]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,615,'trade_weapons');
INSERT INTO `traders_data` VALUES(6261,'[\"AK_47_M\",3]',20,'[8,\"ItemGoldBar\",1]','[6,\"ItemGoldBar\",1]',0,615,'trade_weapons');
INSERT INTO `traders_data` VALUES(6262,'[\"AK_74\",3]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,615,'trade_weapons');
INSERT INTO `traders_data` VALUES(6263,'[\"FN_FAL\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,615,'trade_weapons');
INSERT INTO `traders_data` VALUES(6264,'[\"M249_EP1_DZ\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,616,'trade_weapons');
INSERT INTO `traders_data` VALUES(6265,'[\"M240_DZ\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,616,'trade_weapons');
INSERT INTO `traders_data` VALUES(6266,'[\"Mk_48_DZ\",3]',20,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,616,'trade_weapons');
INSERT INTO `traders_data` VALUES(6267,'[\"Pecheneg_DZ\",3]',20,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,616,'trade_weapons');
INSERT INTO `traders_data` VALUES(6268,'[\"M9SD\",3]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,617,'trade_weapons');
INSERT INTO `traders_data` VALUES(6269,'[\"glock17_EP1\",3]',20,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,617,'trade_weapons');
INSERT INTO `traders_data` VALUES(6270,'[\"Colt1911\",3]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,617,'trade_weapons');
INSERT INTO `traders_data` VALUES(6271,'[\"M9\",3]',20,'[1,\"ItemGoldBar\",1]','[2,\"ItemSilverBar10oz\",1]',0,617,'trade_weapons');
INSERT INTO `traders_data` VALUES(6272,'[\"MakarovSD\",3]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,617,'trade_weapons');
INSERT INTO `traders_data` VALUES(6273,'[\"revolver_gold_EP1\",3]',20,'[3,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,617,'trade_weapons');
INSERT INTO `traders_data` VALUES(6274,'[\"Makarov\",3]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,617,'trade_weapons');
INSERT INTO `traders_data` VALUES(6275,'[\"revolver_EP1\",3]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,617,'trade_weapons');
INSERT INTO `traders_data` VALUES(6276,'[\"bizon_silenced\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,618,'trade_weapons');
INSERT INTO `traders_data` VALUES(6277,'[\"UZI_EP1\",3]',20,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,618,'trade_weapons');
INSERT INTO `traders_data` VALUES(6278,'[\"Sa61_EP1\",3]',20,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,618,'trade_weapons');
INSERT INTO `traders_data` VALUES(6279,'[\"MP5A5\",3]',20,'[1,\"ItemGoldBar\",1]','[2,\"ItemSilverBar10oz\",1]',0,618,'trade_weapons');
INSERT INTO `traders_data` VALUES(6280,'[\"UZI_SD_EP1\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,618,'trade_weapons');
INSERT INTO `traders_data` VALUES(6281,'[\"MP5SD\",3]',20,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,618,'trade_weapons');
INSERT INTO `traders_data` VALUES(6282,'[\"SVD_CAMO\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,619,'trade_weapons');
INSERT INTO `traders_data` VALUES(6283,'[\"M40A3\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,619,'trade_weapons');
INSERT INTO `traders_data` VALUES(6284,'[\"M14_EP1\",3]',20,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,619,'trade_weapons');
INSERT INTO `traders_data` VALUES(6285,'[\"huntingrifle\",3]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,619,'trade_weapons');
INSERT INTO `traders_data` VALUES(6286,'[\"M4SPR\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,619,'trade_weapons');
INSERT INTO `traders_data` VALUES(6287,'[\"SVD\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,619,'trade_weapons');
INSERT INTO `traders_data` VALUES(6288,'[\"SVD_des_EP1\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,619,'trade_weapons');
INSERT INTO `traders_data` VALUES(6289,'[\"M24\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,619,'trade_weapons');
INSERT INTO `traders_data` VALUES(6290,'[\"M24_des_EP1\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,619,'trade_weapons');
INSERT INTO `traders_data` VALUES(6291,'[\"Winchester1866\",3]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,620,'trade_weapons');
INSERT INTO `traders_data` VALUES(6292,'[\"MR43\",3]',20,'[1,\"ItemSilverBar10oz\",1]','[8,\"ItemSilverBar\",1]',0,620,'trade_weapons');
INSERT INTO `traders_data` VALUES(6293,'[\"Crossbow_DZ\",3]',20,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,620,'trade_weapons');
INSERT INTO `traders_data` VALUES(6294,'[\"M1014\",3]',20,'[3,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,620,'trade_weapons');
INSERT INTO `traders_data` VALUES(6295,'[\"Remington870_lamp\",3]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,620,'trade_weapons');
INSERT INTO `traders_data` VALUES(6296,'[\"LeeEnfield\",3]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,620,'trade_weapons');
INSERT INTO `traders_data` VALUES(6298,'[\"30Rnd_556x45_Stanag\",1]',20,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,621,'trade_items');
INSERT INTO `traders_data` VALUES(6299,'[\"20Rnd_762x51_FNFAL\",1]',20,'[4,\"ItemSilverBar10oz\",1]','[2,\"ItemSilverBar10oz\",1]',0,621,'trade_items');
INSERT INTO `traders_data` VALUES(6300,'[\"30Rnd_545x39_AK\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,621,'trade_items');
INSERT INTO `traders_data` VALUES(6301,'[\"30Rnd_762x39_AK47\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,621,'trade_items');
INSERT INTO `traders_data` VALUES(6302,'[\"100Rnd_762x51_M240\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,622,'trade_items');
INSERT INTO `traders_data` VALUES(6303,'[\"200Rnd_556x45_M249\",1]',20,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,622,'trade_items');
INSERT INTO `traders_data` VALUES(6304,'[\"100Rnd_762x54_PK\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,622,'trade_items');
INSERT INTO `traders_data` VALUES(6305,'[\"15Rnd_W1866_Slug\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,623,'trade_items');
INSERT INTO `traders_data` VALUES(6306,'[\"2Rnd_shotgun_74Pellets\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,623,'trade_items');
INSERT INTO `traders_data` VALUES(6307,'[\"2Rnd_shotgun_74Slug\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,623,'trade_items');
INSERT INTO `traders_data` VALUES(6308,'[\"8Rnd_B_Beneli_74Slug\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,623,'trade_items');
INSERT INTO `traders_data` VALUES(6309,'[\"8Rnd_B_Beneli_Pellets\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,623,'trade_items');
INSERT INTO `traders_data` VALUES(6310,'[\"WoodenArrow\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,623,'trade_items');
INSERT INTO `traders_data` VALUES(6311,'[\"Quiver\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,623,'trade_items');
INSERT INTO `traders_data` VALUES(6312,'[\"10x_303\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,623,'trade_items');
INSERT INTO `traders_data` VALUES(6313,'[\"20Rnd_762x51_DMR\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,624,'trade_items');
INSERT INTO `traders_data` VALUES(6314,'[\"10Rnd_762x54_SVD\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,624,'trade_items');
INSERT INTO `traders_data` VALUES(6316,'[\"5Rnd_762x51_M24\",1]',20,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,624,'trade_items');
INSERT INTO `traders_data` VALUES(6317,'[\"5x_22_LR_17_HMR\",1]',20,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,624,'trade_items');
INSERT INTO `traders_data` VALUES(6318,'[\"15Rnd_9x19_M9\",1]',20,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,625,'trade_items');
INSERT INTO `traders_data` VALUES(6319,'[\"15Rnd_9x19_M9SD\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,625,'trade_items');
INSERT INTO `traders_data` VALUES(6320,'[\"17Rnd_9x19_glock17\",1]',20,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,625,'trade_items');
INSERT INTO `traders_data` VALUES(6321,'[\"6Rnd_45ACP\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,625,'trade_items');
INSERT INTO `traders_data` VALUES(6322,'[\"7Rnd_45ACP_1911\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,625,'trade_items');
INSERT INTO `traders_data` VALUES(6323,'[\"8Rnd_9x18_Makarov\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,625,'trade_items');
INSERT INTO `traders_data` VALUES(6324,'[\"8Rnd_9x18_MakarovSD\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,625,'trade_items');
INSERT INTO `traders_data` VALUES(6325,'[\"30rnd_9x19_MP5\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,626,'trade_items');
INSERT INTO `traders_data` VALUES(6326,'[\"30Rnd_9x19_MP5SD\",1]',20,'[4,\"ItemSilverBar10oz\",1]','[2,\"ItemSilverBar10oz\",1]',0,626,'trade_items');
INSERT INTO `traders_data` VALUES(6327,'[\"30Rnd_9x19_UZI\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,626,'trade_items');
INSERT INTO `traders_data` VALUES(6328,'[\"64Rnd_9x19_SD_Bizon\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,626,'trade_items');
INSERT INTO `traders_data` VALUES(6329,'[\"30Rnd_9x19_UZI_SD\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,626,'trade_items');
INSERT INTO `traders_data` VALUES(6330,'[\"20Rnd_B_765x17_Ball\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,626,'trade_items');
INSERT INTO `traders_data` VALUES(6332,'[\"FN_FAL\",3]',30,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,477,'trade_weapons');
INSERT INTO `traders_data` VALUES(6333,'[\"Mk_48_DZ\",3]',41,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,477,'trade_weapons');
INSERT INTO `traders_data` VALUES(6334,'[\"M240_DZ\",3]',32,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,477,'trade_weapons');
INSERT INTO `traders_data` VALUES(6335,'[\"G36_C_SD_camo\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,627,'trade_weapons');
INSERT INTO `traders_data` VALUES(6336,'[\"M4A1_AIM_SD_camo\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,627,'trade_weapons');
INSERT INTO `traders_data` VALUES(6337,'[\"FN_FAL_ANPVS4\",3]',20,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,627,'trade_weapons');
INSERT INTO `traders_data` VALUES(6338,'[\"SCAR_H_LNG_Sniper_SD\",3]',20,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,627,'trade_weapons');
INSERT INTO `traders_data` VALUES(6339,'[\"BAF_LRR_scoped\",3]',20,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,627,'trade_weapons');
INSERT INTO `traders_data` VALUES(6340,'[\"FN_FAL\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,627,'trade_weapons');
INSERT INTO `traders_data` VALUES(6341,'[\"Mk_48_DZ\",3]',20,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,627,'trade_weapons');
INSERT INTO `traders_data` VALUES(6342,'[\"M240_DZ\",3]',21,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,627,'trade_weapons');
INSERT INTO `traders_data` VALUES(6344,'[\"Skin_Rocker1_DZ\",1]',31,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,497,'trade_items');
INSERT INTO `traders_data` VALUES(6345,'[\"Skin_Rocker3_DZ\",1]',26,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,497,'trade_items');
INSERT INTO `traders_data` VALUES(6346,'[\"Skin_RU_Policeman_DZ\",1]',24,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,497,'trade_items');
INSERT INTO `traders_data` VALUES(6347,'[\"Skin_Pilot_EP1_DZ\",1]',33,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,497,'trade_items');
INSERT INTO `traders_data` VALUES(6348,'[\"Skin_Rocker4_DZ\",1]',37,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,497,'trade_items');
INSERT INTO `traders_data` VALUES(6349,'[\"Skin_Rocker2_DZ\",1]',21,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,628,'trade_items');
INSERT INTO `traders_data` VALUES(6350,'[\"Skin_SurvivorW2_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,628,'trade_items');
INSERT INTO `traders_data` VALUES(6351,'[\"Skin_Functionary1_EP1_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,628,'trade_items');
INSERT INTO `traders_data` VALUES(6352,'[\"Skin_Haris_Press_EP1_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,628,'trade_items');
INSERT INTO `traders_data` VALUES(6353,'[\"Skin_Priest_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,628,'trade_items');
INSERT INTO `traders_data` VALUES(6354,'[\"Skin_SurvivorWpink_DZ\",1]',21,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,628,'trade_items');
INSERT INTO `traders_data` VALUES(6355,'[\"Skin_SurvivorWurban_DZ\",1]',22,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,628,'trade_items');
INSERT INTO `traders_data` VALUES(6356,'[\"Skin_SurvivorWcombat_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,628,'trade_items');
INSERT INTO `traders_data` VALUES(6357,'[\"Skin_SurvivorWdesert_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,628,'trade_items');
INSERT INTO `traders_data` VALUES(6358,'[\"Skin_Survivor2_DZ\",1]',41,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,628,'trade_items');
INSERT INTO `traders_data` VALUES(6359,'[\"Skin_Rocker1_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,628,'trade_items');
INSERT INTO `traders_data` VALUES(6360,'[\"Skin_Rocker3_DZ\",1]',21,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,628,'trade_items');
INSERT INTO `traders_data` VALUES(6361,'[\"Skin_RU_Policeman_DZ\",1]',22,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,628,'trade_items');
INSERT INTO `traders_data` VALUES(6362,'[\"Skin_Pilot_EP1_DZ\",1]',22,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,628,'trade_items');
INSERT INTO `traders_data` VALUES(6363,'[\"Skin_Rocker4_DZ\",1]',22,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,628,'trade_items');
INSERT INTO `traders_data` VALUES(6364,'[\"FoodCanBakedBeans\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,629,'trade_items');
INSERT INTO `traders_data` VALUES(6365,'[\"FoodCanFrankBeans\",1]',23,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,629,'trade_items');
INSERT INTO `traders_data` VALUES(6366,'[\"FoodCanPasta\",1]',23,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,629,'trade_items');
INSERT INTO `traders_data` VALUES(6367,'[\"FoodCanSardines\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,629,'trade_items');
INSERT INTO `traders_data` VALUES(6368,'[\"FoodMRE\",1]',20,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,629,'trade_items');
INSERT INTO `traders_data` VALUES(6369,'[\"FoodPistachio\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,629,'trade_items');
INSERT INTO `traders_data` VALUES(6370,'[\"FoodNutmix\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,629,'trade_items');
INSERT INTO `traders_data` VALUES(6371,'[\"FoodbaconCooked\",1]',20,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,630,'trade_items');
INSERT INTO `traders_data` VALUES(6372,'[\"FoodbeefCooked\",1]',25,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,630,'trade_items');
INSERT INTO `traders_data` VALUES(6373,'[\"FoodchickenCooked\",1]',20,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,630,'trade_items');
INSERT INTO `traders_data` VALUES(6374,'[\"FoodmuttonCooked\",1]',20,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,630,'trade_items');
INSERT INTO `traders_data` VALUES(6375,'[\"FoodrabbitCooked\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,630,'trade_items');
INSERT INTO `traders_data` VALUES(6376,'[\"ItemTroutCooked\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemSilverBar10oz\",1]',0,630,'trade_items');
INSERT INTO `traders_data` VALUES(6377,'[\"ItemSeaBassCooked\",1]',20,'[3,\"ItemGoldBar\",1]','[2,\"ItemSilverBar10oz\",1]',0,630,'trade_items');
INSERT INTO `traders_data` VALUES(6378,'[\"ItemTunaCooked\",1]',20,'[4,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,630,'trade_items');
INSERT INTO `traders_data` VALUES(6379,'[\"Skin_Rocker2_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,631,'trade_items');
INSERT INTO `traders_data` VALUES(6380,'[\"Skin_SurvivorW2_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,631,'trade_items');
INSERT INTO `traders_data` VALUES(6381,'[\"Skin_Functionary1_EP1_DZ\",1]',24,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,631,'trade_items');
INSERT INTO `traders_data` VALUES(6382,'[\"Skin_Haris_Press_EP1_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,631,'trade_items');
INSERT INTO `traders_data` VALUES(6383,'[\"Skin_Priest_DZ\",1]',24,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,631,'trade_items');
INSERT INTO `traders_data` VALUES(6384,'[\"Skin_SurvivorWpink_DZ\",1]',25,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,631,'trade_items');
INSERT INTO `traders_data` VALUES(6385,'[\"Skin_SurvivorWurban_DZ\",1]',25,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,631,'trade_items');
INSERT INTO `traders_data` VALUES(6386,'[\"Skin_SurvivorWcombat_DZ\",1]',21,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,631,'trade_items');
INSERT INTO `traders_data` VALUES(6387,'[\"Skin_SurvivorWdesert_DZ\",1]',21,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,631,'trade_items');
INSERT INTO `traders_data` VALUES(6388,'[\"Skin_Survivor2_DZ\",1]',29,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,631,'trade_items');
INSERT INTO `traders_data` VALUES(6389,'[\"Skin_Rocker1_DZ\",1]',21,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,631,'trade_items');
INSERT INTO `traders_data` VALUES(6390,'[\"Skin_Rocker3_DZ\",1]',25,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,631,'trade_items');
INSERT INTO `traders_data` VALUES(6391,'[\"Skin_RU_Policeman_DZ\",1]',21,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,631,'trade_items');
INSERT INTO `traders_data` VALUES(6392,'[\"Skin_Pilot_EP1_DZ\",1]',23,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,631,'trade_items');
INSERT INTO `traders_data` VALUES(6393,'[\"Skin_Rocker4_DZ\",1]',25,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,631,'trade_items');
INSERT INTO `traders_data` VALUES(6394,'[\"DZ_Patrol_Pack_EP1\",2]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,632,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6395,'[\"CZ_VestPouch_EP1\",2]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,632,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6396,'[\"DZ_ALICE_Pack_EP1\",2]',21,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,632,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6397,'[\"DZ_Assault_Pack_EP1\",2]',20,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,632,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6398,'[\"DZ_Backpack_EP1\",2]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,632,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6399,'[\"DZ_British_ACU\",2]',22,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,632,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6400,'[\"DZ_CivilBackpack_EP1\",2]',20,'[6,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,632,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6401,'[\"DZ_Czech_Vest_Puch\",2]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,632,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6402,'[\"DZ_TK_Assault_Pack_EP1\",2]',20,'[6,\"ItemSilverBar10oz\",1]','[3,\"ItemSilverBar10oz\",1]',0,632,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6403,'[\"DZ_TerminalPack_EP1\",2]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,632,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6404,'[\"DZ_GunBag_EP1\",2]',20,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,632,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6405,'[\"ItemSodaCoke\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,633,'trade_items');
INSERT INTO `traders_data` VALUES(6406,'[\"ItemSodaPepsi\",1]',24,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,633,'trade_items');
INSERT INTO `traders_data` VALUES(6407,'[\"ItemSodaMdew\",1]',28,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,633,'trade_items');
INSERT INTO `traders_data` VALUES(6408,'[\"ItemSodaR4z0r\",1]',20,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,633,'trade_items');
INSERT INTO `traders_data` VALUES(6409,'[\"ItemWaterbottleUnfilled\",1]',23,'[3,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,633,'trade_items');
INSERT INTO `traders_data` VALUES(6410,'[\"ItemSodaRbull\",1]',35,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,633,'trade_items');
INSERT INTO `traders_data` VALUES(6411,'[\"ItemSodaOrangeSherbet\",1]',60,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,633,'trade_items');
INSERT INTO `traders_data` VALUES(6412,'[\"FoodbaconCooked\",1]',23,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,634,'trade_items');
INSERT INTO `traders_data` VALUES(6413,'[\"FoodbeefCooked\",1]',20,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,634,'trade_items');
INSERT INTO `traders_data` VALUES(6414,'[\"FoodchickenCooked\",1]',20,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,634,'trade_items');
INSERT INTO `traders_data` VALUES(6415,'[\"FoodmuttonCooked\",1]',20,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,634,'trade_items');
INSERT INTO `traders_data` VALUES(6416,'[\"FoodrabbitCooked\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,634,'trade_items');
INSERT INTO `traders_data` VALUES(6417,'[\"ItemTroutCooked\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemSilverBar10oz\",1]',0,634,'trade_items');
INSERT INTO `traders_data` VALUES(6418,'[\"ItemSeaBassCooked\",1]',20,'[3,\"ItemGoldBar\",1]','[2,\"ItemSilverBar10oz\",1]',0,634,'trade_items');
INSERT INTO `traders_data` VALUES(6419,'[\"ItemTunaCooked\",1]',20,'[4,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,634,'trade_items');
INSERT INTO `traders_data` VALUES(6420,'[\"FoodCanBakedBeans\",1]',22,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,635,'trade_items');
INSERT INTO `traders_data` VALUES(6421,'[\"FoodCanFrankBeans\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,635,'trade_items');
INSERT INTO `traders_data` VALUES(6422,'[\"FoodCanPasta\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,635,'trade_items');
INSERT INTO `traders_data` VALUES(6423,'[\"FoodCanSardines\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,635,'trade_items');
INSERT INTO `traders_data` VALUES(6424,'[\"FoodMRE\",1]',20,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,635,'trade_items');
INSERT INTO `traders_data` VALUES(6425,'[\"FoodPistachio\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,635,'trade_items');
INSERT INTO `traders_data` VALUES(6426,'[\"FoodNutmix\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,635,'trade_items');
INSERT INTO `traders_data` VALUES(6427,'[\"bulk_ItemSandbag\",1]',20,'[2,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,555,'trade_items');
INSERT INTO `traders_data` VALUES(6429,'[\"bulk_15Rnd_9x19_M9SD\",1]',20,'[2,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,636,'trade_items');
INSERT INTO `traders_data` VALUES(6430,'[\"bulk_17Rnd_9x19_glock17\",1]',20,'[2,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,636,'trade_items');
INSERT INTO `traders_data` VALUES(6431,'[\"bulk_30Rnd_556x45_StanagSD\",1]',20,'[2,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,636,'trade_items');
INSERT INTO `traders_data` VALUES(6432,'[\"bulk_30Rnd_9x19_MP5SD\",1]',20,'[2,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,636,'trade_items');
INSERT INTO `traders_data` VALUES(6433,'[\"bulk_ItemSandbag\",1]',20,'[2,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,636,'trade_items');
INSERT INTO `traders_data` VALUES(6434,'[\"Skin_Soldier_Bodyguard_AA12_PMC_DZ\",1]',22,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,476,'trade_items');
INSERT INTO `traders_data` VALUES(6435,'[\"Skin_Camo1_DZ\",1]',22,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,476,'trade_items');
INSERT INTO `traders_data` VALUES(6436,'[\"Skin_Rocket_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,476,'trade_items');
INSERT INTO `traders_data` VALUES(6437,'[\"Skin_Sniper1_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,476,'trade_items');
INSERT INTO `traders_data` VALUES(6438,'[\"Skin_Soldier1_DZ\",1]',24,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,476,'trade_items');
INSERT INTO `traders_data` VALUES(6439,'[\"Skin_Soldier_TL_PMC_DZ\",1]',21,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,476,'trade_items');
INSERT INTO `traders_data` VALUES(6440,'[\"Skin_Bandit1_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,575,'trade_items');
INSERT INTO `traders_data` VALUES(6441,'[\"Skin_Bandit2_DZ\",1]',23,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,575,'trade_items');
INSERT INTO `traders_data` VALUES(6442,'[\"Skin_GUE_Commander_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,575,'trade_items');
INSERT INTO `traders_data` VALUES(6443,'[\"Skin_GUE_Soldier_2_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,575,'trade_items');
INSERT INTO `traders_data` VALUES(6444,'[\"Skin_GUE_Soldier_CO_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,575,'trade_items');
INSERT INTO `traders_data` VALUES(6445,'[\"Skin_GUE_Soldier_Crew_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,575,'trade_items');
INSERT INTO `traders_data` VALUES(6446,'[\"Skin_GUE_Soldier_Sniper_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,575,'trade_items');
INSERT INTO `traders_data` VALUES(6447,'[\"Skin_Ins_Soldier_GL_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,575,'trade_items');
INSERT INTO `traders_data` VALUES(6448,'[\"Skin_TK_INS_Soldier_EP1_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,575,'trade_items');
INSERT INTO `traders_data` VALUES(6449,'[\"Skin_TK_INS_Warlord_EP1_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,575,'trade_items');
INSERT INTO `traders_data` VALUES(6450,'[\"Skin_BanditW1_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,575,'trade_items');
INSERT INTO `traders_data` VALUES(6451,'[\"Skin_BanditW2_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,575,'trade_items');
INSERT INTO `traders_data` VALUES(6452,'[\"G36A_camo\",3]',21,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,637,'trade_weapons');
INSERT INTO `traders_data` VALUES(6453,'[\"G36C\",3]',20,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,637,'trade_weapons');
INSERT INTO `traders_data` VALUES(6454,'[\"G36C_camo\",3]',20,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,637,'trade_weapons');
INSERT INTO `traders_data` VALUES(6455,'[\"G36K_camo\",3]',20,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,637,'trade_weapons');
INSERT INTO `traders_data` VALUES(6456,'[\"M16A2\",3]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,637,'trade_weapons');
INSERT INTO `traders_data` VALUES(6457,'[\"M16A2GL\",3]',20,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,637,'trade_weapons');
INSERT INTO `traders_data` VALUES(6458,'[\"M16A4_ACG\",3]',20,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,637,'trade_weapons');
INSERT INTO `traders_data` VALUES(6459,'[\"M4A1\",3]',20,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,637,'trade_weapons');
INSERT INTO `traders_data` VALUES(6460,'[\"M4A1_HWS_GL_camo\",3]',21,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,637,'trade_weapons');
INSERT INTO `traders_data` VALUES(6461,'[\"M4A3_CCO_EP1\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,637,'trade_weapons');
INSERT INTO `traders_data` VALUES(6462,'[\"M4A1_Aim\",3]',21,'[6,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,637,'trade_weapons');
INSERT INTO `traders_data` VALUES(6463,'[\"Sa58P_EP1\",3]',21,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,637,'trade_weapons');
INSERT INTO `traders_data` VALUES(6464,'[\"Sa58V_CCO_EP1\",3]',22,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,637,'trade_weapons');
INSERT INTO `traders_data` VALUES(6465,'[\"Sa58V_EP1\",3]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,637,'trade_weapons');
INSERT INTO `traders_data` VALUES(6466,'[\"Sa58V_RCO_EP1\",3]',21,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,637,'trade_weapons');
INSERT INTO `traders_data` VALUES(6467,'[\"AKS_74_kobra\",3]',21,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,637,'trade_weapons');
INSERT INTO `traders_data` VALUES(6468,'[\"AKS_74_U\",3]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,637,'trade_weapons');
INSERT INTO `traders_data` VALUES(6469,'[\"AK_47_M\",3]',21,'[8,\"ItemGoldBar\",1]','[6,\"ItemGoldBar\",1]',0,637,'trade_weapons');
INSERT INTO `traders_data` VALUES(6470,'[\"AK_74\",3]',21,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,637,'trade_weapons');
INSERT INTO `traders_data` VALUES(6471,'[\"FN_FAL\",3]',22,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,637,'trade_weapons');
INSERT INTO `traders_data` VALUES(6472,'[\"M249_EP1_DZ\",3]',21,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,638,'trade_weapons');
INSERT INTO `traders_data` VALUES(6473,'[\"M240_DZ\",3]',27,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,638,'trade_weapons');
INSERT INTO `traders_data` VALUES(6474,'[\"Mk_48_DZ\",3]',20,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,638,'trade_weapons');
INSERT INTO `traders_data` VALUES(6475,'[\"Pecheneg_DZ\",3]',28,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,638,'trade_weapons');
INSERT INTO `traders_data` VALUES(6483,'[\"SVD_CAMO\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,640,'trade_weapons');
INSERT INTO `traders_data` VALUES(6484,'[\"M40A3\",3]',21,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,640,'trade_weapons');
INSERT INTO `traders_data` VALUES(6485,'[\"M14_EP1\",3]',21,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,640,'trade_weapons');
INSERT INTO `traders_data` VALUES(6486,'[\"huntingrifle\",3]',26,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,640,'trade_weapons');
INSERT INTO `traders_data` VALUES(6487,'[\"M4SPR\",3]',27,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,640,'trade_weapons');
INSERT INTO `traders_data` VALUES(6488,'[\"SVD\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,640,'trade_weapons');
INSERT INTO `traders_data` VALUES(6489,'[\"SVD_des_EP1\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,640,'trade_weapons');
INSERT INTO `traders_data` VALUES(6490,'[\"M24\",3]',21,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,640,'trade_weapons');
INSERT INTO `traders_data` VALUES(6491,'[\"M24_des_EP1\",3]',21,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,640,'trade_weapons');
INSERT INTO `traders_data` VALUES(6492,'[\"Winchester1866\",3]',32,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,641,'trade_weapons');
INSERT INTO `traders_data` VALUES(6493,'[\"MR43\",3]',22,'[1,\"ItemSilverBar10oz\",1]','[8,\"ItemSilverBar\",1]',0,641,'trade_weapons');
INSERT INTO `traders_data` VALUES(6494,'[\"Crossbow_DZ\",3]',21,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,641,'trade_weapons');
INSERT INTO `traders_data` VALUES(6495,'[\"M1014\",3]',21,'[3,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,641,'trade_weapons');
INSERT INTO `traders_data` VALUES(6496,'[\"Remington870_lamp\",3]',21,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,641,'trade_weapons');
INSERT INTO `traders_data` VALUES(6497,'[\"LeeEnfield\",3]',26,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,641,'trade_weapons');
INSERT INTO `traders_data` VALUES(6498,'[\"bizon_silenced\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,642,'trade_weapons');
INSERT INTO `traders_data` VALUES(6499,'[\"UZI_EP1\",3]',21,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,642,'trade_weapons');
INSERT INTO `traders_data` VALUES(6500,'[\"Sa61_EP1\",3]',20,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,642,'trade_weapons');
INSERT INTO `traders_data` VALUES(6501,'[\"MP5A5\",3]',22,'[1,\"ItemGoldBar\",1]','[2,\"ItemSilverBar10oz\",1]',0,642,'trade_weapons');
INSERT INTO `traders_data` VALUES(6502,'[\"UZI_SD_EP1\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,642,'trade_weapons');
INSERT INTO `traders_data` VALUES(6503,'[\"MP5SD\",3]',20,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,642,'trade_weapons');
INSERT INTO `traders_data` VALUES(6505,'[\"30Rnd_556x45_Stanag\",1]',21,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,643,'trade_items');
INSERT INTO `traders_data` VALUES(6506,'[\"20Rnd_762x51_FNFAL\",1]',20,'[4,\"ItemSilverBar10oz\",1]','[2,\"ItemSilverBar10oz\",1]',0,643,'trade_items');
INSERT INTO `traders_data` VALUES(6507,'[\"30Rnd_545x39_AK\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,643,'trade_items');
INSERT INTO `traders_data` VALUES(6508,'[\"30Rnd_762x39_AK47\",1]',29,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,643,'trade_items');
INSERT INTO `traders_data` VALUES(6509,'[\"100Rnd_762x51_M240\",1]',53,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,644,'trade_items');
INSERT INTO `traders_data` VALUES(6510,'[\"200Rnd_556x45_M249\",1]',28,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,644,'trade_items');
INSERT INTO `traders_data` VALUES(6511,'[\"100Rnd_762x54_PK\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,644,'trade_items');
INSERT INTO `traders_data` VALUES(6520,'[\"15Rnd_9x19_M9\",1]',20,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,646,'trade_items');
INSERT INTO `traders_data` VALUES(6521,'[\"15Rnd_9x19_M9SD\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,646,'trade_items');
INSERT INTO `traders_data` VALUES(6522,'[\"17Rnd_9x19_glock17\",1]',25,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,646,'trade_items');
INSERT INTO `traders_data` VALUES(6523,'[\"6Rnd_45ACP\",1]',38,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,646,'trade_items');
INSERT INTO `traders_data` VALUES(6524,'[\"7Rnd_45ACP_1911\",1]',44,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,646,'trade_items');
INSERT INTO `traders_data` VALUES(6525,'[\"8Rnd_9x18_Makarov\",1]',58,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,646,'trade_items');
INSERT INTO `traders_data` VALUES(6526,'[\"8Rnd_9x18_MakarovSD\",1]',21,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,646,'trade_items');
INSERT INTO `traders_data` VALUES(6527,'[\"20Rnd_762x51_DMR\",1]',27,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,647,'trade_items');
INSERT INTO `traders_data` VALUES(6528,'[\"10Rnd_762x54_SVD\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,647,'trade_items');
INSERT INTO `traders_data` VALUES(6530,'[\"5Rnd_762x51_M24\",1]',24,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,647,'trade_items');
INSERT INTO `traders_data` VALUES(6531,'[\"5x_22_LR_17_HMR\",1]',75,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,647,'trade_items');
INSERT INTO `traders_data` VALUES(6532,'[\"30rnd_9x19_MP5\",1]',61,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,648,'trade_items');
INSERT INTO `traders_data` VALUES(6533,'[\"30Rnd_9x19_MP5SD\",1]',21,'[4,\"ItemSilverBar10oz\",1]','[2,\"ItemSilverBar10oz\",1]',0,648,'trade_items');
INSERT INTO `traders_data` VALUES(6534,'[\"30Rnd_9x19_UZI\",1]',23,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,648,'trade_items');
INSERT INTO `traders_data` VALUES(6535,'[\"64Rnd_9x19_SD_Bizon\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,648,'trade_items');
INSERT INTO `traders_data` VALUES(6536,'[\"30Rnd_9x19_UZI_SD\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,648,'trade_items');
INSERT INTO `traders_data` VALUES(6537,'[\"20Rnd_B_765x17_Ball\",1]',21,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,648,'trade_items');
INSERT INTO `traders_data` VALUES(6538,'[\"15Rnd_W1866_Slug\",1]',46,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,649,'trade_items');
INSERT INTO `traders_data` VALUES(6539,'[\"2Rnd_shotgun_74Pellets\",1]',44,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,649,'trade_items');
INSERT INTO `traders_data` VALUES(6540,'[\"2Rnd_shotgun_74Slug\",1]',50,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,649,'trade_items');
INSERT INTO `traders_data` VALUES(6541,'[\"8Rnd_B_Beneli_74Slug\",1]',24,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,649,'trade_items');
INSERT INTO `traders_data` VALUES(6542,'[\"8Rnd_B_Beneli_Pellets\",1]',23,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,649,'trade_items');
INSERT INTO `traders_data` VALUES(6543,'[\"WoodenArrow\",1]',37,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,649,'trade_items');
INSERT INTO `traders_data` VALUES(6544,'[\"Quiver\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,649,'trade_items');
INSERT INTO `traders_data` VALUES(6545,'[\"10x_303\",1]',48,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,649,'trade_items');
INSERT INTO `traders_data` VALUES(6546,'[\"MMT_Civ\",2]',20,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,650,'trade_any_bicycle');
INSERT INTO `traders_data` VALUES(6547,'[\"Old_bike_TK_INS_EP1\",2]',20,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,650,'trade_any_bicycle');
INSERT INTO `traders_data` VALUES(6548,'[\"TT650_Civ\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,650,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6549,'[\"TT650_Ins\",2]',11,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,650,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6550,'[\"TT650_TK_CIV_EP1\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,650,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6551,'[\"ATV_CZ_EP1\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,650,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6552,'[\"ATV_US_EP1\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,650,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6553,'[\"M1030_US_DES_EP1\",2]',11,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,650,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6554,'[\"Old_moto_TK_Civ_EP1\",2]',11,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,650,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6555,'[\"Ikarus\",2]',11,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,651,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6556,'[\"Ikarus_TK_CIV_EP1\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,651,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6557,'[\"S1203_TK_CIV_EP1\",2]',12,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,651,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6558,'[\"S1203_ambulance_EP1\",2]',10,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,651,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6588,'[\"VWGolf\",2]',10,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,652,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6589,'[\"Ural_CDF\",2]',13,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,653,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6590,'[\"Ural_TK_CIV_EP1\",2]',13,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,653,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6591,'[\"Ural_UN_EP1\",2]',13,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,653,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6592,'[\"V3S_Open_TK_CIV_EP1\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,653,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6593,'[\"V3S_Open_TK_EP1\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,653,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6594,'[\"Kamaz\",2]',12,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,653,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6595,'[\"MTVR_DES_EP1\",2]',12,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,653,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6622,'[\"KamazRefuel_DZ\",2]',17,'[7,\"ItemGoldBar10oz\",1]','[3,\"ItemGoldBar10oz\",1]',0,655,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6623,'[\"MtvrRefuel_DES_EP1_DZ\",2]',15,'[7,\"ItemGoldBar10oz\",1]','[3,\"ItemGoldBar10oz\",1]',0,655,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6624,'[\"UralRefuel_TK_EP1_DZ\",2]',14,'[7,\"ItemGoldBar10oz\",1]','[3,\"ItemGoldBar10oz\",1]',0,655,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6625,'[\"V3S_Refuel_TK_GUE_EP1_DZ\",2]',16,'[7,\"ItemGoldBar10oz\",1]','[3,\"ItemGoldBar10oz\",1]',0,655,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6638,'[\"HMMWV_M1035_DES_EP1\",2]',11,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,658,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6639,'[\"HMMWV_Ambulance\",2]',13,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,658,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6640,'[\"HMMWV_Ambulance_CZ_DES_EP1\",2]',11,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,658,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6641,'[\"HMMWV_DES_EP1\",2]',12,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,658,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6642,'[\"GAZ_Vodnik_MedEvac\",2]',12,'[1,\"ItemBriefcase100oz\",1]','[5,\"ItemGoldBar10oz\",1]',0,658,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6643,'[\"HMMWV_DZ\",2]',14,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,658,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6644,'[\"hilux1_civil_3_open_EP1\",2]',11,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,659,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6645,'[\"datsun1_civil_3_open\",2]',10,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,659,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6646,'[\"hilux1_civil_1_open\",2]',11,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,659,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6647,'[\"datsun1_civil_2_covered\",2]',10,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,659,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6648,'[\"datsun1_civil_1_open\",2]',11,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,659,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6649,'[\"hilux1_civil_2_covered\",2]',14,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,659,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6653,'[\"Skoda\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,660,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6654,'[\"SkodaBlue\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,660,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6655,'[\"SkodaGreen\",2]',11,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,660,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6656,'[\"SkodaRed\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,660,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6657,'[\"VolhaLimo_TK_CIV_EP1\",2]',25,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,660,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6658,'[\"Volha_1_TK_CIV_EP1\",2]',11,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,660,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6659,'[\"Volha_2_TK_CIV_EP1\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,660,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6660,'[\"VWGolf\",2]',10,'[3,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,660,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6661,'[\"car_hatchback\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,660,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6662,'[\"car_sedan\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,660,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6663,'[\"GLT_M300_LT\",2]',11,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,660,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6664,'[\"GLT_M300_ST\",2]',25,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,660,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6665,'[\"Lada1\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,660,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6666,'[\"Lada1_TK_CIV_EP1\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,660,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6667,'[\"Lada2\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,660,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6668,'[\"Lada2_TK_CIV_EP1\",2]',10,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,660,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6669,'[\"LadaLM\",2]',10,'[3,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,660,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6670,'[\"SUV_TK_CIV_EP1\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,661,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6671,'[\"SUV_Blue\",2]',11,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,661,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6672,'[\"SUV_Charcoal\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,661,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6673,'[\"SUV_Green\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,661,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6674,'[\"SUV_Orange\",2]',11,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,661,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6675,'[\"SUV_Pink\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,661,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6676,'[\"SUV_Red\",2]',11,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,661,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6677,'[\"SUV_Silver\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,661,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6678,'[\"SUV_White\",2]',12,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,661,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6679,'[\"SUV_Yellow\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,661,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6680,'[\"SUV_Camo\",2]',15,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,661,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6681,'[\"UAZ_CDF\",2]',10,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,661,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6682,'[\"UAZ_INS\",2]',12,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,661,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6683,'[\"UAZ_RU\",2]',11,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,661,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6684,'[\"UAZ_Unarmed_TK_CIV_EP1\",2]',10,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,661,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6685,'[\"UAZ_Unarmed_TK_EP1\",2]',11,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,661,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6686,'[\"UAZ_Unarmed_UN_EP1\",2]',11,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,661,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(6687,'[\"ItemSandbag\",1]',25,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,662,'trade_items');
INSERT INTO `traders_data` VALUES(6688,'[\"ItemTankTrap\",1]',21,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,662,'trade_items');
INSERT INTO `traders_data` VALUES(6689,'[\"ItemTentOld\",1]',25,'[4,\"ItemSilverBar10oz\",1]','[2,\"ItemSilverBar10oz\",1]',0,662,'trade_items');
INSERT INTO `traders_data` VALUES(6690,'[\"ItemWire\",1]',21,'[6,\"ItemSilverBar\",1]','[3,\"ItemSilverBar\",1]',0,662,'trade_items');
INSERT INTO `traders_data` VALUES(6691,'[\"30m_plot_kit\",1]',20,'[6,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar10oz\",1]',0,662,'trade_items');
INSERT INTO `traders_data` VALUES(6695,'[\"ItemCompass\",3]',20,'[6,\"ItemSilverBar\",1]','[3,\"ItemSilverBar\",1]',0,663,'trade_weapons');
INSERT INTO `traders_data` VALUES(6696,'[\"Binocular\",3]',21,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,663,'trade_weapons');
INSERT INTO `traders_data` VALUES(6697,'[\"Binocular_Vector\",3]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,663,'trade_weapons');
INSERT INTO `traders_data` VALUES(6698,'[\"ItemEtool\",3]',22,'[9,\"ItemSilverBar10oz\",1]','[6,\"ItemSilverBar10oz\",1]',0,663,'trade_weapons');
INSERT INTO `traders_data` VALUES(6699,'[\"ItemFlashlight\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,663,'trade_weapons');
INSERT INTO `traders_data` VALUES(6700,'[\"ItemFlashlightRed\",3]',20,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,663,'trade_weapons');
INSERT INTO `traders_data` VALUES(6701,'[\"ItemGPS\",3]',21,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,663,'trade_weapons');
INSERT INTO `traders_data` VALUES(6702,'[\"ItemHatchet_DZE\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,663,'trade_weapons');
INSERT INTO `traders_data` VALUES(6703,'[\"ItemKnife\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,663,'trade_weapons');
INSERT INTO `traders_data` VALUES(6704,'[\"ItemMap\",3]',20,'[6,\"ItemSilverBar\",1]','[3,\"ItemSilverBar\",1]',0,663,'trade_weapons');
INSERT INTO `traders_data` VALUES(6705,'[\"ItemMatchbox_DZE\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,663,'trade_weapons');
INSERT INTO `traders_data` VALUES(6706,'[\"ItemToolbox\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,663,'trade_weapons');
INSERT INTO `traders_data` VALUES(6707,'[\"ItemWatch\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,663,'trade_weapons');
INSERT INTO `traders_data` VALUES(6708,'[\"NVGoggles\",3]',22,'[4,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,663,'trade_weapons');
INSERT INTO `traders_data` VALUES(6709,'[\"ItemJerrycan\",1]',26,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,664,'trade_items');
INSERT INTO `traders_data` VALUES(6710,'[\"ItemJerrycanEmpty\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,664,'trade_items');
INSERT INTO `traders_data` VALUES(6711,'[\"PartEngine\",1]',20,'[5,\"ItemGoldBar\",1]','[1,\"ItemSilverBar10oz\",1]',0,664,'trade_items');
INSERT INTO `traders_data` VALUES(6712,'[\"PartVRotor\",1]',23,'[5,\"ItemGoldBar\",1]','[1,\"ItemSilverBar10oz\",1]',0,664,'trade_items');
INSERT INTO `traders_data` VALUES(6713,'[\"PartWheel\",1]',20,'[2,\"ItemGoldBar\",1]','[2,\"ItemSilverBar\",1]',0,664,'trade_items');
INSERT INTO `traders_data` VALUES(6714,'[\"PartGlass\",1]',25,'[1,\"ItemGoldBar\",1]','[1,\"ItemSilverBar\",1]',0,664,'trade_items');
INSERT INTO `traders_data` VALUES(6715,'[\"PartGeneric\",1]',20,'[2,\"ItemGoldBar\",1]','[6,\"ItemSilverBar\",1]',0,664,'trade_items');
INSERT INTO `traders_data` VALUES(6716,'[\"ItemAntibiotic\",1]',23,'[1,\"ItemGoldBar\",1]','[2,\"ItemSilverBar10oz\",1]',0,665,'trade_items');
INSERT INTO `traders_data` VALUES(6717,'[\"ItemBandage\",1]',41,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,665,'trade_items');
INSERT INTO `traders_data` VALUES(6718,'[\"ItemBloodbag\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,665,'trade_items');
INSERT INTO `traders_data` VALUES(6719,'[\"ItemEpinephrine\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,665,'trade_items');
INSERT INTO `traders_data` VALUES(6720,'[\"ItemHeatPack\",1]',30,'[1,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,665,'trade_items');
INSERT INTO `traders_data` VALUES(6721,'[\"ItemMorphine\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,665,'trade_items');
INSERT INTO `traders_data` VALUES(6722,'[\"ItemPainkiller\",1]',20,'[1,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,665,'trade_items');
INSERT INTO `traders_data` VALUES(6723,'[\"HandChemBlue\",1]',35,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,666,'trade_items');
INSERT INTO `traders_data` VALUES(6724,'[\"HandChemGreen\",1]',28,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,666,'trade_items');
INSERT INTO `traders_data` VALUES(6725,'[\"HandChemRed\",1]',34,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,666,'trade_items');
INSERT INTO `traders_data` VALUES(6726,'[\"FlareGreen_M203\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,666,'trade_items');
INSERT INTO `traders_data` VALUES(6727,'[\"FlareWhite_M203\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,666,'trade_items');
INSERT INTO `traders_data` VALUES(6728,'[\"HandRoadFlare\",1]',65,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,666,'trade_items');
INSERT INTO `traders_data` VALUES(6736,'[\"SmokeShell\",1]',24,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,668,'trade_items');
INSERT INTO `traders_data` VALUES(6737,'[\"SmokeShellGreen\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,668,'trade_items');
INSERT INTO `traders_data` VALUES(6738,'[\"SmokeShellRed\",1]',21,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,668,'trade_items');
INSERT INTO `traders_data` VALUES(6739,'[\"HandChemBlue\",1]',24,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,669,'trade_items');
INSERT INTO `traders_data` VALUES(6740,'[\"HandChemGreen\",1]',22,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,669,'trade_items');
INSERT INTO `traders_data` VALUES(6741,'[\"HandChemRed\",1]',25,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,669,'trade_items');
INSERT INTO `traders_data` VALUES(6742,'[\"FlareGreen_M203\",1]',22,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,669,'trade_items');
INSERT INTO `traders_data` VALUES(6743,'[\"FlareWhite_M203\",1]',21,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,669,'trade_items');
INSERT INTO `traders_data` VALUES(6744,'[\"HandRoadFlare\",1]',23,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,669,'trade_items');
INSERT INTO `traders_data` VALUES(6745,'[\"ItemAntibiotic\",1]',20,'[1,\"ItemGoldBar\",1]','[2,\"ItemSilverBar10oz\",1]',0,670,'trade_items');
INSERT INTO `traders_data` VALUES(6746,'[\"ItemBandage\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,670,'trade_items');
INSERT INTO `traders_data` VALUES(6747,'[\"ItemBloodbag\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,670,'trade_items');
INSERT INTO `traders_data` VALUES(6748,'[\"ItemEpinephrine\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,670,'trade_items');
INSERT INTO `traders_data` VALUES(6749,'[\"ItemHeatPack\",1]',20,'[1,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,670,'trade_items');
INSERT INTO `traders_data` VALUES(6750,'[\"ItemMorphine\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,670,'trade_items');
INSERT INTO `traders_data` VALUES(6751,'[\"ItemPainkiller\",1]',20,'[1,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,670,'trade_items');
INSERT INTO `traders_data` VALUES(6752,'[\"SmokeShell\",1]',28,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,671,'trade_items');
INSERT INTO `traders_data` VALUES(6753,'[\"SmokeShellGreen\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,671,'trade_items');
INSERT INTO `traders_data` VALUES(6754,'[\"SmokeShellRed\",1]',27,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,671,'trade_items');
INSERT INTO `traders_data` VALUES(6755,'[\"Smallboat_1\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,672,'trade_any_boat');
INSERT INTO `traders_data` VALUES(6756,'[\"Smallboat_2\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,672,'trade_any_boat');
INSERT INTO `traders_data` VALUES(6757,'[\"Zodiac\",2]',10,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,672,'trade_any_boat');
INSERT INTO `traders_data` VALUES(6758,'[\"Fishing_Boat\",2]',10,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,672,'trade_any_boat');
INSERT INTO `traders_data` VALUES(6759,'[\"PBX\",2]',10,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,672,'trade_any_boat');
INSERT INTO `traders_data` VALUES(6760,'[\"RHIB\",2]',11,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,673,'trade_any_boat');
INSERT INTO `traders_data` VALUES(6761,'[\"M9SD\",3]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,674,'trade_weapons');
INSERT INTO `traders_data` VALUES(6762,'[\"glock17_EP1\",3]',20,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,674,'trade_weapons');
INSERT INTO `traders_data` VALUES(6763,'[\"Colt1911\",3]',26,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,674,'trade_weapons');
INSERT INTO `traders_data` VALUES(6764,'[\"M9\",3]',20,'[1,\"ItemGoldBar\",1]','[2,\"ItemSilverBar10oz\",1]',0,674,'trade_weapons');
INSERT INTO `traders_data` VALUES(6765,'[\"MakarovSD\",3]',21,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,674,'trade_weapons');
INSERT INTO `traders_data` VALUES(6766,'[\"revolver_gold_EP1\",3]',20,'[3,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,674,'trade_weapons');
INSERT INTO `traders_data` VALUES(6767,'[\"Makarov\",3]',24,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,674,'trade_weapons');
INSERT INTO `traders_data` VALUES(6768,'[\"revolver_EP1\",3]',21,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,674,'trade_weapons');
INSERT INTO `traders_data` VALUES(6777,'[\"bulk_15Rnd_9x19_M9SD\",1]',20,'[2,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,675,'trade_items');
INSERT INTO `traders_data` VALUES(6778,'[\"bulk_17Rnd_9x19_glock17\",1]',20,'[2,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,675,'trade_items');
INSERT INTO `traders_data` VALUES(6779,'[\"bulk_30Rnd_556x45_StanagSD\",1]',20,'[2,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,675,'trade_items');
INSERT INTO `traders_data` VALUES(6780,'[\"bulk_30Rnd_9x19_MP5SD\",1]',20,'[2,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,675,'trade_items');
INSERT INTO `traders_data` VALUES(6781,'[\"bulk_ItemSandbag\",1]',20,'[2,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,675,'trade_items');
INSERT INTO `traders_data` VALUES(6790,'[\"ItemJerrycan\",1]',20,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,677,'trade_items');
INSERT INTO `traders_data` VALUES(6791,'[\"ItemJerrycanEmpty\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,677,'trade_items');
INSERT INTO `traders_data` VALUES(6792,'[\"PartEngine\",1]',20,'[5,\"ItemGoldBar\",1]','[1,\"ItemSilverBar10oz\",1]',0,677,'trade_items');
INSERT INTO `traders_data` VALUES(6793,'[\"PartVRotor\",1]',20,'[5,\"ItemGoldBar\",1]','[1,\"ItemSilverBar10oz\",1]',0,677,'trade_items');
INSERT INTO `traders_data` VALUES(6794,'[\"PartWheel\",1]',20,'[2,\"ItemGoldBar\",1]','[2,\"ItemSilverBar\",1]',0,677,'trade_items');
INSERT INTO `traders_data` VALUES(6795,'[\"PartGlass\",1]',20,'[1,\"ItemGoldBar\",1]','[1,\"ItemSilverBar\",1]',0,677,'trade_items');
INSERT INTO `traders_data` VALUES(6796,'[\"PartGeneric\",1]',20,'[2,\"ItemGoldBar\",1]','[6,\"ItemSilverBar\",1]',0,677,'trade_items');
INSERT INTO `traders_data` VALUES(6797,'[\"ItemSandbag\",1]',20,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,678,'trade_items');
INSERT INTO `traders_data` VALUES(6798,'[\"ItemTankTrap\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,678,'trade_items');
INSERT INTO `traders_data` VALUES(6799,'[\"ItemTentOld\",1]',20,'[4,\"ItemSilverBar10oz\",1]','[2,\"ItemSilverBar10oz\",1]',0,678,'trade_items');
INSERT INTO `traders_data` VALUES(6800,'[\"ItemVault\",1]',20,'[1,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,678,'trade_items');
INSERT INTO `traders_data` VALUES(6801,'[\"ItemWire\",1]',20,'[6,\"ItemSilverBar\",1]','[3,\"ItemSilverBar\",1]',0,678,'trade_items');
INSERT INTO `traders_data` VALUES(6802,'[\"30m_plot_kit\",1]',20,'[6,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar10oz\",1]',0,678,'trade_items');
INSERT INTO `traders_data` VALUES(6803,'[\"ItemCorrugated\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,678,'trade_items');
INSERT INTO `traders_data` VALUES(6804,'[\"ItemPole\",1]',20,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,678,'trade_items');
INSERT INTO `traders_data` VALUES(6805,'[\"ItemCompass\",3]',20,'[6,\"ItemSilverBar\",1]','[3,\"ItemSilverBar\",1]',0,679,'trade_weapons');
INSERT INTO `traders_data` VALUES(6806,'[\"Binocular\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,679,'trade_weapons');
INSERT INTO `traders_data` VALUES(6807,'[\"Binocular_Vector\",3]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,679,'trade_weapons');
INSERT INTO `traders_data` VALUES(6808,'[\"ItemEtool\",3]',20,'[9,\"ItemSilverBar10oz\",1]','[6,\"ItemSilverBar10oz\",1]',0,679,'trade_weapons');
INSERT INTO `traders_data` VALUES(6809,'[\"ItemFlashlight\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,679,'trade_weapons');
INSERT INTO `traders_data` VALUES(6810,'[\"ItemFlashlightRed\",3]',20,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,679,'trade_weapons');
INSERT INTO `traders_data` VALUES(6811,'[\"ItemGPS\",3]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,679,'trade_weapons');
INSERT INTO `traders_data` VALUES(6812,'[\"ItemHatchet_DZE\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,679,'trade_weapons');
INSERT INTO `traders_data` VALUES(6813,'[\"ItemKnife\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,679,'trade_weapons');
INSERT INTO `traders_data` VALUES(6814,'[\"ItemMap\",3]',20,'[6,\"ItemSilverBar\",1]','[3,\"ItemSilverBar\",1]',0,679,'trade_weapons');
INSERT INTO `traders_data` VALUES(6815,'[\"ItemMatchbox_DZE\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,679,'trade_weapons');
INSERT INTO `traders_data` VALUES(6816,'[\"ItemToolbox\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,679,'trade_weapons');
INSERT INTO `traders_data` VALUES(6817,'[\"ItemWatch\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,679,'trade_weapons');
INSERT INTO `traders_data` VALUES(6818,'[\"NVGoggles\",3]',20,'[4,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,679,'trade_weapons');
INSERT INTO `traders_data` VALUES(6819,'[\"ItemSandbag\",1]',20,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,680,'trade_items');
INSERT INTO `traders_data` VALUES(6820,'[\"ItemTankTrap\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,680,'trade_items');
INSERT INTO `traders_data` VALUES(6821,'[\"ItemTentOld\",1]',20,'[4,\"ItemSilverBar10oz\",1]','[2,\"ItemSilverBar10oz\",1]',0,680,'trade_items');
INSERT INTO `traders_data` VALUES(6822,'[\"ItemVault\",1]',20,'[1,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,680,'trade_items');
INSERT INTO `traders_data` VALUES(6823,'[\"ItemWire\",1]',20,'[6,\"ItemSilverBar\",1]','[3,\"ItemSilverBar\",1]',0,680,'trade_items');
INSERT INTO `traders_data` VALUES(6824,'[\"30m_plot_kit\",1]',20,'[6,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar10oz\",1]',0,680,'trade_items');
INSERT INTO `traders_data` VALUES(6825,'[\"ItemCorrugated\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,680,'trade_items');
INSERT INTO `traders_data` VALUES(6826,'[\"ItemPole\",1]',20,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,680,'trade_items');
INSERT INTO `traders_data` VALUES(6827,'[\"ItemCompass\",3]',20,'[6,\"ItemSilverBar\",1]','[3,\"ItemSilverBar\",1]',0,681,'trade_weapons');
INSERT INTO `traders_data` VALUES(6828,'[\"Binocular\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,681,'trade_weapons');
INSERT INTO `traders_data` VALUES(6829,'[\"Binocular_Vector\",3]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,681,'trade_weapons');
INSERT INTO `traders_data` VALUES(6830,'[\"ItemEtool\",3]',20,'[9,\"ItemSilverBar10oz\",1]','[6,\"ItemSilverBar10oz\",1]',0,681,'trade_weapons');
INSERT INTO `traders_data` VALUES(6831,'[\"ItemFlashlight\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,681,'trade_weapons');
INSERT INTO `traders_data` VALUES(6832,'[\"ItemFlashlightRed\",3]',20,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,681,'trade_weapons');
INSERT INTO `traders_data` VALUES(6833,'[\"ItemGPS\",3]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,681,'trade_weapons');
INSERT INTO `traders_data` VALUES(6834,'[\"ItemHatchet_DZE\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,681,'trade_weapons');
INSERT INTO `traders_data` VALUES(6835,'[\"ItemKnife\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,681,'trade_weapons');
INSERT INTO `traders_data` VALUES(6836,'[\"ItemMap\",3]',20,'[6,\"ItemSilverBar\",1]','[3,\"ItemSilverBar\",1]',0,681,'trade_weapons');
INSERT INTO `traders_data` VALUES(6837,'[\"ItemMatchbox_DZE\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,681,'trade_weapons');
INSERT INTO `traders_data` VALUES(6838,'[\"ItemToolbox\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,681,'trade_weapons');
INSERT INTO `traders_data` VALUES(6839,'[\"ItemWatch\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,681,'trade_weapons');
INSERT INTO `traders_data` VALUES(6840,'[\"NVGoggles\",3]',20,'[4,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,681,'trade_weapons');
INSERT INTO `traders_data` VALUES(6841,'[\"ItemJerrycan\",1]',20,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,682,'trade_items');
INSERT INTO `traders_data` VALUES(6842,'[\"ItemJerrycanEmpty\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,682,'trade_items');
INSERT INTO `traders_data` VALUES(6843,'[\"PartEngine\",1]',20,'[5,\"ItemGoldBar\",1]','[1,\"ItemSilverBar10oz\",1]',0,682,'trade_items');
INSERT INTO `traders_data` VALUES(6844,'[\"PartVRotor\",1]',20,'[5,\"ItemGoldBar\",1]','[1,\"ItemSilverBar10oz\",1]',0,682,'trade_items');
INSERT INTO `traders_data` VALUES(6845,'[\"PartWheel\",1]',20,'[2,\"ItemGoldBar\",1]','[2,\"ItemSilverBar\",1]',0,682,'trade_items');
INSERT INTO `traders_data` VALUES(6846,'[\"PartGlass\",1]',20,'[1,\"ItemGoldBar\",1]','[1,\"ItemSilverBar\",1]',0,682,'trade_items');
INSERT INTO `traders_data` VALUES(6847,'[\"PartGeneric\",1]',20,'[2,\"ItemGoldBar\",1]','[6,\"ItemSilverBar\",1]',0,682,'trade_items');
INSERT INTO `traders_data` VALUES(6848,'[\"Skin_Rocker2_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,683,'trade_items');
INSERT INTO `traders_data` VALUES(6849,'[\"Skin_SurvivorW2_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,683,'trade_items');
INSERT INTO `traders_data` VALUES(6850,'[\"Skin_Functionary1_EP1_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,683,'trade_items');
INSERT INTO `traders_data` VALUES(6851,'[\"Skin_Haris_Press_EP1_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,683,'trade_items');
INSERT INTO `traders_data` VALUES(6852,'[\"Skin_Priest_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,683,'trade_items');
INSERT INTO `traders_data` VALUES(6853,'[\"Skin_SurvivorWpink_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,683,'trade_items');
INSERT INTO `traders_data` VALUES(6854,'[\"Skin_SurvivorWurban_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,683,'trade_items');
INSERT INTO `traders_data` VALUES(6855,'[\"Skin_SurvivorWcombat_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,683,'trade_items');
INSERT INTO `traders_data` VALUES(6856,'[\"Skin_SurvivorWdesert_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,683,'trade_items');
INSERT INTO `traders_data` VALUES(6857,'[\"Skin_Survivor2_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,683,'trade_items');
INSERT INTO `traders_data` VALUES(6858,'[\"Skin_Rocker1_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,683,'trade_items');
INSERT INTO `traders_data` VALUES(6859,'[\"Skin_Rocker3_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,683,'trade_items');
INSERT INTO `traders_data` VALUES(6860,'[\"Skin_RU_Policeman_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,683,'trade_items');
INSERT INTO `traders_data` VALUES(6861,'[\"Skin_Pilot_EP1_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,683,'trade_items');
INSERT INTO `traders_data` VALUES(6862,'[\"Skin_Rocker4_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,683,'trade_items');
INSERT INTO `traders_data` VALUES(6863,'[\"ItemSodaCoke\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,684,'trade_items');
INSERT INTO `traders_data` VALUES(6864,'[\"ItemSodaPepsi\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,684,'trade_items');
INSERT INTO `traders_data` VALUES(6865,'[\"ItemSodaMdew\",1]',20,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,684,'trade_items');
INSERT INTO `traders_data` VALUES(6866,'[\"ItemSodaR4z0r\",1]',20,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,684,'trade_items');
INSERT INTO `traders_data` VALUES(6867,'[\"ItemWaterbottleUnfilled\",1]',20,'[3,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,684,'trade_items');
INSERT INTO `traders_data` VALUES(6868,'[\"ItemSodaRbull\",1]',20,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,684,'trade_items');
INSERT INTO `traders_data` VALUES(6869,'[\"ItemSodaOrangeSherbet\",1]',20,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,684,'trade_items');
INSERT INTO `traders_data` VALUES(6870,'[\"DZ_Patrol_Pack_EP1\",2]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,685,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6871,'[\"CZ_VestPouch_EP1\",2]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,685,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6872,'[\"DZ_ALICE_Pack_EP1\",2]',20,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,685,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6873,'[\"DZ_Assault_Pack_EP1\",2]',20,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,685,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6874,'[\"DZ_Backpack_EP1\",2]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,685,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6875,'[\"DZ_British_ACU\",2]',20,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,685,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6876,'[\"DZ_CivilBackpack_EP1\",2]',20,'[6,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,685,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6877,'[\"DZ_Czech_Vest_Puch\",2]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,685,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6878,'[\"DZ_TK_Assault_Pack_EP1\",2]',20,'[6,\"ItemSilverBar10oz\",1]','[3,\"ItemSilverBar10oz\",1]',0,685,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6879,'[\"DZ_TerminalPack_EP1\",2]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,685,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6880,'[\"DZ_GunBag_EP1\",2]',20,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,685,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6881,'[\"FoodbaconCooked\",1]',20,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,686,'trade_items');
INSERT INTO `traders_data` VALUES(6882,'[\"FoodbeefCooked\",1]',20,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,686,'trade_items');
INSERT INTO `traders_data` VALUES(6883,'[\"FoodchickenCooked\",1]',20,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,686,'trade_items');
INSERT INTO `traders_data` VALUES(6884,'[\"FoodmuttonCooked\",1]',20,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,686,'trade_items');
INSERT INTO `traders_data` VALUES(6885,'[\"FoodrabbitCooked\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,686,'trade_items');
INSERT INTO `traders_data` VALUES(6886,'[\"ItemTroutCooked\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemSilverBar10oz\",1]',0,686,'trade_items');
INSERT INTO `traders_data` VALUES(6887,'[\"ItemSeaBassCooked\",1]',20,'[3,\"ItemGoldBar\",1]','[2,\"ItemSilverBar10oz\",1]',0,686,'trade_items');
INSERT INTO `traders_data` VALUES(6888,'[\"ItemTunaCooked\",1]',20,'[4,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,686,'trade_items');
INSERT INTO `traders_data` VALUES(6889,'[\"FoodCanBakedBeans\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,687,'trade_items');
INSERT INTO `traders_data` VALUES(6890,'[\"FoodCanFrankBeans\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,687,'trade_items');
INSERT INTO `traders_data` VALUES(6891,'[\"FoodCanPasta\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,687,'trade_items');
INSERT INTO `traders_data` VALUES(6892,'[\"FoodCanSardines\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,687,'trade_items');
INSERT INTO `traders_data` VALUES(6893,'[\"FoodMRE\",1]',20,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,687,'trade_items');
INSERT INTO `traders_data` VALUES(6894,'[\"FoodPistachio\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,687,'trade_items');
INSERT INTO `traders_data` VALUES(6895,'[\"FoodNutmix\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,687,'trade_items');
INSERT INTO `traders_data` VALUES(6896,'[\"DZ_Patrol_Pack_EP1\",2]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,688,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6897,'[\"CZ_VestPouch_EP1\",2]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,688,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6898,'[\"DZ_ALICE_Pack_EP1\",2]',20,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,688,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6899,'[\"DZ_Assault_Pack_EP1\",2]',20,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,688,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6900,'[\"DZ_Backpack_EP1\",2]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,688,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6901,'[\"DZ_British_ACU\",2]',20,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,688,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6902,'[\"DZ_CivilBackpack_EP1\",2]',20,'[6,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,688,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6903,'[\"DZ_Czech_Vest_Puch\",2]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,688,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6904,'[\"DZ_TK_Assault_Pack_EP1\",2]',20,'[6,\"ItemSilverBar10oz\",1]','[3,\"ItemSilverBar10oz\",1]',0,688,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6905,'[\"DZ_TerminalPack_EP1\",2]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,688,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6906,'[\"DZ_GunBag_EP1\",2]',20,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,688,'trade_backpacks');
INSERT INTO `traders_data` VALUES(6907,'[\"Skin_Rocker2_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,689,'trade_items');
INSERT INTO `traders_data` VALUES(6908,'[\"Skin_SurvivorW2_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,689,'trade_items');
INSERT INTO `traders_data` VALUES(6909,'[\"Skin_Functionary1_EP1_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,689,'trade_items');
INSERT INTO `traders_data` VALUES(6910,'[\"Skin_Haris_Press_EP1_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,689,'trade_items');
INSERT INTO `traders_data` VALUES(6911,'[\"Skin_Priest_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,689,'trade_items');
INSERT INTO `traders_data` VALUES(6912,'[\"Skin_SurvivorWpink_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,689,'trade_items');
INSERT INTO `traders_data` VALUES(6913,'[\"Skin_SurvivorWurban_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,689,'trade_items');
INSERT INTO `traders_data` VALUES(6914,'[\"Skin_SurvivorWcombat_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,689,'trade_items');
INSERT INTO `traders_data` VALUES(6915,'[\"Skin_SurvivorWdesert_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,689,'trade_items');
INSERT INTO `traders_data` VALUES(6916,'[\"Skin_Survivor2_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,689,'trade_items');
INSERT INTO `traders_data` VALUES(6917,'[\"Skin_Rocker1_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,689,'trade_items');
INSERT INTO `traders_data` VALUES(6918,'[\"Skin_Rocker3_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,689,'trade_items');
INSERT INTO `traders_data` VALUES(6919,'[\"Skin_RU_Policeman_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,689,'trade_items');
INSERT INTO `traders_data` VALUES(6920,'[\"Skin_Pilot_EP1_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,689,'trade_items');
INSERT INTO `traders_data` VALUES(6921,'[\"Skin_Rocker4_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,689,'trade_items');
INSERT INTO `traders_data` VALUES(6922,'[\"FoodbaconCooked\",1]',20,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,690,'trade_items');
INSERT INTO `traders_data` VALUES(6923,'[\"FoodbeefCooked\",1]',20,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,690,'trade_items');
INSERT INTO `traders_data` VALUES(6924,'[\"FoodchickenCooked\",1]',20,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,690,'trade_items');
INSERT INTO `traders_data` VALUES(6925,'[\"FoodmuttonCooked\",1]',20,'[4,\"ItemSilverBar\",1]','[2,\"ItemSilverBar\",1]',0,690,'trade_items');
INSERT INTO `traders_data` VALUES(6926,'[\"FoodrabbitCooked\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,690,'trade_items');
INSERT INTO `traders_data` VALUES(6927,'[\"ItemTroutCooked\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemSilverBar10oz\",1]',0,690,'trade_items');
INSERT INTO `traders_data` VALUES(6928,'[\"ItemSeaBassCooked\",1]',20,'[3,\"ItemGoldBar\",1]','[2,\"ItemSilverBar10oz\",1]',0,690,'trade_items');
INSERT INTO `traders_data` VALUES(6929,'[\"ItemTunaCooked\",1]',20,'[4,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,690,'trade_items');
INSERT INTO `traders_data` VALUES(6930,'[\"ItemSodaCoke\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,691,'trade_items');
INSERT INTO `traders_data` VALUES(6931,'[\"ItemSodaPepsi\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,691,'trade_items');
INSERT INTO `traders_data` VALUES(6932,'[\"ItemSodaMdew\",1]',20,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,691,'trade_items');
INSERT INTO `traders_data` VALUES(6933,'[\"ItemSodaR4z0r\",1]',20,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,691,'trade_items');
INSERT INTO `traders_data` VALUES(6934,'[\"ItemWaterbottleUnfilled\",1]',20,'[3,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,691,'trade_items');
INSERT INTO `traders_data` VALUES(6935,'[\"ItemSodaRbull\",1]',20,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,691,'trade_items');
INSERT INTO `traders_data` VALUES(6936,'[\"ItemSodaOrangeSherbet\",1]',20,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,691,'trade_items');
INSERT INTO `traders_data` VALUES(6937,'[\"FoodCanBakedBeans\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,692,'trade_items');
INSERT INTO `traders_data` VALUES(6938,'[\"FoodCanFrankBeans\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,692,'trade_items');
INSERT INTO `traders_data` VALUES(6939,'[\"FoodCanPasta\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,692,'trade_items');
INSERT INTO `traders_data` VALUES(6940,'[\"FoodCanSardines\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,692,'trade_items');
INSERT INTO `traders_data` VALUES(6941,'[\"FoodMRE\",1]',20,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,692,'trade_items');
INSERT INTO `traders_data` VALUES(6942,'[\"FoodPistachio\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,692,'trade_items');
INSERT INTO `traders_data` VALUES(6943,'[\"FoodNutmix\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,692,'trade_items');
INSERT INTO `traders_data` VALUES(6944,'[\"ItemVault\",1]',30,'[1,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,508,'trade_items');
INSERT INTO `traders_data` VALUES(6945,'[\"ItemCrowbar\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,510,'trade_weapons');
INSERT INTO `traders_data` VALUES(6946,'[\"ItemMachete\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,510,'trade_weapons');
INSERT INTO `traders_data` VALUES(6947,'[\"ItemFishingPole\",3]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,510,'trade_weapons');
INSERT INTO `traders_data` VALUES(6948,'[\"ItemTentDomed\",1]',20,'[6,\"ItemSilverBar10oz\",1]','[3,\"ItemSilverBar10oz\",1]',0,508,'trade_items');
INSERT INTO `traders_data` VALUES(6949,'[\"ItemTentDomed2\",1]',20,'[6,\"ItemSilverBar10oz\",1]','[3,\"ItemSilverBar10oz\",1]',0,508,'trade_items');
INSERT INTO `traders_data` VALUES(6950,'[\"ItemLightBulb\",1]',24,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,508,'trade_items');
INSERT INTO `traders_data` VALUES(6951,'[\"ItemGenerator\",1]',49,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,508,'trade_items');
INSERT INTO `traders_data` VALUES(6960,'[\"ItemTentDomed\",1]',21,'[6,\"ItemSilverBar10oz\",1]','[3,\"ItemSilverBar10oz\",1]',0,530,'trade_items');
INSERT INTO `traders_data` VALUES(6961,'[\"ItemTentDomed2\",1]',20,'[6,\"ItemSilverBar10oz\",1]','[3,\"ItemSilverBar10oz\",1]',0,530,'trade_items');
INSERT INTO `traders_data` VALUES(6962,'[\"ItemLightBulb\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,530,'trade_items');
INSERT INTO `traders_data` VALUES(6963,'[\"ItemGenerator\",1]',27,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,530,'trade_items');
INSERT INTO `traders_data` VALUES(6971,'[\"ItemVault\",1]',20,'[1,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,662,'trade_items');
INSERT INTO `traders_data` VALUES(6972,'[\"ItemTentDomed\",1]',23,'[6,\"ItemSilverBar10oz\",1]','[3,\"ItemSilverBar10oz\",1]',0,662,'trade_items');
INSERT INTO `traders_data` VALUES(6973,'[\"ItemTentDomed2\",1]',20,'[6,\"ItemSilverBar10oz\",1]','[3,\"ItemSilverBar10oz\",1]',0,662,'trade_items');
INSERT INTO `traders_data` VALUES(6974,'[\"ItemLightBulb\",1]',21,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,662,'trade_items');
INSERT INTO `traders_data` VALUES(6975,'[\"ItemGenerator\",1]',28,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,662,'trade_items');
INSERT INTO `traders_data` VALUES(6984,'[\"ItemTentDomed\",1]',20,'[6,\"ItemSilverBar10oz\",1]','[3,\"ItemSilverBar10oz\",1]',0,678,'trade_items');
INSERT INTO `traders_data` VALUES(6985,'[\"ItemTentDomed2\",1]',20,'[6,\"ItemSilverBar10oz\",1]','[3,\"ItemSilverBar10oz\",1]',0,678,'trade_items');
INSERT INTO `traders_data` VALUES(6986,'[\"ItemLightBulb\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,678,'trade_items');
INSERT INTO `traders_data` VALUES(6987,'[\"ItemGenerator\",1]',20,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,678,'trade_items');
INSERT INTO `traders_data` VALUES(6996,'[\"ItemTentDomed\",1]',20,'[6,\"ItemSilverBar10oz\",1]','[3,\"ItemSilverBar10oz\",1]',0,680,'trade_items');
INSERT INTO `traders_data` VALUES(6997,'[\"ItemTentDomed2\",1]',20,'[6,\"ItemSilverBar10oz\",1]','[3,\"ItemSilverBar10oz\",1]',0,680,'trade_items');
INSERT INTO `traders_data` VALUES(6998,'[\"ItemLightBulb\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,680,'trade_items');
INSERT INTO `traders_data` VALUES(6999,'[\"ItemGenerator\",1]',20,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,680,'trade_items');
INSERT INTO `traders_data` VALUES(7014,'[\"ItemCrowbar\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,532,'trade_weapons');
INSERT INTO `traders_data` VALUES(7015,'[\"ItemMachete\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,532,'trade_weapons');
INSERT INTO `traders_data` VALUES(7016,'[\"ItemFishingPole\",3]',22,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,532,'trade_weapons');
INSERT INTO `traders_data` VALUES(7031,'[\"ItemCrowbar\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,663,'trade_weapons');
INSERT INTO `traders_data` VALUES(7032,'[\"ItemMachete\",3]',24,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,663,'trade_weapons');
INSERT INTO `traders_data` VALUES(7033,'[\"ItemFishingPole\",3]',21,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,663,'trade_weapons');
INSERT INTO `traders_data` VALUES(7048,'[\"ItemCrowbar\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,679,'trade_weapons');
INSERT INTO `traders_data` VALUES(7049,'[\"ItemMachete\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,679,'trade_weapons');
INSERT INTO `traders_data` VALUES(7050,'[\"ItemFishingPole\",3]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,679,'trade_weapons');
INSERT INTO `traders_data` VALUES(7065,'[\"ItemCrowbar\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,681,'trade_weapons');
INSERT INTO `traders_data` VALUES(7066,'[\"ItemMachete\",3]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,681,'trade_weapons');
INSERT INTO `traders_data` VALUES(7067,'[\"ItemFishingPole\",3]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,681,'trade_weapons');
INSERT INTO `traders_data` VALUES(7068,'[\"JetSkiYanahui_Case_Red\",2]',23,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,557,'trade_any_boat');
INSERT INTO `traders_data` VALUES(7069,'[\"JetSkiYanahui_Case_Yellow\",2]',10,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,557,'trade_any_boat');
INSERT INTO `traders_data` VALUES(7070,'[\"JetSkiYanahui_Case_Green\",2]',10,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,557,'trade_any_boat');
INSERT INTO `traders_data` VALUES(7071,'[\"JetSkiYanahui_Case_Blue\",2]',24,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,557,'trade_any_boat');
INSERT INTO `traders_data` VALUES(7077,'[\"JetSkiYanahui_Case_Red\",2]',10,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,672,'trade_any_boat');
INSERT INTO `traders_data` VALUES(7078,'[\"JetSkiYanahui_Case_Yellow\",2]',10,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,672,'trade_any_boat');
INSERT INTO `traders_data` VALUES(7079,'[\"JetSkiYanahui_Case_Green\",2]',10,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,672,'trade_any_boat');
INSERT INTO `traders_data` VALUES(7080,'[\"JetSkiYanahui_Case_Blue\",2]',10,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,672,'trade_any_boat');
INSERT INTO `traders_data` VALUES(7081,'[\"PartFueltank\",1]',28,'[2,\"ItemGoldBar\",1]','[5,\"ItemSilverBar\",1]',0,509,'trade_items');
INSERT INTO `traders_data` VALUES(7089,'[\"PartFueltank\",1]',23,'[2,\"ItemGoldBar\",1]','[5,\"ItemSilverBar\",1]',0,664,'trade_items');
INSERT INTO `traders_data` VALUES(7097,'[\"PartFueltank\",1]',20,'[2,\"ItemGoldBar\",1]','[5,\"ItemSilverBar\",1]',0,677,'trade_items');
INSERT INTO `traders_data` VALUES(7105,'[\"PartFueltank\",1]',20,'[2,\"ItemGoldBar\",1]','[5,\"ItemSilverBar\",1]',0,682,'trade_items');
INSERT INTO `traders_data` VALUES(7106,'[\"tractor\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,587,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7116,'[\"tractor\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,536,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7126,'[\"tractor\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,650,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7136,'[\"tractor\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,608,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7144,'[\"PartFueltank\",1]',22,'[2,\"ItemGoldBar\",1]','[5,\"ItemSilverBar\",1]',0,531,'trade_items');
INSERT INTO `traders_data` VALUES(7145,'[\"5Rnd_86x70_L115A1\",1]',25,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,478,'trade_items');
INSERT INTO `traders_data` VALUES(7148,'[\"LandRover_CZ_EP1\",2]',11,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,491,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7149,'[\"LandRover_TK_CIV_EP1\",2]',12,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,491,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7150,'[\"30Rnd_762x39_SA58\",1]',28,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,609,'trade_items');
INSERT INTO `traders_data` VALUES(7155,'[\"30Rnd_762x39_SA58\",1]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,621,'trade_items');
INSERT INTO `traders_data` VALUES(7160,'[\"30Rnd_762x39_SA58\",1]',25,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,643,'trade_items');
INSERT INTO `traders_data` VALUES(7165,'[\"30Rnd_762x39_SA58\",1]',23,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,480,'trade_items');
INSERT INTO `traders_data` VALUES(7172,'[\"LandRover_CZ_EP1\",2]',15,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,598,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7173,'[\"LandRover_TK_CIV_EP1\",2]',12,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,598,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7180,'[\"LandRover_CZ_EP1\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,599,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7181,'[\"LandRover_TK_CIV_EP1\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,599,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7188,'[\"LandRover_CZ_EP1\",2]',11,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,658,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7189,'[\"LandRover_TK_CIV_EP1\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,658,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7190,'[\"1Rnd_HE_M203\",1]',74,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,529,'trade_items');
INSERT INTO `traders_data` VALUES(7191,'[\"ItemFuelBarrel\",1]',22,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,509,'trade_items');
INSERT INTO `traders_data` VALUES(7201,'[\"ItemFuelBarrel\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,531,'trade_items');
INSERT INTO `traders_data` VALUES(7211,'[\"ItemFuelBarrel\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,664,'trade_items');
INSERT INTO `traders_data` VALUES(7221,'[\"ItemFuelBarrel\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,677,'trade_items');
INSERT INTO `traders_data` VALUES(7231,'[\"ItemFuelBarrel\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,682,'trade_items');
INSERT INTO `traders_data` VALUES(7233,'[\"bulk_ItemTankTrap\",1]',20,'[1,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,555,'trade_items');
INSERT INTO `traders_data` VALUES(7240,'[\"bulk_ItemTankTrap\",1]',20,'[1,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,636,'trade_items');
INSERT INTO `traders_data` VALUES(7241,'[\"bulk_ItemWire\",1]',20,'[3,\"ItemSilverBar10oz\",1]','[3,\"ItemSilverBar10oz\",1]',0,636,'trade_items');
INSERT INTO `traders_data` VALUES(7242,'[\"bulk_PartGeneric\",1]',20,'[6,\"ItemSilverBar10oz\",1]','[6,\"ItemSilverBar10oz\",1]',0,555,'trade_items');
INSERT INTO `traders_data` VALUES(7250,'[\"DZ_Czech_Vest_Puch\",2]',20,'[2,\"ItemSilverBar\",1]','[1,\"ItemSilverBar\",1]',0,538,'trade_backpacks');
INSERT INTO `traders_data` VALUES(7251,'[\"DZ_TK_Assault_Pack_EP1\",2]',20,'[6,\"ItemSilverBar10oz\",1]','[3,\"ItemSilverBar10oz\",1]',0,538,'trade_backpacks');
INSERT INTO `traders_data` VALUES(7252,'[\"DZ_TerminalPack_EP1\",2]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,538,'trade_backpacks');
INSERT INTO `traders_data` VALUES(7253,'[\"DZ_GunBag_EP1\",2]',21,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,538,'trade_backpacks');
INSERT INTO `traders_data` VALUES(7254,'[\"Skin_SurvivorW3_DZ\",1]',22,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,628,'trade_items');
INSERT INTO `traders_data` VALUES(7270,'[\"Skin_SurvivorW3_DZ\",1]',31,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,497,'trade_items');
INSERT INTO `traders_data` VALUES(7302,'[\"Skin_SurvivorW3_DZ\",1]',25,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,631,'trade_items');
INSERT INTO `traders_data` VALUES(7318,'[\"Skin_SurvivorW3_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,683,'trade_items');
INSERT INTO `traders_data` VALUES(7334,'[\"Skin_SurvivorW3_DZ\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,689,'trade_items');
INSERT INTO `traders_data` VALUES(7342,'[\"bulk_PartGeneric\",1]',20,'[6,\"ItemSilverBar10oz\",1]','[6,\"ItemSilverBar10oz\",1]',0,636,'trade_items');
INSERT INTO `traders_data` VALUES(7348,'[\"bulk_ItemTankTrap\",1]',20,'[1,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,675,'trade_items');
INSERT INTO `traders_data` VALUES(7349,'[\"bulk_ItemWire\",1]',20,'[3,\"ItemSilverBar10oz\",1]','[3,\"ItemSilverBar10oz\",1]',0,675,'trade_items');
INSERT INTO `traders_data` VALUES(7350,'[\"bulk_PartGeneric\",1]',20,'[6,\"ItemSilverBar10oz\",1]','[6,\"ItemSilverBar10oz\",1]',0,675,'trade_items');
INSERT INTO `traders_data` VALUES(7355,'[\"100Rnd_762x51_M240\",1]',35,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,478,'trade_items');
INSERT INTO `traders_data` VALUES(7356,'[\"20Rnd_762x51_FNFAL\",1]',20,'[4,\"ItemSilverBar10oz\",1]','[2,\"ItemSilverBar10oz\",1]',0,478,'trade_items');
INSERT INTO `traders_data` VALUES(7357,'[\"20Rnd_762x51_SB_SCAR\",1]',26,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,478,'trade_items');
INSERT INTO `traders_data` VALUES(7358,'[\"5Rnd_86x70_L115A1\",1]',34,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,577,'trade_items');
INSERT INTO `traders_data` VALUES(7359,'[\"100Rnd_762x51_M240\",1]',25,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,577,'trade_items');
INSERT INTO `traders_data` VALUES(7360,'[\"20Rnd_762x51_FNFAL\",1]',20,'[4,\"ItemSilverBar10oz\",1]','[2,\"ItemSilverBar10oz\",1]',0,577,'trade_items');
INSERT INTO `traders_data` VALUES(7361,'[\"20Rnd_762x51_SB_SCAR\",1]',25,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,577,'trade_items');
INSERT INTO `traders_data` VALUES(7362,'[\"BAF_L85A2_RIS_SUSAT\",3]',20,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,485,'trade_weapons');
INSERT INTO `traders_data` VALUES(7363,'[\"BAF_L85A2_RIS_Holo\",3]',21,'[9,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,485,'trade_weapons');
INSERT INTO `traders_data` VALUES(7364,'[\"BAF_L85A2_RIS_SUSAT\",3]',21,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,602,'trade_weapons');
INSERT INTO `traders_data` VALUES(7365,'[\"BAF_L85A2_RIS_Holo\",3]',21,'[9,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,602,'trade_weapons');
INSERT INTO `traders_data` VALUES(7366,'[\"BAF_L85A2_RIS_SUSAT\",3]',20,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,615,'trade_weapons');
INSERT INTO `traders_data` VALUES(7367,'[\"BAF_L85A2_RIS_Holo\",3]',20,'[9,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,615,'trade_weapons');
INSERT INTO `traders_data` VALUES(7368,'[\"BAF_L85A2_RIS_SUSAT\",3]',20,'[6,\"ItemGoldBar\",1]','[3,\"ItemGoldBar\",1]',0,637,'trade_weapons');
INSERT INTO `traders_data` VALUES(7369,'[\"BAF_L85A2_RIS_Holo\",3]',20,'[9,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,637,'trade_weapons');
INSERT INTO `traders_data` VALUES(7370,'[\"V3S_Civ\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,564,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7371,'[\"V3S_RA_TK_GUE_EP1_DZE\",2]',25,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,564,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7373,'[\"V3S_TK_EP1_DZE\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,564,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7374,'[\"UralCivil_DZE\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,564,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7375,'[\"UralCivil2_DZE\",2]',25,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,564,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7376,'[\"KamazOpen_DZE\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,564,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7384,'[\"V3S_Civ\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,586,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7385,'[\"V3S_RA_TK_GUE_EP1_DZE\",2]',12,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,586,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7386,'[\"V3S_TK_EP1_DZE\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,586,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7387,'[\"UralCivil_DZE\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,586,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7388,'[\"UralCivil2_DZE\",2]',11,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,586,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7389,'[\"KamazOpen_DZE\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,586,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7397,'[\"V3S_Civ\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,570,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7398,'[\"V3S_RA_TK_GUE_EP1_DZE\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,570,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7399,'[\"V3S_TK_EP1_DZE\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,570,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7400,'[\"UralCivil_DZE\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,570,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7401,'[\"UralCivil2_DZE\",2]',10,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,570,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7402,'[\"KamazOpen_DZE\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,570,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7410,'[\"V3S_Civ\",2]',11,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,653,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7411,'[\"V3S_RA_TK_GUE_EP1_DZE\",2]',11,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,653,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7412,'[\"V3S_TK_EP1_DZE\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,653,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7413,'[\"UralCivil_DZE\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,653,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7414,'[\"UralCivil2_DZE\",2]',11,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,653,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7415,'[\"KamazOpen_DZE\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,653,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7416,'[\"MTVR\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,653,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7417,'[\"MtvrRefuel_DZ\",2]',10,'[7,\"ItemGoldBar10oz\",1]','[3,\"ItemGoldBar10oz\",1]',0,655,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7431,'[\"MTVR\",2]',21,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,586,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7445,'[\"MTVR\",2]',10,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,570,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7473,'[\"MTVR\",2]',23,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,564,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7474,'[\"MtvrRefuel_DZ\",2]',10,'[7,\"ItemGoldBar10oz\",1]','[3,\"ItemGoldBar10oz\",1]',0,589,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7479,'[\"MtvrRefuel_DZ\",2]',10,'[7,\"ItemGoldBar10oz\",1]','[3,\"ItemGoldBar10oz\",1]',0,595,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7489,'[\"MtvrRefuel_DZ\",2]',10,'[7,\"ItemGoldBar10oz\",1]','[3,\"ItemGoldBar10oz\",1]',0,492,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7490,'[\"CinderBlocks\",1]',20,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,555,'trade_items');
INSERT INTO `traders_data` VALUES(7491,'[\"PartPlywoodPack\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,555,'trade_items');
INSERT INTO `traders_data` VALUES(7492,'[\"MortarBucket\",1]',20,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,555,'trade_items');
INSERT INTO `traders_data` VALUES(7493,'[\"PartPlankPack\",1]',20,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,555,'trade_items');
INSERT INTO `traders_data` VALUES(7494,'[\"CinderBlocks\",1]',20,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,636,'trade_items');
INSERT INTO `traders_data` VALUES(7495,'[\"PartPlywoodPack\",1]',25,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,636,'trade_items');
INSERT INTO `traders_data` VALUES(7496,'[\"MortarBucket\",1]',20,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,636,'trade_items');
INSERT INTO `traders_data` VALUES(7497,'[\"PartPlankPack\",1]',20,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,636,'trade_items');
INSERT INTO `traders_data` VALUES(7498,'[\"CinderBlocks\",1]',20,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,675,'trade_items');
INSERT INTO `traders_data` VALUES(7499,'[\"PartPlywoodPack\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,675,'trade_items');
INSERT INTO `traders_data` VALUES(7500,'[\"MortarBucket\",1]',20,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,675,'trade_items');
INSERT INTO `traders_data` VALUES(7501,'[\"PartPlankPack\",1]',20,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,675,'trade_items');
INSERT INTO `traders_data` VALUES(7502,'[\"100Rnd_556x45_BetaCMag\",1]',59,'[6,\"ItemSilverBar10oz\",1]','[3,\"ItemSilverBar10oz\",1]',0,527,'trade_items');
INSERT INTO `traders_data` VALUES(7503,'[\"75Rnd_545x39_RPK\",1]',83,'[3,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,527,'trade_items');
INSERT INTO `traders_data` VALUES(7504,'[\"64Rnd_9x19_Bizon\",1]',53,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,527,'trade_items');
INSERT INTO `traders_data` VALUES(7505,'[\"5Rnd_127x108_KSVK\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,527,'trade_items');
INSERT INTO `traders_data` VALUES(7506,'[\"100Rnd_556x45_BetaCMag\",1]',20,'[6,\"ItemSilverBar10oz\",1]','[3,\"ItemSilverBar10oz\",1]',0,453,'trade_items');
INSERT INTO `traders_data` VALUES(7507,'[\"75Rnd_545x39_RPK\",1]',20,'[3,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,453,'trade_items');
INSERT INTO `traders_data` VALUES(7508,'[\"64Rnd_9x19_Bizon\",1]',20,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,453,'trade_items');
INSERT INTO `traders_data` VALUES(7509,'[\"5Rnd_127x108_KSVK\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,453,'trade_items');
INSERT INTO `traders_data` VALUES(7510,'[\"100Rnd_556x45_BetaCMag\",1]',20,'[6,\"ItemSilverBar10oz\",1]','[3,\"ItemSilverBar10oz\",1]',0,456,'trade_items');
INSERT INTO `traders_data` VALUES(7511,'[\"75Rnd_545x39_RPK\",1]',20,'[3,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,456,'trade_items');
INSERT INTO `traders_data` VALUES(7512,'[\"64Rnd_9x19_Bizon\",1]',20,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,456,'trade_items');
INSERT INTO `traders_data` VALUES(7513,'[\"5Rnd_127x108_KSVK\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,456,'trade_items');
INSERT INTO `traders_data` VALUES(7514,'[\"100Rnd_556x45_BetaCMag\",1]',20,'[6,\"ItemSilverBar10oz\",1]','[3,\"ItemSilverBar10oz\",1]',0,460,'trade_items');
INSERT INTO `traders_data` VALUES(7515,'[\"75Rnd_545x39_RPK\",1]',20,'[3,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,460,'trade_items');
INSERT INTO `traders_data` VALUES(7516,'[\"64Rnd_9x19_Bizon\",1]',20,'[1,\"ItemSilverBar10oz\",1]','[5,\"ItemSilverBar\",1]',0,460,'trade_items');
INSERT INTO `traders_data` VALUES(7517,'[\"5Rnd_127x108_KSVK\",1]',20,'[2,\"ItemSilverBar10oz\",1]','[1,\"ItemSilverBar10oz\",1]',0,460,'trade_items');
INSERT INTO `traders_data` VALUES(7518,'[\"M8_SAW\",3]',22,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,526,'trade_weapons');
INSERT INTO `traders_data` VALUES(7519,'[\"MG36\",3]',26,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,526,'trade_weapons');
INSERT INTO `traders_data` VALUES(7520,'[\"RPK_74\",3]',87,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,526,'trade_weapons');
INSERT INTO `traders_data` VALUES(7521,'[\"M60A4_EP1_DZE\",3]',27,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,526,'trade_weapons');
INSERT INTO `traders_data` VALUES(7522,'[\"m240_scoped_EP1_DZE\",3]',23,'[2,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,526,'trade_weapons');
INSERT INTO `traders_data` VALUES(7523,'[\"M249_m145_EP1_DZE\",3]',22,'[2,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,526,'trade_weapons');
INSERT INTO `traders_data` VALUES(7524,'[\"MG36_camo\",3]',86,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,526,'trade_weapons');
INSERT INTO `traders_data` VALUES(7525,'[\"bizon\",3]',41,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,526,'trade_weapons');
INSERT INTO `traders_data` VALUES(7526,'[\"M4A1_HWS_GL_SD_Camo\",3]',20,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,526,'trade_weapons');
INSERT INTO `traders_data` VALUES(7527,'[\"KSVK_DZE\",3]',69,'[3,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,526,'trade_weapons');
INSERT INTO `traders_data` VALUES(7528,'[\"M8_SAW\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,452,'trade_weapons');
INSERT INTO `traders_data` VALUES(7529,'[\"MG36\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,452,'trade_weapons');
INSERT INTO `traders_data` VALUES(7530,'[\"RPK_74\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,452,'trade_weapons');
INSERT INTO `traders_data` VALUES(7531,'[\"M60A4_EP1_DZE\",3]',20,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,452,'trade_weapons');
INSERT INTO `traders_data` VALUES(7532,'[\"m240_scoped_EP1_DZE\",3]',20,'[2,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,452,'trade_weapons');
INSERT INTO `traders_data` VALUES(7533,'[\"M249_m145_EP1_DZE\",3]',20,'[2,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,452,'trade_weapons');
INSERT INTO `traders_data` VALUES(7534,'[\"MG36_camo\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,452,'trade_weapons');
INSERT INTO `traders_data` VALUES(7535,'[\"bizon\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,452,'trade_weapons');
INSERT INTO `traders_data` VALUES(7536,'[\"M4A1_HWS_GL_SD_Camo\",3]',20,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,452,'trade_weapons');
INSERT INTO `traders_data` VALUES(7537,'[\"KSVK_DZE\",3]',20,'[3,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,452,'trade_weapons');
INSERT INTO `traders_data` VALUES(7538,'[\"M8_SAW\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,455,'trade_weapons');
INSERT INTO `traders_data` VALUES(7539,'[\"MG36\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,455,'trade_weapons');
INSERT INTO `traders_data` VALUES(7540,'[\"RPK_74\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,455,'trade_weapons');
INSERT INTO `traders_data` VALUES(7541,'[\"M60A4_EP1_DZE\",3]',20,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,455,'trade_weapons');
INSERT INTO `traders_data` VALUES(7542,'[\"m240_scoped_EP1_DZE\",3]',20,'[2,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,455,'trade_weapons');
INSERT INTO `traders_data` VALUES(7543,'[\"M249_m145_EP1_DZE\",3]',20,'[2,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,455,'trade_weapons');
INSERT INTO `traders_data` VALUES(7544,'[\"MG36_camo\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,455,'trade_weapons');
INSERT INTO `traders_data` VALUES(7545,'[\"bizon\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,455,'trade_weapons');
INSERT INTO `traders_data` VALUES(7546,'[\"M4A1_HWS_GL_SD_Camo\",3]',20,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,455,'trade_weapons');
INSERT INTO `traders_data` VALUES(7547,'[\"KSVK_DZE\",3]',20,'[3,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,455,'trade_weapons');
INSERT INTO `traders_data` VALUES(7548,'[\"M8_SAW\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,459,'trade_weapons');
INSERT INTO `traders_data` VALUES(7549,'[\"MG36\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,459,'trade_weapons');
INSERT INTO `traders_data` VALUES(7550,'[\"RPK_74\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,459,'trade_weapons');
INSERT INTO `traders_data` VALUES(7551,'[\"M60A4_EP1_DZE\",3]',20,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,459,'trade_weapons');
INSERT INTO `traders_data` VALUES(7552,'[\"m240_scoped_EP1_DZE\",3]',20,'[2,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,459,'trade_weapons');
INSERT INTO `traders_data` VALUES(7553,'[\"M249_m145_EP1_DZE\",3]',20,'[2,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,459,'trade_weapons');
INSERT INTO `traders_data` VALUES(7554,'[\"MG36_camo\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[6,\"ItemGoldBar\",1]',0,459,'trade_weapons');
INSERT INTO `traders_data` VALUES(7555,'[\"bizon\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,459,'trade_weapons');
INSERT INTO `traders_data` VALUES(7556,'[\"M4A1_HWS_GL_SD_Camo\",3]',20,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,459,'trade_weapons');
INSERT INTO `traders_data` VALUES(7557,'[\"KSVK_DZE\",3]',20,'[3,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,459,'trade_weapons');
INSERT INTO `traders_data` VALUES(7558,'[\"HandGrenade_east\",1]',38,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,529,'trade_items');
INSERT INTO `traders_data` VALUES(7565,'[\"bulk_ItemWire\",1]',21,'[3,\"ItemSilverBar10oz\",1]','[3,\"ItemSilverBar10oz\",1]',0,555,'trade_items');
INSERT INTO `traders_data` VALUES(7571,'[\"BAF_Merlin_DZE\",2]',10,'[4,\"ItemBriefcase100oz\",1]','[2,\"ItemBriefcase100oz\",1]',0,519,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7573,'[\"MH60S_DZE\",2]',10,'[4,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,512,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7574,'[\"MH60S_DZE\",2]',11,'[2,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,493,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7581,'[\"CH53_DZE\",1]',38,'[4,\"ItemBriefcase100oz\",1]','[2,\"ItemBriefcase100oz\",1]',0,493,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7582,'[\"CH53_DZE\",1]',17,'[4,\"ItemBriefcase100oz\",1]','[2,\"ItemBriefcase100oz\",1]',0,512,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7583,'[\"BAF_Merlin_DZE\",1]',23,'[4,\"ItemBriefcase100oz\",1]','[2,\"ItemBriefcase100oz\",1]',0,519,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7584,'[\"2000Rnd_762x51_M134\",1]',20,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,478,'trade_items');
INSERT INTO `traders_data` VALUES(7585,'[\"metal_floor_kit\",1]',20,'[1,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,693,'trade_items');
INSERT INTO `traders_data` VALUES(7586,'[\"cinder_wall_kit\",1]',20,'[4,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,693,'trade_items');
INSERT INTO `traders_data` VALUES(7587,'[\"CinderBlocks\",1]',20,'[1,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,693,'trade_items');
INSERT INTO `traders_data` VALUES(7588,'[\"MortarBucket\",1]',20,'[1,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,693,'trade_items');
INSERT INTO `traders_data` VALUES(7589,'[\"bulk_ItemTankTrap\",1]',20,'[1,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,693,'trade_items');
INSERT INTO `traders_data` VALUES(7590,'[\"bulk_PartGeneric\",1]',20,'[6,\"ItemSilverBar10oz\",1]','[6,\"ItemSilverBar10oz\",1]',0,693,'trade_items');
INSERT INTO `traders_data` VALUES(7591,'[\"AK_107_GL\", 3]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,637,'trade_weapons');
INSERT INTO `traders_data` VALUES(7592,'[\"AK_107_GL\", 3]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,615,'trade_weapons');
INSERT INTO `traders_data` VALUES(7593,'[\"AK_107_GL\", 3]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,602,'trade_weapons');
INSERT INTO `traders_data` VALUES(7594,'[\"AK_107_GL\", 3]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,485,'trade_weapons');
INSERT INTO `traders_data` VALUES(7595,'[\"M4A1_HWS_GL\", 3]',25,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,485,'trade_weapons');
INSERT INTO `traders_data` VALUES(7596,'[\"M4A1_HWS_GL\", 3]',41,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,602,'trade_weapons');
INSERT INTO `traders_data` VALUES(7597,'[\"M4A1_HWS_GL\", 3]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,615,'trade_weapons');
INSERT INTO `traders_data` VALUES(7598,'[\"M4A1_HWS_GL\", 3]',21,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,637,'trade_weapons');
INSERT INTO `traders_data` VALUES(7599,'[\"M4A1_HWS_GL\", 3]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,526,'trade_weapons');
INSERT INTO `traders_data` VALUES(7600,'[\"M4A1_HWS_GL\", 3]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,452,'trade_weapons');
INSERT INTO `traders_data` VALUES(7601,'[\"M4A1_HWS_GL\", 3]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,455,'trade_weapons');
INSERT INTO `traders_data` VALUES(7602,'[\"M4A1_HWS_GL\", 3]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,459,'trade_weapons');
INSERT INTO `traders_data` VALUES(7603,'[\"BAF_L85A2_UGL_Holo\", 3]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,485,'trade_weapons');
INSERT INTO `traders_data` VALUES(7604,'[\"BAF_L85A2_UGL_Holo\", 3]',38,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,602,'trade_weapons');
INSERT INTO `traders_data` VALUES(7605,'[\"BAF_L85A2_UGL_Holo\", 3]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,615,'trade_weapons');
INSERT INTO `traders_data` VALUES(7606,'[\"BAF_L85A2_UGL_Holo\", 3]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,637,'trade_weapons');
INSERT INTO `traders_data` VALUES(7607,'[\"BAF_L85A2_UGL_Holo\", 3]',30,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,526,'trade_weapons');
INSERT INTO `traders_data` VALUES(7608,'[\"BAF_L85A2_UGL_Holo\", 3]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,452,'trade_weapons');
INSERT INTO `traders_data` VALUES(7609,'[\"BAF_L85A2_UGL_Holo\", 3]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,455,'trade_weapons');
INSERT INTO `traders_data` VALUES(7610,'[\"BAF_L85A2_UGL_Holo\", 3]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,459,'trade_weapons');
INSERT INTO `traders_data` VALUES(7611,'[\"AK_107_pso\", 3]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,485,'trade_weapons');
INSERT INTO `traders_data` VALUES(7612,'[\"AK_107_pso\", 3]',36,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,602,'trade_weapons');
INSERT INTO `traders_data` VALUES(7613,'[\"AK_107_pso\", 3]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,615,'trade_weapons');
INSERT INTO `traders_data` VALUES(7614,'[\"AK_107_pso\", 3]',21,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,637,'trade_weapons');
INSERT INTO `traders_data` VALUES(7615,'[\"AKS_74_UN_kobra\",3]',21,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,477,'trade_weapons');
INSERT INTO `traders_data` VALUES(7616,'[\"30Rnd_545x39_AKSD\",1]',22,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,478,'trade_items');
INSERT INTO `traders_data` VALUES(7617,'[\"20rnd_762x51_B_SCAR\",1]',20,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,478,'trade_items');
INSERT INTO `traders_data` VALUES(7618,'[\"2000Rnd_762x51_M134\",1]',20,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,577,'trade_items');
INSERT INTO `traders_data` VALUES(7619,'[\"20rnd_762x51_B_SCAR\",1]',25,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,577,'trade_items');
INSERT INTO `traders_data` VALUES(7620,'[\"30Rnd_545x39_AKSD\",1]',25,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,577,'trade_items');
INSERT INTO `traders_data` VALUES(7621,'[\"AKS_74_UN_kobra\",3]',20,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,627,'trade_weapons');
INSERT INTO `traders_data` VALUES(7622,'[\"SCAR_H_LNG_Sniper\",3]',20,'[5,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,627,'trade_weapons');
INSERT INTO `traders_data` VALUES(7623,'[\"SCAR_H_LNG_Sniper\",3]',23,'[5,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,477,'trade_weapons');
INSERT INTO `traders_data` VALUES(7624,'[\"AK_107_GL_kobra\", 3]',20,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,485,'trade_weapons');
INSERT INTO `traders_data` VALUES(7625,'[\"AK_107_GL_kobra\", 3]',20,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,602,'trade_weapons');
INSERT INTO `traders_data` VALUES(7626,'[\"AK_107_GL_kobra\", 3]',20,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,615,'trade_weapons');
INSERT INTO `traders_data` VALUES(7627,'[\"AK_107_GL_kobra\", 3]',20,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,637,'trade_weapons');
INSERT INTO `traders_data` VALUES(7628,'[\"SCAR_L_STD_EGLM_RCO\", 3]',20,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,485,'trade_weapons');
INSERT INTO `traders_data` VALUES(7629,'[\"SCAR_L_STD_EGLM_RCO\", 3]',20,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,602,'trade_weapons');
INSERT INTO `traders_data` VALUES(7630,'[\"SCAR_L_STD_EGLM_RCO\", 3]',20,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,615,'trade_weapons');
INSERT INTO `traders_data` VALUES(7631,'[\"SCAR_L_STD_EGLM_RCO\", 3]',20,'[1,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar\",1]',0,637,'trade_weapons');
INSERT INTO `traders_data` VALUES(7632,'[\"M4A3_RCO_GL_EP1\", 3]',24,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,485,'trade_weapons');
INSERT INTO `traders_data` VALUES(7633,'[\"M4A3_RCO_GL_EP1\", 3]',50,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,602,'trade_weapons');
INSERT INTO `traders_data` VALUES(7634,'[\"M4A3_RCO_GL_EP1\", 3]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,615,'trade_weapons');
INSERT INTO `traders_data` VALUES(7635,'[\"M4A3_RCO_GL_EP1\", 3]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,637,'trade_weapons');
INSERT INTO `traders_data` VALUES(7636,'[\"SCAR_L_STD_Mk4CQT\", 3]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,485,'trade_weapons');
INSERT INTO `traders_data` VALUES(7637,'[\"SCAR_L_STD_Mk4CQT\", 3]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,602,'trade_weapons');
INSERT INTO `traders_data` VALUES(7638,'[\"SCAR_L_STD_Mk4CQT\", 3]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,615,'trade_weapons');
INSERT INTO `traders_data` VALUES(7639,'[\"SCAR_L_STD_Mk4CQT\", 3]',20,'[8,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,637,'trade_weapons');
INSERT INTO `traders_data` VALUES(7640,'[\"M110_NVG_EP1\", 3]',81,'[10,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar10oz\",1]',0,477,'trade_weapons');
INSERT INTO `traders_data` VALUES(7641,'[\"M110_NVG_EP1\", 3]',27,'[10,\"ItemGoldBar10oz\",1]','[5,\"ItemGoldBar10oz\",1]',0,627,'trade_weapons');
INSERT INTO `traders_data` VALUES(7642,'[\"PartPlankPack\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,693,'trade_items');
INSERT INTO `traders_data` VALUES(7643,'[\"PartPlywoodPack\",1]',20,'[4,\"ItemGoldBar\",1]','[2,\"ItemGoldBar\",1]',0,693,'trade_items');
INSERT INTO `traders_data` VALUES(7660,'[\"metal_floor_kit\",1]',20,'[1,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,700,'trade_items');
INSERT INTO `traders_data` VALUES(7661,'[\"cinder_wall_kit\",1]',20,'[4,\"ItemGoldBar\",1]','[4,\"ItemGoldBar\",1]',0,700,'trade_items');
INSERT INTO `traders_data` VALUES(7662,'[\"CinderBlocks\",1]',20,'[1,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,700,'trade_items');
INSERT INTO `traders_data` VALUES(7663,'[\"MortarBucket\",1]',20,'[1,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,700,'trade_items');
INSERT INTO `traders_data` VALUES(7664,'[\"bulk_ItemTankTrap\",1]',20,'[1,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,700,'trade_items');
INSERT INTO `traders_data` VALUES(7665,'[\"bulk_PartGeneric\",1]',20,'[6,\"ItemSilverBar10oz\",1]','[6,\"ItemSilverBar10oz\",1]',0,700,'trade_items');
INSERT INTO `traders_data` VALUES(7666,'[\"MAAWS\", 3]',20,'[3,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,706,'trade_weapons');
INSERT INTO `traders_data` VALUES(7667,'[\"MAAWS\", 3]',20,'[3,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,708,'trade_weapons');
INSERT INTO `traders_data` VALUES(7668,'[\"MAAWS\", 3]',72,'[4,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,701,'trade_weapons');
INSERT INTO `traders_data` VALUES(7669,'[\"MAAWS\", 3]',21,'[4,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,702,'trade_weapons');
INSERT INTO `traders_data` VALUES(7670,'[\"Strela\", 3]',20,'[5,\"ItemBriefcase100oz\",1]','[2,\"ItemBriefcase100oz\",1]',0,705,'trade_weapons');
INSERT INTO `traders_data` VALUES(7671,'[\"Strela\", 3]',20,'[5,\"ItemBriefcase100oz\",1]','[2,\"ItemBriefcase100oz\",1]',0,707,'trade_weapons');
INSERT INTO `traders_data` VALUES(7672,'[\"Strela\", 3]',20,'[5,\"ItemBriefcase100oz\",1]','[2,\"ItemBriefcase100oz\",1]',0,703,'trade_weapons');
INSERT INTO `traders_data` VALUES(7673,'[\"Strela\", 3]',20,'[5,\"ItemBriefcase100oz\",1]','[2,\"ItemBriefcase100oz\",1]',0,704,'trade_weapons');
INSERT INTO `traders_data` VALUES(7674,'[\"MAAWS_HEAT\",1]',20,'[8,\"ItemBriefcase100oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,710,'trade_items');
INSERT INTO `traders_data` VALUES(7675,'[\"MAAWS_HEDP\",1]',20,'[8,\"ItemBriefcase100oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,710,'trade_items');
INSERT INTO `traders_data` VALUES(7676,'[\"MAAWS_HEAT\",1]',20,'[8,\"ItemBriefcase100oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,712,'trade_items');
INSERT INTO `traders_data` VALUES(7677,'[\"MAAWS_HEDP\",1]',20,'[8,\"ItemBriefcase100oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,712,'trade_items');
INSERT INTO `traders_data` VALUES(7678,'[\"MAAWS_HEAT\",1]',20,'[8,\"ItemBriefcase100oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,715,'trade_items');
INSERT INTO `traders_data` VALUES(7679,'[\"MAAWS_HEAT\",1]',33,'[8,\"ItemBriefcase100oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,716,'trade_items');
INSERT INTO `traders_data` VALUES(7680,'[\"MAAWS_HEDP\",1]',20,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,715,'trade_items');
INSERT INTO `traders_data` VALUES(7681,'[\"MAAWS_HEDP\",1]',20,'[4,\"ItemGoldBar10oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,716,'trade_items');
INSERT INTO `traders_data` VALUES(7682,'[\"Strela\",1]',20,'[8,\"ItemBriefcase100oz\",1]','[4,\"ItemGoldBar10oz\",1]',0,709,'trade_items');
INSERT INTO `traders_data` VALUES(7683,'[\"Strela\",1]',20,'[8,\"ItemBriefcase100oz\",1]','[4,\"ItemGoldBar10oz\",1]',0,711,'trade_items');
INSERT INTO `traders_data` VALUES(7684,'[\"Strela\",1]',20,'[6,\"ItemBriefcase100oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,713,'trade_items');
INSERT INTO `traders_data` VALUES(7685,'[\"Strela\",1]',20,'[6,\"ItemBriefcase100oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,714,'trade_items');
INSERT INTO `traders_data` VALUES(7686,'[\"RPG7V\", 3]',25,'[5,\"ItemBriefcase100oz\",1]','[2,\"ItemBriefcase100oz\",1]',0,701,'trade_weapons');
INSERT INTO `traders_data` VALUES(7687,'[\"RPG7V\", 3]',20,'[5,\"ItemBriefcase100oz\",1]','[2,\"ItemBriefcase100oz\",1]',0,702,'trade_weapons');
INSERT INTO `traders_data` VALUES(7688,'[\"PG7V\",1]',20,'[8,\"ItemBriefcase100oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,715,'trade_items');
INSERT INTO `traders_data` VALUES(7689,'[\"PG7V\",1]',20,'[8,\"ItemBriefcase100oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,716,'trade_items');
INSERT INTO `traders_data` VALUES(7690,'[\"PG7VL\",1]',21,'[8,\"ItemBriefcase100oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,715,'trade_items');
INSERT INTO `traders_data` VALUES(7691,'[\"PG7VL\",1]',20,'[8,\"ItemBriefcase100oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,716,'trade_items');
INSERT INTO `traders_data` VALUES(7692,'[\"PG7VR\",1]',20,'[8,\"ItemBriefcase100oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,715,'trade_items');
INSERT INTO `traders_data` VALUES(7693,'[\"PG7VR\",1]',20,'[8,\"ItemBriefcase100oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,716,'trade_items');
INSERT INTO `traders_data` VALUES(7694,'[\"OG7\",1]',20,'[8,\"ItemBriefcase100oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,715,'trade_items');
INSERT INTO `traders_data` VALUES(7695,'[\"OG7\",1]',20,'[8,\"ItemBriefcase100oz\",1]','[2,\"ItemGoldBar10oz\",1]',0,716,'trade_items');
INSERT INTO `traders_data` VALUES(7696,'[\"Stinger\", 3]',20,'[5,\"ItemBriefcase100oz\",1]','[2,\"ItemBriefcase100oz\",1]',0,703,'trade_weapons');
INSERT INTO `traders_data` VALUES(7697,'[\"Stinger\", 3]',20,'[5,\"ItemBriefcase100oz\",1]','[2,\"ItemBriefcase100oz\",1]',0,704,'trade_weapons');
INSERT INTO `traders_data` VALUES(7698,'[\"Stinger\",1]',20,'[9,\"ItemBriefcase100oz\",1]','[5,\"ItemGoldBar10oz\",1]',0,713,'trade_items');
INSERT INTO `traders_data` VALUES(7699,'[\"Stinger\",1]',20,'[9,\"ItemBriefcase100oz\",1]','[5,\"ItemGoldBar10oz\",1]',0,714,'trade_items');
INSERT INTO `traders_data` VALUES(7707,'[\"ItemFuelBarrelEmpty\",1]',20,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,675,'trade_items');
INSERT INTO `traders_data` VALUES(7708,'[\"ItemFuelBarrelEmpty\",1]',20,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,636,'trade_items');
INSERT INTO `traders_data` VALUES(7709,'[\"ItemFuelBarrelEmpty\",1]',20,'[1,\"ItemGoldBar\",1]','[5,\"ItemSilverBar10oz\",1]',0,555,'trade_items');
INSERT INTO `traders_data` VALUES(7713,'[\"TowingTractor\",1]',16,'[2,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,717,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7724,'[\"M1133_MEV_EP1\",2]',10,'[2,\"ItemSapphire\",1]','[1,\"ItemSapphire\",1]',0,694,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7725,'[\"M113_TK_EP1\",2]',10,'[1,\"ItemEmerald\",1]','[2,\"ItemSapphire\",1]',0,694,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7726,'[\"M113Ambul_UN_EP1\",2]',10,'[4,\"ItemTopaz\",1]','[2,\"ItemTopaz\",1]',0,694,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7727,'[\"M1133_MEV_EP1\",2]',10,'[2,\"ItemSapphire\",1]','[1,\"ItemSapphire\",1]',0,695,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7728,'[\"M113_TK_EP1\",2]',10,'[1,\"ItemEmerald\",1]','[2,\"ItemSapphire\",1]',0,695,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7729,'[\"M113Ambul_TK_EP1\",2]',10,'[4,\"ItemTopaz\",1]','[2,\"ItemTopaz\",1]',0,695,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7730,'[\"BTR90_HQ_DZE\",2]',11,'[3,\"ItemSapphire\",1]','[2,\"ItemSapphire\",1]',0,694,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7731,'[\"BTR90_HQ_DZE\",2]',10,'[3,\"ItemSapphire\",1]','[2,\"ItemSapphire\",1]',0,695,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7732,'[\"LAV25_HQ_DZE\",2]',13,'[3,\"ItemSapphire\",1]','[2,\"ItemSapphire\",1]',0,694,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7733,'[\"LAV25_HQ_DZE\",2]',10,'[3,\"ItemSapphire\",1]','[2,\"ItemSapphire\",1]',0,695,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7734,'[\"M1126_ICV_M2_EP1\",2]',12,'[2,\"ItemEmerald\",1]','[5,\"ItemSapphire\",1]',0,694,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7735,'[\"M1126_ICV_M2_EP1\",2]',10,'[2,\"ItemEmerald\",1]','[5,\"ItemSapphire\",1]',0,695,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7736,'[\"M1126_ICV_mk19_EP1\",2]',12,'[1,\"ItemEmerald\",1]','[2,\"ItemSapphire\",1]',0,694,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7737,'[\"M1126_ICV_mk19_EP1\",2]',10,'[1,\"ItemEmerald\",1]','[2,\"ItemSapphire\",1]',0,695,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7738,'[\"pook_H13_medevac_INS\",2]',10,'[1,\"ItemTopaz\",1]','[5,\"ItemBriefcase100oz\",1]',0,696,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7739,'[\"pook_H13_medevac_INS\",2]',10,'[1,\"ItemTopaz\",1]','[5,\"ItemBriefcase100oz\",1]',0,697,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7740,'[\"pook_H13_civ_yellow\",2]',10,'[8,\"ItemBriefcase100oz\",1]','[4,\"ItemBriefcase100oz\",1]',0,696,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7741,'[\"pook_H13_civ_yellow\",2]',10,'[8,\"ItemBriefcase100oz\",1]','[4,\"ItemBriefcase100oz\",1]',0,697,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7742,'[\"pook_H13_civ_ru_black\",2]',10,'[8,\"ItemBriefcase100oz\",1]','[4,\"ItemBriefcase100oz\",1]',0,696,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7743,'[\"pook_H13_civ_ru_black\",2]',10,'[8,\"ItemBriefcase100oz\",1]','[4,\"ItemBriefcase100oz\",1]',0,697,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7744,'[\"pook_H13_gunship\",2]',10,'[5,\"ItemTopaz\",1]','[2,\"ItemTopaz\",1]',0,696,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7745,'[\"pook_H13_gunship\",2]',10,'[5,\"ItemTopaz\",1]','[2,\"ItemTopaz\",1]',0,697,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7746,'[\"pook_H13_transport_GUE\",2]',10,'[2,\"ItemTopaz\",1]','[1,\"ItemTopaz\",1]',0,697,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7747,'[\"pook_H13_transport_GUE\",2]',10,'[2,\"ItemTopaz\",1]','[1,\"ItemTopaz\",1]',0,696,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7748,'[\"AH6J_EP1\",2]',24,'[6,\"ItemTopaz\",1]','[3,\"ItemTopaz\",1]',0,696,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7749,'[\"AH6J_EP1\",2]',10,'[6,\"ItemTopaz\",1]','[3,\"ItemTopaz\",1]',0,697,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7750,'[\"10Rnd_127x99_m107\",1]',20,'[1,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar\",1]',0,718,'trade_items');
INSERT INTO `traders_data` VALUES(7751,'[\"10Rnd_127x99_m107\",1]',25,'[1,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar\",1]',0,719,'trade_items');
INSERT INTO `traders_data` VALUES(7752,'[\"5Rnd_127x108_KSVK\",1]',20,'[1,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar\",1]',0,718,'trade_items');
INSERT INTO `traders_data` VALUES(7753,'[\"5Rnd_127x108_KSVK\",1]',20,'[1,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar\",1]',0,719,'trade_items');
INSERT INTO `traders_data` VALUES(7754,'[\"5Rnd_86x70_L115A1\",1]',20,'[1,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar\",1]',0,718,'trade_items');
INSERT INTO `traders_data` VALUES(7755,'[\"5Rnd_86x70_L115A1\",1]',20,'[1,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar\",1]',0,719,'trade_items');
INSERT INTO `traders_data` VALUES(7778,'[\"SCAR_H_CQC_CCO_SD\",3]',57,'[1,\"ItemBriefcase50oz\",1]','[1,\"ItemBriefcase20oz\",1]',0,477,'trade_weapons');
INSERT INTO `traders_data` VALUES(7779,'[\"SCAR_H_CQC_CCO_SD\",3]',64,'[1,\"ItemBriefcase50oz\",1]','[1,\"ItemBriefcase20oz\",1]',0,627,'trade_weapons');
INSERT INTO `traders_data` VALUES(7780,'[\"AAV\",2]',9,'[3,\"ItemEmerald\",1]','[1,\"ItemEmerald\",1]',0,694,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7781,'[\"AAV\",2]',10,'[3,\"ItemEmerald\",1]','[1,\"ItemEmerald\",1]',0,695,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7782,'[\"BAF_Jackal2_L2A1_w\",2]',10,'[6,\"ItemTopaz\",1]','[1,\"ItemTopaz\",1]',0,694,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7783,'[\"BAF_Jackal2_L2A1_w\",2]',10,'[6,\"ItemTopaz\",1]','[1,\"ItemTopaz\",1]',0,695,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7784,'[\"Ka60_PMC\", 2]',10,'[1,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,493,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7785,'[\"Ka60_PMC\", 2]',10,'[1,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,512,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7786,'[\"Ka60_PMC\", 2]',10,'[1,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,696,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7787,'[\"Ka60_PMC\", 2]',10,'[1,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,697,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7788,'[\"Ka60_PMC\", 2]',10,'[1,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,39,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7789,'[\"Ka60_PMC\", 2]',10,'[1,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,175,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7790,'[\"Ka60_PMC\", 2]',10,'[1,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,249,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7791,'[\"Ka60_PMC\", 2]',10,'[1,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,293,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7792,'[\"Ka60_PMC\", 2]',10,'[1,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,330,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7793,'[\"Ka60_PMC\", 2]',10,'[1,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,343,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7794,'[\"Ka60_PMC\", 2]',10,'[1,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,450,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7795,'[\"Ka60_PMC\", 2]',10,'[1,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,451,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7796,'[\"Ka60_PMC\", 2]',11,'[1,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,519,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7797,'[\"Ka60_PMC\", 2]',10,'[1,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,43,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7798,'[\"Ka60_PMC\", 2]',10,'[1,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,151,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7799,'[\"Ka60_PMC\", 2]',10,'[1,\"ItemBriefcase100oz\",1]','[1,\"ItemBriefcase100oz\",1]',0,331,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7800,'[\"UH1Y\",2]',10,'[2,\"ItemSapphire\",1]','[1,\"ItemSapphire\",1]',0,696,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7801,'[\"UH1Y\",2]',10,'[2,\"ItemSapphire\",1]','[1,\"ItemSapphire\",1]',0,697,'trade_any_vehicle');
INSERT INTO `traders_data` VALUES(7808,'[\"50Rnd_127x107_DSHKM\",1]',21,'[5,\"ItemGoldBar10oz\",1]','[1,\"ItemGoldBar10oz\",1]',0,527,'trade_items');
INSERT INTO `traders_data` VALUES(7809,'[\"ItemSodaMtngreen\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,498,'trade_items');
INSERT INTO `traders_data` VALUES(7810,'[\"ItemSodaMtngreen\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,601,'trade_items');
INSERT INTO `traders_data` VALUES(7811,'[\"ItemSodaMtngreen\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,633,'trade_items');
INSERT INTO `traders_data` VALUES(7812,'[\"ItemSodaMtngreen\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,684,'trade_items');
INSERT INTO `traders_data` VALUES(7813,'[\"ItemSodaMtngreen\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,691,'trade_items');
INSERT INTO `traders_data` VALUES(7819,'[\"ItemSodaClays\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,498,'trade_items');
INSERT INTO `traders_data` VALUES(7820,'[\"ItemSodaClays\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,601,'trade_items');
INSERT INTO `traders_data` VALUES(7821,'[\"ItemSodaClays\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,633,'trade_items');
INSERT INTO `traders_data` VALUES(7822,'[\"ItemSodaClays\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,684,'trade_items');
INSERT INTO `traders_data` VALUES(7823,'[\"ItemSodaClays\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,691,'trade_items');
INSERT INTO `traders_data` VALUES(7824,'[\"ItemSodaSmasht\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,498,'trade_items');
INSERT INTO `traders_data` VALUES(7825,'[\"ItemSodaSmasht\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,601,'trade_items');
INSERT INTO `traders_data` VALUES(7826,'[\"ItemSodaSmasht\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,633,'trade_items');
INSERT INTO `traders_data` VALUES(7827,'[\"ItemSodaSmasht\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,684,'trade_items');
INSERT INTO `traders_data` VALUES(7828,'[\"ItemSodaSmasht\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,691,'trade_items');
INSERT INTO `traders_data` VALUES(7829,'[\"ItemSodaDrwaste\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,498,'trade_items');
INSERT INTO `traders_data` VALUES(7830,'[\"ItemSodaDrwaste\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,601,'trade_items');
INSERT INTO `traders_data` VALUES(7831,'[\"ItemSodaDrwaste\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,633,'trade_items');
INSERT INTO `traders_data` VALUES(7832,'[\"ItemSodaDrwaste\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,684,'trade_items');
INSERT INTO `traders_data` VALUES(7833,'[\"ItemSodaDrwaste\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,691,'trade_items');
INSERT INTO `traders_data` VALUES(7834,'[\"ItemSodaLemonade\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,498,'trade_items');
INSERT INTO `traders_data` VALUES(7835,'[\"ItemSodaLemonade\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,601,'trade_items');
INSERT INTO `traders_data` VALUES(7836,'[\"ItemSodaLemonade\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,633,'trade_items');
INSERT INTO `traders_data` VALUES(7837,'[\"ItemSodaLemonade\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,684,'trade_items');
INSERT INTO `traders_data` VALUES(7838,'[\"ItemSodaLemonade\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,691,'trade_items');
INSERT INTO `traders_data` VALUES(7839,'[\"ItemSodaLvg\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,498,'trade_items');
INSERT INTO `traders_data` VALUES(7840,'[\"ItemSodaLvg\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,601,'trade_items');
INSERT INTO `traders_data` VALUES(7841,'[\"ItemSodaLvg\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,633,'trade_items');
INSERT INTO `traders_data` VALUES(7842,'[\"ItemSodaLvg\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,684,'trade_items');
INSERT INTO `traders_data` VALUES(7843,'[\"ItemSodaLvg\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,691,'trade_items');
INSERT INTO `traders_data` VALUES(7844,'[\"ItemSodaMzly\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,498,'trade_items');
INSERT INTO `traders_data` VALUES(7845,'[\"ItemSodaMzly\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,601,'trade_items');
INSERT INTO `traders_data` VALUES(7846,'[\"ItemSodaMzly\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,633,'trade_items');
INSERT INTO `traders_data` VALUES(7847,'[\"ItemSodaMzly\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,684,'trade_items');
INSERT INTO `traders_data` VALUES(7848,'[\"ItemSodaMzly\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,691,'trade_items');
INSERT INTO `traders_data` VALUES(7849,'[\"ItemSodaRabbit\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,498,'trade_items');
INSERT INTO `traders_data` VALUES(7850,'[\"ItemSodaRabbit\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,601,'trade_items');
INSERT INTO `traders_data` VALUES(7851,'[\"ItemSodaRabbit\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,633,'trade_items');
INSERT INTO `traders_data` VALUES(7852,'[\"ItemSodaRabbit\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,684,'trade_items');
INSERT INTO `traders_data` VALUES(7853,'[\"ItemSodaRabbit\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,691,'trade_items');
INSERT INTO `traders_data` VALUES(7854,'[\"FoodCanGriff\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,579,'trade_items');
INSERT INTO `traders_data` VALUES(7855,'[\"FoodCanGriff\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,629,'trade_items');
INSERT INTO `traders_data` VALUES(7856,'[\"FoodCanGriff\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,635,'trade_items');
INSERT INTO `traders_data` VALUES(7857,'[\"FoodCanGriff\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,687,'trade_items');
INSERT INTO `traders_data` VALUES(7858,'[\"FoodCanGriff\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,692,'trade_items');
INSERT INTO `traders_data` VALUES(7859,'[\"FoodCanBadguy\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,579,'trade_items');
INSERT INTO `traders_data` VALUES(7860,'[\"FoodCanBadguy\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,629,'trade_items');
INSERT INTO `traders_data` VALUES(7861,'[\"FoodCanBadguy\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,635,'trade_items');
INSERT INTO `traders_data` VALUES(7862,'[\"FoodCanBadguy\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,687,'trade_items');
INSERT INTO `traders_data` VALUES(7863,'[\"FoodCanBadguy\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,692,'trade_items');
INSERT INTO `traders_data` VALUES(7864,'[\"FoodCanBoneboy\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,579,'trade_items');
INSERT INTO `traders_data` VALUES(7865,'[\"FoodCanBoneboy\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,629,'trade_items');
INSERT INTO `traders_data` VALUES(7866,'[\"FoodCanBoneboy\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,635,'trade_items');
INSERT INTO `traders_data` VALUES(7867,'[\"FoodCanBoneboy\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,687,'trade_items');
INSERT INTO `traders_data` VALUES(7868,'[\"FoodCanBoneboy\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,692,'trade_items');
INSERT INTO `traders_data` VALUES(7869,'[\"FoodCanCorn\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,579,'trade_items');
INSERT INTO `traders_data` VALUES(7870,'[\"FoodCanCorn\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,629,'trade_items');
INSERT INTO `traders_data` VALUES(7871,'[\"FoodCanCorn\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,635,'trade_items');
INSERT INTO `traders_data` VALUES(7872,'[\"FoodCanCorn\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,687,'trade_items');
INSERT INTO `traders_data` VALUES(7873,'[\"FoodCanCorn\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,692,'trade_items');
INSERT INTO `traders_data` VALUES(7874,'[\"FoodCanCurgon\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,579,'trade_items');
INSERT INTO `traders_data` VALUES(7875,'[\"FoodCanCurgon\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,629,'trade_items');
INSERT INTO `traders_data` VALUES(7876,'[\"FoodCanCurgon\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,635,'trade_items');
INSERT INTO `traders_data` VALUES(7877,'[\"FoodCanCurgon\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,687,'trade_items');
INSERT INTO `traders_data` VALUES(7878,'[\"FoodCanCurgon\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,692,'trade_items');
INSERT INTO `traders_data` VALUES(7879,'[\"FoodCanDemon\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,579,'trade_items');
INSERT INTO `traders_data` VALUES(7880,'[\"FoodCanDemon\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,629,'trade_items');
INSERT INTO `traders_data` VALUES(7881,'[\"FoodCanDemon\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,635,'trade_items');
INSERT INTO `traders_data` VALUES(7882,'[\"FoodCanDemon\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,687,'trade_items');
INSERT INTO `traders_data` VALUES(7883,'[\"FoodCanDemon\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,692,'trade_items');
INSERT INTO `traders_data` VALUES(7884,'[\"FoodCanFraggleos\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,579,'trade_items');
INSERT INTO `traders_data` VALUES(7885,'[\"FoodCanFraggleos\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,629,'trade_items');
INSERT INTO `traders_data` VALUES(7886,'[\"FoodCanFraggleos\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,635,'trade_items');
INSERT INTO `traders_data` VALUES(7887,'[\"FoodCanFraggleos\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,687,'trade_items');
INSERT INTO `traders_data` VALUES(7888,'[\"FoodCanFraggleos\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,692,'trade_items');
INSERT INTO `traders_data` VALUES(7889,'[\"FoodCanHerpy\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,579,'trade_items');
INSERT INTO `traders_data` VALUES(7890,'[\"FoodCanHerpy\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,629,'trade_items');
INSERT INTO `traders_data` VALUES(7891,'[\"FoodCanHerpy\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,635,'trade_items');
INSERT INTO `traders_data` VALUES(7892,'[\"FoodCanHerpy\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,687,'trade_items');
INSERT INTO `traders_data` VALUES(7893,'[\"FoodCanHerpy\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,692,'trade_items');
INSERT INTO `traders_data` VALUES(7894,'[\"FoodCanOrlok\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,579,'trade_items');
INSERT INTO `traders_data` VALUES(7895,'[\"FoodCanOrlok\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,629,'trade_items');
INSERT INTO `traders_data` VALUES(7896,'[\"FoodCanOrlok\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,635,'trade_items');
INSERT INTO `traders_data` VALUES(7897,'[\"FoodCanOrlok\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,687,'trade_items');
INSERT INTO `traders_data` VALUES(7898,'[\"FoodCanOrlok\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,692,'trade_items');
INSERT INTO `traders_data` VALUES(7899,'[\"FoodCanPowell\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,579,'trade_items');
INSERT INTO `traders_data` VALUES(7900,'[\"FoodCanPowell\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,629,'trade_items');
INSERT INTO `traders_data` VALUES(7901,'[\"FoodCanPowell\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,635,'trade_items');
INSERT INTO `traders_data` VALUES(7902,'[\"FoodCanPowell\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,687,'trade_items');
INSERT INTO `traders_data` VALUES(7903,'[\"FoodCanPowell\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,692,'trade_items');
INSERT INTO `traders_data` VALUES(7904,'[\"FoodCanTylers\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,579,'trade_items');
INSERT INTO `traders_data` VALUES(7905,'[\"FoodCanTylers\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,629,'trade_items');
INSERT INTO `traders_data` VALUES(7906,'[\"FoodCanTylers\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,635,'trade_items');
INSERT INTO `traders_data` VALUES(7907,'[\"FoodCanTylers\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,687,'trade_items');
INSERT INTO `traders_data` VALUES(7908,'[\"FoodCanTylers\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,692,'trade_items');
INSERT INTO `traders_data` VALUES(7909,'[\"FoodPumpkin\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,579,'trade_items');
INSERT INTO `traders_data` VALUES(7910,'[\"FoodPumpkin\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,629,'trade_items');
INSERT INTO `traders_data` VALUES(7911,'[\"FoodPumpkin\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,635,'trade_items');
INSERT INTO `traders_data` VALUES(7912,'[\"FoodPumpkin\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,687,'trade_items');
INSERT INTO `traders_data` VALUES(7913,'[\"FoodPumpkin\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,692,'trade_items');
INSERT INTO `traders_data` VALUES(7914,'[\"ItemKiloHemp\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,579,'trade_items');
INSERT INTO `traders_data` VALUES(7915,'[\"ItemKiloHemp\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,629,'trade_items');
INSERT INTO `traders_data` VALUES(7916,'[\"ItemKiloHemp\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,635,'trade_items');
INSERT INTO `traders_data` VALUES(7917,'[\"ItemKiloHemp\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,687,'trade_items');
INSERT INTO `traders_data` VALUES(7918,'[\"ItemKiloHemp\",1]',20,'[2,\"ItemGoldBar\",1]','[1,\"ItemGoldBar\",1]',0,692,'trade_items');

-- ----------------------------------
-- Table structure for table `trader_tids`
-- ----------------------------------

CREATE TABLE `trader_tids` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `trader` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=720 DEFAULT CHARSET=utf8;

-- ----------------------------------
-- Dumping data for table `trader_tids`
-- ----------------------------------

INSERT INTO `trader_tids` VALUES (1,'Sidearm',1);
INSERT INTO `trader_tids` VALUES(2,'Rifles',1);
INSERT INTO `trader_tids` VALUES(3,'Shotguns and Single-shot',1);
INSERT INTO `trader_tids` VALUES(4,'Sidearm',2);
INSERT INTO `trader_tids` VALUES(5,'Rifles',2);
INSERT INTO `trader_tids` VALUES(6,'Shotguns and Single-shot',2);
INSERT INTO `trader_tids` VALUES(7,'Vehicle Parts',3);
INSERT INTO `trader_tids` VALUES(8,'Building Supplies',3);
INSERT INTO `trader_tids` VALUES(11,'Vehicle Parts',4);
INSERT INTO `trader_tids` VALUES(12,'Building Supplies',4);
INSERT INTO `trader_tids` VALUES(13,'Food and Drinks',5);
INSERT INTO `trader_tids` VALUES(14,'Backpacks',5);
INSERT INTO `trader_tids` VALUES(15,'Toolbelt Items',5);
INSERT INTO `trader_tids` VALUES(16,'Clothes',5);
INSERT INTO `trader_tids` VALUES(17,'Food and Drinks',6);
INSERT INTO `trader_tids` VALUES(18,'Backpacks',6);
INSERT INTO `trader_tids` VALUES(19,'Toolbelt Items',6);
INSERT INTO `trader_tids` VALUES(20,'Clothes',6);
INSERT INTO `trader_tids` VALUES(21,'Food and Drinks',7);
INSERT INTO `trader_tids` VALUES(22,'Backpacks',7);
INSERT INTO `trader_tids` VALUES(23,'Toolbelt Items',7);
INSERT INTO `trader_tids` VALUES(24,'Clothes',7);
INSERT INTO `trader_tids` VALUES(25,'Sidearm Ammo',8);
INSERT INTO `trader_tids` VALUES(26,'Rifle Ammo',8);
INSERT INTO `trader_tids` VALUES(27,'Shotguns and Single-shot',8);
INSERT INTO `trader_tids` VALUES(28,'Sidearm Ammo',9);
INSERT INTO `trader_tids` VALUES(29,'Rifle Ammo',9);
INSERT INTO `trader_tids` VALUES(30,'Shotguns and Single-shot',9);
INSERT INTO `trader_tids` VALUES(31,'Assault Rifle Ammo',10);
INSERT INTO `trader_tids` VALUES(32,'Machine Gun Ammo',10);
INSERT INTO `trader_tids` VALUES(33,'Sniper Rifle Ammo',10);
INSERT INTO `trader_tids` VALUES(34,'Cars',11);
INSERT INTO `trader_tids` VALUES(35,'Trucks Unarmed',11);
INSERT INTO `trader_tids` VALUES(36,'SUV',11);
INSERT INTO `trader_tids` VALUES(37,'Vans',11);
INSERT INTO `trader_tids` VALUES(38,'Bikes and ATV',11);
INSERT INTO `trader_tids` VALUES(39,'Helicopter Unarmed',11);
INSERT INTO `trader_tids` VALUES(40,'Military Unarmed',11);
INSERT INTO `trader_tids` VALUES(41,'Trucks Armed',12);
INSERT INTO `trader_tids` VALUES(42,'UAZ',12);
INSERT INTO `trader_tids` VALUES(43,'Helicopter Armed',12);
INSERT INTO `trader_tids` VALUES(44,'Military Armed',12);
INSERT INTO `trader_tids` VALUES(45,'Fuel Trucks',12);
INSERT INTO `trader_tids` VALUES(46,'Heavy Armor Unarmed',12);
INSERT INTO `trader_tids` VALUES(47,'Medical Supplies',13);
INSERT INTO `trader_tids` VALUES(48,'Chem-lites/Flares',13);
INSERT INTO `trader_tids` VALUES(49,'Smoke Grenades',13);
INSERT INTO `trader_tids` VALUES(50,'Medical Supplies',14);
INSERT INTO `trader_tids` VALUES(51,'Chem-lites/Flares',14);
INSERT INTO `trader_tids` VALUES(52,'Smoke Grenades',14);
INSERT INTO `trader_tids` VALUES(53,'Clothes',15);
INSERT INTO `trader_tids` VALUES(54,'Boats Unarmed',16);
INSERT INTO `trader_tids` VALUES(55,'Boats Armed',16);
INSERT INTO `trader_tids` VALUES(57,'Assault Rifle',17);
INSERT INTO `trader_tids` VALUES(58,'Machine Gun',17);
INSERT INTO `trader_tids` VALUES(59,'Sniper Rifle',17);
INSERT INTO `trader_tids` VALUES(60,'Explosives',17);
INSERT INTO `trader_tids` VALUES(63,'Vehicle Parts',38);
INSERT INTO `trader_tids` VALUES(64,'Building Supplies',38);
INSERT INTO `trader_tids` VALUES(65,'Medical Supplies',39);
INSERT INTO `trader_tids` VALUES(66,'Clothes',39);
INSERT INTO `trader_tids` VALUES(67,'Chem lights/Flares',39);
INSERT INTO `trader_tids` VALUES(68,'Smoke Grenades',39);
INSERT INTO `trader_tids` VALUES(70,'Food/Drink',40);
INSERT INTO `trader_tids` VALUES(72,'Backpacks',40);
INSERT INTO `trader_tids` VALUES(73,'Clothes',40);
INSERT INTO `trader_tids` VALUES(74,'Toolbelt Items',40);
INSERT INTO `trader_tids` VALUES(76,'Vehicle Parts',42);
INSERT INTO `trader_tids` VALUES(77,'Building Supplies',42);
INSERT INTO `trader_tids` VALUES(78,'Demolition Supplies',42);
INSERT INTO `trader_tids` VALUES(79,'Food/Drink',43);
INSERT INTO `trader_tids` VALUES(80,'Backpacks',43);
INSERT INTO `trader_tids` VALUES(81,'Clothes',43);
INSERT INTO `trader_tids` VALUES(82,'Toolbelt Items',43);
INSERT INTO `trader_tids` VALUES(85,'Fishing boats',45);
INSERT INTO `trader_tids` VALUES(86,'PBX',45);
INSERT INTO `trader_tids` VALUES(87,'Tour boats',46);
INSERT INTO `trader_tids` VALUES(88,'PBX',46);
INSERT INTO `trader_tids` VALUES(89,'Armed Boats',47);
INSERT INTO `trader_tids` VALUES(90,'Tracked Vehicles',48);
INSERT INTO `trader_tids` VALUES(91,'Armed Vehicles',48);
INSERT INTO `trader_tids` VALUES(92,'Fuel Trucks',48);
INSERT INTO `trader_tids` VALUES(93,'Armored Vehicles',48);
INSERT INTO `trader_tids` VALUES(94,'Vehicle Parts',49);
INSERT INTO `trader_tids` VALUES(95,'Building Supplies',49);
INSERT INTO `trader_tids` VALUES(96,'Food/Drink',50);
INSERT INTO `trader_tids` VALUES(97,'Backpacks',50);
INSERT INTO `trader_tids` VALUES(98,'Toolbelt Items',50);
INSERT INTO `trader_tids` VALUES(99,'Clothes',50);
INSERT INTO `trader_tids` VALUES(100,'Armed Choppers',51);
INSERT INTO `trader_tids` VALUES(101,'Unarmed Choppers',51);
INSERT INTO `trader_tids` VALUES(102,'Pistol Ammo',52);
INSERT INTO `trader_tids` VALUES(103,'Assault Ammo',52);
INSERT INTO `trader_tids` VALUES(104,'Heavy Ammo',52);
INSERT INTO `trader_tids` VALUES(105,'Sniper Ammo',52);
INSERT INTO `trader_tids` VALUES(106,'Pistols',53);
INSERT INTO `trader_tids` VALUES(107,'Assault Rifles',53);
INSERT INTO `trader_tids` VALUES(108,'Heavy Machine Guns',53);
INSERT INTO `trader_tids` VALUES(109,'Sniper Rifles',53);
INSERT INTO `trader_tids` VALUES(110,'Offroad Trucks',54);
INSERT INTO `trader_tids` VALUES(111,'Food/Drinks',55);
INSERT INTO `trader_tids` VALUES(112,'Clothes',55);
INSERT INTO `trader_tids` VALUES(113,'ATV\'s',56);
INSERT INTO `trader_tids` VALUES(114,'Dirt Bikes',56);
INSERT INTO `trader_tids` VALUES(115,'Trucks Armed',57);
INSERT INTO `trader_tids` VALUES(116,'Trucks Unarmed',57);
INSERT INTO `trader_tids` VALUES(117,'Cars',57);
INSERT INTO `trader_tids` VALUES(118,'Waggons',57);
INSERT INTO `trader_tids` VALUES(119,'Bus',57);
INSERT INTO `trader_tids` VALUES(120,'SUV\'s',48);
INSERT INTO `trader_tids` VALUES(121,'Pistols',58);
INSERT INTO `trader_tids` VALUES(122,'Assault Rifles',58);
INSERT INTO `trader_tids` VALUES(123,'Sniper Rifles',58);
INSERT INTO `trader_tids` VALUES(124,'Pistol Ammo',59);
INSERT INTO `trader_tids` VALUES(125,'Assault Ammo',59);
INSERT INTO `trader_tids` VALUES(126,'Sniper Ammo',59);
INSERT INTO `trader_tids` VALUES(128,'Vehicle Parts',61);
INSERT INTO `trader_tids` VALUES(129,'Vehicle Parts',62);
INSERT INTO `trader_tids` VALUES(130,'Clothes',20);
INSERT INTO `trader_tids` VALUES(131,'Weapons',20);
INSERT INTO `trader_tids` VALUES(132,'Vehicles',20);
INSERT INTO `trader_tids` VALUES(133,'Assault Rifle',21);
INSERT INTO `trader_tids` VALUES(134,'Machine Gun',21);
INSERT INTO `trader_tids` VALUES(135,'Sniper Rifle',21);
INSERT INTO `trader_tids` VALUES(136,'Explosives',21);
INSERT INTO `trader_tids` VALUES(137,'Assault Rifle Ammo',22);
INSERT INTO `trader_tids` VALUES(138,'Machine Gun Ammo',22);
INSERT INTO `trader_tids` VALUES(139,'Sniper Rifle Ammo',22);
INSERT INTO `trader_tids` VALUES(140,'Food and Drinks',23);
INSERT INTO `trader_tids` VALUES(141,'Backpacks',23);
INSERT INTO `trader_tids` VALUES(142,'Toolbelt Items',23);
INSERT INTO `trader_tids` VALUES(143,'Clothes',23);
INSERT INTO `trader_tids` VALUES(144,'Vehicle Parts',24);
INSERT INTO `trader_tids` VALUES(145,'Building Supplies',24);
INSERT INTO `trader_tids` VALUES(146,'Medical Supplies',25);
INSERT INTO `trader_tids` VALUES(147,'Chem-lites/Flares',25);
INSERT INTO `trader_tids` VALUES(148,'Smoke Grenades',25);
INSERT INTO `trader_tids` VALUES(149,'Trucks Armed',26);
INSERT INTO `trader_tids` VALUES(150,'UAZ',26);
INSERT INTO `trader_tids` VALUES(151,'Helicopter Armed',26);
INSERT INTO `trader_tids` VALUES(152,'Military Armed',26);
INSERT INTO `trader_tids` VALUES(153,'Fuel Trucks',26);
INSERT INTO `trader_tids` VALUES(154,'Heavy Armor Unarmed',26);
INSERT INTO `trader_tids` VALUES(155,'Vehicle Parts',27);
INSERT INTO `trader_tids` VALUES(156,'Building Supplies',27);
INSERT INTO `trader_tids` VALUES(157,'Sidearm',28);
INSERT INTO `trader_tids` VALUES(158,'Rifles',28);
INSERT INTO `trader_tids` VALUES(159,'Shotguns and Single-shot',28);
INSERT INTO `trader_tids` VALUES(160,'Sidearm Ammo',29);
INSERT INTO `trader_tids` VALUES(161,'Rifle Ammo',29);
INSERT INTO `trader_tids` VALUES(162,'Shotguns and Single-shot',29);
INSERT INTO `trader_tids` VALUES(163,'Food and Drinks',30);
INSERT INTO `trader_tids` VALUES(164,'Backpacks',30);
INSERT INTO `trader_tids` VALUES(165,'Toolbelt Items',30);
INSERT INTO `trader_tids` VALUES(166,'Clothes',30);
INSERT INTO `trader_tids` VALUES(167,'Medical Supplies',31);
INSERT INTO `trader_tids` VALUES(168,'Chem-lites/Flares',31);
INSERT INTO `trader_tids` VALUES(169,'Smoke Grenades',31);
INSERT INTO `trader_tids` VALUES(170,'Cars',32);
INSERT INTO `trader_tids` VALUES(171,'Trucks Unarmed',32);
INSERT INTO `trader_tids` VALUES(172,'SUV',32);
INSERT INTO `trader_tids` VALUES(173,'Buses and Vans',32);
INSERT INTO `trader_tids` VALUES(174,'Bikes and ATV',32);
INSERT INTO `trader_tids` VALUES(175,'Helicopter Unarmed',32);
INSERT INTO `trader_tids` VALUES(176,'Military Unarmed',32);
INSERT INTO `trader_tids` VALUES(177,'Vehicle Parts',33);
INSERT INTO `trader_tids` VALUES(178,'Building Supplies',33);
INSERT INTO `trader_tids` VALUES(179,'Food and Drinks',34);
INSERT INTO `trader_tids` VALUES(180,'Backpacks',34);
INSERT INTO `trader_tids` VALUES(181,'Toolbelt Items',34);
INSERT INTO `trader_tids` VALUES(182,'Clothes',34);
INSERT INTO `trader_tids` VALUES(185,'Airplanes',37);
INSERT INTO `trader_tids` VALUES(186,'Weapons',15);
INSERT INTO `trader_tids` VALUES(187,'Vehicles',15);
INSERT INTO `trader_tids` VALUES(188,'Food/Drinks',63);
INSERT INTO `trader_tids` VALUES(189,'Backpacks',63);
INSERT INTO `trader_tids` VALUES(190,'Toolbelt Items',63);
INSERT INTO `trader_tids` VALUES(191,'Clothes',63);
INSERT INTO `trader_tids` VALUES(192,'Cargo Planes',64);
INSERT INTO `trader_tids` VALUES(193,'Medical Supplies',66);
INSERT INTO `trader_tids` VALUES(194,'Cars',65);
INSERT INTO `trader_tids` VALUES(195,'Food/Drinks',67);
INSERT INTO `trader_tids` VALUES(196,'Backpacks',67);
INSERT INTO `trader_tids` VALUES(197,'Toolbelt Items',67);
INSERT INTO `trader_tids` VALUES(198,'Clothes',67);
INSERT INTO `trader_tids` VALUES(199,'Cars',68);
INSERT INTO `trader_tids` VALUES(200,'Trucks Unarmed',68);
INSERT INTO `trader_tids` VALUES(201,'Trucks Armed',68);
INSERT INTO `trader_tids` VALUES(202,'Military Unarmed',68);
INSERT INTO `trader_tids` VALUES(203,'UAZ',68);
INSERT INTO `trader_tids` VALUES(204,'Helicopters Unarmed',68);
INSERT INTO `trader_tids` VALUES(205,'Pistol Ammo',69);
INSERT INTO `trader_tids` VALUES(206,'Rifle Ammo',69);
INSERT INTO `trader_tids` VALUES(207,'Heavy Ammo',69);
INSERT INTO `trader_tids` VALUES(208,'Sniper Ammo',69);
INSERT INTO `trader_tids` VALUES(209,'Pistols',70);
INSERT INTO `trader_tids` VALUES(210,'Rifles',70);
INSERT INTO `trader_tids` VALUES(211,'Heavy Machine Guns',70);
INSERT INTO `trader_tids` VALUES(212,'Sniper Rifles',70);
INSERT INTO `trader_tids` VALUES(213,'Vehicle Parts',71);
INSERT INTO `trader_tids` VALUES(214,'Building Supplies',71);
INSERT INTO `trader_tids` VALUES(215,'Explosives',71);
INSERT INTO `trader_tids` VALUES(216,'Armored Vehicles',72);
INSERT INTO `trader_tids` VALUES(217,'SUV',72);
INSERT INTO `trader_tids` VALUES(218,'ATV/Motorcycles ',72);
INSERT INTO `trader_tids` VALUES(219,'Bus/Van/Bikes',72);
INSERT INTO `trader_tids` VALUES(220,'Armed Choppers',72);
INSERT INTO `trader_tids` VALUES(221,'Medical Supplies',73);
INSERT INTO `trader_tids` VALUES(222,'Chemlights/Flares',73);
INSERT INTO `trader_tids` VALUES(223,'Smoke Grenades',73);
INSERT INTO `trader_tids` VALUES(224,'Food/Drinks',74);
INSERT INTO `trader_tids` VALUES(225,'Backpacks',74);
INSERT INTO `trader_tids` VALUES(226,'Toolbelt Items',74);
INSERT INTO `trader_tids` VALUES(227,'Clothes',74);
INSERT INTO `trader_tids` VALUES(228,'Pistol Ammo',76);
INSERT INTO `trader_tids` VALUES(229,'Rifle Ammo',76);
INSERT INTO `trader_tids` VALUES(230,'Heavy Ammo',76);
INSERT INTO `trader_tids` VALUES(231,'Sniper Ammo',76);
INSERT INTO `trader_tids` VALUES(232,'Pistols',77);
INSERT INTO `trader_tids` VALUES(233,'Rifles',77);
INSERT INTO `trader_tids` VALUES(234,'Heavy Machine Guns',77);
INSERT INTO `trader_tids` VALUES(235,'Sniper Rifles',77);
INSERT INTO `trader_tids` VALUES(236,'Clothes',78);
INSERT INTO `trader_tids` VALUES(237,'Weapons',78);
INSERT INTO `trader_tids` VALUES(238,'Vehicles',78);
INSERT INTO `trader_tids` VALUES(239,'Armed Choppers',79);
INSERT INTO `trader_tids` VALUES(241,'Assault Rifle',80);
INSERT INTO `trader_tids` VALUES(242,'Pistols',80);
INSERT INTO `trader_tids` VALUES(243,'Heavy Machine Guns',80);
INSERT INTO `trader_tids` VALUES(244,'Sniper Rifles',80);
INSERT INTO `trader_tids` VALUES(245,'Assault Ammo',81);
INSERT INTO `trader_tids` VALUES(246,'Pistol Ammo',81);
INSERT INTO `trader_tids` VALUES(247,'Heavy Ammo',81);
INSERT INTO `trader_tids` VALUES(248,'Sniper Rifle Ammo',81);
INSERT INTO `trader_tids` VALUES(249,'Helicopter Unarmed',82);
INSERT INTO `trader_tids` VALUES(250,'Building Supplies',83);
INSERT INTO `trader_tids` VALUES(251,'PBX',84);
INSERT INTO `trader_tids` VALUES(254,'Boats Unarmed',84);
INSERT INTO `trader_tids` VALUES(257,'Clothes',86);
INSERT INTO `trader_tids` VALUES(258,'Weapons',86);
INSERT INTO `trader_tids` VALUES(259,'Military Armed',87);
INSERT INTO `trader_tids` VALUES(260,'Toolbelt Items',83);
INSERT INTO `trader_tids` VALUES(261,'Vehicle Parts',83);
INSERT INTO `trader_tids` VALUES(262,'Medical Supplies',88);
INSERT INTO `trader_tids` VALUES(264,'Chem-lites/Flares',88);
INSERT INTO `trader_tids` VALUES(265,'Smoke Grenades',88);
INSERT INTO `trader_tids` VALUES(266,'Medical Supplies',89);
INSERT INTO `trader_tids` VALUES(267,'Chem-lites/Flares',89);
INSERT INTO `trader_tids` VALUES(268,'Airplanes',90);
INSERT INTO `trader_tids` VALUES(269,'Smoke Grenades',89);
INSERT INTO `trader_tids` VALUES(270,'Building Supplies',91);
INSERT INTO `trader_tids` VALUES(271,'Vehicle Parts',91);
INSERT INTO `trader_tids` VALUES(272,'Cars',92);
INSERT INTO `trader_tids` VALUES(273,'Bus/Van/Bikes',92);
INSERT INTO `trader_tids` VALUES(274,'Trucks Unarmed',92);
INSERT INTO `trader_tids` VALUES(275,'Trucks Armed',92);
INSERT INTO `trader_tids` VALUES(276,'Backpacks',93);
INSERT INTO `trader_tids` VALUES(277,'Food/Drinks',93);
INSERT INTO `trader_tids` VALUES(278,'Food and Drinks',93);
INSERT INTO `trader_tids` VALUES(279,'Toolbelt Items',93);
INSERT INTO `trader_tids` VALUES(280,'Backpacks',94);
INSERT INTO `trader_tids` VALUES(281,'Clothes',94);
INSERT INTO `trader_tids` VALUES(282,'Food and Drinks',94);
INSERT INTO `trader_tids` VALUES(283,'Toolbelt Items',94);
INSERT INTO `trader_tids` VALUES(284,'Medical Supplies',95);
INSERT INTO `trader_tids` VALUES(285,'Assault Rifle',96);
INSERT INTO `trader_tids` VALUES(286,'Pistols',96);
INSERT INTO `trader_tids` VALUES(287,'Sniper Rifles',96);
INSERT INTO `trader_tids` VALUES(288,'Assault Rifle Ammo',97);
INSERT INTO `trader_tids` VALUES(289,'Pistol Ammo',97);
INSERT INTO `trader_tids` VALUES(290,'Boats Armed',98);
INSERT INTO `trader_tids` VALUES(291,'Backpacks',99);
INSERT INTO `trader_tids` VALUES(292,'Armed Choppers',100);
INSERT INTO `trader_tids` VALUES(293,'Helicopter Unarmed',100);
INSERT INTO `trader_tids` VALUES(294,'Building Supplies',101);
INSERT INTO `trader_tids` VALUES(295,'Vehicle Parts',101);
INSERT INTO `trader_tids` VALUES(297,'Safes',86);
INSERT INTO `trader_tids` VALUES(298,'Food/Drinks',99);
INSERT INTO `trader_tids` VALUES(299,'Toolbelt Items',99);
INSERT INTO `trader_tids` VALUES(300,'Fuel Trucks',87);
INSERT INTO `trader_tids` VALUES(301,'Clothes',99);
INSERT INTO `trader_tids` VALUES(302,'Sniper Rifle Ammo',97);
INSERT INTO `trader_tids` VALUES(303,'Airplanes',103);
INSERT INTO `trader_tids` VALUES(304,'ATV/Motorcycles ',92);
INSERT INTO `trader_tids` VALUES(305,'UAZ',92);
INSERT INTO `trader_tids` VALUES(306,'Military Unarmed',87);
INSERT INTO `trader_tids` VALUES(307,'SUV',92);
INSERT INTO `trader_tids` VALUES(308,'Military Unarmed',48);
INSERT INTO `trader_tids` VALUES(309,'Vehicle Parts',104);
INSERT INTO `trader_tids` VALUES(310,'Building Supplies',104);
INSERT INTO `trader_tids` VALUES(311,'Toolbelt Items',104);
INSERT INTO `trader_tids` VALUES(312,'Food/Drinks',105);
INSERT INTO `trader_tids` VALUES(313,'Clothes',105);
INSERT INTO `trader_tids` VALUES(314,'Backpacks',105);
INSERT INTO `trader_tids` VALUES(315,'Food/Drinks',106);
INSERT INTO `trader_tids` VALUES(316,'Clothes',106);
INSERT INTO `trader_tids` VALUES(317,'Backpacks',106);
INSERT INTO `trader_tids` VALUES(318,'Medical Supplies',107);
INSERT INTO `trader_tids` VALUES(319,'Chem lights/Flares',107);
INSERT INTO `trader_tids` VALUES(320,'Pistol Ammo',108);
INSERT INTO `trader_tids` VALUES(321,'Rifle Ammo',108);
INSERT INTO `trader_tids` VALUES(322,'LMG Ammo',108);
INSERT INTO `trader_tids` VALUES(323,'Sniper Ammo',108);
INSERT INTO `trader_tids` VALUES(324,'SMG Ammo',108);
INSERT INTO `trader_tids` VALUES(325,'Pistols',109);
INSERT INTO `trader_tids` VALUES(326,'Assault Rifles',109);
INSERT INTO `trader_tids` VALUES(327,'Light Machine Guns',109);
INSERT INTO `trader_tids` VALUES(328,'Sniper Rifles',109);
INSERT INTO `trader_tids` VALUES(330,'Helicopter Unarmed',110);
INSERT INTO `trader_tids` VALUES(331,'Helicopter Armed',110);
INSERT INTO `trader_tids` VALUES(332,'Armored Vehicles',110);
INSERT INTO `trader_tids` VALUES(333,'Fuel Trucks',110);
INSERT INTO `trader_tids` VALUES(334,'URALs',110);
INSERT INTO `trader_tids` VALUES(335,'Land Rovers',110);
INSERT INTO `trader_tids` VALUES(336,'Pistols',111);
INSERT INTO `trader_tids` VALUES(337,'Assault Rifles',111);
INSERT INTO `trader_tids` VALUES(338,'Sniper Rifles',111);
INSERT INTO `trader_tids` VALUES(339,'Pistol Ammo',112);
INSERT INTO `trader_tids` VALUES(340,'Rifle Ammo',112);
INSERT INTO `trader_tids` VALUES(341,'LMG Ammo',112);
INSERT INTO `trader_tids` VALUES(342,'Sniper Ammo',112);
INSERT INTO `trader_tids` VALUES(343,'Helicopter Unarmed',113);
INSERT INTO `trader_tids` VALUES(344,'Armed Chopper',113);
INSERT INTO `trader_tids` VALUES(345,'Cars',113);
INSERT INTO `trader_tids` VALUES(346,'Motorcycles/ATV\'s',113);
INSERT INTO `trader_tids` VALUES(347,'Boats Unarmed',114);
INSERT INTO `trader_tids` VALUES(348,'Boats Armed',114);
INSERT INTO `trader_tids` VALUES(349,'ATV/Motorcycles ',115);
INSERT INTO `trader_tids` VALUES(350,'Cars',115);
INSERT INTO `trader_tids` VALUES(351,'Bus/Van/Bikes',115);
INSERT INTO `trader_tids` VALUES(352,'SUV',115);
INSERT INTO `trader_tids` VALUES(353,'Trucks Armed',115);
INSERT INTO `trader_tids` VALUES(354,'Trucks Unarmed',115);
INSERT INTO `trader_tids` VALUES(355,'UAZ',115);
INSERT INTO `trader_tids` VALUES(356,'Vehicle Parts',116);
INSERT INTO `trader_tids` VALUES(357,'Building Supplies',116);
INSERT INTO `trader_tids` VALUES(358,'Toolbelt Items',116);
INSERT INTO `trader_tids` VALUES(361,'Weapons',119);
INSERT INTO `trader_tids` VALUES(362,'Vehicles',119);
INSERT INTO `trader_tids` VALUES(363,'Clothes',119);
INSERT INTO `trader_tids` VALUES(364,'Ammunition',119);
INSERT INTO `trader_tids` VALUES(365,'Safes',119);
INSERT INTO `trader_tids` VALUES(366,'Shotguns and Single-shot',111);
INSERT INTO `trader_tids` VALUES(367,'Shotguns and Single-shot Ammo',112);
INSERT INTO `trader_tids` VALUES(368,'Sub Machine Guns',109);
INSERT INTO `trader_tids` VALUES(369,'Sniper Ammo',8);
INSERT INTO `trader_tids` VALUES(370,'Sniper Rifles',1);
INSERT INTO `trader_tids` VALUES(372,'Sniper Ammo',9);
INSERT INTO `trader_tids` VALUES(374,'Pistol Ammo',10);
INSERT INTO `trader_tids` VALUES(375,'Sniper Rifles',2);
INSERT INTO `trader_tids` VALUES(376,'Sub Machine Guns',2);
INSERT INTO `trader_tids` VALUES(377,'SMG Ammo',9);
INSERT INTO `trader_tids` VALUES(378,'SMG Ammo',10);
INSERT INTO `trader_tids` VALUES(379,'Sub Machine Guns',17);
INSERT INTO `trader_tids` VALUES(380,'Sub Machine Guns',21);
INSERT INTO `trader_tids` VALUES(381,'SMG Ammo',22);
INSERT INTO `trader_tids` VALUES(382,'Sniper Rifles',28);
INSERT INTO `trader_tids` VALUES(383,'Sniper Ammo',29);
INSERT INTO `trader_tids` VALUES(384,'Pistols',21);
INSERT INTO `trader_tids` VALUES(385,'Pistol Ammo',22);
INSERT INTO `trader_tids` VALUES(386,'Airplanes',120);
INSERT INTO `trader_tids` VALUES(388,'Attack Choppers',120);
INSERT INTO `trader_tids` VALUES(389,'Airplanes',121);
INSERT INTO `trader_tids` VALUES(391,'Medical Supplies',123);
INSERT INTO `trader_tids` VALUES(392,'LMG Ammo',124);
INSERT INTO `trader_tids` VALUES(393,'Pistol Ammo',124);
INSERT INTO `trader_tids` VALUES(394,'Rifle Ammo',124);
INSERT INTO `trader_tids` VALUES(395,'Shotguns and Single-shot Ammo',124);
INSERT INTO `trader_tids` VALUES(396,'Sniper Ammo',124);
INSERT INTO `trader_tids` VALUES(397,'Light Machine Guns',125);
INSERT INTO `trader_tids` VALUES(398,'Pistols',125);
INSERT INTO `trader_tids` VALUES(399,'Assault Rifles',125);
INSERT INTO `trader_tids` VALUES(400,'Shotguns and Single-shot',125);
INSERT INTO `trader_tids` VALUES(401,'Sniper Rifles',125);
INSERT INTO `trader_tids` VALUES(402,'Ammunition',126);
INSERT INTO `trader_tids` VALUES(403,'Weapons',126);
INSERT INTO `trader_tids` VALUES(404,'Clothes',126);
INSERT INTO `trader_tids` VALUES(405,'Vehicles',126);
INSERT INTO `trader_tids` VALUES(406,'Safes',126);
INSERT INTO `trader_tids` VALUES(407,'LMG Ammo',127);
INSERT INTO `trader_tids` VALUES(408,'Pistol Ammo',127);
INSERT INTO `trader_tids` VALUES(409,'Rifle Ammo',127);
INSERT INTO `trader_tids` VALUES(410,'SMG Ammo',127);
INSERT INTO `trader_tids` VALUES(411,'Sniper Ammo',127);
INSERT INTO `trader_tids` VALUES(412,'Light Machine Guns',128);
INSERT INTO `trader_tids` VALUES(413,'Pistols',128);
INSERT INTO `trader_tids` VALUES(414,'Assault Rifles',128);
INSERT INTO `trader_tids` VALUES(415,'Sub Machine Guns',128);
INSERT INTO `trader_tids` VALUES(416,'Sniper Rifles',128);
INSERT INTO `trader_tids` VALUES(417,'Bus/Van/Bikes',129);
INSERT INTO `trader_tids` VALUES(418,'ATV/Motorcycles ',129);
INSERT INTO `trader_tids` VALUES(419,'Cars',129);
INSERT INTO `trader_tids` VALUES(420,'Trucks Armed',129);
INSERT INTO `trader_tids` VALUES(421,'UAZ',129);
INSERT INTO `trader_tids` VALUES(422,'Boats Unarmed',130);
INSERT INTO `trader_tids` VALUES(423,'Boats Armed',130);
INSERT INTO `trader_tids` VALUES(424,'Vehicles',131);
INSERT INTO `trader_tids` VALUES(425,'Attack Choppers',131);
INSERT INTO `trader_tids` VALUES(426,'Airplanes',132);
INSERT INTO `trader_tids` VALUES(427,'Medical Supplies',133);
INSERT INTO `trader_tids` VALUES(428,'Cars',134);
INSERT INTO `trader_tids` VALUES(429,'Fuel Trucks',134);
INSERT INTO `trader_tids` VALUES(430,'Chem lights/Flares',133);
INSERT INTO `trader_tids` VALUES(431,'SUV',134);
INSERT INTO `trader_tids` VALUES(432,'URALs',134);
INSERT INTO `trader_tids` VALUES(433,'Armored Vehicles',134);
INSERT INTO `trader_tids` VALUES(434,'Land Rovers',134);
INSERT INTO `trader_tids` VALUES(435,'Food/Drinks',135);
INSERT INTO `trader_tids` VALUES(436,'Backpacks',135);
INSERT INTO `trader_tids` VALUES(437,'Clothes',135);
INSERT INTO `trader_tids` VALUES(438,'Vehicle Parts',136);
INSERT INTO `trader_tids` VALUES(439,'Building Supplies',136);
INSERT INTO `trader_tids` VALUES(440,'Toolbelt Items',136);
INSERT INTO `trader_tids` VALUES(442,'Food/Drinks',138);
INSERT INTO `trader_tids` VALUES(443,'Chem lights/Flares',123);
INSERT INTO `trader_tids` VALUES(444,'Backpacks',138);
INSERT INTO `trader_tids` VALUES(445,'Clothes',138);
INSERT INTO `trader_tids` VALUES(446,'Vehicle Parts',139);
INSERT INTO `trader_tids` VALUES(447,'Building Supplies',139);
INSERT INTO `trader_tids` VALUES(448,'Toolbelt Items',139);
INSERT INTO `trader_tids` VALUES(449,'Armed Chopper',121);
INSERT INTO `trader_tids` VALUES(450,'Helicopter Unarmed',121);
INSERT INTO `trader_tids` VALUES(451,'Helicopter Unarmed',132);
INSERT INTO `trader_tids` VALUES(452,'Black Market Weapons',140);
INSERT INTO `trader_tids` VALUES(453,'Black Market Ammo',140);
INSERT INTO `trader_tids` VALUES(454,'Pistols',17);
INSERT INTO `trader_tids` VALUES(455,'Black Market Weapons',141);
INSERT INTO `trader_tids` VALUES(456,'Black Market Ammo',141);
INSERT INTO `trader_tids` VALUES(457,'Ammunition',15);
INSERT INTO `trader_tids` VALUES(458,'Ammunition',20);
INSERT INTO `trader_tids` VALUES(459,'Black Market Weapons',142);
INSERT INTO `trader_tids` VALUES(460,'Black Market Ammo',142);
INSERT INTO `trader_tids` VALUES(461,'URALs',11);
INSERT INTO `trader_tids` VALUES(462,'Explosives',141);
INSERT INTO `trader_tids` VALUES(463,'Backpacks',141);
INSERT INTO `trader_tids` VALUES(464,'Clothing',141);
INSERT INTO `trader_tids` VALUES(466,'BMW',131);
INSERT INTO `trader_tids` VALUES(471,'Mid Size Cars',11);
INSERT INTO `trader_tids` VALUES(473,'Cargo Trucks',11);
INSERT INTO `trader_tids` VALUES(474,'Buses',11);
INSERT INTO `trader_tids` VALUES(475,'Cargo Vans',11);
INSERT INTO `trader_tids` VALUES(476,'Clothes',143);
INSERT INTO `trader_tids` VALUES(477,'Weapons',143);
INSERT INTO `trader_tids` VALUES(478,'Ammunition',143);
INSERT INTO `trader_tids` VALUES(479,'Trucks Armed',143);
INSERT INTO `trader_tids` VALUES(480,'Assault Rifle Ammo',144);
INSERT INTO `trader_tids` VALUES(481,'Light Machine Gun Ammo',144);
INSERT INTO `trader_tids` VALUES(482,'Sniper Rifle Ammo',144);
INSERT INTO `trader_tids` VALUES(483,'Submachine Gun Ammo',144);
INSERT INTO `trader_tids` VALUES(484,'Pistol Ammo',144);
INSERT INTO `trader_tids` VALUES(485,'Assault Rifle',145);
INSERT INTO `trader_tids` VALUES(486,'Light Machine Gun',145);
INSERT INTO `trader_tids` VALUES(487,'Sniper Rifle',145);
INSERT INTO `trader_tids` VALUES(488,'Submachine Guns',145);
INSERT INTO `trader_tids` VALUES(489,'Pistols',145);
INSERT INTO `trader_tids` VALUES(491,'Military Unarmed',146);
INSERT INTO `trader_tids` VALUES(492,'Fuel Trucks',146);
INSERT INTO `trader_tids` VALUES(493,'Helicopter Armed',143);
INSERT INTO `trader_tids` VALUES(495,'Trucks',146);
INSERT INTO `trader_tids` VALUES(496,'Backpacks',147);
INSERT INTO `trader_tids` VALUES(497,'Clothes',147);
INSERT INTO `trader_tids` VALUES(498,'Drinks',147);
INSERT INTO `trader_tids` VALUES(508,'Building Supplies',150);
INSERT INTO `trader_tids` VALUES(509,'Vehicle Parts',150);
INSERT INTO `trader_tids` VALUES(510,'Toolbelt Items',150);
INSERT INTO `trader_tids` VALUES(512,'Helicopter Armed',151);
INSERT INTO `trader_tids` VALUES(517,'Airplanes',152);
INSERT INTO `trader_tids` VALUES(519,'Helicopter Unarmed',152);
INSERT INTO `trader_tids` VALUES(520,'Used Cars',153);
INSERT INTO `trader_tids` VALUES(526,'Black Market Weapons',154);
INSERT INTO `trader_tids` VALUES(527,'Black Market Ammo',154);
INSERT INTO `trader_tids` VALUES(529,'Explosives',154);
INSERT INTO `trader_tids` VALUES(530,'Building Supplies',155);
INSERT INTO `trader_tids` VALUES(531,'Vehicle Parts',155);
INSERT INTO `trader_tids` VALUES(532,'Toolbelt Items',155);
INSERT INTO `trader_tids` VALUES(534,'Trucks Armed',151);
INSERT INTO `trader_tids` VALUES(535,'Trucks Unarmed',156);
INSERT INTO `trader_tids` VALUES(536,'Bikes and ATV',156);
INSERT INTO `trader_tids` VALUES(538,'Backpacks',157);
INSERT INTO `trader_tids` VALUES(541,'Medical Supplies',158);
INSERT INTO `trader_tids` VALUES(542,'Chem-lites/Flares',158);
INSERT INTO `trader_tids` VALUES(543,'Smoke Grenades',158);
INSERT INTO `trader_tids` VALUES(555,'Wholesale',161);
INSERT INTO `trader_tids` VALUES(557,'Boats Unarmed',164);
INSERT INTO `trader_tids` VALUES(558,'Boats Armed',164);
INSERT INTO `trader_tids` VALUES(562,'Military Armed',143);
INSERT INTO `trader_tids` VALUES(563,'Buses and Vans',146);
INSERT INTO `trader_tids` VALUES(564,'Cargo Trucks',146);
INSERT INTO `trader_tids` VALUES(565,'Utility Vehicles',146);
INSERT INTO `trader_tids` VALUES(568,'Utility Vehicles',156);
INSERT INTO `trader_tids` VALUES(569,'Military Armed',151);
INSERT INTO `trader_tids` VALUES(570,'Cargo Trucks',156);
INSERT INTO `trader_tids` VALUES(573,'Shotguns and Single-shot Ammo',144);
INSERT INTO `trader_tids` VALUES(574,'Shotguns and Single-shot',145);
INSERT INTO `trader_tids` VALUES(575,'Clothing',151);
INSERT INTO `trader_tids` VALUES(577,'Ammunition',151);
INSERT INTO `trader_tids` VALUES(579,'Packaged Food',147);
INSERT INTO `trader_tids` VALUES(580,'Cooked Meats',147);
INSERT INTO `trader_tids` VALUES(585,'Used Cars',146);
INSERT INTO `trader_tids` VALUES(586,'Cargo Trucks',153);
INSERT INTO `trader_tids` VALUES(587,'Bikes and ATV',153);
INSERT INTO `trader_tids` VALUES(588,'Buses and Vans',153);
INSERT INTO `trader_tids` VALUES(589,'Fuel Trucks',153);
INSERT INTO `trader_tids` VALUES(590,'Trucks',153);
INSERT INTO `trader_tids` VALUES(591,'Utility Vehicles',153);
INSERT INTO `trader_tids` VALUES(592,'Buses and Vans',156);
INSERT INTO `trader_tids` VALUES(595,'Fuel Trucks',156);
INSERT INTO `trader_tids` VALUES(598,'Military Unarmed',153);
INSERT INTO `trader_tids` VALUES(599,'Military Unarmed',156);
INSERT INTO `trader_tids` VALUES(600,'Used Cars',156);
INSERT INTO `trader_tids` VALUES(601,'Drinks',157);
INSERT INTO `trader_tids` VALUES(602,'Assault Rifle',148);
INSERT INTO `trader_tids` VALUES(603,'Light Machine Gun',148);
INSERT INTO `trader_tids` VALUES(604,'Submachine Guns',148);
INSERT INTO `trader_tids` VALUES(605,'Sniper Rifle',148);
INSERT INTO `trader_tids` VALUES(606,'Pistols',148);
INSERT INTO `trader_tids` VALUES(607,'Shotguns and Single-shot',148);
INSERT INTO `trader_tids` VALUES(608,'Bikes and ATV',146);
INSERT INTO `trader_tids` VALUES(609,'Assault Rifle Ammo',149);
INSERT INTO `trader_tids` VALUES(610,'Light Machine Gun Ammo',149);
INSERT INTO `trader_tids` VALUES(611,'Pistol Ammo',149);
INSERT INTO `trader_tids` VALUES(612,'Submachine Gun Ammo',149);
INSERT INTO `trader_tids` VALUES(613,'Shotguns and Single-shot Ammo',149);
INSERT INTO `trader_tids` VALUES(614,'Sniper Rifle Ammo',149);
INSERT INTO `trader_tids` VALUES(615,'Assault Rifle',159);
INSERT INTO `trader_tids` VALUES(616,'Light Machine Gun',159);
INSERT INTO `trader_tids` VALUES(617,'Pistols',159);
INSERT INTO `trader_tids` VALUES(618,'Submachine Guns',159);
INSERT INTO `trader_tids` VALUES(619,'Sniper Rifle',159);
INSERT INTO `trader_tids` VALUES(620,'Shotguns and Single-shot',159);
INSERT INTO `trader_tids` VALUES(621,'Assault Rifle Ammo',160);
INSERT INTO `trader_tids` VALUES(622,'Light Machine Gun Ammo',160);
INSERT INTO `trader_tids` VALUES(623,'Shotguns and Single-shot Ammo',160);
INSERT INTO `trader_tids` VALUES(624,'Sniper Rifle Ammo',160);
INSERT INTO `trader_tids` VALUES(625,'Pistol Ammo',160);
INSERT INTO `trader_tids` VALUES(626,'Submachine Gun Ammo',160);
INSERT INTO `trader_tids` VALUES(627,'Weapons',151);
INSERT INTO `trader_tids` VALUES(628,'Clothes',157);
INSERT INTO `trader_tids` VALUES(629,'Packaged Food',157);
INSERT INTO `trader_tids` VALUES(630,'Cooked Meats',157);
INSERT INTO `trader_tids` VALUES(631,'Clothes',162);
INSERT INTO `trader_tids` VALUES(632,'Backpacks',162);
INSERT INTO `trader_tids` VALUES(633,'Drinks',162);
INSERT INTO `trader_tids` VALUES(634,'Cooked Meats',162);
INSERT INTO `trader_tids` VALUES(635,'Packaged Food',162);
INSERT INTO `trader_tids` VALUES(636,'Wholesale',163);
INSERT INTO `trader_tids` VALUES(637,'Assault Rifle',165);
INSERT INTO `trader_tids` VALUES(638,'Light Machine Gun',165);
INSERT INTO `trader_tids` VALUES(640,'Sniper Rifle',165);
INSERT INTO `trader_tids` VALUES(641,'Shotguns and Single-shot',165);
INSERT INTO `trader_tids` VALUES(642,'Submachine Guns',165);
INSERT INTO `trader_tids` VALUES(643,'Assault Rifle Ammo',166);
INSERT INTO `trader_tids` VALUES(644,'Light Machine Gun Ammo',166);
INSERT INTO `trader_tids` VALUES(646,'Pistol Ammo',166);
INSERT INTO `trader_tids` VALUES(647,'Sniper Rifle Ammo',166);
INSERT INTO `trader_tids` VALUES(648,'Submachine Gun Ammo',166);
INSERT INTO `trader_tids` VALUES(649,'Shotguns and Single-shot Ammo',166);
INSERT INTO `trader_tids` VALUES(650,'Bikes and ATV',167);
INSERT INTO `trader_tids` VALUES(651,'Buses and Vans',167);
INSERT INTO `trader_tids` VALUES(653,'Cargo Trucks',167);
INSERT INTO `trader_tids` VALUES(655,'Fuel Trucks',167);
INSERT INTO `trader_tids` VALUES(658,'Military Unarmed',167);
INSERT INTO `trader_tids` VALUES(659,'Trucks',167);
INSERT INTO `trader_tids` VALUES(660,'Used Cars',167);
INSERT INTO `trader_tids` VALUES(661,'Utility Vehicles',167);
INSERT INTO `trader_tids` VALUES(662,'Building Supplies',168);
INSERT INTO `trader_tids` VALUES(663,'Toolbelt Items',168);
INSERT INTO `trader_tids` VALUES(664,'Vehicle Parts',168);
INSERT INTO `trader_tids` VALUES(665,'Medical Supplies',169);
INSERT INTO `trader_tids` VALUES(666,'Chem-lites/Flares',169);
INSERT INTO `trader_tids` VALUES(668,'Smoke Grenades',169);
INSERT INTO `trader_tids` VALUES(669,'Chem-lites/Flares',170);
INSERT INTO `trader_tids` VALUES(670,'Medical Supplies',170);
INSERT INTO `trader_tids` VALUES(671,'Smoke Grenades',170);
INSERT INTO `trader_tids` VALUES(672,'Boats Unarmed',171);
INSERT INTO `trader_tids` VALUES(673,'Boats Armed',171);
INSERT INTO `trader_tids` VALUES(674,'Pistols',165);
INSERT INTO `trader_tids` VALUES(675,'Wholesale',172);
INSERT INTO `trader_tids` VALUES(677,'Vehicle Parts',173);
INSERT INTO `trader_tids` VALUES(678,'Building Supplies',173);
INSERT INTO `trader_tids` VALUES(679,'Toolbelt Items',173);
INSERT INTO `trader_tids` VALUES(680,'Building Supplies',174);
INSERT INTO `trader_tids` VALUES(681,'Toolbelt Items',174);
INSERT INTO `trader_tids` VALUES(682,'Vehicle Parts',174);
INSERT INTO `trader_tids` VALUES(683,'Clothes',175);
INSERT INTO `trader_tids` VALUES(684,'Drinks',175);
INSERT INTO `trader_tids` VALUES(685,'Backpacks',175);
INSERT INTO `trader_tids` VALUES(686,'Cooked Meats',175);
INSERT INTO `trader_tids` VALUES(687,'Packaged Food',175);
INSERT INTO `trader_tids` VALUES(688,'Backpacks',176);
INSERT INTO `trader_tids` VALUES(689,'Clothes',176);
INSERT INTO `trader_tids` VALUES(690,'Cooked Meats',176);
INSERT INTO `trader_tids` VALUES(691,'Drinks',176);
INSERT INTO `trader_tids` VALUES(692,'Packaged Food',176);
INSERT INTO `trader_tids` VALUES(693,'Metal and Concrete Supplies',177);
INSERT INTO `trader_tids` VALUES(694,'Heavy Armored',179);
INSERT INTO `trader_tids` VALUES(695,'Heavy Armored',180);
INSERT INTO `trader_tids` VALUES(696,'Special Helicopter',179);
INSERT INTO `trader_tids` VALUES(697,'Special Helicopter',180);
INSERT INTO `trader_tids` VALUES(700,'Metal and Concrete Supplies',178);
INSERT INTO `trader_tids` VALUES(701,'Anti Tank Weapons',179);
INSERT INTO `trader_tids` VALUES(702,'Anti Tank Weapons',180);
INSERT INTO `trader_tids` VALUES(703,'Anti Air Weapons',179);
INSERT INTO `trader_tids` VALUES(704,'Anti Air Weapons',180);
INSERT INTO `trader_tids` VALUES(705,'Anti Air Weapons',143);
INSERT INTO `trader_tids` VALUES(706,'Anti Tank Weapons',143);
INSERT INTO `trader_tids` VALUES(707,'Anti Air Weapons',151);
INSERT INTO `trader_tids` VALUES(708,'Anti Tank Weapons',151);
INSERT INTO `trader_tids` VALUES(709,'Anti Air Ammo',143);
INSERT INTO `trader_tids` VALUES(710,'Anti Tank Ammo',143);
INSERT INTO `trader_tids` VALUES(711,'Anti Air Ammo',151);
INSERT INTO `trader_tids` VALUES(712,'Anti Tank Ammo',151);
INSERT INTO `trader_tids` VALUES(713,'Anti Air Ammo',179);
INSERT INTO `trader_tids` VALUES(714,'Anti Air Ammo',180);
INSERT INTO `trader_tids` VALUES(715,'Anti Tank Ammo',179);
INSERT INTO `trader_tids` VALUES(716,'Anti Tank Ammo',180);
INSERT INTO `trader_tids` VALUES(717,'Airport Utility',152);
INSERT INTO `trader_tids` VALUES(718,'General Ammo',179);
INSERT INTO `trader_tids` VALUES(719,'General Ammo',180);

-- ----------------------------------
-- Dumping data for table `safe_zones`
-- ----------------------------------

INSERT INTO `safe_zones` (`id`, `name`, `instance_id`, `x`, `y`, `radius`) VALUES(1, 'Trader City Lenzburg', 24, 8246, 15485, 50);
INSERT INTO `safe_zones` (`id`, `name`, `instance_id`, `x`, `y`, `radius`) VALUES(2, 'Trader City Emmen', 24, 15506, 13229, 100);
INSERT INTO `safe_zones` (`id`, `name`, `instance_id`, `x`, `y`, `radius`) VALUES(3, 'Trader City Schratten', 24, 12399, 5074, 75);
INSERT INTO `safe_zones` (`id`, `name`, `instance_id`, `x`, `y`, `radius`) VALUES(4, 'Bandit Vendor', 24, 10398, 8279, 50);
INSERT INTO `safe_zones` (`id`, `name`, `instance_id`, `x`, `y`, `radius`) VALUES(5, 'Hero Vendor', 24, 5149, 4864, 50);
INSERT INTO `safe_zones` (`id`, `name`, `instance_id`, `x`, `y`, `radius`) VALUES(6, 'West Wholesaler', 24, 2122, 7807, 50);
INSERT INTO `safe_zones` (`id`, `name`, `instance_id`, `x`, `y`, `radius`) VALUES(7, 'North Wholesaler', 24, 5379, 16103, 50);
INSERT INTO `safe_zones` (`id`, `name`, `instance_id`, `x`, `y`, `radius`) VALUES(8, 'Nordic Boats', 24, 6772, 16983, 50);
INSERT INTO `safe_zones` (`id`, `name`, `instance_id`, `x`, `y`, `radius`) VALUES(9, 'Pauls Boats', 24, 16839, 5264, 50);
INSERT INTO `safe_zones` (`id`, `name`, `instance_id`, `x`, `y`, `radius`) VALUES(10, 'AWOLs Airfield', 24, 15128, 16421, 75);
INSERT INTO `safe_zones` (`id`, `name`, `instance_id`, `x`, `y`, `radius`) VALUES(11, 'Trader City Stary', 11, 6325, 7807, 100);
INSERT INTO `safe_zones` (`id`, `name`, `instance_id`, `x`, `y`, `radius`) VALUES(12, 'Trader City Bash', 11, 4063, 11664, 100);
INSERT INTO `safe_zones` (`id`, `name`, `instance_id`, `x`, `y`, `radius`) VALUES(13, 'Trader City Klen', 11, 11447, 11364, 100);
INSERT INTO `safe_zones` (`id`, `name`, `instance_id`, `x`, `y`, `radius`) VALUES(14, 'Bandit Vendor', 11, 1606, 7803, 100);
INSERT INTO `safe_zones` (`id`, `name`, `instance_id`, `x`, `y`, `radius`) VALUES(15, 'Hero Vendor', 11, 12944, 12766, 100);
INSERT INTO `safe_zones` (`id`, `name`, `instance_id`, `x`, `y`, `radius`) VALUES(16, 'Airplane Dealer', 11, 12060, 12638, 100);
