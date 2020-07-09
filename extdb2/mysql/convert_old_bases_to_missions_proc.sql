-- ----------------------------
-- Event structure for createMissionFromOldBasesProcCherno
-- This is a heavy query and may take a few seconds to complete
-- ----------------------------

DROP PROCEDURE IF EXISTS createMissionFromOldBasesProcCherno;
DELIMITER ;;
CREATE PROCEDURE createMissionFromOldBasesProcCherno ()
BEGIN
        INSERT INTO old_bases_cherno (ws_x, ws_y, ws_z)
        SELECT DISTINCT objs.ws_x, objs.ws_y, objs.ws_z FROM object_data_cherno_tmp AS objs
        LEFT JOIN old_bases_cherno as base ON objs.ws_x > base.ws_x-45 AND objs.ws_x < base.ws_x+45 AND objs.ws_y > base.ws_y-45 AND objs.ws_y < base.ws_y+45
        WHERE last_updated < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 89 DAY)
        AND datestamp < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 119 DAY)
        AND classname LIKE '%plastic%' AND base_id IS NULL;

        SET @bids = (SELECT GROUP_CONCAT(base_id SEPARATOR ',') FROM old_bases_cherno WHERE grouped = 0 ORDER BY base_id);
        SET @nofOldBases = (SELECT COUNT(base_id) FROM old_bases_cherno WHERE grouped = 0);
        SET @idx = 1;
        SET @bid = CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(@bids, ',', @idx), ',', -1) AS INT);
        WHILE (@idx <= @nofOldBases)
	DO
                INSERT INTO old_base_parts_cherno (
			object_uid,
			base_id,
			classname,
			datestamp,
			last_updated,
			character_id,
			ws_x,
			ws_y,
			ws_z,
			ws_dir,
			ws_ownerpuid,
			ws_vect,
			inventory_magazines,
			inventory_weapons,
			inventory_backpacks,
			hitpoints,
			fuel,
			damage,
			storage_coins)
                SELECT object_uid,
			@bid,
			classname,
			datestamp,
			last_updated,
			IF(objs.classname='VaultStorageLocked',
				CONCAT(SUBSTR(CAST(objs.ws_x AS CHAR), -10, 1), SUBSTR(CAST((15360-objs.ws_y) AS CHAR), -9, 1),
				SUBSTR(LPAD(objs.character_id, 4), 3, 2)),
				IF(objs.classname='LockboxStorageLocked',
					CONCAT(SUBSTR(CAST(objs.ws_x AS CHAR), -10, 1), SUBSTR(CAST((15360-objs.ws_y) AS CHAR), -9, 1),
					SUBSTR(LPAD(objs.character_id, 3), 3, 1)),
					objs.character_id)),
			objs.ws_x,
			objs.ws_y,
			objs.ws_z,
			ws_dir,
			ws_ownerpuid,
			ws_vect,
			inventory_magazines,
			inventory_weapons,
			inventory_backpacks,
			hitpoints,
			fuel,
			damage,
			storage_coins
                FROM object_data_cherno_tmp AS objs
                INNER JOIN old_bases_cherno AS base_x ON objs.ws_x BETWEEN base_x.ws_x-45 AND base_x.ws_x+45
                INNER JOIN old_bases_cherno AS base_y ON objs.ws_y BETWEEN base_y.ws_y-45 AND base_y.ws_y+45
                WHERE base_y.base_id = @bid
                AND (objs.classname LIKE 'Tent%'
                OR objs.classname LIKE '%Locked'
                OR (objs.classname LIKE 'Land%' AND objs.classname NOT LIKE 'LandRover%')
                OR objs.classname LIKE 'Cinder%'
                OR objs.classname LIKE 'Wood%'
                OR objs.classname LIKE 'Metal%'
                OR objs.classname LIKE '%Storage%'
		OR objs.classname='M2StaticMG'
		OR objs.classname='DSHKM_CDF'
                OR objs.classname IN ('OutHouse_DZ', 'GunRack_DZ', 'WorkBench_DZ', 'Sandbag1_DZ', 'FireBarrel_DZ', 'DesertCamoNet_DZ', 'StickFence_DZ', 'LightPole_DZ', 'DeerStand_DZ', 'ForestLargeCamoNet_DZ', 'Plastic_Pole_EP1_DZ', 'Hedgehog_DZ', 'FuelPump_DZ', 'Fort_RazorWire', 'SandNest_DZ', 'ForestCamoNet_DZ', 'Fence_corrugated_DZ', 'CanvasHut_DZ', 'Generator_DZ'));

                UPDATE old_bases_cherno SET grouped=1 WHERE base_id=@bid;
                SET @idx = @idx + 1;
                SET @bid = CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(@bids, ',', @idx), ',', -1) AS INT);
        END WHILE;
END
;;
DELIMITER ;

-- ----------------------------
-- Event structure for createMissionFromOldBasesProcNapf
-- This is a heavy query and may take a few seconds to complete
-- ----------------------------

DROP PROCEDURE IF EXISTS createMissionFromOldBasesProcNapf;
DELIMITER ;;
CREATE PROCEDURE createMissionFromOldBasesProcNapf ()
BEGIN
	INSERT INTO old_bases_napf (ws_x, ws_y, ws_z)
        SELECT DISTINCT objs.ws_x, objs.ws_y, objs.ws_z FROM object_data_napf_tmp AS objs
        LEFT JOIN old_bases_napf as base ON objs.ws_x > base.ws_x-45 AND objs.ws_x < base.ws_x+45 AND objs.ws_y > base.ws_y-45 AND objs.ws_y < base.ws_y+45
        WHERE last_updated < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 89 DAY)
        AND datestamp < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 119 DAY)
        AND classname LIKE '%plastic%' AND base_id IS NULL;

        SET @bids = (SELECT GROUP_CONCAT(base_id SEPARATOR ',')
        FROM old_bases_napf WHERE grouped = 0
        ORDER BY base_id);

        SET @nofOldBases = (SELECT COUNT(base_id) FROM old_bases_napf WHERE grouped = 0);
        SET @idx = 1;
        SET @bid = CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(@bids, ',', @idx), ',', -1) AS INT);
        WHILE (@idx <= @nofOldBases)
	DO
                INSERT INTO old_base_parts_napf (
			object_uid,
			base_id,
			classname,
			datestamp,
			last_updated,
			character_id,
			ws_x,
			ws_y,
			ws_z,
			ws_dir,
			ws_ownerpuid,
			ws_vect,
			inventory_magazines,
			inventory_weapons,
			inventory_backpacks,
			hitpoints,
			fuel,
			damage,
			storage_coins)
                SELECT object_uid,
			@bid,
			classname,
			datestamp,
			last_updated,
			IF(objs.classname='VaultStorageLocked',
				CONCAT(SUBSTR(CAST(objs.ws_x AS CHAR), -10, 1), SUBSTR(CAST((20480-objs.ws_y) AS CHAR), -9, 1),
				SUBSTR(LPAD(objs.character_id, 4), 3, 2)),
				IF(objs.classname='LockboxStorageLocked',
					CONCAT(SUBSTR(CAST(objs.ws_x AS CHAR), -10, 1), SUBSTR(CAST((20480-objs.ws_y) AS CHAR), -9, 1),
					SUBSTR(LPAD(objs.character_id, 3), 3, 1)),
					objs.character_id)),
			objs.ws_x,
			objs.ws_y,
			objs.ws_z,
			ws_dir,
			ws_ownerpuid,
			ws_vect,
			inventory_magazines,
			inventory_weapons,
			inventory_backpacks,
			hitpoints,
			fuel,
			damage,
			storage_coins
                FROM object_data_napf_tmp AS objs
                INNER JOIN old_bases_napf AS base_x ON objs.ws_x BETWEEN base_x.ws_x-45 AND base_x.ws_x+45
                INNER JOIN old_bases_napf AS base_y ON objs.ws_y BETWEEN base_y.ws_y-45 AND base_y.ws_y+45
                WHERE base_y.base_id = @bid
                AND (objs.classname LIKE 'Tent%'
                OR objs.classname LIKE '%Locked'
                OR (objs.classname LIKE 'Land%' AND objs.classname NOT LIKE 'LandRover%')
                OR objs.classname LIKE 'Cinder%'
                OR objs.classname LIKE 'Wood%'
                OR objs.classname LIKE 'Metal%'
                OR objs.classname LIKE '%Storage%'
		OR objs.classname='M2StaticMG'
		OR objs.classname='DSHKM_CDF'
                OR objs.classname IN ('OutHouse_DZ', 'GunRack_DZ', 'WorkBench_DZ', 'Sandbag1_DZ', 'FireBarrel_DZ', 'DesertCamoNet_DZ', 'StickFence_DZ', 'LightPole_DZ', 'DeerStand_DZ', 'ForestLargeCamoNet_DZ', 'Plastic_Pole_EP1_DZ', 'Hedgehog_DZ', 'FuelPump_DZ', 'Fort_RazorWire', 'SandNest_DZ', 'ForestCamoNet_DZ', 'Fence_corrugated_DZ', 'CanvasHut_DZ', 'Generator_DZ'));

                UPDATE old_bases_napf SET grouped=1 WHERE base_id=@bid;
                SET @idx = @idx + 1;
                SET @bid = CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(@bids, ',', @idx), ',', -1) AS INT);
        END WHILE;
END
;;
DELIMITER ;
