::@echo off

::reading Oracle_Username from environmental variables and assigning it to variable password
::reading Oracle_Password from environmental variables and and assigning it to variable username
set username=%Oracle_Username%
set password=%Oracle_Password%

::changing directory to F: then navigating to 09_QuadAim project folder
C:
set root="C:\Users\Jeremy\Documents\nhl_analysis\"
cd %root%

::extracting day, month, year from date. This will be used to dynamicly name log files.
set year=%date:~0,4%
set month=%date:~5,2%
set day=%date:~8,2%
set today=%year%%month%%day%

::creating variable that will be used for the CONTROL parameter in the sqlldr command
set CtlFileDir=02_Source_Code\sql_loader\
set CtlFileFactSchedule=%CtlFileDir%fact_schedule_load.ctl
set CtlFileFactPlayer=%CtlFileDir%fact_player_load.ctl
set CtlFileFactGoalie=%CtlFileDir%fact_goalie_load.ctl
set CtlFileDimPlayer=%CtlFileDir%dim_player_load.ctl

::creating variables that will be used for the LOG parameter in the sqlldr command
set LogFileDir=03_Output\log_files\
set LogFileFactSchedule=%LogFileDir%Fact_Schedule_%today%.log
set LogFileFactPlayer=%LogFileDir%Fact_Player_%today%.log
set LogFileFactGoalie=%LogFileDir%Fact_Goalie_%today%.log
set LogFileDimPlayer=%LogFileDir%Dim_Player_%today%.log

::calling SQL loader to run control file that will load data. See control file for more details. Also see log and bad files for more details
::Fact Schedule Load
sqlldr %username%/%password%@10.0.0.69:1521/XEPDB1 CONTROL=%CtlFileFactSchedule% LOG=%LogFileFactSchedule% BAD='C:\Users\Jeremy\Documents\nhl_analysis\03_Output\bad_files\'
::Fact Player Load
sqlldr %username%/%password%@10.0.0.69:1521/XEPDB1 CONTROL=%CtlFileFactPlayer% LOG=%LogFileFactPlayer% BAD='C:\Users\Jeremy\Documents\nhl_analysis\03_Output\bad_files\'
::Fact Player Load
sqlldr %username%/%password%@10.0.0.69:1521/XEPDB1 CONTROL=%CtlFileFactGoalie% LOG=%LogFileFactGoalie% BAD='C:\Users\Jeremy\Documents\nhl_analysis\03_Output\bad_files\'
::Fact Player Load
sqlldr %username%/%password%@10.0.0.69:1521/XEPDB1 CONTROL=%CtlFileDimPlayer% LOG=%LogFileDimPlayer% BAD='C:\Users\Jeremy\Documents\nhl_analysis\03_Output\bad_files\'

::Navigating to load_files folder to move files that were loaded into the database to their appropriate archive folders then delete files from load_files folder. 
::This will unsure workflow doesn't break next month/load
set root="C:\Users\Jeremy\Documents\nhl_analysis\01_Input\"
cd %root%

::copying files from load_files folder to appropriate folder
xcopy "load_files\fact_schedule_*.csv" "nhl_api\fact_schedule" /Y /I
xcopy "load_files\fact_player_*.csv" "nhl_api\fact_player" /Y /I
xcopy "load_files\fact_goalie_*.csv" "nhl_api\fact_goalie" /Y /I
xcopy "load_files\dim_player_*.csv" "nhl_api\dim_player" /Y /I

::deleting files from load_files folder for reasons stated above
del load_files\*.csv

::will prompt user to press any key to continue and exit window. Gives the user an opportunity to review terminal
PAUSE
