#LOAD LIBRARY
library(tidyverse)
library(lubridate)
library("nhlapi")

game_metadata <-nhl_md_game_types()
play_metadata <- nhl_md_play_types()
standings_metadata <- nhl_md_standings_types()
stat_metadata <- nhl_md_stat_types()

metadata_functions_list <- list(nhl_md_game_types(),
                                nhl_md_play_types(),
                                nhl_md_standings_types(),
                                nhl_md_stat_types()) %>%
    unnest()
    
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

metadata_functions_list[[1]]
