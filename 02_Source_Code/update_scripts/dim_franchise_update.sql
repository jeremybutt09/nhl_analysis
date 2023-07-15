DELETE FROM dim_franchise WHERE franchise_id IN (SELECT DISTINCT franchise_id FROM dim_franchise_load);

INSERT INTO dim_franchise (
    franchise_id,
    first_season_id,
    most_recent_team_id,
    team_name,
    location_name,
    franchise_link,
    last_season_id,
    load_date
)
SELECT
    franchise_id,
    first_season_id,
    most_recent_team_id,
    team_name,
    location_name,
    franchise_link,
    last_season_id,
    SYSDATE
FROM
    dim_franchise_load;

DELETE FROM dim_franchise_load;