OPTIONS (DIRECT=TRUE, SKIP=0, ERRORS=50, ROWS=50000)
load data
infile 'C:\Users\Jeremy\Documents\nhl_analysis\01_Input\load_files\fact_goalie_*.csv' "str '\n'"
TRUNCATE
into table FACT_GOALIE_LOAD
WHEN game_id != 'GAME_ID'
fields terminated by ','
OPTIONALLY ENCLOSED BY '"' AND '"'
trailing nullcols
           ( GAME_ID CHAR(10),
             PLAYER_ID CHAR(7),
             PLAYER_NAME CHAR(128),
             PRIMARY_POSITION_CODE CHAR(1),
             TEAM_ID CHAR(2),
             TIME_ON_ICE CHAR(6),
             ASSISTS,
             GOALS,
             PENALTY_MINUTES,
             SHOTS,
             SAVES,
             POWER_PLAY_SAVES,
             SHORT_HANDED_SAVES,
             EVEN_SAVES,
             SHORT_HANDED_SHOTS_AGAINST,
             EVEN_SHOTS_AGAINST,
             POWER_PLAY_SHOTS_AGAINST,
             DECISION CHAR(26),
             SAVE_PERCENTAGE "ROUND(:SAVE_PERCENTAGE, 2)",
             EVEN_STRENGTH_SAVE_PERCENTAGE "ROUND(:EVEN_STRENGTH_SAVE_PERCENTAGE, 2)",
			 LOAD_DATE "SYSDATE"
           )
