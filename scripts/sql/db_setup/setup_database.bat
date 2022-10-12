@ECHO off
:: Uses SQL*Plus utility to run the SQL scripts that create
:: and populate the tables in the JEREMYBUTT.

:: If necessary, edit the username/password
sqlplus system/system@10.0.0.69:1521/XEPDB1 @setup_database
sqlldr JEREMYBUTT/system@10.0.0.69:1521/XEPDB1 CONTROL=C:\Users\Jeremy\Documents\nhl_analysis\scripts\sql_loader\dim_game_types\dim_game_type.ctl LOG=C:\Users\Jeremy\Documents\nhl_analysis\scripts\sql_loader\dim_game_types\dim_game_type.log BAD=C:\Users\Jeremy\Documents\nhl_analysis\scripts\sql_loader\dim_game_types\dim_game_type.bad skip=1
sqlldr JEREMYBUTT/system@10.0.0.69:1521/XEPDB1 CONTROL=C:\Users\Jeremy\Documents\nhl_analysis\scripts\sql_loader\dim_player\dim_player.ctl LOG=C:\Users\Jeremy\Documents\nhl_analysis\scripts\sql_loader\dim_player\dim_player.log BAD=C:\Users\Jeremy\Documents\nhl_analysis\scripts\sql_loader\dim_player\dim_player.bad skip=1
sqlldr JEREMYBUTT/system@10.0.0.69:1521/XEPDB1 CONTROL=C:\Users\Jeremy\Documents\nhl_analysis\scripts\sql_loader\dim_season\dim_season.ctl LOG=C:\Users\Jeremy\Documents\nhl_analysis\scripts\sql_loader\dim_season\dim_season.log BAD=C:\Users\Jeremy\Documents\nhl_analysis\scripts\sql_loader\dim_season\dim_season.bad skip=1   
sqlldr JEREMYBUTT/system@10.0.0.69:1521/XEPDB1 CONTROL=C:\Users\Jeremy\Documents\nhl_analysis\scripts\sql_loader\dim_team\dim_teams.ctl LOG=C:\Users\Jeremy\Documents\nhl_analysis\scripts\sql_loader\dim_team\dim_teams.log BAD=C:\Users\Jeremy\Documents\nhl_analysis\scripts\sql_loader\dim_team\dim_teams.bad skip=1   
sqlldr JEREMYBUTT/system@10.0.0.69:1521/XEPDB1 CONTROL=C:\Users\Jeremy\Documents\nhl_analysis\scripts\sql_loader\dim_venue\dim_venue.ctl LOG=C:\Users\Jeremy\Documents\nhl_analysis\scripts\sql_loader\dim_venue\dim_venue.log BAD=C:\Users\Jeremy\Documents\nhl_analysis\scripts\sql_loader\dim_venue\dim_venue.bad skip=1   
sqlldr JEREMYBUTT/system@10.0.0.69:1521/XEPDB1 CONTROL=C:\Users\Jeremy\Documents\nhl_analysis\scripts\sql_loader\fact_goalie\fact_goalie.ctl LOG=C:\Users\Jeremy\Documents\nhl_analysis\scripts\sql_loader\fact_goalie\fact_goalie.log BAD=C:\Users\Jeremy\Documents\nhl_analysis\scripts\sql_loader\fact_goalie\fact_goalie.bad skip=1
sqlldr JEREMYBUTT/system@10.0.0.69:1521/XEPDB1 CONTROL=C:\Users\Jeremy\Documents\nhl_analysis\scripts\sql_loader\fact_player\fact_player.ctl LOG=C:\Users\Jeremy\Documents\nhl_analysis\scripts\sql_loader\fact_player\fact_player.log BAD=C:\Users\Jeremy\Documents\nhl_analysis\scripts\sql_loader\fact_player\fact_player.bad skip=1
sqlldr JEREMYBUTT/system@10.0.0.69:1521/XEPDB1 CONTROL=C:\Users\Jeremy\Documents\nhl_analysis\scripts\sql_loader\fact_schedule\fact_schedule.ctl LOG=C:\Users\Jeremy\Documents\nhl_analysis\scripts\sql_loader\fact_schedule\fact_schedule.log BAD=C:\Users\Jeremy\Documents\nhl_analysis\scripts\sql_loader\fact_schedule\fact_schedule.bad skip=1   

:: Display a message about the log file
ECHO.
ECHO For details, check the setup_database.log file in the current directory.
ECHO.

:: Display 'press any key to continue' message
PAUSE