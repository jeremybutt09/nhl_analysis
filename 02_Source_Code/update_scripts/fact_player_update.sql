--DELETE FROM fact_schedule IF THERE IS A DIFFERENCE BETWEEN fact_schedule AND fact_schedule_load.
DELETE FROM 
    fact_player
WHERE
    game_id IN (
                SELECT
                    player_load.game_id
                FROM
                    fact_player_load player_load
                    JOIN fact_player player
                        ON player_load.game_id = player.game_id
                        AND player_load.player_id = player.player_id
                    WHERE
                        player_load.game_id = player.game_id
                        OR player_load.player_id = player.player_id
                        OR player_load.player_name = player.player_name
                        OR player_load.primary_position_code = player.primary_position_code
                        OR player_load.team_id = player.team_id
                        OR player_load.time_on_ice = player.time_on_ice
                        OR player_load.assists = player.assists
                        OR player_load.goals = player.goals
                        OR player_load.shots = player.shots
                        OR player_load.hits = player.hits
                        OR player_load.power_play_goals = player.power_play_goals
                        OR player_load.power_play_assists = player.power_play_assists
                        OR player_load.penalty_minutes = player.penalty_minutes
                        OR player_load.face_off_wins = player.face_off_wins
                        OR player_load.faceoff_taken = player.faceoff_taken
                        OR player_load.takeaways = player.takeaways
                        OR player_load.giveaways = player.giveaways
                        OR player_load.short_handed_goals = player.short_handed_goals
                        OR player_load.short_handed_assists = player.short_handed_assists
                        OR player_load.blocked = player.blocked
                        OR player_load.plus_minus = player.plus_minus
                        OR player_load.even_time_on_ice = player.even_time_on_ice
                        OR player_load.power_play_time_on_ice = player.power_play_time_on_ice
                        OR player_load.short_handed_time_on_ice = player.short_handed_time_on_ice
                        OR player_load.face_off_pct = player.face_off_pct
                        OR player_load.load_date = player.load_date
                    )
    AND player_id IN (
                SELECT
                    player_load.player_id
                FROM
                    fact_player_load player_load
                    JOIN fact_player player
                        ON player_load.game_id = player.game_id
                        AND player_load.player_id = player.player_id
                    WHERE
                        player_load.game_id = player.game_id
                        OR player_load.player_id = player.player_id
                        OR player_load.player_name = player.player_name
                        OR player_load.primary_position_code = player.primary_position_code
                        OR player_load.team_id = player.team_id
                        OR player_load.time_on_ice = player.time_on_ice
                        OR player_load.assists = player.assists
                        OR player_load.goals = player.goals
                        OR player_load.shots = player.shots
                        OR player_load.hits = player.hits
                        OR player_load.power_play_goals = player.power_play_goals
                        OR player_load.power_play_assists = player.power_play_assists
                        OR player_load.penalty_minutes = player.penalty_minutes
                        OR player_load.face_off_wins = player.face_off_wins
                        OR player_load.faceoff_taken = player.faceoff_taken
                        OR player_load.takeaways = player.takeaways
                        OR player_load.giveaways = player.giveaways
                        OR player_load.short_handed_goals = player.short_handed_goals
                        OR player_load.short_handed_assists = player.short_handed_assists
                        OR player_load.blocked = player.blocked
                        OR player_load.plus_minus = player.plus_minus
                        OR player_load.even_time_on_ice = player.even_time_on_ice
                        OR player_load.power_play_time_on_ice = player.power_play_time_on_ice
                        OR player_load.short_handed_time_on_ice = player.short_handed_time_on_ice
                        OR player_load.face_off_pct = player.face_off_pct
                        OR player_load.load_date = player.load_date
                    )
;
COMMIT;

--NEED TO ADD PLAYER_ID TO dim_player SO THAT FK DOES NOT BREAK.
INSERT INTO dim_player ( player_id )
SELECT DISTINCT
    player_load.player_id
FROM
    fact_player_load player_load
    LEFT JOIN dim_player d_player
        ON player_load.player_id = d_player.player_id
WHERE
    d_player.player_id IS NULL;
    
COMMIT;

--INSERT INTO fact_schedule WHERE THE game_pk EXISTS IN fact_schedule_load BUT NOT IN fact_schedule
INSERT INTO fact_player
SELECT
    player_load.*
FROM 
    fact_player_load player_load
    LEFT JOIN fact_player player
        ON player_load.game_id = player.game_id
        AND player_load.player_id = player.player_id
WHERE
    player.game_id IS NULL
    AND player.player_id IS NULL;
    
COMMIT;

DELETE FROM fact_player_load;

COMMIT;