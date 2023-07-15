CREATE TABLE dim_game_type 
(
    game_type_id              VARCHAR2(26 BYTE)     NOT NULL, 
	game_type_description     VARCHAR2(256 BYTE),
    postseason                VARCHAR2(128 BYTE)
    CONSTRAINT game_type_pk 
        PRIMARY KEY (game_type_id)
);

CREATE TABLE dim_player 
(	
    player_id               VARCHAR2(7 BYTE)        NOT NULL, 
	full_name               VARCHAR2(56 BYTE), 
	first_name              VARCHAR2(26 BYTE), 
	last_name               VARCHAR2(26 BYTE), 
	shoots                  VARCHAR2(2 BYTE), 
	height                  VARCHAR2(6 BYTE), 
	weight                  NUMBER(3,0), 
	jersey_number           VARCHAR2(2 BYTE), 
	captain                 VARCHAR2(5 BYTE), 
	alternate_captain       VARCHAR2(5 BYTE), 
	rookie                  VARCHAR2(5 BYTE), 
	current_team_id         VARCHAR2(2 BYTE), 
	current_team_name       VARCHAR2(26 BYTE), 
	primary_position_name   VARCHAR2(26 BYTE), 
	primary_position_type   VARCHAR2(26 BYTE), 
	birth_date              VARCHAR2(2 BYTE), 
	birth_city              VARCHAR2(56 BYTE), 
	birth_state_province    VARCHAR2(5 BYTE), 
	birth_country           VARCHAR2(3 BYTE), 
	nationality             VARCHAR2(3 BYTE),
    CONSTRAINT player_pk
        PRIMARY KEY (player_id)
);

CREATE TABLE dim_season 
( 
  season_id                   VARCHAR2(8)     NOT NULL,
  regular_season_start_date   DATE,
  regular_season_end_date     DATE,
  season_end_date             DATE,
  number_of_games             NUMBER(38),
  ties_in_use                 VARCHAR2(26),
  olympics_participation      VARCHAR2(26),
  conferences_in_use          VARCHAR2(26),
  divisions_in_use            VARCHAR2(26),
  wild_card_in_use            VARCHAR2(26),
  CONSTRAINT season_pk
    PRIMARY KEY (season_id)
);

CREATE TABLE dim_team 
( 
  team_id                 VARCHAR2(2)		NOT NULL,
  team_full_name          VARCHAR2(56),
  abbreviation            VARCHAR2(3),
  team_name               VARCHAR2(26),
  location_name           VARCHAR2(26),
  first_year_of_play      NUMBER(4),
  short_name              VARCHAR2(26),
  franchise_id            VARCHAR2(2),
  active                  VARCHAR2(26),
  venue_name              VARCHAR2(26),
  venue_city              VARCHAR2(26),
  venue_id                NUMBER(4),
  venue_time_zone_id      VARCHAR2(26),
  venue_time_zone_offset  NUMBER(38),
  venue_time_zone_tz      VARCHAR2(26),
  division_id             VARCHAR2(2),
  division_name           VARCHAR2(26),
  division_name_short     VARCHAR2(5),
  division_abbreviation   VARCHAR2(1),
  conference_id           VARCHAR2(2),
  conference_name         VARCHAR2(26),
  franchise_franchise_id  VARCHAR2(2),
  franchise_team_name     VARCHAR2(26),
  CONSTRAINT team_pk
    PRIMARY KEY (team_id)
);

CREATE TABLE dim_venue 
( 
  venue_id        VARCHAR2(4)		  NOT NULL,
  venue_name      VARCHAR2(128),
  CONSTRAINT venue_pk
    PRIMARY KEY (venue_id)
);

CREATE TABLE fact_goalie 
( 
  game_id                           VARCHAR2(10)	    NOT NULL,
  player_id                         VARCHAR2(7)       	NOT NULL,
  player_name                       VARCHAR2(128),
  primary_position_code             VARCHAR2(1),
  team_name                         VARCHAR2(56),
  team_abbreviation                 VARCHAR2(3),
  time_on_ice                       NUMBER(38, 2),
  decision                          VARCHAR2(5),
  goals                             NUMBER(2),
  assists                           NUMBER(2),
  penalty_minutes                   NUMBER(3),
  saves                             NUMBER(3),
  shots                             NUMBER(2),
  goals_against						NUMBER(2),
  save_percentage					NUMBER(5,2),
  even_saves                        NUMBER(3),
  even_shots_against                NUMBER(3),
  even_strength_save_percentage		NUMBER(5,2),
  power_play_saves                  NUMBER(3),
  power_play_shots_against          NUMBER(3),
  power_play_save_percentage		NUMBER(5,2),
  shorthanded_saves                 NUMBER(3),
  shorthanded_shots_against         NUMBER(3),
  shorthanded_save_percentage		NUMBER(5,2),
  CONSTRAINT fact_goalie_pk
    PRIMARY KEY (game_id, player_id),
  CONSTRAINT fact_goalie_fk_player FOREIGN KEY (player_id)
    REFERENCES dim_player (player_id)
);

CREATE TABLE fact_player 
( 
  game_id                     VARCHAR2(10)    NOT NULL,
  player_id                   VARCHAR2(7)     NOT NULL,
  player_name                 VARCHAR2(128),
  primary_position_code       VARCHAR2(1),
  team_name                   VARCHAR2(56),
  team_abbreviation           VARCHAR2(3),
  time_on_ice                 NUMBER(5, 2),
  goals                       NUMBER(2),
  assists                     NUMBER(2),
  points                      NUMBER(2),
  plus_minus                  NUMBER(2),
  shots                       NUMBER(2),
  hits                        NUMBER(2),
  penalty_minutes             NUMBER(3),
  power_play_goals            NUMBER(2),
  power_play_assists          NUMBER(2),
  power_play_points           NUMBER(2),
  shorthanded_goals           NUMBER(2),
  shorthanded_assists         NUMBER(2),
  shorthanded_points          NUMBER(2),
  face_off_wins               NUMBER(2),
  faceoff_taken               NUMBER(2),
  takeaways                   NUMBER(2),
  giveaways                   NUMBER(2),
  blocked                     NUMBER(2),
  even_time_on_ice            NUMBER(38, 2),
  power_play_time_on_ice      NUMBER(5, 2),
  shorthanded_time_on_ice     NUMBER(5, 2),
  face_off_pct                NUMBER(3),
  CONSTRAINT fact_player_pk
    PRIMARY KEY (game_id, player_id),
  CONSTRAINT fact_player_fk_player FOREIGN KEY (player_id)
    REFERENCES dim_player (player_id)
);

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