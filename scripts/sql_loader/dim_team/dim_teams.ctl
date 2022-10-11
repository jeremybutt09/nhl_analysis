load data 
infile 'C:\Users\Jeremy\Documents\nhl_analysis\data\dim_teams.csv' "str '\n'"
append
into table DIM_TEAM
fields terminated by ','
OPTIONALLY ENCLOSED BY '"' AND '"'
trailing nullcols
           ( TEAM_ID CHAR(2),
             NAME CHAR(56),
             API_LINK CHAR(56),
             ABBREVIATION CHAR(3),
             TEAM_NAME CHAR(26),
             LOCATION_NAME CHAR(26),
             FIRST_YEAR_OF_PLAY,
             SHORT_NAME CHAR(26),
             OFFICIAL_SITE_URL CHAR(128),
             FRANCHISE_ID CHAR(2),
             ACTIVE CHAR(26),
             VENUE_NAME CHAR(56),
             VENUE_LINK CHAR(26),
             VENUE_CITY CHAR(26),
             VENUE_ID CHAR(4),
             VENUE_TIME_ZONE_ID CHAR(26),
             VENUE_TIME_ZONE_OFFSET,
             VENUE_TIME_ZONE_TZ CHAR(26),
             DIVISION_ID CHAR(2),
             DIVISION_NAME CHAR(26),
             DIVISION_NAME_SHORT CHAR(5),
             DIVISION_LINK CHAR(26),
             DIVISION_ABBREVIATION CHAR(1),
             CONFERENCE_ID CHAR(2),
             CONFERENCE_NAME CHAR(26),
             CONFERENCE_LINK CHAR(26),
             FRANCHISE_FRANCHISE_ID CHAR(2),
             FRANCHISE_TEAM_NAME CHAR(26),
             FRANCHISE_LINK CHAR(26),
             URL CHAR(128),
             COPYRIGHT CHAR(512)
           )
