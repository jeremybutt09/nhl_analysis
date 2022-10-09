create or replace FUNCTION fn_ice_time_to_num 
(
    p_time VARCHAR2
)
RETURN NUMBER
AS
    v_time_num NUMBER;
BEGIN
    v_time_num := ROUND(TO_NUMBER(REGEXP_SUBSTR(p_time, '[[:digit:]]+')) + (TO_NUMBER(REGEXP_SUBSTR(p_time, '[[:digit:]]+', 1, 2))/60), 2);

    RETURN v_time_num;
END;