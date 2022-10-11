load data 
infile 'C:\Users\Jeremy\Documents\nhl_analysis\data\fact_player.csv' "str '\n'"
append
into table FACT_PLAYER
fields terminated by ','
OPTIONALLY ENCLOSED BY '"' AND '"'
trailing nullcols
           ( GAME_ID CHAR(10),
             PLAYER_ID CHAR(7),
             PLAYER_NAME CHAR(128),
             PRIMARY_POSITION_CODE "CASE WHEN :PRIMARY_POSITION_CODE = 'N/A' THEN NULL ELSE :PRIMARY_POSITION_CODE END",
             TEAM_ID CHAR(2),
             TIME_ON_ICE CHAR(6),
             ASSISTS,
             GOALS,
             SHOTS,
             HITS,
             POWER_PLAY_GOALS,
             POWER_PLAY_ASSISTS,
             PENALTY_MINUTES,
             FACE_OFF_WINS,
             FACEOFF_TAKEN,
             TAKEAWAYS,
             GIVEAWAYS,
             SHORT_HANDED_GOALS,
             SHORT_HANDED_ASSISTS,
             BLOCKED,
             PLUS_MINUS,
             EVEN_TIME_ON_ICE CHAR(6),
             POWER_PLAY_TIME_ON_ICE CHAR(6),
             SHORT_HANDED_TIME_ON_ICE CHAR(6),
             FACE_OFF_PCT
           )
