CREATE TABLE dim_franchise (
    franchise_id                NUMBER(2,0),
    first_season_id             NUMBER(8,0), 
    most_recent_team_id         NUMBER(2,0),
    team_name                   VARCHAR2(32 BYTE),
    location_name               VARCHAR2(32 BYTE),
    franchise_link              VARCHAR2(64 BYTE),
    last_season_id              NUMBER(8,0),
    load_date                   DATE,
    CONSTRAINT franchise_pk PRIMARY KEY (franchise_id)
)