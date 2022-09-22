#LOAD LIBRARY
library(tidyverse)
library(lubridate)
library(magrittr)
library("nhlapi")

#OUTPUT FILE
player_output_file <- "data/player_game_data"
goalie_output_file <- "data/goalie_game_data.csv"

#FILE WITH SCHEDULE DATA. 
schedule_file <- "data/schedule_data.csv"

#LOADING ONLY GAME_PK DATA. THIS WILL BE RUN THROUGH A LOOP
game_id <- read_csv(file = schedule_file) %>%
    filter(DATE >= as_date("2016-09-01"),
           DATE <= today()) %>%
    pull(GAME_PK)

#DEFINING THE HOME VS AWAY LIST
home_away_list <- list("home",
                       "away")

player_game_data_extract <- function(game_id, home_away) {
    player_data <- nhl_games_boxscore(game_id) %>%
        .[[1]] %>%
        extract2("teams") %>%
        extract2(home_away) %>%
        extract2("players") %>%
        tibble(player_id = .) %>%
        unnest_wider(player_id) %>%
        unnest_wider(stats) %>%
        unnest_wider(skaterStats,
                     names_sep = "_") %>%
        hoist(person,
              player_id = list("id"),
              player_name = list("fullName"),
              primary_position_code = list("primaryPosition", "code")) %>%
        filter(primary_position_code != "G",
               !is.na(skaterStats_timeOnIce)) %>%
        select(player_id,
               player_name,
               primary_position_code,
               starts_with("skaterStats_")) %>%
        rename_with(.,
                    str_replace_all,
                    pattern = "(?<=[a-z0-9])(?=[A-Z])",
                    replacement = "_") %>%
        rename_with(.,
                    str_to_upper) %>%
        rename_with(.,
                    str_remove,
                    pattern = "SKATER_STATS_")
    
    return(player_data)
}

#1 2892
#1 2909
#1 2916
for (i in 1:length(home_away_list)) {
    for (j in 2916:length(game_id)) {
    
    test <- nhl_games_boxscore(game_id[j]) %>%
                .[[1]] %>%
                extract2("teams") %>%
                extract2("away") %>%
                extract2("players")
    
    if (length(test) == 0) {
        next
    }

    player_game_data <- player_game_data_extract(game_id = game_id[j],
                                                 home_away = home_away_list[[i]])
    print(paste(i, " ", j))
    
    write_csv(x = player_game_data,
              file = paste(player_output_file, "_", str_sub(game_id[i], 1, 4), ".csv", sep = ""),
              na = "",
              append = TRUE)

    }
}

file.remove(player_output_file)

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
