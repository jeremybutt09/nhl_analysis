create or replace FUNCTION fn_goalie_fantasy_points
(
    p_player_id  VARCHAR2,
    p_game_id    VARCHAR2
)
RETURN NUMBER
AS
    v_position          VARCHAR2(26);
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
        (CASE WHEN decision = 'W' THEN 1 ELSE 0 END)*v_win_fan_pts +
        (CASE WHEN decision = 'L' THEN 1 ELSE 0 END)*v_lose_fan_pts +
        (CASE WHEN (NVL(shots, 0) - NVL(saves, 0)) >= 0 THEN (NVL(shots, 0) - NVL(saves, 0)) ELSE  0 END)*v_ga_fan_pts +
        NVL(saves, 0)*v_save_fan_pts +
        (CASE WHEN shots = saves AND (shots IS NOT NULL OR shots != 0) AND (saves IS NOT NULL OR saves != 0) THEN 1 ELSE 0 END)*v_shut_out_fan_pts
    INTO
        v_fan_pts
    FROM
        fact_goalie
    WHERE
        player_id = p_player_id
        AND game_id = p_game_id;

    RETURN v_fan_pts;

END;