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
DROP TABLE TAB_KUENSTLER_HAT_GEN   RE;
DROP TABLE TAB_SONG_HAT_GENRE;
DROP TABLE TAB_KUENSTLER_PLAYLIST;
DROP TABLE TAB_KUENSTLER_PLAYLIST_HAT_SONGS;
DROP TABLE TAB_BENUTZER_PLAYLIST;
DROP TABLE TAB_BENUTZER_PLAYLIST_HAT_SONGS;
DROP TABLE TAB_SONG;
DROP TABLE TAB_BENUTZER_VERTRAG;
DROP TABLE TAB_KUENSTLER_VERTRAG;
DROP TABLE TAB_BENUTZER_HAT_VERTRAG;

-- ***************************************************************
-- * Table Section

CREATE TABLE TAB_KUENSTLER(
       KUENSTLER_ID number(8) PRIMARY KEY,
       Nachname VARCHAR2(50) NOT Null,
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
       KUENSTLER_PLAYLIST_ID number(8),
       SONG_ID number(8)
);

CREATE TABLE TAB_BENUTZER_PLAYLIST(
       BENUTZER_PLAYLIST_ID number(8),
       Bezeichnung VARCHAR2(50)
);

CREATE TABLE TAB_BENUTZER_PLAYLIST_HAT_SONGS(
       BENUTZER_Playlist_ID number(8),
       SONG_ID number(8)
);

CREATE TABLE TAB_SONG(
       SONG_ID number(8),
       Bezeichnung VARCHAR2(50)
);

CREATE TABLE TAB_BENUTZER_VERTRAG(
       BENUTZER_VERTRAG_ID number(8),
       Bezeichnung VARCHAR2(50),
       Beschreibung VARCHAR2(50),
       Preis number(3,2)
);

CREATE TABLE TAB_BENUTZER_HAT_VERTRAG(
       BENUTZER_VERTRAG_ID number(8),
       BENUTZER_ID number(8)
);

CREATE TABLE TAB_KUENSTLER_VERTRAG(
       KUENSTLER_VERTRAG_ID number(8),
       Bezeichnung VARCHAR2(50),
       Beschreibung VARCHAR2(50),
);

CREATE TABLE TAB_KUENSTLER_HAT_VERTRAG(
       KUENSTLER_VERTRAG_ID number(8),
       KUENSTLER_ID number(8)
);


-- ***************************************************************
-- * NOT NULL Constraint Section

-- Kuenstler Tabellen NOT NULL Constraints

ALTER TABLE TAB_KUENSTLER ADD CONSTRAINT
NN_KUENSTLER_KUENSTLER_ID CHECK(KUENSTLER_ID IS NOT NULL);

ALTER TABLE TAB_KUENSTLER ADD CONSTRAINT
NN_KUENSTLER_NACHNAME CHECK(NACHNAME IS NOT NULL);

ALTER TABLE TAB_KUENSTLER ADD CONSTRAINT
NN_KUENSTLER_VORNAME CHECK(VORNAME IS NOT NULL);

-- Benutzer Tabellen NOT NULL Constraints

ALTER TABLE TAB_BENUTZER ADD CONSTRAINT
NN_BENUTZER_BENUTZER_ID CHECK(BENUTZER_ID IS NOT NULL);

ALTER TABLE TAB_BENUTZER ADD CONSTRAINT
NN_BENUTZER_NACHNAME CHECK(NACHNAME IS NOT NULL);

ALTER TABLE TAB_BENUTZER ADD CONSTRAINT
NN_BENUTZER_VORNAME CHECK(VORNAME IS NOT NULL);

-- Genre Tabelle NOT NULL Constraint

ALTER TABLE TAB_GENRE ADD CONSTRAINT
NN_GENRE_GENRE_ID CHECK(GENRE_ID IS NOT NULL);

-- KUENSTLER_HAT_GENRE Tabelle NOT NUL Constraint

ALTER TABLE TAB_KUENSTLER_HAT_GENRE ADD CONSTRAINT
NN_KUENSTLER_HAT_GENRE_KUENSTLER_ID CHECK(KUENSTLER_ID IS NOT NULL);

ALTER TABLE TAB_KUENST_HAT_GENRE ADD CONSTRAINT
NN_KUENSTLER_HAT_GENRE_GENRE_ID CHECK(GENRE_ID IS NOT NULL);

-- SONG_HAT_GENRE Tabelle NOT NULL Constraint

ALTER TABLE TAB_SONG_HAT_GENRE ADD CONSTRAINT
NN_SONG_HAT_GENRE_SONG_ID CHECK(SONG_ID IS NOT NULL);

ALTER TABLE TAB_SONG_HAT_GENRE ADD CONSTRAINT
NN_SONG_HAT_GENRE_GENRE_ID CHECK(GENRE_ID IS NOT NULL);

-- KUENSTLER_PLAYLIST Tabelle NOT NULL Constraints

ALTER TABLE TAB_KUENSTLER_PLAYLIST ADD CONSTRAINT
NN_KUENSTLER_PLAYLIST_KUENSTLER_PLAYLIST_ID CHECK(KUENSTLER_PLAYLIST_ID NOT NULL);

ALTER TABLE TAB_KUENSTLER_PLAYLIST ADD CONSTRAINT
NN_KUENSTLER_PLAYLIST_BEZEICHNUNG CHECK(BEZEICHNUNG NOT NULL);

ALTER TABLE TAB_KUENSTLER_PLAYLIST ADD CONSTRAINT
NN_KUENSTLER_PLAYLIST_ALBUM CHECK(ALBUM NOT NULL);

-- KUENSTLER_PLAYLIST_HAT_SONGS Tabelle NOT NULL Constraints

ALTER TABLE TAB_KUENSTLER_PLAYLIST_HAT_SONGS ADD CONSTRAINT
NN_KUENSTLER_PLAYLIST_HAT_SONGS_KUENSTLER_PLAYLIST_ID CHECK(KUENSTLER_PLAYLIST_ID NOT NULL);

ALTER TABLE TAB_KUENSTLER_PLAYLIST_HAT_SONGS ADD CONSTRAINT
NN_KUENSTLER_PLAYLIST_HAT_SONGS_SONG_ID CHECK(SONG_ID NOT NULL);

-- BENUTZER_PLAYLIST Tabelle NOT NULL Constraints

ALTER TABLE TAB_BENUTZER_PLAYLIST ADD CONSTRAINT
NN_BENUTZER_PLAYLIST_KUENSTLER_PLAYLIST_ID CHECK(BENUTZER_PLAYLIST_ID NOT NULL);

ALTER TABLE TAB_BENUTZER_PLAYLIST ADD CONSTRAINT
NN_BENUTZER_PLAYLIST_BEZEICHNUNG CHECK(BEZEICHNUNG NOT NULL);

-- BENUTZER_PLAYLIST_HAT_SONGS Tabelle NOT NULL Constraints

ALTER TABLE TAB_BENUTZER_PLAYLIST_HAT_SONGS ADD CONSTRAINT
NN_BENUTZER_PLAYLIST_HAT_SONGS_BENUTZER_PLAYLIST_ID CHECK(BENUTZER_PLAYLIST_ID NOT NULL);

ALTER TABLE TAB_BENUTZER_PLAYLIST_HAT_SONGS ADD CONSTRAINT
NN_BENUTZER_PLAYLIST_HAT_SONGS_SONG_ID CHECK(SONG_ID NOT NULL);

--SONG Tabelle NOT NULL Constraint

ALTER TABLE TAB_SONG ADD CONSTRAINT
NN_SONG_SONG_ID CHECK(SONG_ID NOT NULL);

ALTER TABLE TAB_SONG ADD CONSTRAINT
NN_SONG_BEZEICHNUNG CHECK(Bezeichung NOT NULL);

-- BENUTZER_VERTRAG Tabelle NOT NULL Constraint

ALTER TABLE TAB_BENUTZER_VERTRAG ADD CONSTRAINT
NN_BENUTZER_VERTRAG_BENUTZER_VERTRAG_ID CHECK(BENUTZER_VERTRAG_ID NOT NULL);

ALTER TABLE TAB_BENUTZER_VERTRAG ADD CONSTRAINT
NN_BENUTZER_VERTRAG_BEZEICHNUNG CHECK(Bezeichnung NOT NULL);

ALTER TABLE TAB_BENUTZER_VERTRAG ADD CONSTRAINT
NN_BENUTZER_VERTRAG_PREIS CHECK(Preis NOT NULL);

-- BENUTZER_HAT_VERTRAG Tabelle NOT NULL Constraint

ALTER TABLE TAB_BENUTZER_HAT_VERTRAG ADD CONSTRAINT
NN_BENUTZER_HAT_VERTRAG_BENUTZER_VERTRAG_ID CHECK(BENUTZER_VERTRAG_ID NOT NULL);

ALTER TABLE TAB_BENUTZER_HAT_VERTRAG ADD CONSTRAINT
NN_BENUTZER_HAT_VERTRAG_BENUTZER_ID CHECK(BENUTZER_ID NOT NULL);

-- KUENSTLER_VERTRAG Tabelle NOT NULL Constraint

ALTER TABLE TAB_KUENSTLER_VERTRAG ADD CONSTRAINT
NN_KUENSTLER_VERTRAG_KUENSTLER_VERTRAG_ID CHECK(KUESTLER_VERTRAG_ID NOT NULL);

ALTER TABLE TAB_KUENSTLER_VERTRAG ADD CONSTRAINT
NN_BENUTZER_VERTRAG_NAME CHECK(Bezeichnung NOT NULL);

-- KUENSTLER_HAT_VERTRAG Tabelle NOT NULL Constraint 

ALTER TABLE TAB_KUENSTLER_HAT_VERTRAG ADD CONSTRAINT
NN_KUENSTLER_HAT_VERTRAG_KUENSTLER_VERTRAG_ID CHECK(KUENSTLER_VERTRAG_ID NOT NULL);

ALTER TABLE TAB_KUENSTLER_HAT_VERTRAG ADD CONSTRAINT
NN_KUENSTLER_HAT_VERTRAG_KUENSTLER_ID CHECK(KUENSTLER_ID NOT NULL);

-- ***************************************************************
-- * Primary Key Constraint Section

ALTER TABLE TAB_KUENSTLER ADD CONSTRAINT
PK_KUENSTLER PRIMARY KEY (KUENSTLER_ID);

ALTER TABLE TAB_BENUTZER ADD CONSTRAINT
PK_BENUTZER PRIMARY KEY (BENUTZER_ID);

ALTER TABLE TAB_GENRE ADD CONSTRAINT
PK_GENRE_GENRE_ID PRIMARY KEY (GENRE_ID);

ALTER TABLE TAB_BENUTZER_VERTRAG ADD CONSTRAINT
PK_BENUTZER_VERTRAG_BENUTZER_VERTRAG_ID PRIMARY KEY (BENUTZER_VERTRAG_ID);

ALTER TABLE TAB_KUENSTLER_VERTRAG ADD CONSTRAINT
PK_KUENSTLER_VERTRAG_KUENSTLER_VERTRAG_ID PRIMARY KEY (KUENSTLER_VERTRAG_ID);

ALTER TABLE TAB_KUENSTLER_PLAYLIST ADD CONSTRAINT
PK_KUENSTLER_PLAYLIST_KUENSTLER_PLAYLIST_ID PRIMARY KEY (KUENSTLER_PLAYLIST_ID);

ALTER TABLE TAB_BENUTZER_PLAYLIST ADD CONSTRAINT
PK_BENUTZER_PLAYLIST_BENUTZER_PLAYLIST_ID PRIMARY KEY (BENUTZER_PLAYLIST_ID);

ALTER TABLE TAB_SONG ADD CONSTRAINT
PK_SONG_SONG_ID PRIMARY KEY (SONG_ID);

-- ***************************************************************
-- * Unique Key Constraint Section
ALTER TABLE TAB_SONG ADD CONSTRAINT uk_song_bezeichnung
UNIQUE (bezeichnung);

-- ***************************************************************
-- * Foreign Key Constraint Section

-- KUENSTLER_HAT_GENRE Tabelle FK auf Kuenstler Tabelle Kuenstler_ID

ALTER TABLE TAB_KUENSTLER_HAT_GENRE ADD CONSTRAINT
FK_KUENSTLER_HAT_GENRE_KUENSTLER FOREIGN KEY (KUENSTLER_ID) REFERENCES TAB_KUENSTLER (KUENSTLER_ID);

-- FK auf Genre Tabelle über Genre_ID

ALTER TABLE TAB_KUENSTLER_HAT_GENRE ADD CONSTRAINT
FK_KUENSTLER_HAT_GENRE_GENRE FOREIGN KEY (GENRE_ID) REFERENCES TAB_GENRE (GENRE_ID);

-- SONG_HAT_GENRE Tabelle FK auf Song Tabelle über Song_ID

ALTER TABLE TAB_SONG_HAT_GENRE ADD CONSTRAINT
FK_SONG_HAT_GENRE_SONG FOREIGN KEY (SONG_ID) REFERENCES TAB_SONG (SONG_ID);

-- FK auf Genre Tabelle über Genre_ID

ALTER TABLE TAB_SONG_HAT_GENRE ADD CONSTRAINT
FK_SONG_HAT_GENRE_GENRE FOREIGN KEY (GENRE_ID) REFERENCES TAB_GENRE (GENRE_ID);


-- KUENSTLER_PLAYLIST_HAT_SONGS Tabelle FK auf KUENSTLER_PLAYLIST Tabele über KUENSTLER_PLAYLIST_ID

ALTER TABLE TAB_KUENSTLER_PLAYLIST_HAT_SONGS ADD CONSTRAINT
FK_KUENSTLER_PLAYLIST_HAT_SONG_KUENSTLER_PLAYLIST
FOREIGN KEY (KUENSTLER_PLAYLIST_ID) REFERENCES TAB_KUENSTLER_PLAYLIST (KUENSTLER_PLAYLIST_ID);

--FK auf SONG Tabelle über SONG_ID

ALTER TABLE TAB_KUENSTLER_PLAYLIST_HAT_SONGS ADD CONSTRAINT
FK_KUENSTLER_PLAYLIST_HAT_SONGS_


-- ***************************************************************
-- * SQL*plus Job Control Section

-- Systemdatum Ende (bitte nicht aendern)
--
  SELECT user,
         TO_CHAR(SYSDATE, 'dd-mm-yy hh24:mi:ss') 
  FROM   dual
  ;  

  spool off