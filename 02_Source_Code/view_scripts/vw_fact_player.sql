CREATE OR REPLACE VIEW vw_fact_player AS
SELECT
    fp.game_id,
    fp.player_id,
    fp.player_name,
    fp.primary_position_code,
    dt.name AS team_name,
    dt.abbreviation AS team_abbreviation,
    ROUND(TO_NUMBER(SUBSTR(fp.time_on_ice, 1, INSTR(fp.time_on_ice, ':') - 1)) +  TO_NUMBER(SUBSTR(fp.time_on_ice, INSTR(fp.time_on_ice, ':') + 1))/60,2) AS time_on_ice,
    fp.goals,
    fp.assists,
    fp.goals + fp.assists AS points,
    fp.shots,
    fp.hits,
    fp.penalty_minutes,
    fp.power_play_goals,
    fp.power_play_assists,
    fp.power_play_goals + fp.power_play_assists AS power_play_points,
    fp.face_off_wins,
    fp.faceoff_taken,
    fp.takeaways,
    fp.giveaways,
    fp.short_handed_goals,
    fp.short_handed_assists,
    fp.short_handed_goals + short_handed_assists AS short_handed_points,
    fp.blocked,
    fp.plus_minus,
    ROUND(TO_NUMBER(SUBSTR(fp.even_time_on_ice, 1, INSTR(fp.even_time_on_ice, ':') - 1)) +  TO_NUMBER(SUBSTR(fp.even_time_on_ice, INSTR(fp.even_time_on_ice, ':') + 1))/60,2) AS even_time_on_ice,
    ROUND(TO_NUMBER(SUBSTR(fp.power_play_time_on_ice, 1, INSTR(fp.power_play_time_on_ice, ':') - 1)) +  TO_NUMBER(SUBSTR(fp.power_play_time_on_ice, INSTR(fp.power_play_time_on_ice, ':') + 1))/60,2) AS power_play_time_on_ice,
    ROUND(TO_NUMBER(SUBSTR(fp.short_handed_time_on_ice, 1, INSTR(fp.short_handed_time_on_ice, ':') - 1)) +  TO_NUMBER(SUBSTR(fp.short_handed_time_on_ice, INSTR(fp.short_handed_time_on_ice, ':') + 1))/60,2) AS short_handed_time_on_ice,
    fp.face_off_pct
FROM
    fact_player fp
    LEFT JOIN dim_team dt
        ON fp.team_id = dt.team_id;