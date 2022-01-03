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





--      Frage: Worauf muss geachtet werden, wenn die lv_nr der
--		Lehrveranstaltung ermittelt wird?
--


--
--	2   Einfuegen neuer Datensaetze
--
--      Fuegen Sie die folgenden Datensaetze ein:
--
--      Erfassen Sie die neuen Geb�ude "G" und "H", die in der Stra�e "Grantham-Allee",
--      noch ohne Hausnummer, entstehen.
--


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