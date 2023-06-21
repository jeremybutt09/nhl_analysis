OPTIONS (DIRECT=TRUE, SKIP=0, ERRORS=50, ROWS=50000)
load data
infile 'C:\Users\Jeremy\Documents\nhl_analysis\01_Input\load_files\dim_player_*.csv' "str '\n'"
TRUNCATE
into table DIM_PLAYER_LOAD
WHEN player_id != 'ID'
fields terminated by ','
OPTIONALLY ENCLOSED BY '"' AND '"'
trailing nullcols
           ( PLAYER_ID CHAR(7),
             FULL_NAME CHAR(56),
             API_LINK CHAR(26),
             FIRST_NAME CHAR(26),
             LAST_NAME CHAR(26),
             PRIMARY_NUMBER CHAR(2),
             BIRTH_DATE "TO_DATE(:BIRTH_DATE, 'YYYY-MM-DD')",
			 CURRENT_AGE,
             BIRTH_CITY CHAR(56),
             BIRTH_COUNTRY CHAR(3),
             NATIONALITY CHAR(3),
             HEIGHT CHAR(6),
             WEIGHT,
             ACTIVE CHAR(5),
             ALTERNATE_CAPTAIN CHAR(5),
             CAPTAIN CHAR(5),
             ROOKIE CHAR(5),
             SHOOTS_CATCHES CHAR(2),
             ROSTER_STATUS CHAR(1),
             CURRENT_TEAM_ID CHAR(2),
             CURRENT_TEAM_NAME CHAR(26),
             CURRENT_TEAM_LINK CHAR(56),
             PRIMARY_POSITION_CODE CHAR(1),
             PRIMARY_POSITION_NAME CHAR(26),
             PRIMARY_POSITION_TYPE CHAR(26),
             PRIMARY_POSITION_ABBREVIATION CHAR(2),
             URL CHAR(128),
             COPYRIGHT CHAR(256),
			 BIRTH_STATE_PROVINCE CHAR(5),
			 LOAD_DATE "SYSDATE"
           )
