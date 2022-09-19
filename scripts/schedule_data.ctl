load data 
infile 'C:\Users\Jeremy\Documents\nhl_analysis\data\schedule_data.csv' "str '\n'"
append
into table nhl_schedule
fields terminated by ','
OPTIONALLY ENCLOSED BY '"' AND '"'
trailing nullcols
           ( GAME_DATE DATE "RRRR-MM-DD",
             TOTALITEMS,
             TOTALEVENTS,
             TOTALGAMES,
             TOTALMATCHES,
             GAMEPK CHAR(4000),
             LINK CHAR(4000),
             GAMETYPE CHAR(4000),
             SEASON CHAR(4000),
             GAMEDATE CHAR(4000),
             STATUS_ABSTRACTGAMESTATE CHAR(4000),
             STATUS_CODEDGAMESTATE CHAR(4000),
             STATUS_DETAILEDSTATE CHAR(4000),
             STATUS_STATUSCODE CHAR(4000),
             STATUS_STARTTIMETBD CHAR(4000),
             TEAMS_AWAY_SCORE,
             TEAMS_AWAY_LEAGUERECORD_WINS,
             TEAMS_AWAY_LEAGUERECORD_LOSSES,
             TEAMS_AWAY_LEAGUERECORD_OT,
             TEAMS_AWAY_LEAGUERECORD_TYPE CHAR(4000),
             TEAMS_AWAY_TEAM_ID CHAR(4000),
             TEAMS_AWAY_TEAM_NAME CHAR(4000),
             TEAMS_AWAY_TEAM_LINK CHAR(4000),
             TEAMS_HOME_SCORE,
             TEAMS_HOME_LEAGUERECORD_WINS,
             TEAMS_HOME_LEAGUERECORD_LOSSES,
             TEAMS_HOME_LEAGUERECORD_OT,
             TEAMS_HOME_LEAGUERECORD_TYPE CHAR(4000),
             TEAMS_HOME_TEAM_ID CHAR(4000),
             TEAMS_HOME_TEAM_NAME CHAR(4000),
             TEAMS_HOME_TEAM_LINK CHAR(4000),
             VENUE_ID CHAR(4000),
             VENUE_NAME CHAR(4000),
             VENUE_LINK CHAR(4000),
             CONTENT_LINK CHAR(4000)
           )
