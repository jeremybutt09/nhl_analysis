#LIBRARY LOAD
library(rvest)
library(tidyverse)
library(lubridate)

#OUTPUT FILE NAMES FOR BOTH PLAYER AND GOALIE STATS
output_player_file_name <- "player_game_stats.csv"
output_goalie_file_name <- "goalie_game_stats.csv"

#RETURNS THE LAST DATE IN THE CURRENT PLAYERS DATA
max_data <- read_csv(output_player_file_name) %>%
    pull(DATE) %>%
    max(.)

#RETURNST HE CURRENT DATE
today <- today()

#THE START AND END DATE OF STATS YOU WANT TO DOWNLOAD
start_date <- as.Date(max_data) + 1
end_date <- as.Date(today)

#CREATING A DATE SEQUENCE TO LOOP OVER
date_seq <- seq(from = start_date,
                to = end_date,
                by = "day")

#INITIALIZING AN EMPTY LIST. FIRST RULE OF R CLUB: DON'T GROW VECTORS, LISTS, ETC
daily_stats <- vector(mode = "list",
                      length = length(date_seq))

#THE RESULT OF THIS LOOP IS A LIST WITH 2 LIST NESTED IN EACH ELEMENT
for (i in 1:length(date_seq)) {
    url_template <- paste0("https://www.hockey-reference.com/friv/dailyleaders.fcgi?year=",
                           year(date_seq[i]),
                           "&month=",
                           month(date_seq[i]),
                           "&day=",
                           day(date_seq[i]))
    
    daily_stats[[i]] <- read_html(url_template) %>%
        html_table(header = FALSE)
    
    if(length(daily_stats[[i]]) == 0) { #SOME DAYS THERE ARE NO GAMES. WITHOUT THIS IF STATEMENT CODE WILL ERROR OUT
        NA
    } else {
        daily_stats[[i]][[1]] <- daily_stats[[i]][[1]] %>% #WANT TO ADD NEW COLUMN WITH DATE TO KNOW WHAT DAY STATS BELONG TO
            mutate(DATE = date_seq[i], .before = X1)
        
        daily_stats[[i]][[2]] <- daily_stats[[i]][[2]] %>% #WANT TO ADD NEW COLUMN WITH DATE TO KNOW WHAT DAY STATS BELONG TO
            mutate(DATE = date_seq[i], .before = X1)
    }
}

#COLUMN NAMES FOR THE PLAYER DATAFRAME
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

#EXTRACTING PLAYER DATA FROM THE ORIGINAL DOWNLOAD
player_daily_stats <- map(daily_stats, 1) %>% #USING MAP FUNCTION TO EXTRACT ONLY FIRST ELEMENT OF EACH ELEMENT OF LIST
    map(~.x %>%
            na.omit() %>%
            .[-c(1:2),]) %>%                  #WANT TO REMOVE FIRST 2 ROWS BECAUSE THEY ACTUALLY AREN'T STATS BUT RATHER HEADERS
    bind_rows() %>%
    rename_with(function(x) player_col_names) %>%
    select(c(-RANK)) %>%                            #MIGHT KEEP THIS IN FUTURE BECAUSE RANK AND DATE CAN BE USED AS A PRIMARY KEY
    mutate(HOME_STATUS = ifelse(HOME_STATUS == "@",
                                "AWAY",
                                "HOME")) %>%
    mutate_all(str_to_upper)

#COLUMN NAMES FOR THE GOALIE DATAFRAME. IT IS DIFFERENT THAN PLAYER DATAFRAME
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

#EXTRACTING GOALIE DATA FROM THE ORIGINAL DOWNLOAD
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

#WRITING PLAYER DATA TO A CSV
write_csv(x = player_daily_stats,
          file = output_player_file_name,
          na = "",
          append = TRUE)

#WRITING PLAYER DATA TO A CSV
write_csv(x = goalie_daily_stats,
          file = output_goalie_file_name,
          na = "",
          append = TRUE)

