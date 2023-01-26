--------------------------------------------------------
--  DDL for Procedure P_L4A_LOG
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "P_L4A_LOG" (
               P_BODY_IN IN CLOB,
                P_LOG_TYPE_IN VARCHAR2 DEFAULT 'I',  
                P_SAVE_PAGE_ITEMS_IN VARCHAR2 DEFAULT 'F',
                P_SAVE_COLLECTIONS_IN VARCHAR2 DEFAULT 'F',
                P_PLSQL_UNIT_IN VARCHAR2 DEFAULT null,
                P_PLSQL_LINE_IN VARCHAR2 DEFAULT null,
                P_PARAMS_IN IN L4A_PKG.tab_param default L4A_PKG.gc_empty_tab_param) AS


BEGIN
    L4A_PKG.P_L4A_LOG(P_BODY_IN, P_LOG_TYPE_IN, P_SAVE_PAGE_ITEMS_IN, P_SAVE_COLLECTIONS_IN, P_PLSQL_UNIT_IN, P_PLSQL_LINE_IN, P_PARAMS_IN);

END;

/
