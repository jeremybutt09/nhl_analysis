--DELETE FROM fact_schedule IF THERE IS A DIFFERENCE BETWEEN fact_schedule AND fact_schedule_load.
DELETE FROM 
    fact_goalie
WHERE
    game_id IN (
                SELECT
                    goalie_load.game_id
                FROM
                    fact_goalie_load goalie_load
                    JOIN fact_goalie goalie
                        ON goalie_load.game_id = goalie.game_id
                        AND goalie_load.player_id = goalie.player_id
                    WHERE
                           goalie_load.game_id = goalie.game_id
                        OR goalie_load.player_id = goalie.player_id
                        OR goalie_load.player_name = goalie.player_name
                        OR goalie_load.primary_position_code = goalie.primary_position_code
                        OR goalie_load.team_id = goalie.team_id
                        OR goalie_load.time_on_ice = goalie.time_on_ice
                        OR goalie_load.assists = goalie.assists
                        OR goalie_load.goals = goalie.goals
                        OR goalie_load.penalty_minutes = goalie.penalty_minutes
                        OR goalie_load.shots = goalie.shots
                        OR goalie_load.saves = goalie.saves
                        OR goalie_load.power_play_saves = goalie.power_play_saves
                        OR goalie_load.short_handed_saves = goalie.short_handed_saves
                        OR goalie_load.even_saves = goalie.even_saves
                        OR goalie_load.short_handed_shots_against = goalie.short_handed_shots_against
                        OR goalie_load.even_shots_against = goalie.even_shots_against
                        OR goalie_load.power_play_shots_against = goalie.power_play_shots_against
                        OR goalie_load.decision = goalie.decision
                        OR goalie_load.save_percentage = goalie.save_percentage
                        OR goalie_load.even_strength_save_percentage = goalie.even_strength_save_percentage
                        OR goalie_load.load_date = goalie.load_date
                    )
    AND player_id IN (
                SELECT
                    goalie_load.player_id
                FROM
                    fact_goalie_load goalie_load
                    JOIN fact_goalie goalie
                        ON goalie_load.game_id = goalie.game_id
                        AND goalie_load.player_id = goalie.player_id
                    WHERE
                        goalie_load.game_id = goalie.game_id
                        OR goalie_load.player_id = goalie.player_id
                        OR goalie_load.player_name = goalie.player_name
                        OR goalie_load.primary_position_code = goalie.primary_position_code
                        OR goalie_load.team_id = goalie.team_id
                        OR goalie_load.time_on_ice = goalie.time_on_ice
                        OR goalie_load.assists = goalie.assists
                        OR goalie_load.goals = goalie.goals
                        OR goalie_load.penalty_minutes = goalie.penalty_minutes
                        OR goalie_load.shots = goalie.shots
                        OR goalie_load.saves = goalie.saves
                        OR goalie_load.power_play_saves = goalie.power_play_saves
                        OR goalie_load.short_handed_saves = goalie.short_handed_saves
                        OR goalie_load.even_saves = goalie.even_saves
                        OR goalie_load.short_handed_shots_against = goalie.short_handed_shots_against
                        OR goalie_load.even_shots_against = goalie.even_shots_against
                        OR goalie_load.power_play_shots_against = goalie.power_play_shots_against
                        OR goalie_load.decision = goalie.decision
                        OR goalie_load.save_percentage = goalie.save_percentage
                        OR goalie_load.even_strength_save_percentage = goalie.even_strength_save_percentage
                        OR goalie_load.load_date = goalie.load_date
                    )
;
COMMIT;

--NEED TO ADD PLAYER_ID TO dim_player SO THAT FK DOES NOT BREAK.
INSERT INTO dim_player ( 
    player_id 
    )
SELECT DISTINCT
    goalie_load.player_id
FROM
    fact_goalie_load goalie_load
    LEFT JOIN dim_player d_player
        ON goalie_load.player_id = d_player.player_id
WHERE
    d_player.player_id IS NULL;
    
COMMIT;

--INSERT INTO fact_schedule WHERE THE game_pk EXISTS IN fact_schedule_load BUT NOT IN fact_schedule
INSERT INTO fact_goalie
SELECT
    goalie_load.*
FROM 
    fact_goalie_load goalie_load
    LEFT JOIN fact_goalie goalie
        ON goalie_load.game_id = goalie.game_id
        AND goalie_load.player_id = goalie.player_id
WHERE
    goalie.game_id IS NULL
    AND goalie.player_id IS NULL;
    
COMMIT;

DELETE FROM fact_goalie_load;

COMMIT;