#LOAD LIBRARY
library(tidyverse)
library(lubridate)
library("nhlapi")

#PREVIOUS_FILES
last_file_year <- list.files("01_Input/nhl_api/fact_schedule") %>%
    str_extract(pattern = "[[:digit:]]{4}") %>%
    max() %>%
    as.numeric()

current_year <- year(today())

#OUTPUT FILE
output_file <- "01_Input/load_files/fact_schedule_"

#CREATING A DATE SEQUENCE TO LOOP OVER
year_seq <- seq(from = last_file_year,
                to = if_else(last_file_year == current_year, last_file_year, last_file_year + 1),
                by = 1)

#INITIALIZING AN EMPTY VARIABLE FOR LOOP
schedule_check <- vector(length = length(year_seq))

schedule_list <- vector(mode = "list", length = length(year_seq))

#CHECKING WHICH YEARS ACTUALLY HAVE DATA. WILL RETURN ONLY YEARS THAT HAVE SCHEDULE DATA
for (i in 1:length(year_seq)) {
    schedule_check[[i]] <- length(nhl_schedule(seasons = year_seq[i])[[1]][["dates"]]) > 0
    valid_years <- year_seq[schedule_check]
}

#EXTRACTING DATA TO SHOW ALL NHL GAMES WITH METADATA FOR DEFINED YEAR RANGE
for (i in 1:length(valid_years)) {
    schedule_list[[i]] <- nhl_schedule(seasons = valid_years[i])[[1]][["dates"]] %>%
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
                  file = paste0(output_file, valid_years[i], ".csv"),
                  na = "",
                  append = FALSE)
}
