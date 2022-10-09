create or replace FUNCTION fn_player_fantasy_points
(
    p_player_id  VARCHAR2,
    p_game_id    VARCHAR2
)
RETURN NUMBER
AS
    v_fan_pts           NUMBER;
    v_goal_fan_pts      NUMBER := 3.5;
    v_assist_fan_pts    NUMBER := 2.5;
    v_pen_mins_fan_pts  NUMBER := 0.5;
    v_ppp_fan_pts       NUMBER := 1;
    v_shp_fan_pts       NUMBER := 3;
    v_shot_fan_pts      NUMBER := 0.4;
    v_hit_fan_pts       NUMBER := 0.4;
    v_blk_fan_pts       NUMBER := 0.7;
    v_win_fan_pts       NUMBER := 4;
    v_lose_fan_pts      NUMBER := -2;
    v_ga_fan_pts        NUMBER := -2;
    v_save_fan_pts      NUMBER := 0.4;
    v_shut_out_fan_pts  NUMBER := 2;

BEGIN

    SELECT
        NVL(goals, 0)*v_goal_fan_pts +
        NVL(assists, 0)*v_assist_fan_pts +
        NVL(penalty_minutes, 0)*v_pen_mins_fan_pts +
        (NVL(power_play_goals, 0)+NVL(power_play_assists, 0))*v_ppp_fan_pts +
        (NVL(short_handed_goals, 0)+NVL(short_handed_assists, 0))*v_shp_fan_pts +
        NVL(hits, 0)*v_hit_fan_pts +
        NVL(shots, 0)*v_shot_fan_pts +
        NVL(blocked, 0)*v_blk_fan_pts
    INTO
        v_fan_pts
    FROM
        fact_player
    WHERE
        player_id = p_player_id
        AND game_id = p_game_id;

    RETURN v_fan_pts;

END;