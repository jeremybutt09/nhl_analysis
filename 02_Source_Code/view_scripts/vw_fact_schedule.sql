CREATE OR REPLACE VIEW vw_fact_schedule AS
SELECT
    game_date,
    game_pk,
    gt.description AS game_type_description,
    season,
    game_date_time,
    teams_away_score,
    teams_away_league_record_wins,
    teams_away_league_record_losses,
    teams_away_league_record_ot,
    teams_away_team_name,
    teams_home_score,
    teams_home_league_record_wins,
    teams_home_league_record_losses,
    teams_home_league_record_ot,
    teams_home_team_name,
    venue_name
FROM
    fact_schedule fs
    LEFT JOIN dim_game_type gt
        ON fs.game_type = gt.game_type_id