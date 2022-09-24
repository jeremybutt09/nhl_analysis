DROP TABLE "SPORTDATASCI"."STATS_GOALIE";
CREATE TABLE "SPORTDATASCI"."STATS_GOALIE" 
   (
    "GAME_ID"                               VARCHAR2(10 BYTE)   NOT NULL ENABLE, 
	"PLAYER_ID"                             VARCHAR2(7 BYTE)    NOT NULL ENABLE, 
	"PLAYER_NAME"                           VARCHAR2(128 BYTE)  NOT NULL ENABLE, 
	"PRIMARY_POSITION_CODE"                 VARCHAR2(1 BYTE), 
	"TEAM_ID"                               VARCHAR2(2 BYTE), 
	"TIME_ON_ICE"                           VARCHAR2(6 BYTE), 
	"ASSISTS"                               NUMBER(2,0), 
	"GOALS"                                 NUMBER(2,0), 
	"PIM  "                                 NUMBER(3,0), 
	"SHOTS"                                 NUMBER(2,0), 
	"SAVES"                                 NUMBER(3,0), 
	"POWER_PLAY_SAVES"                      NUMBER(3,0), 
	"SHORT_HANDED_SAVES"                    NUMBER(3,0), 
	"EVEN_SAVES"                            NUMBER(3,0), 
	"SHORT_HANDED_SHOTS_AGAINST"            NUMBER(3,0), 
	"EVEN_SHOTS_AGAINST"                    NUMBER(3,0), 
	"POWER_PLAY_SHOTS_AGAINST"              NUMBER(3,0), 
	"DECISION"                              VARCHAR2(26 BYTE), 
	"SAVE_PERCENTAGE"                       NUMBER(5,2), 
	"EVEN_STRENGTH_SAVE_PERCENTAGE"         NUMBER(5,2)
   )

