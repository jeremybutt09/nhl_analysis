DROP TABLE "SPORTDATASCI"."STATS_PLAYER";


CREATE TABLE "SPORTDATASCI"."STATS_PLAYER" 
   (
    "GAME_ID"                               VARCHAR2(10 BYTE)   NOT NULL ENABLE, 
	"PLAYER_ID"                             VARCHAR2(7 BYTE)    NOT NULL ENABLE, 
	"PLAYER_NAME"                           VARCHAR2(128 BYTE)  NOT NULL ENABLE, 
	"PRIMARY_POSITION_CODE"                 VARCHAR2(1 BYTE), 
	"TEAM_ID"                               VARCHAR2(2 BYTE), 
	"TIME_ON_ICE"                           VARCHAR2(6 BYTE), 
	"ASSISTS"                               NUMBER(2,0), 
	"GOALS"                                 NUMBER(2,0), 
	"SHOTS"                                 NUMBER(2,0), 
	"HITS"                                  NUMBER(2,0), 
	"POWER_PLAY_GOALS"                      NUMBER(2,0), 
	"POWER_PLAY_ASSISTS"                    NUMBER(2,0), 
	"PENALTY_MINUTES"                       NUMBER(3,0), 
	"FACE_OFF_WINS"                         NUMBER(2,0), 
	"FACEOFF_TAKEN"                         NUMBER(2,0), 
	"TAKEAWAYS"                             NUMBER(2,0), 
	"GIVEAWAYS"                             NUMBER(2,0), 
	"SHORT_HANDED_GOALS"                    NUMBER(2,0), 
	"SHORT_HANDED_ASSISTS"                  NUMBER(2,0), 
	"BLOCKED"                               NUMBER(2,0), 
	"PLUS_MINUS"                            NUMBER(2,0), 
	"EVEN_TIME_ON_ICE"                      VARCHAR2(6 BYTE), 
	"POWER_PLAY_TIME_ON_ICE"                VARCHAR2(6 BYTE), 
	"SHORT_HANDED_TIME_ON_ICE"              VARCHAR2(6 BYTE), 
	"FACE_OFF_PCT"                          NUMBER(3,0)
   )

