load data 
infile 'C:\Users\Jeremy\Documents\nhl_analysis\data\dim_venue.csv' "str '\n'"
append
into table DIM_VENUE
fields terminated by ','
OPTIONALLY ENCLOSED BY '"' AND '"'
trailing nullcols
           ( VENUE_ID CHAR(4),
             VENUE_NAME CHAR(128),
             VENUE_LINK CHAR(26),
             APP_ENABLED CHAR(26),
             URL CHAR(128),
             COPYRIGHT CHAR(256)
           )
