OPTIONS (DIRECT=TRUE, SKIP=0, ERRORS=50, ROWS = 50000)
load data 
infile 'C:\Users\Jeremy\Documents\nhl_analysis\01_Input\load_files\fact_schedule_*.csv' "str '\n'"
TRUNCATE
into table FACT_SCHEDULE_LOAD
WHEN total_items != 'TOTAL_ITEMS'
fields terminated by ','
OPTIONALLY ENCLOSED BY '"' AND '"'
trailing nullcols
           ( GAME_DATE DATE "RRRR-MM-DD",
             TOTAL_ITEMS,
             TOTAL_EVENTS,
             TOTAL_GAMES,
             TOTAL_MATCHES,
             GAME_PK,
             API_LINK CHAR(128),
             GAME_TYPE CHAR(26),
             SEASON CHAR(8),
             GAME_DATE_TIME CHAR(20),
             STATUS_ABSTRACT_GAME_STATE CHAR(26),
             STATUS_CODED_GAME_STATE CHAR(38),
             STATUS_DETAILED_STATE CHAR(26),
             STATUS_STATUS_CODE CHAR(38),
             STATUS_START_TIME_TBD CHAR(26),
             TEAMS_AWAY_SCORE,
             TEAMS_AWAY_LEAGUE_RECORD_WINS,
             TEAMS_AWAY_LEAGUE_RECORD_LOSSES,
             TEAMS_AWAY_LEAGUE_RECORD_OT,
             TEAMS_AWAY_LEAGUE_RECORD_TYPE CHAR(26),
             TEAMS_AWAY_TEAM_ID CHAR(38),
             TEAMS_AWAY_TEAM_NAME CHAR(52),
             TEAMS_AWAY_TEAM_LINK CHAR(52),
             TEAMS_HOME_SCORE,
             TEAMS_HOME_LEAGUE_RECORD_WINS,
             TEAMS_HOME_LEAGUE_RECORD_LOSSES,
             TEAMS_HOME_LEAGUE_RECORD_OT,
             TEAMS_HOME_LEAGUE_RECORD_TYPE CHAR(26),
             TEAMS_HOME_TEAM_ID CHAR(38),
             TEAMS_HOME_TEAM_NAME CHAR(52),
             TEAMS_HOME_TEAM_LINK CHAR(52),
             VENUE_ID CHAR(38),
             VENUE_NAME CHAR(256),
             VENUE_LINK CHAR(52),
             CONTENT_LINK CHAR(256),
			 LOAD_DATE "SYSDATE"
           )
