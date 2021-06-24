-- --------------------------------------------------
-- SQL to find old base at coordinates on Chernarus
-- --------------------------------------------------
-- SET @originx = <origin x>
-- SET @originy = <origin y>
-- SET @originr = <origin radius/box half width>

INSERT INTO object_data_sub_bases_cherno (base_id, ws_x, ws_y, ws_z)
SELECT DISTINCT -1 AS base_id,
        JSON_EXTRACT(objs.Worldspace, '$[1][0]') AS ws_x,
        JSON_EXTRACT(objs.Worldspace, '$[1][1]') AS ws_y,
        JSON_EXTRACT(objs.Worldspace, '$[1][2]') AS ws_z
        FROM object_data AS objs LEFT JOIN object_data_sub_bases_cherno as base
        ON JSON_EXTRACT(objs.Worldspace,'$[1][0]') > base.ws_x-45 AND
        JSON_EXTRACT(objs.Worldspace,'$[1][0]') < base.ws_x+45 AND
        JSON_EXTRACT(objs.Worldspace,'$[1][1]') > base.ws_y-45 AND
        JSON_EXTRACT(objs.Worldspace,'$[1][1]') < base.ws_y+45
        WHERE ABS(JSON_EXTRACT(objs.Worldspace, '$[1][0]')-@originx)<=@originr
        AND ABS(JSON_EXTRACT(objs.Worldspace, '$[1][1]')-@originy)<=@originr
        AND Classname LIKE '%plastic%' AND base_id IS NULL;
SET @n=(SELECT COUNT(*) FROM object_data_sub_bases_cherno WHERE base_id=-1);
WHILE @n>0
DO
        -- Select first new and unprocessed plot pole found.
        SET @base_part_id = (SELECT base_part_id FROM object_data_sub_bases_cherno
        WHERE grouped=0 LIMIT 1);

        -- Insert the first plot pole as the first/main point for the old base
        INSERT INTO object_data_bases_cherno (ws_x, ws_y, ws_z)
        SELECT ws_x,ws_y,ws_z FROM object_data_sub_bases_cherno WHERE base_part_id=@base_part_id;

        SET @base_id = LAST_INSERT_ID();

        -- Mark the plots in the adjacent plot set by finding a set recursively of all base_part_id's
        -- which are within 75m of each other from the initial base_part_id
        UPDATE object_data_sub_bases_cherno SET grouped=1, base_id=@base_id WHERE base_part_id IN (
                WITH RECURSIVE adjacent_plots AS (
                        SELECT base_part_id, ws_x, ws_y, ws_z, grouped, base_id
                        FROM object_data_sub_bases_cherno WHERE base_part_id=@base_part_id
                        UNION
                        SELECT ba.base_part_id, ba.ws_x, ba.ws_y, ba.ws_z, ba.grouped, ba.base_id
                        FROM object_data_sub_bases_cherno AS ba
                        INNER JOIN adjacent_plots AS bb
                        ON (bb.ws_x<>ba.ws_x OR bb.ws_y<>ba.ws_y OR bb.ws_z<>ba.ws_z)
                        AND ABS(bb.ws_x-ba.ws_x) <= 45 AND ABS(bb.ws_y-ba.ws_y) <= 45
                        AND ABS(bb.ws_z-ba.ws_z) <= 45 AND bb.grouped=0 AND ba.grouped=0
                        AND bb.base_id=-1 AND ba.base_id=-1
                ) SELECT base_part_id FROM adjacent_plots
        );

        -- Do not iterate the plot poles, get single center point and perimeter radius instead,
        -- like this:
        SET @center_x = (SELECT SUM(b.ws_x)/COUNT(*)
                FROM object_data_sub_bases_cherno AS b
                WHERE base_id=@base_id);
        SET @center_y = (SELECT SUM(b.ws_y)/COUNT(*)
                FROM object_data_sub_bases_cherno AS b
                WHERE base_id=@base_id);
        SET @radius = (SELECT GREATEST(MAX(b.ws_x)-MIN(b.ws_x)+45, MAX(b.ws_y)-MIN(b.ws_y)+45)
                FROM object_data_sub_bases_cherno AS b
                WHERE base_id=@base_id);

        -- Insert the base parts around each plot pole and set the corresponding base_id
        INSERT INTO object_data_base_parts_cherno (
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
        SELECT ObjectUID,
                @base_id,
                Classname,
                Datestamp,
                LastUpdated,
                IF(Classname='VaultStorageLocked',
                        CONCAT(SUBSTR(CAST(JSON_EXTRACT(Worldspace,'$[1][0]') AS CHAR), -10, 1), SUBSTR(CAST((20480-JSON_EXTRACT(Worldspace,'$[1][1]')) AS CHAR), -9, 1),
                        SUBSTR(LPAD(CharacterID, 4), 3, 2)),
                        IF(classname='LockboxStorageLocked',
                                CONCAT(SUBSTR(CAST(JSON_EXTRACT(Worldspace,'$[1][0]') AS CHAR), -10, 1), SUBSTR(CAST((20480-JSON_EXTRACT(Worldspace,'$[1][1]')) AS CHAR), -9, 1),
                                SUBSTR(LPAD(CharacterID, 3), 3, 1)),
                                CharacterID)),
                JSON_EXTRACT(Worldspace, '$[1][0]') AS ws_x,
                JSON_EXTRACT(Worldspace, '$[1][1]') AS ws_y,
                JSON_EXTRACT(Worldspace, '$[1][2]') AS ws_z,
                JSON_EXTRACT(Worldspace, '$[0][0]') AS ws_dir,
                '0' AS ws_ownerpuid,
                IFNULL(JSON_EXTRACT(Worldspace, '$[3]'), '[]') AS ws_vect,
                IF(JSON_TYPE(JSON_EXTRACT(Inventory, '$[0][0]'))='STRING','[]',IFNULL(JSON_EXTRACT(Inventory, '$[1]'), '[]')) AS inventory_magazines,
                IF(JSON_TYPE(JSON_EXTRACT(Inventory, '$[0][0]'))='STRING','[]',IFNULL(JSON_EXTRACT(Inventory, '$[0]'), '[]')) AS inventory_weapons,
                IF(JSON_TYPE(JSON_EXTRACT(Inventory, '$[0][0]'))='STRING','[]',IFNULL(JSON_EXTRACT(Inventory, '$[2]'), '[]')) AS inventory_backpacks,
                Hitpoints,
                Fuel,
                Damage,
                StorageCoins
        FROM object_data AS objs
        WHERE JSON_EXTRACT(objs.Worldspace,'$[1][0]') BETWEEN @center_x-@radius AND @center_x+@radius
        AND JSON_EXTRACT(objs.Worldspace,'$[1][1]') BETWEEN @center_y-@radius AND @center_y+@radius
        AND (objs.Classname LIKE 'Tent%'
        OR objs.Classname LIKE '%Locked'
        OR (objs.Classname LIKE 'Land%' AND objs.Classname NOT LIKE 'LandRover%')
        OR objs.Classname LIKE 'Cinder%'
        OR objs.Classname LIKE 'Wood%'
        OR objs.Classname LIKE 'Metal%'
        OR objs.Classname LIKE '%Storage%'
        OR objs.Classname='M2StaticMG'
        OR objs.Classname='DSHKM_CDF'
        OR objs.Classname IN ('OutHouse_DZ', 'GunRack_DZ', 'WorkBench_DZ', 'Sandbag1_DZ', 'FireBarrel_DZ', 'DesertCamoNet_DZ', 'StickFence_DZ', 'LightPole_DZ', 'DeerStand_DZ', 'ForestLargeCamoNet_DZ', 'Plastic_Pole_EP1_DZ', 'Hedgehog_DZ', 'FuelPump_DZ', 'Fort_RazorWire', 'SandNest_DZ', 'ForestCamoNet_DZ', 'Fence_corrugated_DZ', 'CanvasHut_DZ', 'Generator_DZ', 'fiberplant', 'MAP_pumpkin2', 'MAP_pumpkin', 'MAP_p_Helianthus'));

        UPDATE object_data_base_parts_cherno SET inventory_magazines=REPLACE(inventory_magazines, '"', "'") WHERE base_id=@base_id;
        UPDATE object_data_base_parts_cherno SET inventory_weapons=REPLACE(inventory_weapons, '"', "'") WHERE base_id=@base_id;
        UPDATE object_data_base_parts_cherno SET inventory_backpacks=REPLACE(inventory_backpacks, '"', "'") WHERE base_id=@base_id;

        -- Update base as grouped if needed
        UPDATE object_data_bases_cherno SET grouped=1 WHERE base_id=@base_id;
        SET @n=(SELECT COUNT(*) FROM object_data_sub_bases_cherno WHERE base_id=-1);
END WHILE;

-- --------------------------------------------------
-- SQL to find old base at coordinates on Napf
-- --------------------------------------------------
-- SET @originx = <origin x>
-- SET @originy = <origin y>
-- SET @originr = <origin radius/box half width>

INSERT INTO object_data_sub_bases_napf (base_id, ws_x, ws_y, ws_z)
SELECT DISTINCT -1 AS base_id,
        JSON_EXTRACT(objs.Worldspace, '$[1][0]') AS ws_x,
        JSON_EXTRACT(objs.Worldspace, '$[1][1]') AS ws_y,
        JSON_EXTRACT(objs.Worldspace, '$[1][2]') AS ws_z
        FROM object_data AS objs LEFT JOIN object_data_sub_bases_napf as base
        ON JSON_EXTRACT(objs.Worldspace,'$[1][0]') > base.ws_x-45 AND
        JSON_EXTRACT(objs.Worldspace,'$[1][0]') < base.ws_x+45 AND
        JSON_EXTRACT(objs.Worldspace,'$[1][1]') > base.ws_y-45 AND
        JSON_EXTRACT(objs.Worldspace,'$[1][1]') < base.ws_y+45
        WHERE ABS(JSON_EXTRACT(objs.Worldspace, '$[1][0]')-@originx)<=@originr
        AND ABS(JSON_EXTRACT(objs.Worldspace, '$[1][1]')-@originy)<=@originr
        AND Classname LIKE '%plastic%' AND base_id IS NOT NULL;
SET @n=(SELECT COUNT(*) FROM object_data_sub_bases_napf);
WHILE @n>0
DO
        -- Select first new and unprocessed plot pole found.
        SET @base_part_id = (SELECT base_part_id FROM object_data_sub_bases_napf
        WHERE grouped=0 LIMIT 1);

        -- Insert the first plot pole as the first/main point for the old base
        INSERT INTO object_data_bases_napf (ws_x, ws_y, ws_z)
        SELECT ws_x,ws_y,ws_z FROM object_data_sub_bases_napf WHERE base_part_id=@base_part_id;

        SET @base_id = LAST_INSERT_ID();

        -- Mark the plots in the adjacent plot set by finding a set recursively of all base_part_id's
        -- which are within 75m of each other from the initial base_part_id
        UPDATE object_data_sub_bases_napf SET grouped=1, base_id=@base_id WHERE base_part_id IN (
                WITH RECURSIVE adjacent_plots AS (
                        SELECT base_part_id, ws_x, ws_y, ws_z, grouped, base_id
                        FROM object_data_sub_bases_napf WHERE base_part_id=@base_part_id
                        UNION
                        SELECT ba.base_part_id, ba.ws_x, ba.ws_y, ba.ws_z, ba.grouped, ba.base_id
                        FROM object_data_sub_bases_napf AS ba
                        INNER JOIN adjacent_plots AS bb
                        ON (bb.ws_x<>ba.ws_x OR bb.ws_y<>ba.ws_y OR bb.ws_z<>ba.ws_z)
                        AND ABS(bb.ws_x-ba.ws_x) <= 75 AND ABS(bb.ws_y-ba.ws_y) <= 75
                        AND ABS(bb.ws_z-ba.ws_z) <= 75 AND bb.grouped=0 AND ba.grouped=0
                        AND bb.base_id=-1 AND ba.base_id=-1
                ) SELECT base_part_id FROM adjacent_plots
        );

        -- Do not iterate the plot poles, get single center point and perimeter radius instead,
        -- like this:
        SET @center_x = (SELECT SUM(b.ws_x)/COUNT(*)
                FROM object_data_sub_bases_napf AS b
                WHERE base_id=@base_id);
        SET @center_y = (SELECT SUM(b.ws_y)/COUNT(*)
                FROM object_data_sub_bases_napf AS b
                WHERE base_id=@base_id);
        SET @radius = (SELECT GREATEST(MAX(b.ws_x)-MIN(b.ws_x)+45, MAX(b.ws_y)-MIN(b.ws_y)+45)
                FROM object_data_sub_bases_napf AS b
                WHERE base_id=@base_id);

        -- Insert the base parts around each plot pole and set the corresponding base_id
        INSERT INTO object_data_base_parts_napf (
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
        SELECT ObjectUID,
                @base_id,
                Classname,
                Datestamp,
                LastUpdated,
                IF(Classname='VaultStorageLocked',
                        CONCAT(SUBSTR(CAST(JSON_EXTRACT(Worldspace,'$[1][0]') AS CHAR), -10, 1), SUBSTR(CAST((20480-JSON_EXTRACT(Worldspace,'$[1][1]')) AS CHAR), -9, 1),
                        SUBSTR(LPAD(CharacterID, 4), 3, 2)),
                        IF(classname='LockboxStorageLocked',
                                CONCAT(SUBSTR(CAST(JSON_EXTRACT(Worldspace,'$[1][0]') AS CHAR), -10, 1), SUBSTR(CAST((20480-JSON_EXTRACT(Worldspace,'$[1][1]')) AS CHAR), -9, 1),
                                SUBSTR(LPAD(CharacterID, 3), 3, 1)),
                                CharacterID)),
                JSON_EXTRACT(Worldspace, '$[1][0]') AS ws_x,
                JSON_EXTRACT(Worldspace, '$[1][1]') AS ws_y,
                JSON_EXTRACT(Worldspace, '$[1][2]') AS ws_z,
                JSON_EXTRACT(Worldspace, '$[0][0]') AS ws_dir,
                '0' AS ws_ownerpuid,
                IFNULL(JSON_EXTRACT(Worldspace, '$[3]'), '[]') AS ws_vect,
                IF(JSON_TYPE(JSON_EXTRACT(Inventory, '$[0][0]'))='STRING','[]',IFNULL(JSON_EXTRACT(Inventory, '$[1]'), '[]')) AS inventory_magazines,
                IF(JSON_TYPE(JSON_EXTRACT(Inventory, '$[0][0]'))='STRING','[]',IFNULL(JSON_EXTRACT(Inventory, '$[0]'), '[]')) AS inventory_weapons,
                IF(JSON_TYPE(JSON_EXTRACT(Inventory, '$[0][0]'))='STRING','[]',IFNULL(JSON_EXTRACT(Inventory, '$[2]'), '[]')) AS inventory_backpacks,
                Hitpoints,
                Fuel,
                Damage,
                StorageCoins
        FROM object_data AS objs
        WHERE JSON_EXTRACT(objs.Worldspace,'$[1][0]') BETWEEN @center_x-@radius AND @center_x+@radius
        AND JSON_EXTRACT(objs.Worldspace,'$[1][1]') BETWEEN @center_y-@radius AND @center_y+@radius
        AND (objs.Classname LIKE 'Tent%'
        OR objs.Classname LIKE '%Locked'
        OR (objs.Classname LIKE 'Land%' AND objs.Classname NOT LIKE 'LandRover%')
        OR objs.Classname LIKE 'Cinder%'
        OR objs.Classname LIKE 'Wood%'
        OR objs.Classname LIKE 'Metal%'
        OR objs.Classname LIKE '%Storage%'
        OR objs.Classname='M2StaticMG'
        OR objs.Classname='DSHKM_CDF'
        OR objs.Classname IN ('OutHouse_DZ', 'GunRack_DZ', 'WorkBench_DZ', 'Sandbag1_DZ', 'FireBarrel_DZ', 'DesertCamoNet_DZ', 'StickFence_DZ', 'LightPole_DZ', 'DeerStand_DZ', 'ForestLargeCamoNet_DZ', 'Plastic_Pole_EP1_DZ', 'Hedgehog_DZ', 'FuelPump_DZ', 'Fort_RazorWire', 'SandNest_DZ', 'ForestCamoNet_DZ', 'Fence_corrugated_DZ', 'CanvasHut_DZ', 'Generator_DZ', 'fiberplant', 'MAP_pumpkin2', 'MAP_p_Helianthus'));

        UPDATE object_data_base_parts_napf SET inventory_magazines=REPLACE(inventory_magazines, '"', "'") WHERE base_id=@base_id;
        UPDATE object_data_base_parts_napf SET inventory_weapons=REPLACE(inventory_weapons, '"', "'") WHERE base_id=@base_id;
        UPDATE object_data_base_parts_napf SET inventory_backpacks=REPLACE(inventory_backpacks, '"', "'") WHERE base_id=@base_id;

        -- Update base as grouped if needed
        UPDATE object_data_bases_napf SET grouped=1 WHERE base_id=@base_id;
        SET @n=(SELECT COUNT(*) FROM object_data_sub_bases_napf WHERE base_id=-1);
END WHILE;

