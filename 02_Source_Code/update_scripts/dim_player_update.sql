--REMOVING FK SO THAT I CAN DELETE FROM dim_player TABLE WILL ADD BACK AT THE END OF THE SCRIPT
ALTER TABLE "JEREMYBUTT"."FACT_GOALIE" DROP CONSTRAINT "FACT_GOALIE_FK";
ALTER TABLE "JEREMYBUTT"."FACT_PLAYER" DROP CONSTRAINT "FACT_PLAYER_FK";

--DELETE FROM dim_player IF THERE IS A DIFFERENCE BETWEEN dim_player AND dim_player_load.
DELETE FROM 
    dim_player
WHERE
    player_id IN (
                SELECT
                    load_table.player_id
                FROM
                    dim_player_load load_table
                    JOIN dim_player main_table
                        ON load_table.player_id = main_table.player_id
                    WHERE
                           load_table.player_id = main_table.player_id
                        OR load_table.full_name = main_table.full_name
                        OR load_table.api_link = main_table.api_link
                        OR load_table.first_name = main_table.first_name
                        OR load_table.last_name = main_table.last_name
                        OR load_table.primary_number = main_table.primary_number
                        OR load_table.birth_date = main_table.birth_date
                        OR load_table.current_age = main_table.current_age
                        OR load_table.birth_city = main_table.birth_city
                        OR load_table.birth_country = main_table.birth_country
                        OR load_table.nationality = main_table.nationality
                        OR load_table.height = main_table.height
                        OR load_table.weight = main_table.weight
                        OR load_table.active = main_table.active
                        OR load_table.alternate_captain = main_table.alternate_captain
                        OR load_table.captain = main_table.captain
                        OR load_table.rookie = main_table.rookie
                        OR load_table.shoots_catches = main_table.shoots_catches
                        OR load_table.roster_status = main_table.roster_status
                        OR load_table.current_team_id = main_table.current_team_id
                        OR load_table.current_team_name = main_table.current_team_name
                        OR load_table.current_team_link = main_table.current_team_link
                        OR load_table.primary_position_code = main_table.primary_position_code
                        OR load_table.primary_position_name = main_table.primary_position_name
                        OR load_table.primary_position_type = main_table.primary_position_type
                        OR load_table.primary_position_abbreviation = main_table.primary_position_abbreviation
                        OR load_table.url = main_table.url
                        OR load_table.copyright = main_table.copyright
                        OR load_table.birth_state_province = main_table.birth_state_province
                        OR load_table.load_date = main_table.load_date
                    )
;
COMMIT;

--INSERT INTO dim_player WHERE THE player_id EXISTS IN dim_player_load BUT NOT IN dim_player
INSERT INTO dim_player
SELECT
    load_table.*
FROM 
    dim_player_load load_table
    LEFT JOIN dim_player main_table
        ON load_table.player_id = main_table.player_id
WHERE
    main_table.player_id IS NULL;
    
COMMIT;

DELETE FROM dim_player_load;

COMMIT;

--UPDATING CURRENT AGE BASED ON TODAYS DATE
UPDATE dim_player
SET
    current_age = FLOOR(MONTHS_BETWEEN(sysdate, birth_date)/12);
    
COMMIT;

--ADDING BACK FK THAT WERE REMOVED IN THE BEGINNING OF SCRIPT
ALTER TABLE "JEREMYBUTT"."FACT_GOALIE" ADD CONSTRAINT FACT_GOALIE_FK FOREIGN KEY("PLAYER_ID") REFERENCES "DIM_PLAYER"("PLAYER_ID");
ALTER TABLE "JEREMYBUTT"."FACT_PLAYER" ADD CONSTRAINT FACT_PLAYER_FK FOREIGN KEY("PLAYER_ID") REFERENCES "DIM_PLAYER"("PLAYER_ID");