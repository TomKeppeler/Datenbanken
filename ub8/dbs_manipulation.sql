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



--
--      Erhoehen Sie das Gehalt aller Mitarbeiter um 3 Prozent
--


--
--      Professor Becker wird neuer Dekan des Fachbereichs Informatik
-- 
--      Frage: wie können Sie die zur Beantwortung dieser Änderung 
--      erforderlichen beiden SQL-Befehle zu einem Befehl kombinieren?
--

--
--      Aendern Sie die Straßenangabe des Professors mit dem 
--      Fachgebiet "Statistik" in "Siegburger Straße 66" 
--
--      Frage: Was muss beachtet werden, wenn Sie in der  
--      SET-Anweisung mit Unteranfrage das "="-Zeichen werwenden?




--		Alle Teilnehmer der letzten Prüfung in Datenbanksysteme
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
--      Erfassen Sie die neuen Gebäude "G" und "H", die in der Straße "Grantham-Allee",
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
--      Hinweis: Die nächste freie Schlüsselnummer erhält man 
--      mit „SELECT MAX(<attribut>)+1 FROM <tabelle>“. 
--
--      Frage: In welchen Tabellen muss in welcher Reihenfolge 
--      eingefügt werden?
--
--      Frage: Wie lassen sich die Values direkt mit einem 
--      SELECT-Befehl ermitteln und einfuegen?



--
--      Eine neue Lehrkraft wurde an den Fachbereich Informatik 
--      berufen. Es handelt sich um die Professorin "Dr.  
--      Roberta Maria Feinbein, 53113 Bonn, 
--      Hauptstrasse 66". Sie wird mit einem monatlichen Gehalt 
--      von € 5.999 die Forschung und Lehre des Fachgebiets 
--      "Rechentechnik" vertreten. Ihre Heimatanschrift lautet 
--      "Jahnwiese 19, 47051 Duisburg" 
--
--      Frage: In welchen Tabellen muss in welcher Reihenfolge 
--      eingefügt werden?
-- 
--      Frage: Wie lasen sich die neuen Primaerschluesselwerte 
--      ohne "Auto-Increment“ ermitteln?
-- 
--      Hinweis: Die nächste freie Schlüsselnummer erhaelt man 
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
--      Loeschen Sie oben eingefügte  Gebaeude "H", das von keiner 
--      Lehrveranstaltungen belegt wird.
--

--
-- 		Der Studierende Leon Barsch, mit der Matr-Nr. 808603 hat sich 
--      von allen Prüfungen abgemeldet. Löschen sie die aktuellen 
--      Anmeldungen zu seinen Prüfungen.
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