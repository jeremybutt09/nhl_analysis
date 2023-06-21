CREATE OR REPLACE VIEW vw_fact_goalie AS
SELECT
    fg.game_id,
    fg.player_id,
    fg.player_name,
    fg.primary_position_code,
    dt.name AS team_name,
    dt.abbreviation AS team_abbreviation,
    ROUND(TO_NUMBER(SUBSTR(fg.time_on_ice, 1, INSTR(fg.time_on_ice, ':') - 1)) +  TO_NUMBER(SUBSTR(fg.time_on_ice, INSTR(fg.time_on_ice, ':') + 1))/60,2) AS time_on_ice,
    fg.decision,
    fg.goals,
    fg.assists,
    fg.penalty_minutes,
    fg.saves,
    fg.shots,
    fg.shots - fg.saves AS goals_against,
    fg.save_percentage,
    fg.even_saves,
    fg.even_shots_against,
    fg.even_strength_save_percentage,
    fg.power_play_saves,
    fg.power_play_shots_against,
    CASE WHEN fg.power_play_shots_against = 0 THEN NULL ELSE  ROUND(fg.power_play_saves/fg.power_play_shots_against*100, 2) END AS power_play_save_percentage,
    fg.short_handed_saves,
    fg.short_handed_shots_against,
    CASE WHEN fg.short_handed_shots_against = 0 THEN NULL ELSE  ROUND(fg.short_handed_saves/fg.short_handed_shots_against*100, 2) END AS short_handed_save_percentage
FROM
    fact_goalie fg
    LEFT JOIN dim_team dt
        ON fg.team_id = dt.team_id;