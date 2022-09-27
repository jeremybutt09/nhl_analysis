--SELECT WITH AN ORDER CLAUSE
SELECT
    game_id,
    player_id,
    player_name,
    primary_position_code,
    team_id,
    time_on_ice,
    assists,
    goals,
    shots,
    hits,
    power_play_goals,
    power_play_assists,
    penalty_minutes,
    face_off_wins,
    faceoff_taken,
    takeaways,
    giveaways,
    short_handed_goals,
    short_handed_assists,
    blocked,
    plus_minus,
    even_time_on_ice,
    power_play_time_on_ice,
    short_handed_time_on_ice,
    face_off_pct
FROM
    fact_player
ORDER BY
    goals DESC;

--WHERE AND ORDER CLAUSE EXAMPLE
--WHERE CLAUSE VARCHAR
SELECT
    *
FROM
    fact_player
WHERE
    player_id = '8471675'
ORDER BY
    game_id DESC;

--WHERE AND ORDER CLAUSE EXAMPLE
--WHERE CLAUSE NUMERIC
SELECT
    game_id,
    player_id,
    player_name,
    penalty_minutes
FROM
    fact_player
WHERE
    penalty_minutes > 30
ORDER BY
    game_id DESC
;

--WHERE CLAUSE WITH TIME
SELECT
    *
FROM
    dim_nhl_schedule
WHERE
    game_date BETWEEN '21-09-01' AND '22-04-30'
--    game_date >= '21-09-01' 
--    AND game_date < ='22-04-30'
--    game_date BETWEEN TO_DATE('2021-09-01', 'YYYY-MM-DD') AND TO_DATE('2022-04-30', 'YYYY-MM-DD')
    ;

SELECT
    *
FROM
    fact_player
WHERE
    power_play_goals > 50;
    
--SELECT WITH ARITHMETIC EXPRESSION: ADDITION
SELECT
    game_id,
    player_id,
    player_name,
    goals,
    assists,
    goals + assists AS points
FROM
    fact_player
;

--SELECT WITH ARITHMETIC EXPRESSION: ADDITION
SELECT
    game_id,
    player_id,
    player_name,
    primary_position_code,
    shots,
    saves,
    shots - saves AS goals_against
FROM
    fact_goalie;

--SELECT WITH ARITHMETIC EXPRESSION: MULTIPLICATION
SELECT
    game_id,
    player_id,
    player_name,
    goals,
    assists,
    shots,
    hits,
    goals*3.5 + assists*2.5 + shots*0.1 + hits*0.5 AS fantasy_pts
FROM
    fact_player;
    
SELECT
    game_id,
    player_id,
    player_name,
    goals,
    shots,
    goals/shots  AS shooting_percent
FROM
    fact_player
WHERE
    shots != 0;
    
--concat
SELECT
    player_id,
    first_name,
    last_name,
    first_name || ' ' || last_name AS full_name,
    last_name || ', ' || first_name full_name2,
    first_name || ' ' || last_name AS "FULL_NAME" --EXAMPLE OF USING DOUBLE QUOTES AROUND ALIAS
FROM
    dim_players;
    
--SCALAR FUNCTION
SELECT SYSDATE FROM dual;

--SUBSTR
SELECT
    player_id,
    first_name,
    last_name,
    SUBSTR(first_name, 1, 1) || SUBSTR(last_name, 1, 1) AS player_initals
FROM
    dim_players;
    
--sentence. TO_CHAR
SELECT
    player_id,
    first_name,
    last_name,
    first_name || ' ' || last_name || ' was born on ' || TO_CHAR(birth_date, 'MON DD, YYYY') || ' in ' || birth_city || ', ' || birth_country AS sentence_example
FROM
    dim_players;

--ROUND
SELECT
    game_id,
    player_id,
    player_name,
    goals,
    shots,
    goals/shots AS shooting_percent,
    ROUND(goals/shots, 2)  AS shooting_percent_round
FROM
    fact_player
WHERE
    shots != 0;
    
--MOD EXAMPLE
SELECT
    player_id,
    player_name,
    game_id,
    penalty_minutes,
    MOD(penalty_minutes, 5) AS remainder
FROM
    fact_player
WHERE
    penalty_minutes > 5;

--dual example
SELECT
    'John Doe' AS player_name,
    3 + 2 AS points,
    SYSDATE AS game_date
FROM
    dual
;

SELECT DISTINCT
    venue_name
FROM
    fact_schedule
ORDER BY
    venue_name
;

SELECT
    player_name,
    COUNT(DISTINCT player_id) AS num_of_ids
FROM
    fact_player
GROUP BY
    player_name
HAVING
    COUNT(DISTINCT player_id) > 1;
    
WITH temp AS (
SELECT
    player_name,
    COUNT(DISTINCT player_id) AS num_of_ids
FROM
    fact_player
GROUP BY
    player_name
HAVING
    COUNT(DISTINCT player_id) > 1
)
SELECT DISTINCT
--    SUBSTR(game_id, 1, 4) AS game_year,
    player.player_id,
    player.player_name
FROM
    fact_player player
    JOIN temp temp
        ON player.player_name = temp.player_name
;

--RETURNING LIMITED ROWS
SELECT
    *
FROM
    fact_player
WHERE
    rownum <= 10
;

--ROWNUM AND WHERE
--FIRST WILL RETURN 10 ROWS THEN SORT THOSE 10 ROWS. NOT THE OTHER WAY AROUND
SELECT
    *
FROM
    fact_player
WHERE
    penalty_minutes IS NOT NULL
    AND rownum <= 10
ORDER BY
    penalty_minutes DESC
;

--ORDERS RIGHT THEN RETURNS TOP 10 ROWS
SELECT
    *
FROM
    (SELECT
        *
     FROM 
        fact_player
     WHERE
        penalty_minutes IS NOT NULL
     ORDER BY
        penalty_minutes DESC)
WHERE
    rownum <= 10
;
--MORE WHERE EXAMPLES
--MATH IN WHERE CLAUSE
SELECT
    game_id,
    player_id,
    player_name,
    goals,
    assists,
    goals + assists AS points
FROM
    fact_player
WHERE
    goals + assists >= 5
;

--PLAYERS LAST NAME FROM A-C
SELECT
    player_id,
    full_name
FROM
    dim_players
WHERE
    SUBSTR(last_name, 1, 1) < 'D'
;

--NOT EQUAL TO EXAMPLE
SELECT
    *
FROM
    fact_schedule
WHERE
    teams_home_score != 0
--    teams_home_score <> 0
    ;

SELECT
    team_id,
    name,
    abbreviation,
    team_name,
    location_name
FROM
    dim_team
WHERE
    conference_name = 'Eastern'
    AND SUBSTR(name, 1, 1) = 'B'
;

SELECT
    player_id,
    player_name,
    goals,
    assists,
    goals + assists AS points,
    penalty_minutes
FROM
    fact_player
WHERE
    goals + assists > 5
    OR penalty_minutes > 30
ORDER BY
    player_name;
    
SELECT
    game_date,
    game_type,
    season,
    teams_away_team_name || ' (' || teams_away_league_record_wins || '-' || teams_away_league_record_losses || '-' || teams_away_league_record_ot || '): ' || teams_away_score AS away_team,
    teams_home_team_name || ' (' || teams_home_league_record_wins || '-' || teams_home_league_record_losses || '-' || teams_home_league_record_ot || '): ' || teams_home_score AS home_team
FROM
    fact_schedule
WHERE
    teams_home_league_record_wins > 50
    AND teams_away_league_record_wins > 50
ORDER BY
    game_date DESC
;

SELECT
    game_date,
    game_type,
    season,
    teams_away_team_name || ' (' || teams_away_league_record_wins || '-' || teams_away_league_record_losses || '-' || teams_away_league_record_ot || '): ' || teams_away_score AS away_team,
    teams_home_team_name || ' (' || teams_home_league_record_wins || '-' || teams_home_league_record_losses || '-' || teams_home_league_record_ot || '): ' || teams_home_score AS home_team
FROM
    fact_schedule
WHERE
    NOT (teams_home_league_record_wins > 50
         AND teams_away_league_record_wins > 50)
ORDER BY
    game_date DESC
;

SELECT
    game_date,
    game_type,
    season,
    teams_away_team_name || ' (' || teams_away_league_record_wins || '-' || teams_away_league_record_losses || '-' || teams_away_league_record_ot || '): ' || teams_away_score AS away_team,
    teams_home_team_name || ' (' || teams_home_league_record_wins || '-' || teams_home_league_record_losses || '-' || teams_home_league_record_ot || '): ' || teams_home_score AS home_team
FROM
    fact_schedule
WHERE
    (teams_home_league_record_wins > 50
    AND teams_away_league_record_wins < 25)
    OR
    (teams_home_league_record_wins < 25
    AND teams_away_league_record_wins > 50)
ORDER BY
    game_date DESC
;