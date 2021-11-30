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

DROP TABLE KUENSTLER;
DROP TABLE BENUTZER;
DROP TABLE GENRE;
DROP TABLE KUENSTLER_HAT_GENRE;
DROP TABLE SONG_HAT_GENRE;
DROP TABLE KUENSTLER_PLAYLIST;
DROP TABLE KUENSTLER_PLAYLIST_HAT_SONGS;
DROP TABLE BENUTZER_PLAYLIST;
DROP TABLE BENUTZER_PLAYLIST_HAT_SONGS;
DROP TABLE SONG;
DROP TABLE BENUTZER_VERTRAG;
DROP TABLE KUENSTLER_VERTRAG;

-- ***************************************************************
-- * Table Section

CREATE TABLE KUENSTLER(
       id number(8),
       Nachname VARCHAR2(50),
       Vorname VARCHAR2(50),
       Strasse VARCHAR2(50),
       Hausnummer VARCHAR2(30),
       PLZ VARCHAR2(10),
       Land VARCHAR2(10),
       Benutzername VARCHAR2(50),
       Passwort VARCHAR2(50),
       EMail VARCHAR2(50)
);

CREATE TABLE BENUTZER(
       id number(8),
       Nachname VARCHAR2(50),
       Vorname VARCHAR2(50),
       Strasse VARCHAR2(50),
       Hausnummer VARCHAR2(30),
       PLZ VARCHAR2(10),
       Land VARCHAR2(10),
       Benutzername VARCHAR2(50),
       Passwort VARCHAR2(50),
       EMail VARCHAR2(50),
);

CREATE TABLE GENRE(
       id number(8),
       Bezeichnung VARCHAR2(50)
);

CREATE TABLE KUENSTLER_HAT_GENRE(
       KUENSTLER_ID number(8),
       GENRE_ID number(8)
);

CREATE TABLE SONG_HAT_GENRE(
       SONG_ID number(8),
       GENRE_ID number(8)
);

CREATE TABLE KUENSTLER_PLAYLIST(
       id number(8),
       Bezeichnung VARCHAR2(50),
       Album boolean
);

CREATE TABLE KUENSTLER_PLAYLIST_HAT_SONGS(
       K_Playlist_ID number(8),
       SONG_ID number(8)
);

CREATE TABLE BENUTZER_PLAYLIST(
       id number(8),
       Bezeichnung VARCHAR2(50)
);

CREATE TABLE BENUTZER_PLAYLIST_HAT_SONGS(
       B_Playlist_ID number(8),
       SONG_ID number(8)
);

CREATE TABLE SONG(
       id number(8),
       Bezeichnung VARCHAR2(50)
);

CREATE TABLE BENUTZER_VERTRAG(
       id number(8),
       Name VARCHAR2(50),
       Bezeichnung VARCHAR2(50),
       Preis number(3,2)
);

CREATE TABLE KUENSTLER_VERTRAG(
       id number(8),
       Name VARCHAR2(50),
       Bezeichnung VARCHAR2(50),
);

CREATE TABLE KUENSTLER_HAT_VERTRAG(
       KUENSTLER_VERTRAG_ID number(8),
       KUENSTLER_ID number(8)
);
-- ***************************************************************
-- * NOT NULL Constraint Section

ALTER TABLE 

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