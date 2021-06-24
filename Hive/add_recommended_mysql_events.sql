--
-- http://epochmod.gamepedia.com/A2Epoch:Server_Installation_Instructions_Extended
--

-- ----------------------------
-- Function structure for FindVehicleKeysCount
-- ----------------------------
DROP FUNCTION IF EXISTS `FindVehicleKeysCount`;
DELIMITER ;;
CREATE FUNCTION `FindVehicleKeysCount`(`keyId` INT)
        RETURNS int(11)
        DETERMINISTIC
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

    SET keysInChar = (SELECT COUNT(*) FROM `Character_DATA` WHERE `Alive` = '1' AND (`Inventory` LIKE CONCAT('%', keyName, '%') OR `Backpack` LIKE CONCAT('%', keyName, '%')));
    SET keysInObj = (SELECT COUNT(*) FROM `Object_DATA` WHERE `Inventory` LIKE CONCAT('%', keyName, '%'));

    RETURN (keysInChar + keysInObj);
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for DeleteNonKeyVehicles
-- Example usage: SELECT DeleteNonKeyVehicles();
-- ----------------------------
DROP FUNCTION IF EXISTS `DeleteNonKeyVehicles`;
DELIMITER ;;
CREATE FUNCTION `DeleteNonKeyVehicles`()
        RETURNS int(11)
        DETERMINISTIC
BEGIN
        DELETE FROM
                `Object_DATA`
        WHERE
                `Object_DATA`.`CharacterID` <> 0
                AND `Object_DATA`.`CharacterID` <= 12500
                AND `Object_DATA`.`Classname` NOT LIKE '%Tent%'
                AND `Object_DATA`.`Classname` NOT LIKE '%Locked'
                AND `Object_DATA`.`Classname` NOT LIKE 'Land\_%' -- added escape character so LandRover vehicles are not ignored
                AND `Object_DATA`.`Classname` NOT LIKE 'Cinder%'
                AND `Object_DATA`.`Classname` NOT LIKE 'Wood%'
                AND `Object_DATA`.`Classname` NOT LIKE 'Metal%'
                AND `Object_DATA`.`Classname` NOT LIKE '%Storage%'
                AND `Object_DATA`.`Classname` NOT LIKE '%CamoNet_DZ'
                AND `Object_DATA`.`Classname` NOT LIKE 'Concrete%'
                AND `Object_DATA`.`Classname` NOT LIKE 'Glass%'
                AND `Object_DATA`.`Classname` NOT LIKE 'Stash%'
                AND `Object_DATA`.`Classname` NOT LIKE 'Door%'
                AND `Object_DATA`.`Classname` NOT LIKE 'Garage%'
                AND `Object_DATA`.`Classname` NOT LIKE 'Helipad%'
                AND `Object_DATA`.`Classname` NOT LIKE '%Bench%'
                AND `Object_DATA`.`Classname` NOT LIKE 'Vendmachine%'
                AND `Object_DATA`.`Classname` NOT LIKE '%Trap%'
                AND `Object_DATA`.`Classname` NOT IN ('Arcade_DZ','Sofa_DZ','Armchair_DZ','ATM_DZ','Server_Rack_DZ','Washing_Machine_DZ','Fridge_DZ','Wardrobe_DZ','Commode_DZ','Stoneoven_DZ','CookTripod_DZ','CCTV_DZ','Office_Chair_DZ','Table_DZ','Bed_DZ','Water_Pump_DZ','Water_Pump_DZ','Notebook_DZ','Scaffolding_DZ','OutHouse_DZ','Sandbag1_DZ', 'FireBarrel_DZ', 'StickFence_DZ', 'LightPole_DZ', 'DeerStand_DZ', 'Plastic_Pole_EP1_DZ', 'Hedgehog_DZ', 'FuelPump_DZ', 'Fort_RazorWire', 'SandNest_DZ', 'Fence_corrugated_DZ', 'CanvasHut_DZ', 'Generator_DZ', 'BagFenceRound_DZ')
                AND FindVehicleKeysCount(Object_DATA.CharacterID) = 0;

        RETURN ROW_COUNT();
END
;;
DELIMITER ;

-- ----------------------------
-- Event structure for removeDamagedVehicles
-- ----------------------------
DROP EVENT IF EXISTS `removeDamagedVehicles`;
DELIMITER ;;
CREATE EVENT `removeDamagedVehicles` ON SCHEDULE EVERY 1 MINUTE COMMENT 'Removes damaged vehicles' DO DELETE FROM `Object_DATA` WHERE Damage >= 1
;;
DELIMITER ;

-- ----------------------------
-- Event structure for removeObjectEmpty
-- ----------------------------
DROP EVENT IF EXISTS `removeObjectEmpty`;
DELIMITER ;;
CREATE EVENT `removeObjectEmpty` ON SCHEDULE EVERY 1 DAY COMMENT 'Removes abandoned storage objects and vehicles' DO DELETE FROM `Object_DATA` WHERE `LastUpdated` < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 14 DAY) AND `Datestamp` < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 24 DAY) AND ( (`Inventory` IS NULL) OR (`Inventory` = '[]') OR (`Inventory` = '[[[],[]],[[],[]],[[],[]]]') )
;;
DELIMITER ;

-- ----------------------------
-- Event structure for removeObjectOld
-- ----------------------------
DROP EVENT IF EXISTS `removeObjectOld`;
DELIMITER ;;
CREATE EVENT `removeObjectOld` ON SCHEDULE EVERY 1 DAY STARTS '2017-04-22 00:00:00' COMMENT 'Removes old objects and vehicles' DO
BEGIN
        DELETE FROM `object_data` WHERE `LastUpdated` < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 90 DAY)
        AND `Datestamp` < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 120 DAY)
        AND `Datestamp` <> `LastUpdated`;
        UPDATE `object_data` SET `Classname`='MAP_pumpkin' WHERE `Classname`='MAP_pumpkin2';
END
;;
DELIMITER ;

-- ----------------------------
-- Event structure for removeObjectRecentUntouched
-- ----------------------------
DROP EVENT IF EXISTS `removeObjectRecentUntouched`;
DELIMITER ;;
CREATE EVENT `removeObjectRecentUntouched` ON SCHEDULE EVERY 1 DAY COMMENT 'Removes recent untouched vehicles' DO DELETE FROM `object_data` WHERE `object_data`.`LastUpdated` = `object_data`.`Datestamp` AND `object_data`.`CharacterID` = 0 AND `object_data`.`Datestamp` < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)
;;
DELIMITER ;

-- ----------------------------
-- Event structure for setDamageOnAge
-- ----------------------------
DROP EVENT IF EXISTS `setDamageOnAge`;
DELIMITER ;;
CREATE EVENT `setDamageOnAge` ON SCHEDULE EVERY 1 DAY COMMENT 'This sets damage on a wall so that it can be maintained' DO UPDATE `Object_DATA` SET `Damage`=0.1 WHERE `ObjectUID` <> 0 AND `CharacterID` <> 0 AND `Datestamp` < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY) AND ( (`Inventory` IS NULL) OR (`Inventory` = '[]') OR (`Classname` IN ('Land_DZE_GarageWoodDoorLocked','Land_DZE_LargeWoodDoorLocked','Land_DZE_WoodDoorLocked','CinderWallDoorLocked_DZ','CinderWallDoorSmallLocked_DZ','WoodenGate_1_DZ','WoodenGate_2_DZ','WoodenGate_3_DZ','WoodenGate_4_DZ','Land_DZE_WoodGateLocked','CinderGateLocked_DZ','Metal_DrawbridgeLocked_DZ','Land_DZE_WoodOpenTopGarageLocked','CinderGarageOpenTopLocked_DZ','DoorLocked_DZ','CinderWallWindowLocked_DZ','CinderDoorHatchLocked_DZ','Concrete_Bunker_Locked_DZ','CinderWallWindowLocked_DZ','Plastic_Pole_EP1_DZ')) )
;;
DELIMITER ;

-- ----------------------------
-- Event structure for UnlockNonKeyVehicles
-- ----------------------------
DROP EVENT IF EXISTS `UnlockNonKeyVehicles`;
DELIMITER ;;
CREATE EVENT `UnlockNonKeyVehicles` ON SCHEDULE EVERY 1 DAY DO UPDATE
                        `Object_DATA`
                SET
                        `Object_DATA`.`CharacterID` = 0
                WHERE
                        `Object_DATA`.`CharacterID` <> 0
                        AND `Object_DATA`.`CharacterID` <= 12500
                        AND `Object_DATA`.`Classname` NOT LIKE '%Tent%'
                        AND `Object_DATA`.`Classname` NOT LIKE '%Locked'
                        AND `Object_DATA`.`Classname` NOT LIKE 'Land\_%' -- added escape character so LandRover vehicles are not ignored
                        AND `Object_DATA`.`Classname` NOT LIKE 'Cinder%'
                        AND `Object_DATA`.`Classname` NOT LIKE 'Wood%'
                        AND `Object_DATA`.`Classname` NOT LIKE 'Metal%'
                        AND `Object_DATA`.`Classname` NOT LIKE '%Storage%'
                        AND `Object_DATA`.`Classname` NOT LIKE '%CamoNet_DZ'
                        AND `Object_DATA`.`Classname` NOT LIKE 'Concrete%'
                        AND `Object_DATA`.`Classname` NOT LIKE 'Glass%'
                        AND `Object_DATA`.`Classname` NOT LIKE 'Stash%'
                        AND `Object_DATA`.`Classname` NOT LIKE 'Door%'
                        AND `Object_DATA`.`Classname` NOT LIKE 'Garage%'
                        AND `Object_DATA`.`Classname` NOT LIKE 'Helipad%'
                        AND `Object_DATA`.`Classname` NOT LIKE '%Bench%'
                        AND `Object_DATA`.`Classname` NOT LIKE 'Vendmachine%'
                        AND `Object_DATA`.`Classname` NOT LIKE '%Trap%'
                        AND `Object_DATA`.`Classname` NOT IN ('Arcade_DZ','Sofa_DZ','Armchair_DZ','ATM_DZ','Server_Rack_DZ','Washing_Machine_DZ','Fridge_DZ','Wardrobe_DZ','Commode_DZ','Stoneoven_DZ','CookTripod_DZ','CCTV_DZ','Office_Chair_DZ','Table_DZ','Bed_DZ','Water_Pump_DZ','Water_Pump_DZ','Notebook_DZ','Scaffolding_DZ','OutHouse_DZ','Sandbag1_DZ', 'FireBarrel_DZ', 'StickFence_DZ', 'LightPole_DZ', 'DeerStand_DZ', 'Plastic_Pole_EP1_DZ', 'Hedgehog_DZ', 'FuelPump_DZ', 'Fort_RazorWire', 'SandNest_DZ', 'Fence_corrugated_DZ', 'CanvasHut_DZ', 'Generator_DZ', 'BagFenceRound_DZ')
                        AND FindVehicleKeysCount(Object_DATA.CharacterID) = 0
;;
DELIMITER ;

-- ----------------------------
-- Event structure for UnlockOldSafes
-- ----------------------------
DROP EVENT IF EXISTS `UnlockOldSafes`;
DELIMITER ;;
CREATE EVENT `UnlockOldSafes` ON SCHEDULE EVERY 1 DAY STARTS '2020-06-29 00:00:00' ON COMPLETION NOT PRESERVE ENABLE
DO
BEGIN
        UPDATE
        `object_data`
        SET
                `object_data`.`CharacterID` = 0
        WHERE
                `object_data`.`CharacterID` <> 0
                AND `object_data`.`Classname` IN ('LockboxStorage', 'LockboxStorageLocked', 'VaultStorage', 'VaultStorageLocked')
                AND `LastUpdated` < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 60 DAY)
                AND `Datestamp` < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 90 DAY) ;
END
;;
DELIMITER ;

-- ----------------------------
-- Event structure for UnlockVehiclesInSafezones
-- ----------------------------
DROP EVENT IF EXISTS `UnlockVehiclesInSafezones`;
DELIMITER ;;
CREATE EVENT `UnlockVehiclesInSafezones` ON SCHEDULE EVERY 1 DAY STARTS '2020-06-30 00:00:00' ON COMPLETION NOT PRESERVE ENABLE
DO
BEGIN
  UPDATE `object_data` AS `objs` INNER JOIN `safe_zones` AS `zones` ON `objs`.`Instance`=`zones`.`instance_id`
    SET `objs`.`CharacterID`=0
  WHERE
    `objs`.`CharacterID` <> 0
    AND `objs`.`CharacterID` <= 12500
    AND `objs`.`Classname` NOT LIKE 'Tent%'
    AND `objs`.`Classname` NOT LIKE 'Land%'
    AND `objs`.`Classname` NOT LIKE 'Cinder%'
    AND `objs`.`Classname` NOT LIKE 'Wood%'
    AND `objs`.`Classname` NOT LIKE 'Metal%'
    AND `objs`.`Classname` NOT IN ('OutHouse_DZ', 'GunRack_DZ', 'WorkBench_DZ', 'Sandbag1_DZ', 'FireBarrel_DZ', 'DesertCamoNet_DZ', 'StickFence_DZ', 'LightPole_DZ', 'DeerStand_DZ', 'ForestLargeCamoNet_DZ', 'Plastic_Pole_EP1_DZ', 'Hedgehog_DZ', 'FuelPump_DZ', 'Fort_RazorWire', 'SandNest_DZ', 'ForestCamoNet_DZ', 'Fence_corrugated_DZ', 'CanvasHut_DZ', 'Generator_DZ')
    AND JSON_EXTRACT(objs.Worldspace, '$[1][0]')<`zones`.`x`+`zones`.`radius`
    AND JSON_EXTRACT(objs.Worldspace, '$[1][0]')>`zones`.`x`-`zones`.`radius`
    AND JSON_EXTRACT(objs.Worldspace, '$[1][1]')<`zones`.`y`+`zones`.`radius`
    AND JSON_EXTRACT(objs.Worldspace, '$[1][1]')>`zones`.`y`-`zones`.`radius`;
END
;;
DELIMITER ;

