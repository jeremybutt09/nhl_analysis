#LOAD LIBRARY
library(tidyverse)
library(lubridate)
library("nhlapi")

#OUTPUT FILE
output_file <- "data/playoff_data.csv"


fact_schedule <- nhl_schedule_date_range(
    startDate = "2016-01-01", endDate = "2022-10-01",
    gameTypes = "P",
    expand = "schedule.boxscore") %>%
    extract2(1)%>%
    extract2("dates") %>%
    unnest(games) %>%
    select(-c(events, matches)) %>%
    mutate_if(is.character, stringi::stri_trans_general, "Latin-ASCII") %>%
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

#WRITE DATA TO A CSV
write_csv(x = fact_schedule,
          file = output_file,
          na = "")