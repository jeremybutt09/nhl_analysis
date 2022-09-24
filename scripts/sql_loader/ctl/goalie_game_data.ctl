load data 
infile 'C:\Users\Jeremy\Documents\nhl_analysis\data\goalie_game_data_2016.csv' "str '\n'"
infile 'C:\Users\Jeremy\Documents\nhl_analysis\data\goalie_game_data_2017.csv' "str '\n'"
infile 'C:\Users\Jeremy\Documents\nhl_analysis\data\goalie_game_data_2018.csv' "str '\n'"
infile 'C:\Users\Jeremy\Documents\nhl_analysis\data\goalie_game_data_2019.csv' "str '\n'"
infile 'C:\Users\Jeremy\Documents\nhl_analysis\data\goalie_game_data_2020.csv' "str '\n'"
infile 'C:\Users\Jeremy\Documents\nhl_analysis\data\goalie_game_data_2021.csv' "str '\n'"
append
into table STATS_GOALIE
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
             EVEN_STRENGTH_SAVE_PERCENTAGE "ROUND(:EVEN_STRENGTH_SAVE_PERCENTAGE, 2)"
           )
