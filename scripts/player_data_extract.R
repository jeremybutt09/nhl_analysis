#LOAD LIBRARY
library(tidyverse)
library(lubridate)
library(magrittr)
library("nhlapi")

#OUTPUT FILE
player_output_file <- "data/player_game_data.csv"
goalie_output_file <- "data/goalie_game_data.csv"

#FILE WITH SCHEDULE DATA. 
schedule_file <- "data/schedule_data.csv"

#LOADING ONLY GAME_PK DATA. THIS WILL BE RUN THROUGH A LOOP
game_id <- read_csv(file = schedule_file,
                          col_select = GAME_PK) %>%
    pull(GAME_PK)

#DEFINING THE HOME VS AWAY LIST
home_away_list <- list("home",
                       "away")

for (i in 1:2) {

boxscore <- nhl_games_boxscore(game_id[i])

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
                        data = boxscore) %>%
    bind_rows()

write_csv(x = player_game_data,
          file = player_output_file,
          na = "",
          append = TRUE)

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
                        data = boxscore) %>%
    bind_rows

write_csv(x = goalie_game_data,
          file = goalie_output_file,
          na = "",
          append = TRUE)

}
