--------------------------------------------------------
--  DDL for Package Body L4A_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "L4A_PKG" AS

PROCEDURE P_L4A_LOG(
                P_BODY_IN IN CLOB,
                P_LOG_TYPE_IN VARCHAR2 DEFAULT 'I',  
                P_SAVE_PAGE_ITEMS_IN VARCHAR2 DEFAULT 'F',
                P_SAVE_COLLECTIONS_IN VARCHAR2 DEFAULT 'F',
                P_PLSQL_UNIT_IN VARCHAR2 DEFAULT null,
                P_PLSQL_LINE_IN VARCHAR2 DEFAULT null,
                P_PARAMS_IN IN tab_param DEFAULT L4A_PKG.gc_empty_tab_param
                ) AS
    PRAGMA AUTONOMOUS_TRANSACTION;

    V_SQLERRM           VARCHAR2(4000)          := SQLERRM;
    V_ERROR_STACK       VARCHAR2(2000 CHAR)     := SYS.DBMS_UTILITY.FORMAT_ERROR_STACK;
    V_ERROR_BACKTRACE   VARCHAR2(2000 CHAR)     := SYS.DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
    V_CALL_STACK        VARCHAR2(2000 CHAR)     := SYS.DBMS_UTILITY.FORMAT_CALL_STACK;
    V_ID_L4A_LOG         NUMBER;
    V_PARAMS            CLOB DEFAULT '';
    I                   INT;
BEGIN
    if P_PARAMS_IN.count > 0 then
            I := P_PARAMS_IN.first;
            while true loop
                V_PARAMS := V_PARAMS || CHR(10)|| P_PARAMS_IN(I).item_name || ': ' || P_PARAMS_IN(I).item_value ;
                I := P_PARAMS_IN.next(I);
                if I is null then
                    exit;
                else
                    V_PARAMS := V_PARAMS || '   ';
                end if;
            end loop;
        else
            V_PARAMS := null;
        end if;

    INSERT INTO L4A_LOG(
                            LOG, 
                            SQLERRM, 
                            AUDIT_USER_INS, 
                            APP_PAGE_ID, 
                            APP_ID, 
                            ERROR_STACK, 
                            ERROR_BACKTRACE, 
                            CALL_STACK, 
                            SESSION_ID,
                            "TYPE",
                            PLSQL_UNIT,
                            PLSQL_LINE,
                            PARAMS
							)
                    VALUES(
                            P_BODY_IN,
                            V_SQLERRM,
                            nvl(v('APP_USER'),USER),
                            V('APP_PAGE_ID'), 
                            V('APP_ID'),
                            V_ERROR_STACK,
                            V_ERROR_BACKTRACE,
                            V_CALL_STACK, 
                            V('APP_SESSION'),
                            P_LOG_TYPE_IN,
                            P_PLSQL_UNIT_IN,
                            P_PLSQL_LINE_IN,
                            V_PARAMS
							) 
                    RETURNING ID_L4A_LOG INTO V_ID_L4A_LOG;
    COMMIT;

    IF P_SAVE_PAGE_ITEMS_IN = 'T' AND V('APP_ID') is not null THEN
        L4A_PKG.P_L4A_GET_PAGE_ITEMS(
                        P_LOG_ID_IN => V_ID_L4A_LOG
                        );
    END IF;

    IF P_SAVE_COLLECTIONS_IN = 'T' AND V('APP_ID') is not null THEN
        L4A_PKG.P_L4A_GET_COLLECTIONS(
                        P_LOG_ID_IN => V_ID_L4A_LOG
                        );
    END IF;

END;

PROCEDURE P_L4A_LOG_PARAM(P_LOG_PARAM_IN IN OUT NOCOPY L4A_PKG.tab_param,P_NAME_IN IN VARCHAR2,P_VALUE_IN IN VARCHAR2) AS
    PRAGMA AUTONOMOUS_TRANSACTION;

    l_param L4A_PKG.rec_param;
BEGIN
    l_param.item_name := P_NAME_IN;
    l_param.item_value := P_VALUE_IN;
    P_LOG_PARAM_IN(P_LOG_PARAM_IN.count + 1) := l_param;
    commit;

END;


PROCEDURE P_L4A_GET_PAGE_ITEMS(
                            P_LOG_ID_IN NUMBER
                            )
AS
PRAGMA AUTONOMOUS_TRANSACTION;

v_apex_version_no       VARCHAR2(50 CHAR);
v_sql                   VARCHAR2(1000);
CUR1                    SYS_REFCURSOR;
v_item_status           CLOB := '';
tab_items               rec_items_status;

BEGIN

SELECT 'apex_' || substr(replace(version_no,'.','0'),0,6) || '.wwv_flow_DATE' INTO v_apex_version_no FROM apex_release;

begin
    v_sql := 'select
        d.item_name item_name
        ,d.item_value_vc2 item_value
        ,d.item_value_clob item_value_clob
        --,      d.item_filter item_filter
        ,      d.session_state_status session_state_status,
        pi.page_id page_id
        from ' || v_apex_version_no || ' d
        left join apex_application_page_db_items i using (item_id)
        left join apex_application_page_items pi using (item_id)
        where 
        d.flow_instance = ' || V('APP_SESSION') ||'
        and d.flow_id = ' || V('APP_ID') ||'
        and (pi.page_id = nvl('|| V('APP_PAGE_ID') ||' , pi.page_id) OR pi.page_id is null)
        and d.item_name is not null
        order by pi.page_id nulls first, d.item_name';

        OPEN CUR1 FOR v_sql;

        LOOP
            FETCH CUR1 INTO tab_items;
            EXIT WHEN CUR1%NOTFOUND;
                v_item_status := v_item_status || tab_items.item_name || ' :: ' || nvl(tab_items.item_value, tab_items.item_value_clob) || ' :: ' || tab_items.session_state_status ||chr(13) || chr(10);
        END LOOP;

        CLOSE CUR1;
        UPDATE L4A_LOG SET ITEMS_STATUS = v_item_status WHERE ID_L4A_LOG = P_LOG_ID_IN;
end;
commit;

END;

PROCEDURE P_L4A_GET_COLLECTIONS(
                            P_LOG_ID_IN NUMBER
                            )
AS
PRAGMA AUTONOMOUS_TRANSACTION;

BEGIN

    INSERT INTO L4A_LOG_COLLECTION(ID_L4A_LOG,
    SESSION_ID,
    APP_ID,
    PAGE_ID,
    XMLTYPE001,
    COLLECTION_NAME,
    SEQ_ID,
    C001, C002, C003, C004, C005, C006, C007, C008, C009, C010, C011, C012, C013, C014, C015, C016, C017, C018, C019, C020, C021, C022, C023, C024, C025, 
    C026, C027, C028, C029, C030, C031, C032, C033, C034, C035, C036, C037, C038, C039, C040, C041, C042, C043, C044, C045, C046, C047, C048, C049, C050,
    CLOB001, 
    BLOB001,
    N001, N002, N003, N004, N005,
    D001, D002, D003, D004, D005)

    (SELECT 
    P_LOG_ID_IN,
    V('APP_SESSION'),
    V('APP_ID'),
    V('APP_PAGE_ID'),
    XMLTYPE001,
    COLLECTION_NAME,
    SEQ_ID,
    C001, C002, C003, C004, C005, C006, C007, C008, C009, C010, C011, C012, C013, C014, C015, C016, C017, C018, C019, C020, C021, C022, C023, C024, C025, 
    C026, C027, C028, C029, C030, C031, C032, C033, C034, C035, C036, C037, C038, C039, C040, C041, C042, C043, C044, C045, C046, C047, C048, C049, C050,
    CLOB001, 
    BLOB001,
    N001, N002, N003, N004, N005,
    D001, D002, D003, D004, D005
    FROM APEX_COLLECTIONS);
commit;

END;

END;

/
