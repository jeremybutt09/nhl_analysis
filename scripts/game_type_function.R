game_year <- function(gameIds) {
    str_sub(gameIds, 1, 4)
}

game_type <- function(gameIds) {
    if (str_sub(gameIds, 5, 6) == 01) {
        print("Pre-Season")
    } else if (str_sub(gameIds, 5, 6) == 02) {
        print("Regular Season")
    } else if (str_sub(gameIds, 5, 6) == 03) {
        print("Playoffs")
    } else if (str_sub(gameIds, 5, 6) == 04) {
        print("All-Star")
    }
}


game_type("200201")
