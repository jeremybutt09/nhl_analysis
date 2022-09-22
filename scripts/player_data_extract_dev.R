test1 <- nhl_games_boxscore(2019020001) %>%
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
                pattern = "SKATER_STATS_") %>%
    select(PLAYER_ID,         #CHANGED
           PLAYER_NAME,
           PRIMARY_POSITION_CODE,
           TIME_ON_ICE,
           ASSISTS,
           GOALS,
           SHOTS,
           HITS,
           POWER_PLAY_GOALS,
           POWER_PLAY_ASSISTS,
           PENALTY_MINUTES,
           FACE_OFF_WINS,
           FACEOFF_TAKEN,
           TAKEAWAYS,
           GIVEAWAYS,
           SHORT_HANDED_GOALS,
           SHORT_HANDED_ASSISTS,
           BLOCKED,
           PLUS_MINUS,
           EVEN_TIME_ON_ICE,
           POWER_PLAY_TIME_ON_ICE,
           SHORT_HANDED_TIME_ON_ICE) %>%
    add_column(!!!col[!names(df) %in% names(.)]) %>%
    select(PLAYER_ID,         #CHANGED
           PLAYER_NAME,
           PRIMARY_POSITION_CODE,
           TIME_ON_ICE,
           ASSISTS,
           GOALS,
           SHOTS,
           HITS,
           POWER_PLAY_GOALS,
           POWER_PLAY_ASSISTS,
           PENALTY_MINUTES,
           FACE_OFF_WINS,
           FACEOFF_TAKEN,
           TAKEAWAYS,
           GIVEAWAYS,
           SHORT_HANDED_GOALS,
           SHORT_HANDED_ASSISTS,
           BLOCKED,
           PLUS_MINUS,
           EVEN_TIME_ON_ICE,
           POWER_PLAY_TIME_ON_ICE,
           SHORT_HANDED_TIME_ON_ICE,
           FACE_OFF_PCT)


glimpse(test1)

col <- c(PLAYER_ID = NA_integer_,
         PLAYER_NAME = NA_character_,
         PRIMARY_POSITION_CODE = NA_character_,
         TIME_ON_ICE = NA_character_,
         ASSISTS = NA_integer_,
         GOALS = NA_integer_,
         SHOTS = NA_integer_,
         HITS = NA_integer_,
         POWER_PLAY_GOALS = NA_integer_,
         POWER_PLAY_ASSISTS = NA_integer_,
         PENALTY_MINUTES = NA_integer_,
         FACE_OFF_WINS = NA_integer_,
         FACEOFF_TAKEN = NA_integer_,
         TAKEAWAYS = NA_integer_,
         GIVEAWAYS = NA_integer_,
         SHORT_HANDED_GOALS = NA_integer_,
         SHORT_HANDED_ASSISTS = NA_integer_,
         BLOCKED = NA_integer_,
         PLUS_MINUS = NA_integer_,
         EVEN_TIME_ON_ICE = NA_character_,
         POWER_PLAY_TIME_ON_ICE = NA_character_,
         SHORT_HANDED_TIME_ON_ICE = NA_character_,
         FACE_OFF_PCT = NA_real_)

df <- data.frame(PLAYER_ID = integer(),
                 PLAYER_NAME = character(),
                 PRIMARY_POSITION_CODE = character(),
                 TIME_ON_ICE = character(),
                 ASSISTS = integer(),
                 GOALS = integer(),
                 SHOTS = integer(),
                 HITS = integer(),
                 POWER_PLAY_GOALS = integer(),
                 POWER_PLAY_ASSISTS = integer(),
                 PENALTY_MINUTES = integer(),
                 FACE_OFF_WINS = integer(),
                 FACEOFF_TAKEN = integer(),
                 TAKEAWAYS = integer(),
                 GIVEAWAYS = integer(),
                 SHORT_HANDED_GOALS = integer(),
                 SHORT_HANDED_ASSISTS = integer(),
                 BLOCKED = integer(),
                 PLUS_MINUS = integer(),
                 EVEN_TIME_ON_ICE = character(),
                 POWER_PLAY_TIME_ON_ICE = character(),
                 SHORT_HANDED_TIME_ON_ICE = character(),
                 FACE_OFF_PCT = double(),
                 stringsAsFactors=FALSE)

df[names(test1) == names(df)]

