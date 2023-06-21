SELECT
    player.game_id,
    player_id,
    player_name,
    primary_position_code,
    team_name,
    team_abbreviation,
    time_on_ice,
    goals,
    assists,
    points,
    shots,
    hits,
    penalty_minutes,
    power_play_goals,
    power_play_assists,
    power_play_points,
    face_off_wins,
    faceoff_taken,
    takeaways,
    giveaways,
    short_handed_goals,
    short_handed_assists,
    short_handed_points,
    blocked,
    plus_minus,
    even_time_on_ice,
    power_play_time_on_ice,
    short_handed_time_on_ice,
    face_off_pct
FROM
    vw_fact_player player
    JOIN vw_fact_schedule sch
        ON player.game_id = sch.game_pk
WHERE
    player_id IN ('8477934', --Leon Draisaitl
                  '8471675', --Sidney Crosby
                  '8478402', --Connor McDavid
                  '8471214', --Alex Ovechkin
                  '8477492', --Nathan MacKinnon
                  '8480069', --Cale Makar
                  '8479318', --Mitchell Marner
                  '8476945', --Connor Hellebuyck
                  '8480012', --Elias Pettersson
                  '8477496', --Elias Lindholm
                  '8476346', --Johnny Gaudreau
                  '8480801', --Brady Tkachuk
                  '8479314', --Matthew Tkachuk
                  '8476883', --Andrei Vasilevskiy
                  '8480018', --Nick Suzuki
                  '8475167', --Victor Hedman
                  '8476453', --Nikita Kucherov
                  '8481559', --Jack Hughes
                  '8480800', --Quinn Hughes
                  '8478403', --Jack Eichel
                  '8476456', --Jonathan Huberdeau
                  '8477346', --MacKenzie Weegar
                  '8477424', --Juuse Saros
                  '8477956', --David Pastrnak
                  '8476973', --Erik Karlsson
                  '8480839', --Rasmus Dahlin
                  '8481533', --Trevor Zegras
                  '8482110') --Dawson Mercer
    AND SUBSTR(sch.season, 1, 4) = '2022'
;
    
SELECT
    game_id,
    player_id,
    player_name,
    primary_position_code,
    team_name,
    team_abbreviation,
    time_on_ice,
    decision,
    goals,
    assists,
    penalty_minutes,
    saves,
    shots,
    goals_against,
    save_percentage,
    even_saves,
    even_shots_against,
    even_strength_save_percentage,
    power_play_saves,
    power_play_shots_against,
    power_play_save_percentage,
    short_handed_saves,
    short_handed_shots_against,
    short_handed_save_percentage
FROM
    vw_fact_goalie goalie
    JOIN vw_fact_schedule sch
        ON goalie.game_id = sch.game_pk
WHERE
    player_id IN ('8476945', --Connor Hellebuyck
                  '8476883', --Andrei Vasilevskiy
                  '8477424') --Juuse Saros
    AND SUBSTR(sch.season, 1, 4) = '2022';
    
SELECT
    game_date,
    game_pk,
    game_type_description,
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
    vw_fact_schedule
WHERE
    SUBSTR(season, 1, 4) = '2022';