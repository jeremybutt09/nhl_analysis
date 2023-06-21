DROP TABLE "JEREMYBUTT"."FACT_SCHEDULE_LOAD";
CREATE TABLE "JEREMYBUTT"."FACT_SCHEDULE_LOAD" 
   (	
    "GAME_DATE" DATE, 
	"TOTAL_ITEMS" NUMBER(38,0), 
	"TOTAL_EVENTS" NUMBER(38,0), 
	"TOTAL_GAMES" NUMBER(2,0), 
	"TOTAL_MATCHES" NUMBER(38,0), 
	"GAME_PK" NUMBER(10,0), 
	"API_LINK" VARCHAR2(128 BYTE), 
	"GAME_TYPE" VARCHAR2(26 BYTE), 
	"SEASON" VARCHAR2(8 BYTE), 
	"GAME_DATE_TIME" VARCHAR2(20 BYTE), 
	"STATUS_ABSTRACT_GAME_STATE" VARCHAR2(26 BYTE), 
	"STATUS_CODED_GAME_STATE" VARCHAR2(38 BYTE), 
	"STATUS_DETAILED_STATE" VARCHAR2(26 BYTE), 
	"STATUS_STATUS_CODE" VARCHAR2(38 BYTE), 
	"STATUS_START_TIME_TBD" VARCHAR2(26 BYTE), 
	"TEAMS_AWAY_SCORE" NUMBER(2,0), 
	"TEAMS_AWAY_LEAGUE_RECORD_WINS" NUMBER(2,0), 
	"TEAMS_AWAY_LEAGUE_RECORD_LOSSES" NUMBER(3,0), 
	"TEAMS_AWAY_LEAGUE_RECORD_OT" NUMBER(2,0), 
	"TEAMS_AWAY_LEAGUE_RECORD_TYPE" VARCHAR2(26 BYTE), 
	"TEAMS_AWAY_TEAM_ID" VARCHAR2(38 BYTE), 
	"TEAMS_AWAY_TEAM_NAME" VARCHAR2(52 BYTE), 
	"TEAMS_AWAY_TEAM_LINK" VARCHAR2(52 BYTE), 
	"TEAMS_HOME_SCORE" NUMBER(2,0), 
	"TEAMS_HOME_LEAGUE_RECORD_WINS" NUMBER(2,0), 
	"TEAMS_HOME_LEAGUE_RECORD_LOSSES" NUMBER(2,0), 
	"TEAMS_HOME_LEAGUE_RECORD_OT" NUMBER(2,0), 
	"TEAMS_HOME_LEAGUE_RECORD_TYPE" VARCHAR2(26 BYTE), 
	"TEAMS_HOME_TEAM_ID" VARCHAR2(38 BYTE), 
	"TEAMS_HOME_TEAM_NAME" VARCHAR2(52 BYTE), 
	"TEAMS_HOME_TEAM_LINK" VARCHAR2(52 BYTE), 
	"VENUE_ID" VARCHAR2(38 BYTE), 
	"VENUE_NAME" VARCHAR2(256 BYTE), 
	"VENUE_LINK" VARCHAR2(52 BYTE), 
	"CONTENT_LINK" VARCHAR2(256 BYTE),
    "LOAD_DATE" DATE,
	 CONSTRAINT "GAME_PK_LOAD" PRIMARY KEY ("GAME_PK"));

