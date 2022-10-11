#LOAD LIBRARY
library(tidyverse)
library(lubridate)
library(magrittr)
library("nhlapi")

input_files <- list.files("data",
                          pattern = "player_game_data_[[:digit:]]{4}.csv",
                          full.names = TRUE)

col <- c("GAME_ID",
         "PLAYER_ID",
         "PLAYER_NAME",
         "PRIMARY_POSITION_CODE",
         "TEAM_ID",
         "TIME_ON_ICE",
         "ASSISTS",
         "GOALS",
         "SHOTS",
         "HITS",
         "POWER_PLAY_GOALS",
         "POWER_PLAY_ASSISTS",
         "PENALTY_MINUTES",
         "FACE_OFF_WINS",
         "FACEOFF_TAKEN",
         "TAKEAWAYS",
         "GIVEAWAYS",
         "SHORT_HANDED_GOALS",
         "SHORT_HANDED_ASSISTS",
         "BLOCKED",
         'PLUS_MINUS',
         "EVEN_TIME_ON_ICE",
         'POWER_PLAY_TIME_ON_ICE',
         "SHORT_HANDED_TIME_ON_ICE",
         "FACE_OFF_PCT")

data <- map(input_files, read_csv, col_name = col, col_types = cols(.default = col_character()))
data <- bind_rows(data)

glimpse(data)

write_csv(x = data,
          file = "data/fact_player.csv",
          na = "")
