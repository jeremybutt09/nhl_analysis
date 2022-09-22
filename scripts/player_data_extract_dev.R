test1 <- nhl_games_boxscore(game_id[2892]) %>%
    .[[1]] %>%
    extract2("teams") %>%
    extract2("home") %>%
    extract2("players") %>%
    tibble(player_id = .) %>%
    unnest_wider(player_id) %>%
    unnest_wider(stats) %>%
    unnest_wider(skaterStats,
                 names_sep = "_") %>% #CHANGED
    hoist(person,
          player_id = list("id"),
          player_name = list("fullName"),
          primary_position_code = list("primaryPosition", "code")) %>%
    filter(primary_position_code != "G",
           !is.na(skaterStats_timeOnIce)) %>% #CHANGED
    select(player_id,
           player_name,
           primary_position_code,
           starts_with("skaterStats_")) %>%
    rename_with(.,
                str_replace_all,
                pattern = "(?<=[a-z0-9])(?=[A-Z])",
                replacement = "_") %>%
    rename_with(.,
                str_to_upper) %>%
    rename_with(.,
                str_remove,
                pattern = "SKATER_STATS_")

length(player_data)

x <- "faceOffPct" %in% colnames(test1)
x
