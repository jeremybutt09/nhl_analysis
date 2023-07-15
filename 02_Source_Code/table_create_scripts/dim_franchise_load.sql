CREATE TABLE dim_franchise_load (
    franchise_id                NUMBER(38,0),
    first_season_id             NUMBER(38,0), 
    most_recent_team_id         NUMBER(38,0),
    team_name                   VARCHAR2(32 BYTE),
    location_name               VARCHAR2(32 BYTE),
    franchise_link              VARCHAR2(64 BYTE),
    last_season_id              NUMBER(38,0)
)