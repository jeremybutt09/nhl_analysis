load data 
infile 'C:\Users\Jeremy\Documents\nhl_analysis\data\dim_game_type.csv' "str '\r\n'"
append
into table DIM_GAME_TYPE
fields terminated by ','
OPTIONALLY ENCLOSED BY '"' AND '"'
trailing nullcols
           ( GAME_TYPE_ID CHAR(26),
             DESCRIPTION CHAR(128),
             POSTSEASON CHAR(26)
           )
