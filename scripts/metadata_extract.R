#LOAD LIBRARY
library(tidyverse)
library(lubridate)
library("nhlapi")

#DEFINGIN THE OUTPUT FILES. IT IS IMPORTANT THAT THE LIST ORDER IS THE SAME AS
#THE FUNCTION ORDER IN THE NEXT STEP
output_files <- list("/Users/jeremybutt/nhl_analysis/data/metadata_game_types.csv",
                     "/Users/jeremybutt/nhl_analysis/data/metadata_play_types.csv",
                     "/Users/jeremybutt/nhl_analysis/data/metadata_standing_types.csv",
                      "/Users/jeremybutt/nhl_analysis/data/metadata_stat_types.csv")

#CREATING LIST OF METADATA AND RENAMING ALL COLUMNS TO BE IMPORTED INTO ORACLE
metadata_functions_list <- append(nhl_md_game_types(),
                                  nhl_md_play_types()) %>%
    append(nhl_md_standings_types()) %>%
    append(nhl_md_stat_types()) %>%
    map(., ~ rename_with(.x,
                         str_replace_all, 
                         pattern = "\\.",
                         replacement = "_")) %>%
    map(., ~ rename_with(.,
                         str_replace_all,
                         pattern = "(?<=[a-z0-9])(?=[A-Z])",
                         replacement = "_")) %>%
    map(., ~ rename_with(.x, 
                         str_to_upper))

#WRITING METADATA TO DATA FOLDER
map2(.x = metadata_functions_list,
     .y = output_files,
     ~ write_csv(
           x = .x,
           file = .y,
           na = ""))

