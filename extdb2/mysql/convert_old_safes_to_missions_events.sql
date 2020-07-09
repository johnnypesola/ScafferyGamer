-- ----------------------------
-- Event structure for createMissionFromOldBase
-- This is a heavy query and may take a few seconds to complete
-- ----------------------------

DROP EVENT IF EXISTS createMissionFromOldSafes;
DELIMITER ;;
CREATE EVENT createMissionFromOldSafes ON SCHEDULE EVERY 1 DAY STARTS '2017-04-22 00:00:00' COMMENT 'Removes old objects and creates missions from them' DO
BEGIN
        -- -----------------------------------
        --             Chernarus
        -- -----------------------------------

        -- Find expired plot poles and convert to expired base location entries at set coordinates
        -- just 1 day before anything else is deleted
        INSERT INTO old_bases_cherno (ws_x, ws_y, ws_z)
        SELECT objs.ws_x, objs.ws_y, objs.ws_z FROM object_data_cherno AS objs
        LEFT JOIN old_bases_cherno as base ON objs.ws_x > base.ws_x-45 AND objs.ws_x < base.ws_x+45 AND objs.ws_y > base.ws_y-45 AND objs.ws_y < base.ws_y+45
        WHERE last_updated < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 89 DAY)
        AND datestamp < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 119 DAY)
        AND classname='%plastic%' AND base_id IS NULL;

        -- Build a comma separated list string with all base IDs --
        SET @bids = (SELECT GROUP_CONCAT(base_id SEPARATOR ',') FROM old_bases_cherno WHERE grouped = 0 ORDER BY base_id);
        SET @nofOldBases = (SELECT COUNT(base_id) FROM old_bases_cherno WHERE grouped = 0);
        SET @idx = 1;
        SET @bid = CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(@bids, ',', @idx), ',', -1) AS INT);
        WHILE (@idx <= @nofOldBases)
        DO
                -- First copy all base parts surrounding the plot pole --
                -- within 45m which were recorded as old bases from previous queries --
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
                FROM object_data_cherno AS objs
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

                -- We can now use the @bid variable, so delete the old base parts from the map --
                DELETE object_data_cherno FROM object_data_cherno
                INNER JOIN old_base_parts_cherno
                ON object_data_cherno.object_uid=old_base_parts_cherno.object_uid
                WHERE old_base_parts_cherno.base_id=@bid;

                -- Mark this base as grouped --
                UPDATE old_bases_cherno SET grouped=1 WHERE base_id=@bid;
                SET @idx = @idx + 1;
                SET @bid = CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(@bids, ',', @idx), ',', -1) AS INT);
        END WHILE;

        -- Finally delete the old plot poles from the map --
        DELETE FROM object_data_cherno WHERE last_updated < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 89 DAY)
        AND datestamp < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 119 DAY)
        AND classname LIKE '%plastic%';

        -- -----------------------------------
        --                Napf
        -- -----------------------------------

        -- Find expired plot poles and convert to expired base location entries at set coordinates
        -- just 1 day before anything else is deleted
        INSERT INTO old_bases_napf (ws_x, ws_y, ws_z)
        SELECT objs.ws_x, objs.ws_y, objs.ws_z FROM object_data_napf_tmp AS objs
        LEFT JOIN old_bases_napf as base ON objs.ws_x > base.ws_x-45 AND objs.ws_x < base.ws_x+45 AND objs.ws_y > base.ws_y-45 AND objs.ws_y < base.ws_y+45
        WHERE last_updated < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 89 DAY)
        AND datestamp < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 119 DAY)
        AND classname LIKE '%plastic%' AND base_id IS NULL;

        -- Build a list using a string with all base IDs separated by comma... --
        SET @bids = (SELECT GROUP_CONCAT(base_id SEPARATOR ',') FROM old_bases_napf WHERE grouped = 0 ORDER BY base_id);
        SET @nofOldBases = (SELECT COUNT(base_id) FROM old_bases_napf WHERE grouped = 0);
        SET @idx = 1;
        SET @bid = CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(@bids, ',', @idx), ',', -1) AS INT);
        WHILE (@idx <= @nofOldBases)
        DO
                -- First copy all base parts surrounding the plot pole --
                -- within 45m which were recorded as old bases from previous queries --
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
                FROM object_data_napf AS objs
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

                -- Delete the old base parts from the map --
                DELETE object_data_napf FROM object_data_napf
                INNER JOIN old_base_parts_napf
                ON object_data_napf.object_uid=old_base_parts_napf.object_uid
                WHERE old_base_parts_napf.base_id=@base_id;

                -- Mark this base as grouped --
                UPDATE old_bases_napf SET grouped=1 WHERE base_id=@bid;
                SET @idx = @idx + 1;
                SET @bid = CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(@bids, ',', @idx), ',', -1) AS INT);
        END WHILE;

        -- Finally delete the old plot poles from the map --
        DELETE FROM object_data_napf WHERE last_updated < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 89 DAY)
        AND datestamp < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 119 DAY)
        AND classname LIKE '%plastic%';

END
;;
DELIMITER ;
