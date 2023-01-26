--------------------------------------------------------
--  DDL for Procedure P_L4A_LOG_PARAM
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "P_L4A_LOG_PARAM" 
(P_PARAM_IN in out nocopy L4A_PKG.tab_param, P_NAZWA_IN in varchar2, P_WARTOSC_IN in varchar2) AS 
BEGIN 
    L4A_PKG.P_L4A_LOG_PARAM(P_PARAM_IN,P_NAZWA_IN,P_WARTOSC_IN); 
END ;

/
