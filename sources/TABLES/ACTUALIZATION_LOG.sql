--------------------------------------------------------
--  DDL for Table ACTUALIZATION_LOG
--------------------------------------------------------

  CREATE TABLE "ACTUALIZATION_LOG" 
   (	"INSERT_DATE" DATE DEFAULT SYSDATE, 
	"DB_VERSION" VARCHAR2(20 BYTE), 
	"SCRIPT" VARCHAR2(200 BYTE), 
	"STATUS" NUMBER DEFAULT 0
   ) ;
