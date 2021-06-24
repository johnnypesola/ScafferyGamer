-- Scrap yard feature, backup feature for expensive vehicles  --

DROP TABLE IF EXISTS `object_data_scrap_yard`;
CREATE TABLE `object_data_scrap_yard` (
  `ObjectID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ObjectUID` bigint(24) NOT NULL DEFAULT 0,
  `Instance` int(11) unsigned NOT NULL,
  `Classname` varchar(50) DEFAULT NULL,
  `Datestamp` datetime NOT NULL,
  `LastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `CharacterID` bigint(20) unsigned NOT NULL DEFAULT 0,
  `Worldspace` varchar(128) NOT NULL DEFAULT '[]',
  `Inventory` longtext DEFAULT NULL,
  `Hitpoints` varchar(1024) NOT NULL DEFAULT '[]',
  `Fuel` double(13,5) NOT NULL DEFAULT 1.00000,
  `Damage` double(13,5) NOT NULL DEFAULT 0.00000,
  `StorageCoins` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`ObjectID`),
  KEY `ObjectUID` (`ObjectUID`) USING BTREE,
  KEY `Instance` (`Instance`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1

DROP TRIGGER IF EXISTS `to_scrap_yard`;
CREATE TRIGGER `to_scrap_yard`
AFTER DELETE ON `object_data`
FOR EACH ROW
INSERT INTO `object_data_scrap_yard` (
        `Instance`,
        `Classname`,
        `Datestamp`,
        `CharacterID`,
        `Worldspace`,
        `Inventory`,
        `Hitpoints`,
        `Fuel`,
        `Damage`,
        `StorageCoins`
) VALUES (
        old.`Instance`,
        old.`Classname`,
        old.`Datestamp`,
        old.`CharacterID`,
        old.`Worldspace`,
        REPLACE(old.`Inventory`,'"',"'"),
        '[]',
        1.0,
        old.`Damage`,
        old.`StorageCoins`
);

DROP TRIGGER IF EXISTS `from_scrap_yard`;
CREATE TRIGGER `from_scrap_yard`
AFTER INSERT ON `object_data`
FOR EACH ROW
DELETE FROM `object_data_scrap_yard` WHERE `CharacterID`=new.`CharacterID`
AND `Classname`=new.`Classname` AND `Instance`=new.`Instance` AND `CharacterID`<>0
ORDER BY `Datestamp` ASC LIMIT 1;

-- Modify destroyed vehicle cleanup to run every minute
DROP EVENT IF EXISTS `removeDamagedVehicles`;
CREATE EVENT `removeDamagedVehicles`
ON SCHEDULE EVERY 1 MINUTE STARTS '2021-06-14 15:58:34'
ON COMPLETION NOT PRESERVE ENABLE COMMENT 'Removes damaged vehicles'
DO DELETE FROM `Object_DATA` WHERE Damage >= 1;

