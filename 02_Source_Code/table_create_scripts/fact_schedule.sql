DROP TABLE fact_schedule PURGE;
CREATE TABLE fact_schedule 
( 
  game_date                 DATE,
  game_id                   VARCHAR2(10)    NOT NULL,
  game_type_description     VARCHAR2(32),
  season                    VARCHAR2(8),
  game_date_time            DATE,
  away_team_name            VARCHAR2(26),
  away_team_score           NUMBER(2),
  away_team_wins            NUMBER(2),
  away_team_losses          NUMBER(2),
  away_team_ot              NUMBER(2),
  home_team_name            VARCHAR2(26),
  home_team_score           NUMBER(2),
  home_team_wins            NUMBER(2),
  home_team_losses          NUMBER(2),
  home_team_ot              NUMBER(2),
  venue_name                VARCHAR2(56),
  CONSTRAINT game_pk
    PRIMARY KEY (game_id),
  CONSTRAINT fact_schedule_fk_season FOREIGN KEY (season)
    REFERENCES dim_season (season_id)
);