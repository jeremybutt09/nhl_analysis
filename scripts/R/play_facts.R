#LOAD LIBRARY
library(tidyverse)
library(lubridate)
library(magrittr)
library("nhlapi")

all_plays <- nhl_games_feed(2017010001) %>%
    extract2(1) %>%
    extract2("liveData") %>%
    extract2("plays") %>%
    extract2("allPlays") %>%
    rename_with(.,
                str_replace_all,
                pattern = "(?<=[a-z0-9])(?=[A-Z])", #ALL CAMEL CASE WILL BE SEPERATED WITH _
                replacement = "_") %>%
    rename_with(.,
                str_replace_all,
                pattern = "\\.",
                replacement = "_") %>%
    rename_with(.,
                str_to_upper) %>%
    filter(RESULT_EVENT %in% c("Assist", 
                               "Faceoff", 
                               "Penalty", 
                               "Blocked Shot", 
                               "Hit", 
                               "Missed Shot", 
                               "Shot", 
                               "Giveaway", 
                               "Takeaway")) %>%
    group_split(RESULT_EVENT) %>%
    map(~unnest(data = .x, cols = c("PLAYERS"))) %>%
    map(~pivot_wider(data = .x,
                     id_cols = starts_with(c("RESULT", "ABOUT", "COORDINATES", "TEAM")),
                     names_from = playerType,
                     values_from = player.id))

goals <- nhl_games_feed(2017010001) %>%
    extract2(1) %>%
    extract2("liveData") %>%
    extract2("plays") %>%
    extract2("allPlays") %>%
    rename_with(.,
                str_replace_all,
                pattern = "(?<=[a-z0-9])(?=[A-Z])", #ALL CAMEL CASE WILL BE SEPERATED WITH _
                replacement = "_") %>%
    rename_with(.,
                str_replace_all,
                pattern = "\\.",
                replacement = "_") %>%
    rename_with(.,
                str_to_upper) %>%
    filter(RESULT_EVENT == "Goal") %>%
    mutate(PLAYERS = map(PLAYERS,
                         ~.x %>% 
                            group_by(playerType) %>%
                            mutate(row_num = row_number(),
                                   playerType = if_else(str_to_upper(playerType) == "ASSIST" & row_num == 2,
                                                        "Secondary Assist",
                                                        playerType)) %>%
                              select(-row_num)),
           ID = row_number()) %>%
    unnest(PLAYERS) %>%
    pivot_wider(data = .,
                id_cols = starts_with(c("RESULT", "ABOUT", "COORDINATES", "TEAM")),
                names_from = playerType,
                values_from = player.id)

    
#Retrieve some game feed data
gameFeeds <- lapply(
    2019010001:2019010010,
    nhlapi::nhl_games_feed
)

# Create a data.frame with plays
getPlaysDf <- function(gm) {
    playsRes <- try(gm[[1L]][["liveData"]][["plays"]][["allPlays"]])
    if (inherits(playsRes, "try-error")) data.frame() else playsRes
}
plays <- lapply(gameFeeds, getPlaysDf)
plays <- nhlapi:::util_rbindlist(plays)
plays <- plays[!is.na(plays$coordinates.x), ]
plays <- plays[is.na(plays$coordinates.x), ]
unique(plays$result.eventTypeId)

# Move the coordinates to non-negative values before plotting
plays$coordx <- plays$coordinates.x + abs(min(plays$coordinates.x))
plays$coordy <- plays$coordinates.y + abs(min(plays$coordinates.y))

# Select goals only
goals <- plays[plays$result.event == "Goal", ]

# Create the plot and add goals
nhlapi::nhl_plot_rink()
points(goals$coordinates.x, goals$coordinates.y)

