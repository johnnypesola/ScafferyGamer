--
-- http://dayzepoch.com/wiki/index.php?title=Server_Installation_Instructions_Extended
--

-- ----------------------------
-- Function structure for FindVehicleKeysCount
-- ----------------------------
DROP FUNCTION IF EXISTS `FindVehicleKeysCount`;
DELIMITER ;;
CREATE FUNCTION `FindVehicleKeysCount`(`keyId` INT) RETURNS int(11)
BEGIN
    DECLARE totalKeys INT DEFAULT 0;
    DECLARE keyName VARCHAR(32) DEFAULT "";
    DECLARE keysInChar INT DEFAULT 0;
    DECLARE keysInObj INT DEFAULT 0;

    SET keyName = (CASE
        WHEN `keyId` < 2501 THEN CONCAT('ItemKeyGreen', `keyId`)
        WHEN `keyId` < 5001 THEN CONCAT('ItemKeyRed', `keyId` - 2500)
        WHEN `keyId` < 7501 THEN CONCAT('ItemKeyBlue', `keyId` - 5000)
        WHEN `keyId` < 10001 THEN CONCAT('ItemKeyYellow', `keyId` - 7500)
        WHEN `keyId` < 12501 THEN CONCAT('ItemKeyBlack', `keyId` - 10000)
        ELSE 'ERROR'
    END);

    SET keysInChar = (SELECT COUNT(*) FROM `character_data` WHERE `alive` = '1' AND (`inventory_weapons` LIKE CONCAT('%', keyName, '%') OR `backpack_weapons` LIKE CONCAT('%', keyName, '%')));
    SET keysInObj = (SELECT COUNT(*) FROM `object_data_cherno` WHERE `inventory_weapons` LIKE CONCAT('%', keyName, '%')) + (SELECT COUNT(*) FROM `object_data_napf` WHERE `inventory_weapons` LIKE CONCAT('%', keyName, '%')) + (SELECT COUNT(*) FROM `object_data_intermediate` WHERE `inventory_weapons` LIKE CONCAT('%', keyName, '%'));

    RETURN (keysInChar + keysInObj);
END
;;
DELIMITER ;


-- ----------------------------
-- Event structure for removeObjectOld (nonkey vehicles)
-- ----------------------------
DROP EVENT IF EXISTS `removeObjectOld`;
DELIMITER ;;
CREATE EVENT `removeObjectOld` ON SCHEDULE EVERY 1 DAY STARTS '2017-04-22 00:00:00' COMMENT 'Removes old objects and vehicles' DO 
BEGIN
	DELETE FROM `object_data_cherno` WHERE `last_updated` < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 90 DAY) 
	AND `datestamp` < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 120 DAY) AND `object_data_cherno`.`character_id` = 0 ;
	DELETE FROM `object_data_napf` WHERE `last_updated` < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 90 DAY) 
	AND `datestamp` < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 120 DAY) AND `object_data_napf`.`character_id` = 0 ;
	DELETE FROM `object_data_intermediate` WHERE `datestamp` < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 90 DAY) 
	AND `object_data_intermediate`.`character_id` = 0 ;
END
;;
DELIMITER ;

-- ----------------------------
-- Event structure for removeObjectRecentUntouched (nonkey vehicles)
-- ----------------------------
DROP EVENT IF EXISTS `removeObjectRecentUntouched`;
DELIMITER ;;
CREATE EVENT `removeObjectRecentUntouched` ON SCHEDULE EVERY 1 DAY STARTS '2017-04-22 00:00:00' COMMENT 'Removes recent untouched vehicles' DO 
BEGIN
	DELETE FROM `object_data_cherno` WHERE `object_data_cherno`.`last_updated` = `object_data_cherno`.`datestamp` 
	AND `object_data_cherno`.`character_id` = 0
	AND `object_data_cherno`.`datestamp` < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY) ;
	DELETE FROM `object_data_napf` WHERE `object_data_napf`.`last_updated` = `object_data_napf`.`datestamp` 
	AND `object_data_napf`.`character_id` = 0
	AND `object_data_napf`.`datestamp` < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 2 DAY) ;
END
;;
DELIMITER ;

-- ----------------------------
-- Event structure for removeDamagedVehicles
-- ----------------------------
DROP EVENT IF EXISTS `removeDamagedVehicles`;
DELIMITER ;;
CREATE EVENT `removeDamagedVehicles` ON SCHEDULE EVERY 1 DAY STARTS '2017-04-22 00:00:00' COMMENT 'Removes damaged vehicles' DO
BEGIN
	DELETE FROM `object_data_cherno` WHERE damage = 1 ; 
	DELETE FROM `object_data_napf` WHERE damage = 1 ;
END
;;
DELIMITER ;

-- ----------------------------
-- Event structure for setDamageOnAge
-- ----------------------------
DROP EVENT IF EXISTS `setDamageOnAge`;
DELIMITER ;;
CREATE EVENT `setDamageOnAge` ON SCHEDULE EVERY 1 DAY STARTS '2017-04-22 00:00:00' COMMENT 'This sets damage on a wall so that it can be maintained' DO
BEGIN
	UPDATE `object_data_cherno` SET `damage`=0.1 WHERE `object_uid` <> 0 AND `character_id` <> 0 AND `datestamp` < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY) AND (`inventory_magazines` = '[]') AND (`inventory_weapons` = '[]') AND (`inventory_backpacks` = '[]') ; 
	UPDATE `object_data_napf` SET `damage`=0.1 WHERE `object_uid` <> 0 AND `character_id` <> 0 AND `datestamp` < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY) AND (`inventory_magazines` = '[]') AND (`inventory_weapons` = '[]') AND (`inventory_backpacks` = '[]') ;
END
;;
DELIMITER ;

-- ----------------------------
-- Event structure for updateStockDaily
-- ----------------------------
-- DROP EVENT IF EXISTS `updateStockDaily`;
-- DELIMITER ;;
-- CREATE EVENT `updateStockDaily` ON SCHEDULE EVERY 6 HOUR STARTS '2016-10-21 01:59:34' COMMENT 'Updates out of stock vendors' DO UPDATE `Traders_DATA` SET qty=20 WHERE qty<=20 AND afile<>'trade_any_vehicle' AND afile<>'trade_any_boat'
-- ;;
-- DELIMITER ;

-- ----------------------------
-- Event structure for updateStockWeekly
-- ----------------------------
-- DROP EVENT IF EXISTS `updateStockWeekly`;
-- DELIMITER ;;
-- CREATE EVENT `updateStockWeekly` ON SCHEDULE EVERY 7 DAY STARTS '2016-10-21 01:59:36' COMMENT 'Updates out of stock vehicle vendors ' DO UPDATE `Traders_DATA` SET qty=10 WHERE qty<=10 AND afile<>'trade_items' AND afile<>'trade_weapons' AND afile<>'trade_backpacks'
-- ;;
-- DELIMITER ;


-- ----------------------------
-- Event structure for UnlockNonKeyVehicles
-- ----------------------------
DROP EVENT IF EXISTS `UnlockNonKeyVehicles`;
DELIMITER ;;
CREATE EVENT `UnlockNonKeyVehicles` ON SCHEDULE EVERY 1 DAY STARTS '2017-04-22 00:00:00' DO
BEGIN
	UPDATE
			`object_data_cherno`
		SET
			`object_data_cherno`.`character_id` = 0
		WHERE
			`object_data_cherno`.`character_id` <> 0
			AND `object_data_cherno`.`character_id` <= 12500
			AND `object_data_cherno`.`classname` NOT LIKE 'Tent%'
			AND `object_data_cherno`.`classname` NOT LIKE '%Locked'
			AND `object_data_cherno`.`classname` NOT LIKE 'Land%'
			AND `object_data_cherno`.`classname` NOT LIKE 'Cinder%'
			AND `object_data_cherno`.`classname` NOT LIKE 'Wood%'
			AND `object_data_cherno`.`classname` NOT LIKE 'Metal%'
			AND `object_data_cherno`.`classname` NOT LIKE '%Storage%'
			AND `object_data_cherno`.`classname` NOT IN ('OutHouse_DZ', 'GunRack_DZ', 'WorkBench_DZ', 'Sandbag1_DZ', 'FireBarrel_DZ', 'DesertCamoNet_DZ', 'StickFence_DZ', 'LightPole_DZ', 'DeerStand_DZ', 'ForestLargeCamoNet_DZ', 'Plastic_Pole_EP1_DZ', 'Hedgehog_DZ', 'FuelPump_DZ', 'Fort_RazorWire', 'SandNest_DZ', 'ForestCamoNet_DZ', 'Fence_corrugated_DZ', 'CanvasHut_DZ', 'Generator_DZ')
			AND FindVehicleKeysCount(object_data_cherno.character_id) = 0 ;
	UPDATE
			`object_data_napf`
		SET
			`object_data_napf`.`character_id` = 0
		WHERE
			`object_data_napf`.`character_id` <> 0
			AND `object_data_napf`.`character_id` <= 12500
			AND `object_data_napf`.`classname` NOT LIKE 'Tent%'
			AND `object_data_napf`.`classname` NOT LIKE '%Locked'
			AND `object_data_napf`.`classname` NOT LIKE 'Land%'
			AND `object_data_napf`.`classname` NOT LIKE 'Cinder%'
			AND `object_data_napf`.`classname` NOT LIKE 'Wood%'
			AND `object_data_napf`.`classname` NOT LIKE 'Metal%'
			AND `object_data_napf`.`classname` NOT LIKE '%Storage%'
			AND `object_data_napf`.`classname` NOT IN ('OutHouse_DZ', 'GunRack_DZ', 'WorkBench_DZ', 'Sandbag1_DZ', 'FireBarrel_DZ', 'DesertCamoNet_DZ', 'StickFence_DZ', 'LightPole_DZ', 'DeerStand_DZ', 'ForestLargeCamoNet_DZ', 'Plastic_Pole_EP1_DZ', 'Hedgehog_DZ', 'FuelPump_DZ', 'Fort_RazorWire', 'SandNest_DZ', 'ForestCamoNet_DZ', 'Fence_corrugated_DZ', 'CanvasHut_DZ', 'Generator_DZ')
			AND FindVehicleKeysCount(object_data_napf.character_id) = 0 ;
	UPDATE
			`object_data_intermediate`
		SET
			`object_data_intermediate`.`character_id` = 0
		WHERE
			`object_data_intermediate`.`character_id` <> 0
			AND `object_data_intermediate`.`character_id` <= 12500
			AND FindVehicleKeysCount(object_data_intermediate.character_id) = 0 ;
END
;;
DELIMITER ;

-- ----------------------------
-- Event structure for UnlockOldKeyVehicles
-- ----------------------------
DROP EVENT IF EXISTS `UnlockOldKeyVehicles`;
DELIMITER ;;
CREATE EVENT `UnlockOldKeyVehicles` ON SCHEDULE EVERY 1 DAY STARTS '2017-04-22 00:00:00' DO
BEGIN
	UPDATE
			`object_data_cherno`
		SET
			`object_data_cherno`.`character_id` = 0
		WHERE
			`object_data_cherno`.`character_id` <> 0
			AND `object_data_cherno`.`character_id` <= 12500
			AND `object_data_cherno`.`classname` NOT LIKE 'Tent%'
			AND `object_data_cherno`.`classname` NOT LIKE 'Land%'
			AND `object_data_cherno`.`classname` NOT LIKE 'Cinder%'
			AND `object_data_cherno`.`classname` NOT LIKE 'Wood%'
			AND `object_data_cherno`.`classname` NOT LIKE 'Metal%'
			AND `object_data_cherno`.`classname` NOT IN ('OutHouse_DZ', 'GunRack_DZ', 'WorkBench_DZ', 'Sandbag1_DZ', 'FireBarrel_DZ', 'DesertCamoNet_DZ', 'StickFence_DZ', 'LightPole_DZ', 'DeerStand_DZ', 'ForestLargeCamoNet_DZ', 'Plastic_Pole_EP1_DZ', 'Hedgehog_DZ', 'FuelPump_DZ', 'Fort_RazorWire', 'SandNest_DZ', 'ForestCamoNet_DZ', 'Fence_corrugated_DZ', 'CanvasHut_DZ', 'Generator_DZ')
			AND `last_updated` < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 45 DAY) 
			AND `datestamp` < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 60 DAY) ;
	UPDATE
			`object_data_napf`
		SET
			`object_data_napf`.`character_id` = 0
		WHERE
			`object_data_napf`.`character_id` <> 0
			AND `object_data_napf`.`character_id` <= 12500
			AND `object_data_napf`.`classname` NOT LIKE 'Tent%'
			AND `object_data_napf`.`classname` NOT LIKE 'Land%'
			AND `object_data_napf`.`classname` NOT LIKE 'Cinder%'
			AND `object_data_napf`.`classname` NOT LIKE 'Wood%'
			AND `object_data_napf`.`classname` NOT LIKE 'Metal%'
			AND `object_data_napf`.`classname` NOT IN ('OutHouse_DZ', 'GunRack_DZ', 'WorkBench_DZ', 'Sandbag1_DZ', 'FireBarrel_DZ', 'DesertCamoNet_DZ', 'StickFence_DZ', 'LightPole_DZ', 'DeerStand_DZ', 'ForestLargeCamoNet_DZ', 'Plastic_Pole_EP1_DZ', 'Hedgehog_DZ', 'FuelPump_DZ', 'Fort_RazorWire', 'SandNest_DZ', 'ForestCamoNet_DZ', 'Fence_corrugated_DZ', 'CanvasHut_DZ', 'Generator_DZ')
			AND `last_updated` < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 45 DAY) 
			AND `datestamp` < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 60 DAY) ;
	UPDATE
			`object_data_intermediate`
		SET
			`object_data_intermediate`.`character_id` = 0
		WHERE
			`object_data_intermediate`.`character_id` <> 0
			AND `object_data_intermediate`.`character_id` <= 12500
			AND `datestamp` < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 45 DAY) ;
END
;;
DELIMITER ;

-- ----------------------------
-- Event structure for UnlockVehiclesInSafezones
-- ----------------------------
DELIMITER ;;
CREATE EVENT `UnlockVehiclesInSafezones` ON SCHEDULE EVERY 1 DAY STARTS '2020-06-30 00:00:00' DO 
BEGIN
  UPDATE `object_data_cherno` AS `objs` INNER JOIN `safe_zones` AS `zones` ON `objs`.`instance`=`zones`.`instance_id`
    SET `objs`.`character_id`=0
  WHERE
    `objs`.`character_id` <> 0
    AND `objs`.`character_id` <= 12500
    AND `objs`.`classname` NOT LIKE 'Tent%'
    AND `objs`.`classname` NOT LIKE 'Land%'
    AND `objs`.`classname` NOT LIKE 'Cinder%'
    AND `objs`.`classname` NOT LIKE 'Wood%'
    AND `objs`.`classname` NOT LIKE 'Metal%'
    AND `objs`.`classname` NOT IN ('OutHouse_DZ', 'GunRack_DZ', 'WorkBench_DZ', 'Sandbag1_DZ', 'FireBarrel_DZ', 'DesertCamoNet_DZ', 'StickFence_DZ', 'LightPole_DZ', 'DeerStand_DZ', 'ForestLargeCamoNet_DZ', 'Plastic_Pole_EP1_DZ', 'Hedgehog_DZ', 'FuelPump_DZ', 'Fort_RazorWire', 'SandNest_DZ', 'ForestCamoNet_DZ', 'Fence_corrugated_DZ', 'CanvasHut_DZ', 'Generator_DZ')
    AND `objs`.`ws_x`<`zones`.`x`+`zones`.`radius`
    AND `objs`.`ws_x`>`zones`.`x`-`zones`.`radius`
    AND `objs`.`ws_y`<`zones`.`y`+`zones`.`radius`
    AND `objs`.`ws_y`>`zones`.`y`-`zones`.`radius`;
  UPDATE `object_data_napf` AS `objs` INNER JOIN `safe_zones` AS `zones` ON `objs`.`instance`=`zones`.`instance_id`
    SET `objs`.`character_id`=0
  WHERE
    `objs`.`character_id` <> 0
    AND `objs`.`character_id` <= 12500
    AND `objs`.`classname` NOT LIKE 'Tent%'
    AND `objs`.`classname` NOT LIKE 'Land%'
    AND `objs`.`classname` NOT LIKE 'Cinder%'
    AND `objs`.`classname` NOT LIKE 'Wood%'
    AND `objs`.`classname` NOT LIKE 'Metal%'
    AND `objs`.`classname` NOT IN ('OutHouse_DZ', 'GunRack_DZ', 'WorkBench_DZ', 'Sandbag1_DZ', 'FireBarrel_DZ', 'DesertCamoNet_DZ', 'StickFence_DZ', 'LightPole_DZ', 'DeerStand_DZ', 'ForestLargeCamoNet_DZ', 'Plastic_Pole_EP1_DZ', 'Hedgehog_DZ', 'FuelPump_DZ', 'Fort_RazorWire', 'SandNest_DZ', 'ForestCamoNet_DZ', 'Fence_corrugated_DZ', 'CanvasHut_DZ', 'Generator_DZ')
    AND `objs`.`ws_x`<`zones`.`x`+`zones`.`radius`
    AND `objs`.`ws_x`>`zones`.`x`-`zones`.`radius`
    AND `objs`.`ws_y`<`zones`.`y`+`zones`.`radius`
    AND `objs`.`ws_y`>`zones`.`y`-`zones`.`radius`;
END;;
DELIMITER ;


-- ----------------------------
-- Event structure for UnlockOldSafes
-- ----------------------------
DROP EVENT IF EXISTS `UnlockOldSafes`;
DELIMITER ;;
CREATE EVENT `UnlockOldSafes` ON SCHEDULE EVERY 1 DAY STARTS '2017-04-22 00:00:00' DO
BEGIN
	UPDATE
			`object_data_cherno`
		SET
			`object_data_cherno`.`character_id` = 0
		WHERE
			`object_data_cherno`.`character_id` <> 0
			AND `object_data_cherno`.`classname` IN ('LockboxStorage', 'LockboxStorageLocked', 'VaultStorage', 'VaultStorageLocked')
			AND `last_updated` < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 60 DAY) 
			AND `datestamp` < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 90 DAY) ;
	UPDATE
			`object_data_napf`
		SET
			`object_data_napf`.`character_id` = 0
		WHERE
			`object_data_napf`.`character_id` <> 0
			AND `object_data_napf`.`classname` IN ('LockboxStorage', 'LockboxStorageLocked', 'VaultStorage', 'VaultStorageLocked')
			AND `last_updated` < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 60 DAY) 
			AND `datestamp` < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 90 DAY) ;
END
;;
DELIMITER ;
