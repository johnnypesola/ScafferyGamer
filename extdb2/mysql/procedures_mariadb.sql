DROP PROCEDURE IF EXISTS updatePlayer;

DELIMITER //

CREATE PROCEDURE updatePlayer (charID INT, params VARCHAR(512))
BEGIN
	SET @query_begin = 'UPDATE character_data SET ';
	SET @query_end = CONCAT (' WHERE character_id=', charID);
	SET @query_data = '';

	SET @fields = params;
	SET @field = '';
	SET @idx = 0;
	SET @field = ELT(@idx, @fields);
	WHILE (@field <> NULL)
	DO
		SET @key = QUOTE (SUBSTR (@field, 0, LOCATE ('=', @field) - 1));
		SET @val = QUOTE (SUBSTR (@field, LOCATE ('=', @field) + 1));
		SET @esc_field = CONCAT_WS ('=', @key, @val);
		SET @query_data = CONCAT_WS (',', @query_data, @esc_field);
		SET @idx = @idx + 1;
		SET @field = ELT (@idx, @fields);
	END WHILE;
	SET @query = CONCAT (@query_begin, @query_data, @query_end);
	PREPARE stmt FROM @query;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
END;

//

DELIMITER ;
