load data 
infile 'C:\Users\Jeremy\Documents\nhl_analysis\data\dim_player.csv' "str '\n'"
append
into table DIM_PLAYER
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
             BIRTH_CITY CHAR(56),
             BIRTH_STATE_PROVINCE CHAR(5),
             BIRTH_COUNTRY CHAR(3),
             NATIONALITY CHAR(3),
             HEIGHT CHAR(6),
             WEIGHT,
             ACTIVE CHAR(26),
             ROOKIE CHAR(26),
             SHOOTS CHAR(2),
             ROSTER_STATUS CHAR(1),
             PRIMARY_POSITION_CODE CHAR(1),
             PRIMARY_POSITION_NAME CHAR(26),
             PRIMARY_POSITION_TYPE CHAR(26),
             PRIMARY_POSITION_ABBREVIATION CHAR(2),
             URL CHAR(128),
             COPYRIGHT CHAR(256),
             CURRENT_AGE,
             ALTERNATE_CAPTAIN CHAR(26),
             CAPTAIN CHAR(26),
             CURRENT_TEAM_ID CHAR(2),
             CURRENT_TEAM_NAME CHAR(26),
             CURRENT_TEAM_LINK CHAR(56)
           )
