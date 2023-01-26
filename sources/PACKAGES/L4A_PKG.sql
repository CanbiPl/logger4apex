--------------------------------------------------------
--  DDL for Package L4A_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "L4A_PKG" AS 
/*
    P_L4A_LOG has paremeters:
        P_BODY_IN -> messages for logged information,
        P_LOG_TYPE_IN -> I/E, Info/Error - type of message. Default I,  
        P_SAVE_PAGE_ITEMS_IN -> T/F, True/False - need to log all current-website variables to a table. Default F,
        P_SAVE_COLLECTIONS_IN -> T/F, True/False - need to log all current apex collections to the table L4A_COLLECTION. Default F,
        P_PLSQL_UNIT_IN -> $$PLSQL_UNIT . Name of the object used by logger4apex. Default null,
        P_PLSQL_LINE_IN -> $$PLSQL_LINE . Line number of code of the object used by logger4apex. Default null,
        P_PARAMS_IN IN -> v_params .  v_param need to be declared in DECLARE section of procedure/function in a way like this: v_params L4A_PKG.tab_param;
                         In the body of procedure/function can be used to store value of parameters by: P_L4A_LOG_PARAM(v_params,'V_MY_VARIABLE',V_MY_VARIABLE);.
                        Default L4A_PKG.gc_empty_tab_param;

		P_LOG -> procedure used to log messages to the L4A_LOG table.

		Examples of usage:
		P_L4A_LOG(P_BODY_IN =>'My additional comment', P_LOG_TYPE_IN=>'I', P_SAVE_PAGE_ITEMS_IN=> 'T');
		P_L4A_LOG(P_BODY_IN =>'My additional comment to an error', P_LOG_TYPE_IN=>'E', P_SAVE_PAGE_ITEMS_IN=> 'F', P_SAVE_COLLECTIONS_IN=> 'T');

		P_L4A_LOG_PARAM(v_params,'my1VariableName','my1VariableValue');	--and lines below (Remember about: v_params L4A_PKG.tab_param; in declare section !)	
		P_L4A_LOG_PARAM(v_params,'my2VariableName','my2VariableValue');	--and line below		
		P_L4A_LOG(P_BODY_IN =>'My additional comment to an error with 2 params', P_LOG_TYPE_IN=>'E', P_SAVE_PAGE_ITEMS_IN=> 'T',P_PLSQL_UNIT_IN=>'Manual PL/SQL BLOCK',P_PARAMS_IN=>v_params);
*/

TYPE rec_param IS RECORD(item_name varchar2(255),item_value varchar2(4000));

TYPE tab_param is table of rec_param index by binary_integer;

TYPE rec_items_status IS RECORD(item_name VARCHAR2(200),item_value VARCHAR2(500),item_value_clob CLOB,session_state_status VARCHAR2(200),page_id VARCHAR2(50));

gc_empty_tab_param tab_param;

PROCEDURE P_L4A_LOG(
                P_BODY_IN IN CLOB,
                P_LOG_TYPE_IN VARCHAR2 DEFAULT 'I',  
                P_SAVE_PAGE_ITEMS_IN VARCHAR2 DEFAULT 'F',
                P_SAVE_COLLECTIONS_IN VARCHAR2 DEFAULT 'F',
                P_PLSQL_UNIT_IN VARCHAR2 DEFAULT null,
                P_PLSQL_LINE_IN VARCHAR2 DEFAULT null,
                P_PARAMS_IN IN tab_param DEFAULT L4A_PKG.gc_empty_tab_param);

PROCEDURE P_L4A_LOG_PARAM(P_LOG_PARAM_IN IN OUT NOCOPY L4A_PKG.tab_param,P_NAME_IN IN VARCHAR2,P_VALUE_IN IN VARCHAR2);

PROCEDURE P_L4A_GET_PAGE_ITEMS(P_LOG_ID_IN NUMBER);

PROCEDURE P_L4A_GET_COLLECTIONS(P_LOG_ID_IN NUMBER);
END;

/
