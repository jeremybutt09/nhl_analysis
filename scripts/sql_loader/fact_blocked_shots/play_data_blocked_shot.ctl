load data 
infile 'C:\Users\Jeremy\Documents\nhl_analysis\data\play_data_blocked shot.csv' "str '\n'"
append
into table FACT_BLOCKED_SHOT
fields terminated by ','
OPTIONALLY ENCLOSED BY '"' AND '"'
trailing nullcols
           ( RESULT_EVENT CHAR(12),
             RESULT_EVENT_CODE CHAR(26),
             RESULT_EVENT_TYPE_ID CHAR(12),
             RESULT_DESCRIPTION CHAR(512),
             RESULT_SECONDARY_TYPE CHAR(26),
             RESULT_GAME_WINNING_GOAL CHAR(26),
             RESULT_EMPTY_NET CHAR(26),
             RESULT_PENALTY_SEVERITY CHAR(26),
             RESULT_PENALTY_MINUTES CHAR(26),
             RESULT_STRENGTH_CODE CHAR(26),
             RESULT_STRENGTH_NAME CHAR(26),
             ABOUT_EVENT_IDX CHAR(26),
             ABOUT_EVENT_ID CHAR(26),
             ABOUT_PERIOD CHAR(1),
             ABOUT_PERIOD_TYPE CHAR(26),
             ABOUT_ORDINAL_NUM CHAR(4),
             ABOUT_PERIOD_TIME CHAR(5),
             ABOUT_PERIOD_TIME_REMAINING CHAR(5),
             ABOUT_DATE_TIME CHAR(26),
             ABOUT_GOALS_AWAY,
             ABOUT_GOALS_HOME,
             COORDINATES_X,
             COORDINATES_Y,
             TEAM_ID CHAR(2),
             TEAM_NAME CHAR(56),
             TEAM_LINK CHAR(56),
             TEAM_TRI_CODE CHAR(3),
             BLOCKER CHAR(7),
             SHOOTER CHAR(7),
             GAME_ID CHAR(10)
           )
