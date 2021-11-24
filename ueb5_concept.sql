-- ***************************************************************
-- * File Name:                  ueb5_concept.sql                *
-- * File Creator:               Knolle                          *
-- * CreationDate:               8. November 2021                *
-- *                                                             *
-- * <ChangeLogDate>             <ChangeLogText>                 *
-- ***************************************************************

-- ***************************************************************
-- * SQL*plus Job Control Section

set echo on
set linesize 80
set pagesize 50
spool ./ueb5_concept.log

-- Systemdatum Start (bitte nicht aendern)
--
  SELECT user,
         TO_CHAR(SYSDATE, 'dd-mm-yy hh24:mi:ss') 
  FROM   dual
  ;  
--

-- ***************************************************************
-- * Clear Database Section

DROP TABLE PERSON;


-- ***************************************************************
-- * Table Section

CREATE TABLE PERSON(
       Name VARCHAR2(50),
       
);


-- ***************************************************************
-- * NOT NULL Constraint Section

ALTER TABLE ...

-- ***************************************************************
-- * Primary Key Constraint Section

ALTER TABLE ...


-- ***************************************************************
-- * Unique Key Constraint Section

ALTER TABLE ...


-- ***************************************************************
-- * Foreign Key Constraint Section

ALTER TABLE ...


-- ***************************************************************
-- * SQL*plus Job Control Section

-- Systemdatum Ende (bitte nicht aendern)
--
  SELECT user,
         TO_CHAR(SYSDATE, 'dd-mm-yy hh24:mi:ss') 
  FROM   dual
  ;  

  spool off