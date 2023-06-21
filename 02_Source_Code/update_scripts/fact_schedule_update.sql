--DELETE FROM fact_schedule IF THERE IS A DIFFERENCE BETWEEN fact_schedule AND fact_schedule_load.
DELETE FROM 
    fact_schedule
WHERE
    game_pk IN (
                SELECT
                    sch_load.game_pk
                FROM
                    fact_schedule_load sch_load
                    JOIN fact_schedule sch
                        ON sch_load.game_pk = sch.game_pk
                    WHERE
                               sch_load.game_date != sch.game_date
                            OR sch_load.total_items != sch.total_items
                            OR sch_load.total_events != sch.total_events
                            OR sch_load.total_games != sch.total_games
                            OR sch_load.total_matches != sch.total_matches
                            OR sch_load.game_pk != sch.game_pk
                            OR sch_load.api_link != sch.api_link
                            OR sch_load.game_type != sch.game_type
                            OR sch_load.season != sch.season
                            OR sch_load.game_date_time != sch.game_date_time
                            OR sch_load.status_abstract_game_state != sch.status_abstract_game_state
                            OR sch_load.status_coded_game_state != sch.status_coded_game_state
                            OR sch_load.status_detailed_state != sch.status_detailed_state
                            OR sch_load.status_status_code != sch.status_status_code
                            OR sch_load.status_start_time_tbd != sch.status_start_time_tbd
                            OR sch_load.teams_away_score != sch.teams_away_score
                            OR sch_load.teams_away_league_record_wins != sch.teams_away_league_record_wins
                            OR sch_load.teams_away_league_record_losses != sch.teams_away_league_record_losses
                            OR sch_load.teams_away_league_record_ot != sch.teams_away_league_record_ot
                            OR sch_load.teams_away_league_record_type != sch.teams_away_league_record_type
                            OR sch_load.teams_away_team_id != sch.teams_away_team_id
                            OR sch_load.teams_away_team_name != sch.teams_away_team_name
                            OR sch_load.teams_away_team_link != sch.teams_away_team_link
                            OR sch_load.teams_home_score != sch.teams_home_score
                            OR sch_load.teams_home_league_record_wins != sch.teams_home_league_record_wins
                            OR sch_load.teams_home_league_record_losses != sch.teams_home_league_record_losses
                            OR sch_load.teams_home_league_record_ot != sch.teams_home_league_record_ot
                            OR sch_load.teams_home_league_record_type != sch.teams_home_league_record_type
                            OR sch_load.teams_home_team_id != sch.teams_home_team_id
                            OR sch_load.teams_home_team_name != sch.teams_home_team_name
                            OR sch_load.teams_home_team_link != sch.teams_home_team_link
                            OR sch_load.venue_id != sch.venue_id
                            OR sch_load.venue_name != sch.venue_name
                            OR sch_load.venue_link != sch.venue_link
                            OR sch_load.content_link != sch.content_link
                            OR sch_load.load_date != NVL(sch.load_date, SYSDATE)
                    )
;
COMMIT;

--INSERT INTO fact_schedule WHERE THE game_pk EXISTS IN fact_schedule_load BUT NOT IN fact_schedule
INSERT INTO fact_schedule
SELECT
    sch_load.*
FROM 
    fact_schedule_load sch_load
    LEFT JOIN fact_schedule sch
        ON sch_load.game_pk = sch.game_pk
WHERE
    sch.game_pk IS NULL;
    
COMMIT;

DELETE FROM fact_schedule_load;

COMMIT;