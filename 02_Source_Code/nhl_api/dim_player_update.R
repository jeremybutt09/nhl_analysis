#LOAD LIBRARY
library(tidyverse)
library(lubridate)
library("nhlapi")

today <- today() %>%
    as.character() %>%
    str_replace_all(pattern = "-",
                    replacement = "_")

#OUTPUT FILE
dim_player_output <- paste0("01_Input/nhl_api/dim_player/dim_player_", today, ".csv")

#IDENTIFYING LAST FACT_PLAYER_FILE AND THEN EXTRACT ALL UNIQUE PLAYERS OUR OF THE PLAYER ID
fact_player_folder <- "01_Input/nhl_api/fact_player"

fact_player_file_list <- list.files(fact_player_folder,
                                    full.names = TRUE)

last_fact_player_year <- fact_player_file_list %>%
    str_extract(pattern = "fact_player_[[:digit:]]{4}") %>%
    str_extract(pattern = "[[:digit:]]{4}") %>%
    max()

last_fact_player_year_index <- fact_player_file_list %>%
    str_detect(pattern = last_fact_player_year)

fact_player_file <- fact_player_file_list[last_fact_player_year_index]

unique_player_id <- read_csv(file = fact_player_file) %>%
    pull(PLAYER_ID) %>%
    unique()

#IDENTIFYING LAST FACT_GOALIE_FILE AND THEN EXTRACT ALL UNIQUE PLAYERS OUR OF THE PLAYER ID
fact_goalie_folder <- "01_Input/nhl_api/fact_goalie"

fact_goalie_file_list <- list.files(fact_goalie_folder,
                                    full.names = TRUE)

last_fact_goalie_year <- fact_goalie_file_list %>%
    str_extract(pattern = "fact_goalie_[[:digit:]]{4}") %>%
    str_extract(pattern = "[[:digit:]]{4}") %>%
    max()

last_fact_goalie_year_index <- fact_goalie_file_list %>%
    str_detect(pattern = last_fact_goalie_year)

fact_goalie_file <- fact_goalie_file_list[last_fact_goalie_year_index]

unique_player_id <- read_csv(file = fact_goalie_file,
                             col_types = cols(.default = col_character())) %>%
    pull(PLAYER_ID) %>%
    unique() %>%
    append(unique_player_id) %>%
    unique()


player_metadata <- nhl_players(playerIds = unique_player_id) %>%
    mutate_if(is.character, stringi::stri_trans_general, "Latin-ASCII") %>%
    rename_with(.,
                str_replace_all,
                pattern = "(?<=[a-z0-9])(?=[A-Z])", #ALL CAMEL CASE WILL BE SEPERATED WITH _
                replacement = "_") %>%
    rename_with(.,
                str_replace_all,
                pattern = "\\.", #ALL CAMEL CASE WILL BE SEPERATED WITH _
                replacement = "_") %>%
    rename_with(.,
                str_to_upper)

write_csv(x = player_metadata,
          file = dim_player_output,
          na = "")
