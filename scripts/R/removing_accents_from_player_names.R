#LOAD LIBRARY
library(tidyverse)
library(lubridate)

files <- "data/metadata_players.csv"

files

data <- read_csv(file = files)
    mutate_if(is.character, stringi::stri_trans_general, "Latin-ASCII")

write_csv(data,
          file = files)



