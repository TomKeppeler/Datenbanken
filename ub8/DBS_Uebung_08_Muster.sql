-- ***************************************************************
-- * File Name:                  dbs_manipulation.sq             *
-- * File Creator:               Knolle                          *
-- * Revision:                   Bernd Klein,                    *
-- * LastDate:                   18.06.2020                      *
-- *                                                             *
-- * <ChangeLogDate>             <ChangeLogText>                 *
-- ***************************************************************
--
-- ***************************************************************
-- * Datenbanksysteme SS2020
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
--      Aendern Sie die Hausnummer des Gebaeudes "A" in "99"
--
UPDATE   dbs_tab_gebaeude
SET      haus_nr = '99'
WHERE    gebaeude = 'A'
;

COMMIT
;

--
--      Erhoehen Sie das Gehalt aller Mitarbeiter um 3 Prozent
--
UPDATE   dbs_tab_mitarbeiter
SET      gehalt = gehalt + gehalt * 3 / 100
;

COMMIT
;


--
--      Professor Becker wird neuer Dekan des Fachbereichs Informatik
-- 
--      Frage: wie koennen Sie die zur Beantwortung dieser ƒnderung 
--      erforderlichen beiden SQL-Befehle zu einem Befehl kombinieren?
--
SELECT   pers_nr
FROM     dbs_tab_professor 
         natural join dbs_tab_mitarbeiter 
         natural join dbs_tab_hochschulangehoeriger 
WHERE    ho_name = 'Becker'
;

UPDATE   dbs_tab_fachbereich
SET      dekan = (SELECT   pers_nr
			      FROM     dbs_tab_professor 
                           natural join dbs_tab_mitarbeiter 
                           natural join dbs_tab_hochschulangehoeriger 
				  WHERE    ho_name = 'Becker'
                  ;)
WHERE    fb_name = 'Informatik'
;

COMMIT
;

--
--      Aendern Sie die Straﬂenangabe des Professors mit dem 
--      Fachgebiet "Statistik" in "Siegburger Straﬂe 99a" 
--
--      Frage: Was muss beachtet werden, wenn Sie in der  
--      SET-Anweisung mit Unteranfrage das "="-Zeichen werwenden?
UPDATE   dbs_tab_anschrift h1
SET      strasse='Siegburger Straﬂe', haus_nr='99a'
WHERE    h1.ho_nr = (SELECT  h2.ho_nr 
                     FROM    dbs_tab_hochschulangehoeriger h2,
                             dbs_tab_mitarbeiter m,
                             dbs_tab_professor p
                     WHERE   p.Fachgebiet = 'Statistik'
                     AND     p.pers_nr=m.pers_nr
                     AND     m.ho_nr = h2.ho_nr)
;

COMMIT
;


--		Alle Teilnehmer der letzten Pruefung in Datenbanksysteme
--		erhalten eine Notenverbesserung um 10%.
--		
--      Frage: Worauf muss geachtet werden, wenn die lv_nr der
--		Lehrveranstaltung ermittelt wird?
--
UPDATE dbs_tab_pruefung
SET note = note*0.9
WHERE lv_nr = ( --Vorueberlegung: lv_nr aus lv_name ermitteln
			SELECT distinct l.lv_nr 
            FROM dbs_tab_pruefung p, DBS_TAB_LEHRVERANSTALTUNG l
            WHERE p.datum IS NOT NULL
            AND p.lv_nr=l.lv_nr
            AND lv_name = 'Datenbanksysteme' )
AND datum = ( --Vorueberlegung: wie ist die letzte Pruefung
			SELECT MAX(p.datum) AS letztePruefung
            FROM dbs_tab_pruefung p, DBS_TAB_LEHRVERANSTALTUNG l
            WHERE p.datum IS NOT NULL
            AND p.lv_nr=l.lv_nr
            AND lv_name = 'Datenbanksysteme' 
			)
;

COMMIT
;


--
--	2   Einfuegen neuer Datensaetze
--
--      Fuegen Sie die folgenden Datensaetze ein:
--
--      Erfassen Sie die neuen Gebaeude "G" und "H", die in der Straﬂe "Grantham-Allee",
--      noch ohne Hausnummer, entstehen.
--
INSERT INTO dbs_tab_gebaeude 
VALUES ('G', 'Grantham-Allee', NULL)
;

INSERT INTO dbs_tab_gebaeude 
VALUES ('H', 'Grantham-Allee', NULL)
;

COMMIT
;


--
--      Die neue Lehrveranstaltung "Objektrelationale Datenbanken" des 
--      Fachbereichs Informatik soll jeden Mittwoch um 11:45 Uhr  
--      im Raum 321 des Gebaeudes G statt finden. Dozent ist 
--      Prof. Becker.
--
--      Frage: Welchen Primaerschluesselwert erhaelt die 
--      neue Lehrveranstaltung?
--
--      Hinweis: Die naechste freie Schluesselnummer erhaelt man 
--      mit ÑSELECT MAX(<attribut>)+1 FROM <tabelle>ì. 
SELECT MAX(lv_nr)+1 FROM dbs_tab_lv_ort;
--
--      Frage: In welchen Tabellen muss in welcher Reihenfolge 
--      eingefuegt werden?
--
--      Frage: Wie lassen sich die Values direkt mit einem 
--      SELECT-Befehl ermitteln und einfuegen?

-- Tabelle lehrveranstaltung
INSERT INTO dbs_tab_lehrveranstaltung
VALUES      (1155, 'Objektrelationale Datenbanken', 2)
;

-- Tabelle lv_ort:

INSERT INTO dbs_tab_lv_ort
VALUES      (1155, 'Mi', 1145, 'G', '321')
;

-- Direkt mittels VALUES und geschachteltem SELECT:

INSERT INTO dbs_tab_lehrveranstaltung
VALUES      (
	(SELECT MAX(lv_nr)+1 FROM dbs_tab_lv_ort)
	, 'Objektrelationale Datenbanken'
	, 2)
;

INSERT INTO dbs_tab_lv_ort
VALUES      (
	(SELECT MAX(lv_nr) FROM dbs_tab_lv_ort)
	, 'Mi'
	, 1145
	, 'G'
	, '321')
;

--
--      Eine neue Lehrkraft wurde an den Fachbereich Informatik 
--      berufen. Es handelt sich um die Professorin "Dr.  
--      Roberta Maria Feinbein, 53113 Bonn, 
--      Hauptstrasse 99". Sie wird mit einem monatlichen Gehalt 
--      von Ä 5.999 die Forschung und Lehre des Fachgebiets 
--      "Rechentechnik" vertreten. Ihre Heimatanschrift lautet 
--      "Jahnwiese 19, 47051 Duisburg" 
--
--      Frage: In welchen Tabellen muss in welcher Reihenfolge 
--      eingefuegt werden?
-- 
--      Frage: Wie lasen sich die neuen Primaerschluesselwerte 
--      ohne "Auto-Incrementì ermitteln?
-- 
--      Hinweis: Die naechste freie Schluesselnummer erhaelt man 
--      mit "SELECT MAX(<attribut>)+1 FROM <tabelle>". Leider 
--      ist die Personalnummer als CHAR(10) kein Datentyp, auf 
--      dem der "+"-Operator definiert ist. Da aber lediglich 
--      Ziffernwerte verwendet werden, kann man sich wie folgt 
--      behelfen, ohne die Konsistenz der Daten zu gefaehrden: 
--      "SELECT to_char(MAX(to_number(<attribut>))+1) 
--      FROM <tabelle>"
--
-- Im folgenden werden die Werte kuenstlicher Schluesselattribute neu 
-- einzufuegender Datensaetze einfach berechnet: Inkrementierung des 
-- Maximalwertes um eins. Dieses ist jedoch nur moeglich, sofern es
-- sich um Zahlen handelt.

-- Tabelle hochschulangehoeriger:

SELECT  MAX(ho_nr)+1, 'Feinbein'
FROM    dbs_tab_hochschulangehoeriger
;

INSERT INTO dbs_tab_hochschulangehoeriger
            SELECT MAX(ho_nr)+1, 'Feinbein'
            FROM dbs_tab_hochschulangehoeriger
;

-- Tabelle mitarbeiter:

-- Bei der pers_nr handelt es sich um einen CHAR-Datentyp, der nicht einfach 
-- inkrementiert werden kann. ORACLE bietet eine Reihe von Fuktionen zur 
-- Typkonvertierung an, u.a TO_NUMBER <wert> und TO_CHAR <wert>.
--
-- Die Nummer des Fachbereichs kann nicht ohne ein verschachteltes SELECT 
-- selektiert werden (was natuerlich moeglich ist). Dieses geschieht hier 
-- ueber ein anschliessendes Update. Die nr des neuen Hochschulangehoerigen 
-- ist die hoechste Nummer (MAX(ho_nr)).
-- 
-- Im obigen und in den folgenden Beispielen ist die Nutzung 
-- von MAX(<Attribut>) jedoch nicht ungefaehrlich ...

SELECT   TO_CHAR(MAX(TO_NUMBER(m2.pers_nr))+1),
         MAX (h.ho_nr),
         NULL,
         'Forschung und Lehre',
         'Professor',
         5999
FROM     dbs_tab_mitarbeiter m2,
         dbs_tab_hochschulangehoeriger h,
         dbs_tab_fachbereich f
WHERE    f.fb_nr = m2.fb_nr
;

INSERT INTO dbs_tab_mitarbeiter m1
            SELECT TO_CHAR(MAX(TO_NUMBER(m2.pers_nr))+1),
                   MAX(h.ho_nr),
                   NULL,
                   'Forschung und Lehre',
                   'Professor',
                   5999,
                   NULL
            FROM   dbs_tab_mitarbeiter m2,
                   dbs_tab_hochschulangehoeriger h,
                   dbs_tab_fachbereich f
            WHERE  f.fb_nr = m2.fb_nr
;

UPDATE dbs_tab_mitarbeiter
SET    fb_nr   = (SELECT fb_nr 
                  FROM   dbs_tab_fachbereich 
                  WHERE  fb_name = 'Informatik')
WHERE  pers_nr = (SELECT MAX(pers_nr) 
                  FROM   dbs_tab_mitarbeiter)
;

-- Tabelle Professor:

SELECT  'Prof. Dr.',
        MAX(m.pers_nr), 
        'Rechentechnik'
from    dbs_tab_mitarbeiter m
;

INSERT INTO dbs_tab_professor
            SELECT  'Prof. Dr.',
                    MAX(m.pers_nr), 
                    'Rechentechnik'
            FROM    dbs_tab_mitarbeiter m
;

-- Tabelle anschrift:

SELECT  MAX(h.ho_nr),
        1, 
        53113,
        'Bonn',
        'Hauptstrasse',
        '99'
from    dbs_tab_hochschulangehoeriger h, 
        dbs_tab_anschrift a
;

INSERT INTO dbs_tab_anschrift
            SELECT MAX(h.ho_nr),
                   1, 
                   53113,
                   'Bonn',
                   'Hauptstrasse',
                   '99' 
             from dbs_tab_hochschulangehoeriger h, 
                  dbs_tab_anschrift a
;

SELECT  MAX(h.ho_nr), 
        2, 
        47051,
        'Duisburg',
        'Jahnwiese',
        '19'
from    dbs_tab_hochschulangehoeriger h, 
        dbs_tab_anschrift a
;

insert into dbs_tab_anschrift
             select max(h.ho_nr), 
                    2, 
                    47051,
                    'Duisburg',
                    'Jahnwiese',
                    '19'
             from   dbs_tab_hochschulangehoeriger h, 
                    dbs_tab_anschrift a
;

-- Tabelle vorname:

SELECT  MAX(h.ho_nr), 
        1, 
        'Roberta'
from    dbs_tab_hochschulangehoeriger h, 
        dbs_tab_vorname a
;

INSERT INTO dbs_tab_Vorname
            SELECT MAX(h.ho_nr), 
                   1, 
                   'Roberta'
            from   dbs_tab_hochschulangehoeriger h, 
                   dbs_tab_vorname a
;

SELECT  MAX(h.ho_nr),
        2, 
        'Maria'
FROM    dbs_tab_hochschulangehoeriger h, 
        dbs_tab_vorname a 
;

INSERT INTO dbs_tab_vorname
            SELECT MAX(h.ho_nr),
                   2, 
                   'Maria'
            FROM   dbs_tab_hochschulangehoeriger h, 
                   dbs_tab_vorname a 
;

COMMIT
;

-- Nochmal der Hinweis, dass die INSERT-Befehle natuerlich auch 
-- mittels VALUES und geschachteltem SELECT haetten eingefuegt 
-- werden koennen 



--  
--      3    Loeschen von Datensaetzen
--
--      Loeschen Sie die folgenden Datensaetze:
--
--      Loeschen Sie oben eingefuegte  Gebaeude "G", das von keiner 
--      Lehrveranstaltungen belegt wird.
--
DELETE
FROM     dbs_tab_gebaeude
WHERE    gebaeude = 'G'
;

COMMIT
;

--
-- 		Der Studierende Leon Barsch, mit der Matr-Nr. 808603 hat sich 
--      von allen Pruefungen abgemeldet. Loeschen sie die aktuellen 
--      Anmeldungen zu seinen Pruefungen.
--
--		Frage: Wie gehen Sie vor, wenn die Matr-Nr. nicht bekannt ist?
DELETE FROM dbs_tab_pruefung
WHERE matr_nr='808603'
AND datum IS NULL
;

commit
;

-- Matr-Nr. ermitteln:
select s.MATR_NR, h.HO_NAME, v.vorname
from dbs_tab_student s, dbs_tab_hochschulangehoeriger h, dbs_tab_vorname v
where s.ho_nr=h.ho_nr
and h.ho_nr=v.ho_nr
and v.vorname='Leon'
and h.ho_name='Barsch'
;

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

-- Tabelle anschrift:
DELETE
FROM  dbs_tab_anschrift a
WHERE a.ho_nr = (SELECT h.ho_nr
              FROM   dbs_tab_hochschulangehoeriger h, 
                     dbs_tab_mitarbeiter m
              WHERE  h.ho_nr = m.ho_nr
              AND    m.pers_nr = '508322')
;

-- Tabelle vorname:

DELETE
FROM  dbs_tab_vorname v
WHERE v.ho_nr = (SELECT h.ho_nr
              FROM   dbs_tab_hochschulangehoeriger h, 
                     dbs_tab_mitarbeiter m
              WHERE  h.ho_nr = m.ho_nr
              AND    m.pers_nr = '508322')
;
 
-- Tabelle prof_haelt_lv:
-- Achtung: nicht immer erlaubt!

DELETE
FROM    dbs_tab_prof_haelt_lv
WHERE   pers_nr = '508322'
;

-- Tabelle professor:

DELETE
FROM    dbs_tab_professor
WHERE   pers_nr = '508322'
;

-- Tabelle mitarbeiter
-- Achtung: Prof. koennte auch noch Deakan und/oder Student sein

-- Mitarbeiter beruecksichtien 
-- Achtung: nicht immer erlaubt!

UPDATE dbs_tab_mitarbeiter
SET    chef_nr = NULL
WHERE  chef_nr = '508322'
;

DELETE
FROM    dbs_tab_mitarbeiter
WHERE   pers_nr = '508322'
;

-- Tabelle hochschulangehoeriger:

DELETE
FROM    dbs_tab_hochschulangehoeriger h
WHERE   h.ho_nr not in (  SELECT v.ho_nr
                       FROM   dbs_tab_vorname v
                     UNION
                       SELECT a.ho_nr
                       FROM   dbs_tab_anschrift a)
;

COMMIT
;


--
--      Die Lehrveranstaltung "Statistik" ist gestrichen worden.
--
DELETE
FROM    dbs_tab_prof_haelt_lv plv
WHERE   plv.lv_nr in (SELECT nlv.lv_nr
                      FROM   dbs_tab_lehrveranstaltung nlv
                      WHERE  nlv.lv_name = 'Statistik')
;

DELETE
FROM    dbs_tab_lv_ort lvo
WHERE   lvo.lv_nr in (SELECT lv.lv_nr
                    FROM   dbs_tab_lehrveranstaltung lv
                    WHERE  lv.lv_name = 'Statistik')
;

DELETE
FROM    dbs_tab_lehrveranstaltung
WHERE   lv_name = 'Statistik'
;

COMMIT
;

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