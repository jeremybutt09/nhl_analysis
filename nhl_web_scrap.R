library(rvest)
library(tidyverse)
library(lubridate)

output_player_file_name <- "player_game_stats.csv"
output_goalie_file_name <- "goalie_game_stats.csv"

start_date <- as.Date('2017-10-04')
end_date <- as.Date('2021-10-14')
date_seq <- seq(from = start_date,
                to = end_date,
                by = "day")

daily_stats <- vector(mode = "list",
                      length = length(date_seq))


for (i in 1:length(date_seq)) {
    url_template <- paste0("https://www.hockey-reference.com/friv/dailyleaders.fcgi?year=",
                           year(date_seq[i]),
                           "&month=",
                           month(date_seq[i]),
                           "&day=",
                           day(date_seq[i]))
    
    daily_stats[[i]] <- read_html(url_template) %>%
        html_table(header = FALSE)
    
    if(length(daily_stats[[i]]) == 0) {
        NA
    } else {
        daily_stats[[i]][[1]] <- daily_stats[[i]][[1]] %>%
            mutate(DATE = date_seq[i], .before = X1)
        
        daily_stats[[i]][[2]] <- daily_stats[[i]][[2]] %>%
            mutate(DATE = date_seq[i], .before = X1)
    }
}

player_col_names <- c("DATE",
                      "RANK",
                      "PLAYER",
                      "POSITION",
                      "TEAM",
                      "HOME_STATUS",
                      "OPPONENT",
                      "WIN_STATUS",
                      "BOXSCORE",
                      "GOAL",
                      "ASSIST",
                      "PTS",
                      "PLUS_MINUS",
                      "PIM",
                      "EVG",
                      "PPG",
                      "SHG",
                      "GWG",
                      "EVA",
                      "PPA",
                      "SHA",
                      "SHOTS",
                      "SHOOTING_PERCENTAGE",
                      "SHFT",
                      "TOI",
                      "HIT",
                      "BLK",
                      "FOW",
                      "FOL",
                      "FACEOFF_PERCENTAGE")


player_daily_stats <- map(daily_stats, 1) %>%
    map(~.x %>%
            na.omit() %>%
            .[-c(1:2),]) %>%
    bind_rows() %>%
    rename_with(function(x) player_col_names) %>%
    select(c(-RANK)) %>%
    mutate(HOME_STATUS = ifelse(HOME_STATUS == "@",
                                "AWAY",
                                "HOME")) %>%
    mutate_all(str_to_upper)


goalie_col_names <- c("DATE",
                      "RANK",
                      "PLAYER",
                      "POSITION",
                      "TEAM",
                      "HOME_STATUS",
                      "OPPONENT",
                      "WIN_STATUS",
                      "BOXSCORE",
                      "DECISION",
                      "GA",
                      "SA",
                      "SV",
                      "SV_PERCENTAGE",
                      "SO",
                      "GOAL",
                      "ASSIST",
                      "PIM",
                      "TOI")    

goalie_daily_stats <- map(daily_stats, 2) %>%
    map(~.x %>%
            na.omit() %>%
            .[-c(1:2),]) %>%
    bind_rows() %>%
    rename_with(function(x) goalie_col_names) %>%
    select(c(-RANK)) %>%
    mutate(HOME_STATUS = ifelse(HOME_STATUS == "@",
                                "AWAY",
                                "HOME")) %>%
    mutate_all(str_to_upper)

write_csv(x = player_daily_stats,
          file = output_player_file_name,
          na = "",
          append = FALSE)

write_csv(x = goalie_daily_stats,
          file = output_goalie_file_name,
          na = "",
          append = FALSE)

