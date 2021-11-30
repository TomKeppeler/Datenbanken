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

DROP TABLE TAB_KUENSTLER;
DROP TABLE TAB_BENUTZER;
DROP TABLE TAB_GENRE;
DROP TABLE TAB_KUENSTLER_HAT_GENRE;
DROP TABLE TAB_SONG_HAT_GENRE;
DROP TABLE TAB_KUENSTLER_PLAYLIST;
DROP TABLE TAB_KUENSTLER_PLAYLIST_HAT_SONGS;
DROP TABLE TAB_BENUTZER_PLAYLIST;
DROP TABLE TAB_BENUTZER_PLAYLIST_HAT_SONGS;
DROP TABLE TAB_SONG;
DROP TABLE TAB_BENUTZER_VERTRAG;
DROP TABLE TAB_KUENSTLER_VERTRAG;

-- ***************************************************************
-- * Table Section

CREATE TABLE TAB_KUENSTLER(
       KUENSTLER_ID number(8),
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

CREATE TABLE TAB_BENUTZER(
       BENUTZER_ID number(8),
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

CREATE TABLE TAB_GENRE(
       GENRE_ID number(8),
       Bezeichnung VARCHAR2(50)
);

CREATE TABLE TAB_KUENSTLER_HAT_GENRE(
       KUENSTLER_ID number(8),
       GENRE_ID number(8)
);

CREATE TABLE TAB_SONG_HAT_GENRE(
       SONG_ID number(8),
       GENRE_ID number(8)
);

CREATE TABLE TAB_KUENSTLER_PLAYLIST(
       KUENSTLER_PLAYLIST_ID number(8),
       Bezeichnung VARCHAR2(50),
       Album boolean
);

CREATE TABLE TAB_KUENSTLER_PLAYLIST_HAT_SONGS(
       K_Playlist_ID number(8),
       SONG_ID number(8)
);

CREATE TABLE TAB_BENUTZER_PLAYLIST(
       BENUTZER_PLAYLIST_ID number(8),
       Bezeichnung VARCHAR2(50)
);

CREATE TABLE TAB_BENUTZER_PLAYLIST_HAT_SONGS(
       B_Playlist_ID number(8),
       SONG_ID number(8)
);

CREATE TABLE TAB_SONG(
       SONG_ID number(8),
       Bezeichnung VARCHAR2(50)
);

CREATE TABLE TAB_BENUTZER_VERTRAG(
       BENUTZER_VERTRAG_ID number(8),
       Name VARCHAR2(50),
       Bezeichnung VARCHAR2(50),
       Preis number(3,2)
);

CREATE TABLE TAB_KUENSTLER_VERTRAG(
       KUENSTLER_VERTRAG_ID number(8),
       Name VARCHAR2(50),
       Bezeichnung VARCHAR2(50),
);

CREATE TABLE TAB_KUENSTLER_HAT_VERTRAG(
       KUENSTLER_VERTRAG_ID number(8),
       KUENSTLER_ID number(8)
);
-- ***************************************************************
-- * NOT NULL Constraint Section

ALTER TABLE TAB_KUENSTLER ADD CONSTRAINT
NN_KUETAB_KUENSTLERNSTLER_KUENSTLER_ID CHECK(KUENSTLER_ID NOT NULL);

ALTER TABLE TAB_KUENSTLER ADD CONSTRAINT
NN_KUENSTLER_NACHNAME CHECK(NACHNAME NOT NULL);

ALTER TABLE TAB_KUENSTLER ADD CONSTRAINT
NN_KUENSTLER_VORNAME CHECK(VORNAME NOT NULL);


-- ***************************************************************
-- * Primary Key Constraint Section

ALTER TABLE TAB_KUENSTLER ADD CONSTRAINT
PK_KUENSTLER PRIMARY KEY (KUENSTLER_ID);

ALTER TABLE TAB_BENUTZER ADD CONSTRAINT
PK_BENUTZER PRIMARY KEY (BENUTZER_ID);

ALTER TABLE TAB_GENRE ADD CONSTRAINT
PK_GENRE PRIMARY KEY (GENRE_ID);

ALTER TABLE TAB_KUENSTLER ADD CONSTRAINT
PK_KUENSTLER PRIMARY KEY (KUENSTLER_ID);

ALTER TABLE TAB_KUENSTLER ADD CONSTRAINT
PK_KUENSTLER PRIMARY KEY (KUENSTLER_ID);

ALTER TABLE TAB_KUENSTLER ADD CONSTRAINT
PK_KUENSTLER PRIMARY KEY (KUENSTLER_ID);

ALTER TABLE TAB_KUENSTLER ADD CONSTRAINT
PK_KUENSTLER PRIMARY KEY (KUENSTLER_ID);

-- ***************************************************************
-- * Unique Key Constraint Section

ALTER TABLE ...


-- ***************************************************************
-- * Foreign Key Constraint Section

ALTER TABLE TAB_KUENSTLER_HAT_GENRE ADD CONSTRAINT
FK_KUENSTLER_HAT_GENRE_KUENSTLER FOREIGN KEY (KUENSTLER_ID) REFERENCES TAB_KUENSTLER (KUENSTLER_ID);

ALTER TABLE TAB_KUENSTLER_HAT_GENRE ADD CONSTRAINT
FK_KUENSTLER_HAT_GENRE_GENRE FOREIGN KEY (GENRE_ID)  REFERENCES TAB_GENRE (GENRE_ID);


-- ***************************************************************
-- * SQL*plus Job Control Section

-- Systemdatum Ende (bitte nicht aendern)
--
  SELECT user,
         TO_CHAR(SYSDATE, 'dd-mm-yy hh24:mi:ss') 
  FROM   dual
  ;  

  spool off