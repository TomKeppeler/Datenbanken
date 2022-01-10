-- ***************************************************************
-- * File Name:                  dbs_manipulation.sql            *
-- * File Creator:               Knolle                          *
-- * Revision:                   Bernd Klein,                    *
-- * LastDate:                   13.12.2021                      *
-- *                                                             *
-- * <ChangeLogDate>             <ChangeLogText>                 *
-- ***************************************************************
--
-- ***************************************************************
-- * Datenbanksysteme WS2021/22
-- * Uebung 8 
--
-- ***************************************************************
-- * SQL*plus Job Control Section
--
set 	echo 		on
set 	linesize 	128
set 	pagesize 	50
--
-- Spaltenformatierung (nur fuer die Ausgabe)
--
column 	lv_name     format A35 WORD_WRAPPED
column 	beruf       format A30 WORD_WRAPPED
column 	fb_name     format A35 WORD_WRAPPED
column 	institution format A20 WORD_WRAPPED
column 	strasse     format A20 WORD_WRAPPED
column 	ort         format A20 WORD_WRAPPED
column 	lv_name     format A30 WORD_WRAPPED
column 	titel       format A20 WORD_WRAPPED
column 	vorname     format A20 WORD_WRAPPED
column 	ort         format A20 WORD_WRAPPED
column 	fachgebiet  format A20 WORD_WRAPPED
column 	pers_nr     format A15 WORD_WRAPPED
column 	ho_name     format A20 WORD_WRAPPED
column 	NULL        format A6  WORD_WRAPPED
--
-- Protokolldatei
--
-- Systemdatum
--
spool ./dbs_manipulation.log
--
  SELECT user,
         TO_CHAR(SYSDATE, 'dd-mm-yy hh24:mi:ss') 
  FROM   dual
  ;  
--
-- ***************************************************************
-- * S Q L - B E I S P I E L M A N I P U L T I O N E N 
--
--  1   Aenderung von Datensaetzen
--
--      Aendern Sie die folgenden Datensaetze jeweils im Rahmen 
--      eines einzelnen SQL-Befehls:
--
--      Aendern Sie die Hausnummer des Gebaeudes "A" in "66"

UPDATE DBS_TAB_GEBAEUDE SET HAUS_NR = '66' WHERE GEBAEUDE LIKE 'A';

SELECT * FROM DBS_TAB_GEBAEUDE dtg;
--
--      Erhoehen Sie das Gehalt aller Mitarbeiter um 3 Prozent
--
COMMIT;
UPDATE DBS_TAB_MITARBEITER SET GEHALT = GEHALT + (GEHALT * (3/100));

SELECT * FROM DBS_TAB_MITARBEITER;
--
--      Professor Becker wird neuer Dekan des Fachbereichs Informatik
-- 
--      Frage: wie k�nnen Sie die zur Beantwortung dieser �nderung 
--      erforderlichen beiden SQL-Befehle zu einem Befehl kombinieren?
--


FB_NR|FB_NAME                  |DEKAN     |
-----+-------------------------+----------+
3    |Elektrotechnik           |508311    |
1    |Wirtschaftswissenschaften|508514    |
2    |Informatik               |508321    |

UPDATE DBS_TAB_FACHBEREICH SET DEKAN = (SELECT m.PERS_NR FROM DBS_TAB_PROFESSOR p, DBS_TAB_MITARBEITER m, DBS_TAB_HOCHSCHULANGEHOERIGER h 
WHERE p.PERS_NR = m.PERS_NR AND m.HO_NR = h.HO_NR AND HO_NAME LIKE 'Becker')
WHERE FB_NAME LIKE 'Informatik';

SELECT * FROM DBS_TAB_FACHBEREICH;

FB_NR|FB_NAME                  |DEKAN     |
-----+-------------------------+----------+
3    |Elektrotechnik           |508311    |
1    |Wirtschaftswissenschaften|508514    |
2    |Informatik               |508523    |

SELECT m.PERS_NR, h.HO_NAME FROM DBS_TAB_PROFESSOR p, DBS_TAB_MITARBEITER m, DBS_TAB_HOCHSCHULANGEHOERIGER h 
WHERE p.PERS_NR = m.PERS_NR AND m.HO_NR = h.HO_NR AND HO_NAME LIKE 'Becker';

PERS_NR   |HO_NAME|
----------+-------+
508523    |Becker |
--
--      Aendern Sie die Stra�enangabe des Professors mit dem 
--      Fachgebiet "Statistik" in "Siegburger Stra�e 66" 

SELECT p.PERS_NR, h.HO_NR, p.FACHGEBIET, h.HO_NAME, a.STRASSE 
FROM DBS_TAB_PROFESSOR p, DBS_TAB_MITARBEITER m, 
DBS_TAB_HOCHSCHULANGEHOERIGER h, DBS_TAB_ANSCHRIFT a 
WHERE p.PERS_NR = m.PERS_NR AND m.HO_NR = h.HO_NR AND h.HO_NR = a.HO_NR AND p.PERS_NR = 509514

PERS_NR   |HO_NR|FACHGEBIET|HO_NAME|STRASSE|
----------+-----+----------+-------+-------+
509514    | 1016|Statistik |Schmidt|Auerweg|

UPDATE DBS_TAB_ANSCHRIFT SET STRASSE = 'Siegburger Straße 66'
WHERE HO_NR = 1016;

SELECT p.PERS_NR, h.HO_NR, p.FACHGEBIET, h.HO_NAME, a.STRASSE 
FROM DBS_TAB_PROFESSOR p, DBS_TAB_MITARBEITER m, 
DBS_TAB_HOCHSCHULANGEHOERIGER h, DBS_TAB_ANSCHRIFT a 
WHERE p.PERS_NR = m.PERS_NR AND m.HO_NR = h.HO_NR AND h.HO_NR = a.HO_NR AND p.PERS_NR = 509514

PERS_NR   |HO_NR|FACHGEBIET|HO_NAME|STRASSE             |
----------+-----+----------+-------+--------------------+
509514    | 1016|Statistik |Schmidt|Siegburger Straße 66|

--
--      Frage: Was muss beachtet werden, wenn Sie in der  
--      SET-Anweisung mit Unteranfrage das "="-Zeichen werwenden?




--		Alle Teilnehmer der letzten Pr�fung in Datenbanksysteme
--		erhalten eine Notenverbesserung um 10%.
--		
SELECT * FROM DBS_TAB_PRUEFUNG;

MATR_NR|LV_NR|PROFESSOR |VERSUCH|DATUM                  |NOTE|
-------+-----+----------+-------+-----------------------+----+
 808602| 1144|508321    |      1|2021-06-17 00:00:00.000| 1.4|
 808602| 1152|508321    |      1|2021-06-07 00:00:00.000|   5|
 808602| 1152|508321    |      2|2021-06-19 00:00:00.000| 4.7|
 808603| 1153|508323    |      1|2022-03-13 00:00:00.000|    |
 808604| 1144|508321    |      1|2021-06-17 00:00:00.000| 2.2|
 808603| 1144|508321    |      1|                       |    |
 808603| 1152|508321    |      1|                       |    |
 
UPDATE DBS_TAB_PRUEFUNG SET NOTE = NOTE - (Note * (10/100)) 
WHERE MATR_NR IN (SELECT MATR_NR FROM DBS_TAB_STUDENT)
AND LV_NR = (SELECT LV_NR FROM DBS_TAB_LEHRVERANSTALTUNG WHERE LV_NAME LIKE 'Datenbanksysteme');
SELECT * FROM DBS_TAB_LEHRVERANSTALTUNG;
SELECT * FROM DBS_TAB_DBS_TAB_LEHRVERANSTALTUNGPRUEFUNG;

MATR_NR|LV_NR|PROFESSOR |VERSUCH|DATUM                  |NOTE|
-------+-----+----------+-------+-----------------------+----+
 808602| 1144|508321    |      1|2021-06-17 00:00:00.000| 1.3|
 808602| 1152|508321    |      1|2021-06-07 00:00:00.000|   5|
 808602| 1152|508321    |      2|2021-06-19 00:00:00.000| 4.7|
 808603| 1153|508323    |      1|2022-03-13 00:00:00.000|    |
 808604| 1144|508321    |      1|2021-06-17 00:00:00.000|   2|
 808603| 1144|508321    |      1|                       |    |
 808603| 1152|508321    |      1|                       |    |
 
--      Frage: Worauf muss geachtet werden, wenn die lv_nr der
--		Lehrveranstaltung ermittelt wird?
--
auf LIKE oder so

--
--	2   Einfuegen neuer Datensaetze
--
--      Fuegen Sie die folgenden Datensaetze ein:
--
--      Erfassen Sie die neuen Geb�ude "G" und "H", die in der Stra�e "Grantham-Allee",
--      noch ohne Hausnummer, entstehen.
--

DELETE FROM DBS_TAB_GEBAEUDE WHERE GEBAEUDE LIKE 'G' OR GEBAEUDE LIKE 'H';

INSERT INTO DBS_TAB_GEBAEUDE VALUES('G', 'Grantham-Allee', NULL);
INSERT INTO DBS_TAB_GEBAEUDE VALUES('H', 'Grantham-Allee', NULL);
SELECT * FROM DBS_TAB_GEBAEUDE dtg ;
--
--      Die neue Lehrveranstaltung "Objektrelationale Datenbanken" des 
--      Fachbereichs Informatik soll jeden Mittwoch um 11:45 Uhr  
--      im Raum 321 des Gebaeudes G statt finden. Dozent ist 
--      Prof. Becker.
--
--      Frage: Welchen Primaerschluesselwert erhaelt die 
--      neue Lehrveranstaltung?
--
--      Hinweis: Die n�chste freie Schl�sselnummer erh�lt man 
--      mit �SELECT MAX(<attribut>)+1 FROM <tabelle>�. 
--
--      Frage: In welchen Tabellen muss in welcher Reihenfolge 
--      eingef�gt werden?
--
--      Frage: Wie lassen sich die Values direkt mit einem 
--      SELECT-Befehl ermitteln und einfuegen?

DELETE FROM DBS_TAB_PROF_HAELT_LV WHERE LV_NR = (SELECT LV_NR FROM DBS_TAB_LEHRVERANSTALTUNG WHERE LV_NAME LIKE 'Objektrelationale Datenbanken');
DELETE FROM DBS_TAB_LV_ORT WHERE LV_NR = (SELECT LV_NR FROM DBS_TAB_LEHRVERANSTALTUNG WHERE LV_NAME LIKE 'Objektrelationale Datenbanken');
DELETE FROM DBS_TAB_LEHRVERANSTALTUNG WHERE LV_NAME LIKE 'Objektrelationale Datenbanken';

SELECT * FROM DBS_TAB_LEHRVERANSTALTUNG;

INSERT INTO DBS_TAB_LEHRVERANSTALTUNG(LV_NR, LV_NAME, FB_NR)
SELECT (SELECT MAX(LV_NR)+1 FROM DBS_TAB_LEHRVERANSTALTUNG), 'Objektrelationale Datenbanken', (SELECT FB_NR FROM DBS_TAB_FACHBEREICH WHERE FB_NAME LIKE 'Informatik')
FROM DUAL;

INSERT INTO DBS_TAB_LV_ORT(LV_NR, TAG, ZEIT, GEBAEUDE, RAUM)
SELECT (SELECT LV_NR FROM DBS_TAB_LEHRVERANSTALTUNG WHERE LV_NAME LIKE 'Objektrelationale Datenbanken'),
'Mi', 1145, 'G', 321 FROM dual;

SELECT * FROM DBS_TAB_LV_ORT;

LV_NR|TAG|ZEIT |GEBAEUDE|RAUM |
-----+---+-----+--------+-----+
 1144|Mo |1600 |F       |4    |
 1144|Mo |1745 |C       |181  |
 1150|Do |1230 |C       |177  |
 1150|Fr |1230 |C       |181  |
 1152|Fr |1600 |C       |181  |
 1152|Do |1230 |C       |016  |
 1152|Fr |1230 |        |     |
 1153|Di |1415 |C       |177  |
 1153|Do |1015 |C       |181  |
 1153|Do |1230 |C       |177  |
 1153|Do |1415 |C       |181  |
 1154|Di |0815 |E       |4    |
 1154|Di |1600 |F       |23   |
 1154|Di |1745 |C       |181  |
 1155|Mi |1145 |G       |321  |
 
 INSERT INTO DBS_TAB_PROF_HAELT_LV(PERS_NR, LV_NR, TAG, ZEIT)
 SELECT (SELECT p.PERS_NR FROM DBS_TAB_PROFESSOR p
 	JOIN DBS_TAB_MITARBEITER m ON p.PERS_NR = m.PERS_NR 
 	JOIN DBS_TAB_HOCHSCHULANGEHOERIGER h ON m.HO_NR = h.HO_NR 
 	WHERE h.HO_NAME LIKE 'Becker'), 
 (SELECT LV_NR FROM DBS_TAB_LEHRVERANSTALTUNG WHERE LV_NAME LIKE 'Objektrelationale Datenbanken'),
 TAG, ZEIT FROM DBS_TAB_LV_ORT 
 WHERE LV_NR = (SELECT LV_NR FROM DBS_TAB_LEHRVERANSTALTUNG WHERE LV_NAME LIKE 'Objektrelationale Datenbanken');
 
 
 
 SELECT * FROM DBS_TAB_PROF_HAELT_LV ORDER BY LV_NR DESC ;

PERS_NR   |LV_NR|TAG|ZEIT |
----------+-----+---+-----+
508523    | 1155|Mi |1145 |
508321    | 1154|Di |1600 |
508523    | 1154|Di |0815 |
508321    | 1154|Di |1745 |
508523    | 1154|Di |1600 |


--
--      Eine neue Lehrkraft wurde an den Fachbereich Informatik 
--      berufen. Es handelt sich um die Professorin "Dr.  
--      Roberta Maria Feinbein, 53113 Bonn, 
--      Hauptstrasse 66". Sie wird mit einem monatlichen Gehalt 
--      von � 5.999 die Forschung und Lehre des Fachgebiets 
--      "Rechentechnik" vertreten. Ihre Heimatanschrift lautet 
--      "Jahnwiese 19, 47051 Duisburg" 
--
--      Frage: In welchen Tabellen muss in welcher Reihenfolge 
--      eingef�gt werden?
-- 
--      Frage: Wie lasen sich die neuen Primaerschluesselwerte 
--      ohne "Auto-Increment� ermitteln?
-- 
--      Hinweis: Die n�chste freie Schl�sselnummer erhaelt man 
--      mit "SELECT MAX(<attribut>)+1 FROM <tabelle>". Leider 
--      ist die Personalnummer als CHAR(10) kein Datentyp, auf 
--      dem der "+"-Operator definiert ist. Da aber lediglich 
--      Ziffernwerte verwendet werden, kann man sich wie folgt 
--      behelfen, ohne die Konsistenz der Daten zu gefaehrden: 
--      "SELECT to_char(MAX(to_number(<attribut>))+1) 
--      FROM <tabelle>"
--

INSERT INTO DBS_TAB_HOCHSCHULANGEHOERIGER(HO_NR, HO_NAME)
SELECT 
(SELECT MAX(HO_NR)+1 FROM DBS_TAB_HOCHSCHULANGEHOERIGER dth),
'Feinbein' FROM dual;

SELECT * FROM DBS_TAB_HOCHSCHULANGEHOERIGER ORDER BY HO_NR DESC;

HO_NR|HO_NAME    |
-----+-----------+
 1032|Feinbein   |
 1031|Feinbein   |
 1030|Jaguar     |
 1029|Iltis      |
 1028|Hahn       |
 1027|Ganz       |
 
 SELECT * FROM DBS_TAB_VORNAME oder 
BY HO_NR DESC;
 
 
--  
--      3    Loeschen von Datensaetzen
--
--      Loeschen Sie die folgenden Datensaetze:
--
--      Loeschen Sie oben eingef�gte  Gebaeude "H", das von keiner 
--      Lehrveranstaltungen belegt wird.
--

--
-- 		Der Studierende Leon Barsch, mit der Matr-Nr. 808603 hat sich 
--      von allen Pr�fungen abgemeldet. L�schen sie die aktuellen 
--      Anmeldungen zu seinen Pr�fungen.
--
--		Frage: Wie gehen Sie vor, wenn die Matr-Nr. nicht bekannt ist?


--
--      Der Professor mit der Personalnummer 508322 hat 
--      gekuendigt.
--
--      Frage: In welchen Tabellen muss geloescht werden?
--
--      Frage: Warum ist nicht jede beliebige Loeschreihenfolge moeglich?
--
--      Frage: Wie koennen Sie sich die "ho_nr" merken, ohne sie zu wissen?
-- 
 

--
--      Die Lehrveranstaltung "Statistik" ist gestrichen worden.
--


--
-- Systemdatum
--
  SELECT user,
         TO_CHAR(SYSDATE, 'dd-mm-yy hh24:mi:ss') 
  FROM   dual
  ;  
--
--
spool off