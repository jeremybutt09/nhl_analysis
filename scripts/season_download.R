#LOAD LIBRARY
library(tidyverse)
library(lubridate)
library("nhlapi")

#OUTPUT FILE
output_file <- "C:/Users/Jeremy/Documents/nhl_analysis/data/schedule_data.csv"

#CREATING VARIABLE FOR CURRENT YEAR
current_year <- year(today())

#EARLIEST YEAR OF INTEREST FOR SCHEDULE DATA
first_year = 2015

#EXTRACTING DATA TO SHOW ALL NHL GAMES WITH METADATA FOR DEFINED YEAR RANGE
schedule_data <- nhl_schedule(seasons = first_year:current_year)[[1]][["dates"]] %>%
    unnest(games) %>%
    select(-c(events, matches)) %>%
    rename_with(.,
                str_replace_all, 
                pattern = "\\.",
                replacement = "_") %>%
    rename_with(.,
                str_replace_all,
                pattern = "(?<=[a-z0-9])(?=[A-Z])",
                replacement = "_") %>%
    rename_with(.,
                str_to_upper)

glimpse(schedule_data)

#WRITE DATA TO A CSV
write_csv(x = schedule_data,
          file = output_file,
          na = "")
