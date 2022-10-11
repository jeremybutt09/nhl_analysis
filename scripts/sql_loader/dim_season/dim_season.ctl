load data 
infile 'C:\Users\Jeremy\Documents\nhl_analysis\data\dim_season.csv' "str '\n'"
append
into table DIM_SEASON
fields terminated by ','
OPTIONALLY ENCLOSED BY '"' AND '"'
trailing nullcols
           ( SEASON_ID CHAR(8),
             REGULAR_SEASON_START_DATE "TO_DATE(:REGULAR_SEASON_START_DATE , 'YYYY-MM-DD')",
             REGULAR_SEASON_END_DATE "TO_DATE(:REGULAR_SEASON_END_DATE , 'YYYY-MM-DD')",
             SEASON_END_DATE "TO_DATE(:SEASON_END_DATE , 'YYYY-MM-DD')",
             NUMBER_OF_GAMES,
             TIES_IN_USE CHAR(26),
             OLYMPICS_PARTICIPATION CHAR(26),
             CONFERENCES_IN_USE CHAR(26),
             DIVISIONS_IN_USE CHAR(26),
             WILD_CARD_IN_USE CHAR(26),
             URL CHAR(256),
             COPYRIGHT CHAR(512)
           )
