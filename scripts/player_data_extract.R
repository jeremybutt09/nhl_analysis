#LOAD LIBRARY
library(tidyverse)
library(lubridate)
library(magrittr)
library("nhlapi")

game_id <- 2021010002

boxscore <- nhl_games_boxscore(game_id)

home_away_list <- list("home",
                       "away")

player_game_data_extract <- function(data, home_away) {
    player_data <- data %>%
        .[[1]] %>%
        extract2("teams") %>%
        extract2(home_away) %>%
        extract2("players") %>%
        tibble(player_id = .) %>%
        unnest_wider(player_id) %>%
        unnest_wider(stats) %>%
        unnest_wider(skaterStats) %>%
        hoist(person,
              player_id = list("id"),
              player_name = list("fullName"),
              primary_position_code = list("primaryPosition", "code")) %>%
        filter(primary_position_code != "G",
               !is.na(timeOnIce)) %>%
        select(player_id,
               player_name,
               primary_position_code,
               timeOnIce:faceOffPct) %>%
        rename_with(.,
                    str_replace_all,
                    pattern = "(?<=[a-z0-9])(?=[A-Z])",
                    replacement = "_") %>%
        rename_with(.,
                    str_to_upper)
    return(player_data)
}

player_game_data <- map(.x = home_away_list, 
                        .f = player_game_data_extract, 
                        data = boxscore)

goalie_game_data_extract <- function(data, home_away) {
    goalie_data <- data %>%
        .[[1]] %>%
        extract2("teams") %>%
        extract2(home_away) %>%
        extract2("players") %>%
        tibble(player_id = .) %>%
        unnest_wider(player_id) %>%
        unnest_wider(stats) %>%
        unnest_wider(goalieStats) %>%
        hoist(person,
              player_id = list("id"),
              player_name = list("fullName"),
              primary_position_code = list("primaryPosition", "code")) %>%
        filter(primary_position_code == "G",
               !is.na(timeOnIce)) %>%
        select(player_id,
               player_name,
               primary_position_code,
               timeOnIce:evenStrengthSavePercentage) %>%
        rename_with(.,
                    str_replace_all,
                    pattern = "(?<=[a-z0-9])(?=[A-Z])",
                    replacement = "_") %>%
        rename_with(.,
                    str_to_upper)
    return(goalie_data)
}

goalie_game_data <- map(.x = home_away_list, 
                        .f = goalie_game_data_extract, 
                        data = boxscore)
