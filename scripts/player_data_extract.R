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

#CREATING A VECTOR OF COLUMN NAMES WITH THE CORRESPONDING NA VALUES. THIS WILL BE USED IN THE CASE
#A COLUMN DOESN'T EXIST IN API CALL. NOT SURE THE REASON BUT IT SEEMS SOMETIMES THAT faceOffPct COLUMN
#IS NOT AVAILABLE IN API CALL
col <- c(PLAYER_ID = NA_integer_,
         PLAYER_NAME = NA_character_,
         PRIMARY_POSITION_CODE = NA_character_,
         TIME_ON_ICE = NA_character_,
         ASSISTS = NA_integer_,
         GOALS = NA_integer_,
         SHOTS = NA_integer_,
         HITS = NA_integer_,
         POWER_PLAY_GOALS = NA_integer_,
         POWER_PLAY_ASSISTS = NA_integer_,
         PENALTY_MINUTES = NA_integer_,
         FACE_OFF_WINS = NA_integer_,
         FACEOFF_TAKEN = NA_integer_,
         TAKEAWAYS = NA_integer_,
         GIVEAWAYS = NA_integer_,
         SHORT_HANDED_GOALS = NA_integer_,
         SHORT_HANDED_ASSISTS = NA_integer_,
         BLOCKED = NA_integer_,
         PLUS_MINUS = NA_integer_,
         EVEN_TIME_ON_ICE = NA_character_,
         POWER_PLAY_TIME_ON_ICE = NA_character_,
         SHORT_HANDED_TIME_ON_ICE = NA_character_,
         FACE_OFF_PCT = NA_real_)

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
                     names_sep = "_") %>% #SUFFIXING COLUMN NAMES WITH UNNESTED LIST COLUMN SEP BY _
        hoist(person,
              player_id = list("id"),
              player_name = list("fullName"),
              primary_position_code = list("primaryPosition", "code")) %>%
        filter(primary_position_code != "G",      #REMOVING GOALIES. THIS FUNCTION IS FOR PLAYER
               !is.na(skaterStats_timeOnIce)) %>% #DON'T WANT TO INCLUDE PLAYER WHO DIDN'T PLAY
        select(player_id,
               player_name,
               primary_position_code,
               starts_with("skaterStats_")) %>% #COLUMNS WITHIN skaterStats LIST COLUMN VARY FROM API CALL. THIS ENSURE ALL skaterStat COLUMNS ARE RETURNED
        rename_with(.,
                    str_replace_all,
                    pattern = "(?<=[a-z0-9])(?=[A-Z])", #ALL CAMEL CASE WILL BE SEPERATED WITH _
                    replacement = "_") %>%
        rename_with(.,
                    str_to_upper) %>% #ALL COLUMNS TO UPPER CASE
        rename_with(.,
                    str_remove,
                    pattern = "SKATER_STATS_") %>% #REMOVING THIS PATTERN TO MAKE COLUMN NAMES MORE SIMPLY.
        add_column(!!!col[!names(col) %in% names(.)]) %>% #ADDING MISSING COLUMNS FROM THE 
        select(PLAYER_ID,  #EXPLICITY CHOOSING ORDER OF COLUMNS TO ENSURE WHEN RUNNING THROUGH LOOP THAT 
               PLAYER_NAME,#COLUMNS ARE IN PROPER ORDER
               PRIMARY_POSITION_CODE,
               TIME_ON_ICE,
               ASSISTS,
               GOALS,
               SHOTS,
               HITS,
               POWER_PLAY_GOALS,
               POWER_PLAY_ASSISTS,
               PENALTY_MINUTES,
               FACE_OFF_WINS,
               FACEOFF_TAKEN,
               TAKEAWAYS,
               GIVEAWAYS,
               SHORT_HANDED_GOALS,
               SHORT_HANDED_ASSISTS,
               BLOCKED,
               PLUS_MINUS,
               EVEN_TIME_ON_ICE,
               POWER_PLAY_TIME_ON_ICE,
               SHORT_HANDED_TIME_ON_ICE,
               FACE_OFF_PCT)
    
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
