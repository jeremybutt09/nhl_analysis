#LOAD LIBRARY
library(tidyverse)
library(lubridate)
library("nhlapi")

#OUTPUT FILE
output_file <- "01_Input/nhl_api/fact_schedule/fact_schedule_"

#CREATING A DATE SEQUENCE TO LOOP OVER
year_seq <- seq(from = 2015,
                to = 2022,
                by = 1)

#INITIALIZING AN EMPTY LIST
schedule_list <- vector(mode = "list", length = length(year_seq))

#EXTRACTING DATA TO SHOW ALL NHL GAMES WITH METADATA FOR DEFINED YEAR RANGE
for (i in 1:length(year_seq)) {
    schedule_list[[i]] <- nhl_schedule(seasons = year_seq[i])[[1]][["dates"]] %>%
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
                    str_to_upper) %>%
        write_csv(x = .,
                  file = paste0(output_file, year_seq[i], ".csv"),
                  na = "",
                  append = FALSE)
    }
