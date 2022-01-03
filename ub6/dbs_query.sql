-- ***************************************************************
-- * File Name:                  dbs_query.sql                   *
-- * File Creator:               Knolle                          *
-- * CreationDate:               22. November 2021               *
-- *                                                             *
-- * <ChangeLogDate>             <ChangeLogText>                 *
-- ***************************************************************
--
-- ***************************************************************
-- * Datenbanksysteme WS 2021/22
-- * Uebungen 6, 7 
--
-- ***************************************************************
-- * SQL*plus Job Control Section
--
--set 	echo 		on
--set 	linesize 	128
--set 	pagesize 	50
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
--
-- Protokolldatei
--
spool ./dbs_query.log
--
-- Systemdatum
--
  SELECT user,
         TO_CHAR(SYSDATE, 'dd-mm-yy hh24:mi:ss') 
  FROM   dual
  ;  
--
-- ***************************************************************
-- * S Q L - B E I S P I E L A N F R A G E N
--
-- 	1	Projektion
--
-- 	1.1	Auswaehlen von Eigenschaften (Spalten)
--
--	Wie lauten die Namen aller Lehrveranstaltungen?
--

SELECT LV_NAME FROM DBS_TAB_LEHRVERANSTALTUNG;
 
--
--	Welche Berufe haben die Mitarbeiter und wie hoch ist ihr 
--	Gehalt?HO_NR = 1001
--

SELECT dth.HO_NAME, dtv.VORNAME, Beruf, Gehalt FROM DBS_TAB_MITARBEITER dtm, DBS_TAB_VORNAME dtv, DBS_TAB_HOCHSCHULANGEHOERIGER dth 
	WHERE dtm.HO_NR = dtv.HO_NR AND dtm.HO_NR = dth.HO_NR ;
 
--
--	Wie lauten die Daten der Tabelle 'Professor'?
--

SELECT * FROM DBS_TAB_PROFESSOR;

--
-- 	1.2	Umbenennen von Spalten
--
--	Die Daten der Tabelle 'Gebaeude' sollen ausgegeben werden, 
-- 	wobei die Spalte 'haus_nr' in 'Hausnummer' umzubenennen ist.
--

SELECT Gebaeude, Strasse, Haus_NR AS Hausnummer from DBS_TAB_Gebaeude;

--
-- 	1.3	Berechnen bzw. Ableiten von neuen Eigenschaften (Spalten)
--
--	Die Orte sollen mit der Landeskennung '(D)' ausgegeben werden 
--	(kuenstliche Spalte mit konstantem Wert).
--

SELECT Gebaeude, Strasse, Haus_NR AS Hausnummer, '(D)' AS landeskuertzel from DBS_TAB_Gebaeude;


--
--	Zu jeder Personalnummer soll der Stundenlohn ausgegeben und als 
--	solcher benannt werden (Monat = 20 Tage zu je 8 Stunden).
--

SELECT pers_Nr Personalnummer, gehalt/(20*8) Stundenlohn FROM DBS_TAB_MITARBEITER dtm;

--
--	2	Selektion
--
--	2.1	Ausblenden identischer Zeilen
--
--	In welchen unterschiedlichen Orten leben die 
--	Hochschulangehoerigen?
--
SELECT dtv.VORNAME, dth.HO_NAME, dta.ORT 
FROM DBS_TAB_HOCHSCHULANGEHOERIGER dth, 
DBS_TAB_MITARBEITER dtm, DBS_TAB_VORNAME dtv, DBS_TAB_ANSCHRIFT dta 
WHERE dth.HO_NR =dtm.HO_NR AND dtm.HO_NR = dtv.HO_NR AND dtm.HO_NR =dta.HO_NR;

--oder will er dort nur die Orte haben dann so

SELECT DISTINCT dta.ORT 
FROM DBS_TAB_HOCHSCHULANGEHOERIGER dth, DBS_TAB_ANSCHRIFT dta 
WHERE dth.HO_NR =dta.HO_NR;
--
--	Zu welchen Zeiten wird in der Woche gelehrt?
--

SELECT DISTINCT zeit FROM DBS_TAB_LV_ORT dtlo;

--
--	2.2	Sortierung der Ausgabe
--
--	Die Personalnummern sind absteigend nach ihrem zugehoerigen 
--	Gehalt auszugeben.
--

SELECT pers_nr Personalnummer FROM DBS_TAB_MITARBEITER 
	ORDER BY gehalt DESC;

--
--	Die Orte und Strassen sind aufsteigend sortiert nach Ort und bei 
--	gleichen Orten dann absteigend nach Strasse auszugeben.
--

SELECT ort, strasse FROM DBS_TAB_ANSCHRIFT dta 
	ORDER BY ort, strasse DESC;

--
--	2.3	Auswahl bestimmter Tupel (Zeilen, Informationstraeger)
--
--	Welche Gebaeude werden am Dienstag belegt?
--
SELECT g.GEBAEUDE FROM DBS_TAB_LV_ORT o, DBS_TAB_GEBAEUDE g
	WHERE o.GEBAEUDE LIKE g.GEBAEUDE 
	AND o.TAG LIKE 'Di';
	
--
--	Wie lauten die Personalnummern derjenigen Mitarbeiter, die mehr 
--	als 20 � in der Stunde verdienen?
--


SELECT pers_Nr Personalnummer
	FROM DBS_TAB_MITARBEITER dtm
	WHERE gehalt/(20*8) > 20;

--
--	2.4	Auswahl von Tupeln, die mehreren Bedingungen genuegen
--
--	Es sollen die Nummern der Lehrveranstaltungen ausgegeben 
--	werden, die im Gebaeude 'F' oder Freitags abgehalten werden.
--
 
SELECT LV_NR FROM DBS_TAB_LV_ORT 
WHERE GEBAEUDE LIKE 'F' OR TAG LIKE 'Fr';

--
--	Welche Mitarbeiter des Fachbereichs 2 verdienen mehr als 
--	5.000 �?
--

SELECT vorname, ho_name FROM DBS_TAB_MITARBEITER  m, DBS_TAB_HOCHSCHULANGEHOERIGER dth, DBS_TAB_VORNAME dtv 
	WHERE m.HO_NR =dth.HO_NR AND m.HO_NR = dtv.HO_NR 
	AND fb_nr = 2 AND GEHALT > 5000;

--
--	2.5	Vergleich mit einem Muster
--
--	Wie viele Hochschulangehoerige mit einem Namen, der wie 'Meier' 
--	ausgesprochen wird, werden im System verwaltet?
--

SELECT count(*) FROM DBS_TAB_HOCHSCHULANGEHOERIGER dth, DBS_TAB_VORNAME dtv 
WHERE dth.HO_NR = dtv.HO_NR AND dtv.VORNAME LIKE 'M__er';

--
--	Welche unterschiedlichen Vornamen, die mit 'M' beginnen, 
--	existieren im System?
--

SELECT DISTINCT Vorname FROM DBS_TAB_VORNAME dtv 
WHERE vorname LIKE 'M%';

--
--	Welche Fachgebiete von Professoren enthalten das Wort 
--	'system'?
--

SELECT * FROM DBS_TAB_PROFESSOR
WHERE FACHGEBIET LIKE '%system%';

--
--	2.6	Vergleich mit NULL-Werten
--
--	Gebe die Matrikelnummern solcher Studenten aus, die einen Job 
--	haben?
--

SELECT matr_nr FROM DBS_TAB_STUDENT dts, DBS_TAB_MITARBEITER dtm 
WHERE dts.HO_NR = dtm.HO_NR;

--
--	Gebe die Daten der Studenten aus, deren Personalnummer nicht dem Wert 
--	507263 entsprechen.
--
SELECT * FROM DBS_TAB_STUDENT dts 
WHERE PERS_NR != 507263;
--
--	3	Verbund von Tabellen
--
--	3.1	Equi-Join
--
--	Gebe eine Liste aller Fachbereichsnamen mit den Namen ihrer 
--	zugehoerigen Lehrveranstaltungen aus.
--

SELECT fb_name, lv_name FROM DBS_TAB_FACHBEREICH dtf, DBS_TAB_LEHRVERANSTALTUNG dtl 
WHERE dtf.FB_NR = dtl.FB_NR;

--
--	neue Syntax:
--

SELECT fb_name, lv_name FROM DBS_TAB_LEHRVERANSTALTUNG dtl 
JOIN DBS_TAB_FACHBEREICH dtf ON dtl.FB_NR = dtf.FB_NR;

--
--	In welchen unterschiedlichen Strassen finden am Freitag 
--	Lehrveranstaltungen statt?
--

SELECT DISTINCT strasse FROM DBS_TAB_LEHRVERANSTALTUNG dtl, DBS_TAB_LV_ORT dtlo, DBS_TAB_GEBAEUDE dtg
WHERE dtl.LV_NR = dtlo.LV_NR AND dtlo.GEBAEUDE LIKE dtg.GEBAEUDE AND dtlo.tag LIKE 'Fr';

--
--	neue Syntax:
--

SELECT DISTINCT strasse FROM DBS_TAB_LEHRVERANSTALTUNG dtl 
JOIN DBS_TAB_LV_ORT dtlo ON dtl.LV_NR = dtlo.LV_NR 
JOIN DBS_TAB_GEBAEUDE dtg ON dtlo.GEBAEUDE LIKE dtg.GEBAEUDE 
WHERE dtlo.tag LIKE 'Fr';

--
--	Welche Studenten arbeiten nicht am Fachbereich, an dem 
--	sie eingeschrieben sind?
--

SELECT matr_nr FROM DBS_TAB_STUDENT dts, DBS_TAB_MITARBEITER dtm 
WHERE dts.HO_NR = dtm.HO_NR AND dts.FB_NR != dtm.FB_NR;

--	
--	neue Syntax:
--

SELECT MATR_NR FROM DBS_TAB_STUDENT dts
JOIN DBS_TAB_MITARBEITER dtm ON dts.HO_NR = dtm.HO_NR 
WHERE dts.FB_NR != dtm.FB_NR;

--
--	Wie lautet die Adresse des Professors des Fachgebiets 
--	'Mathematik'?
-- 	

SELECT Strasse, haus_nr, plz, ort FROM DBS_TAB_ANSCHRIFT dta, DBS_TAB_PROFESSOR dtp, DBS_TAB_MITARBEITER dtm 
WHERE dtp.PERS_NR = dtm.PERS_NR AND dtm.HO_NR = dta.HO_NR 
AND dtp.FACHGEBIET LIKE 'Mathematik';

--
--	neue Syntax:
--

SELECT Strasse, haus_nr, plz, ort FROM DBS_TAB_PROFESSOR dtp 
JOIN DBS_TAB_MITARBEITER dtm ON dtp.PERS_NR = dtm.PERS_NR 
JOIN DBS_TAB_ANSCHRIFT dta ON dtm.HO_NR = dta.HO_NR 
WHERE dtp.FACHGEBIET LIKE 'Mathematik';

--
--	3.2	Equi-Join mit NULL-Werten (Outer Equi-Join)
--
--	In welchen Institutionen arbeiten Studenten. Zeige auch solche 
--	Studenten an, die nicht arbeiten.
--
--	spezielle Oracle Syntax (+):
--

SELECT matr_nr, institution FROM DBS_TAB_STUDENT dts, DBS_TAB_MITARBEITER dtm 
	WHERE dts.PERS_NR = dtm.PERS_NR
UNION
SELECT MATR_NR, NULL FROM DBS_TAB_STUDENT dts2 
	WHERE MATR_NR NOT IN (SELECT Matr_nr FROM DBS_TAB_MITARBEITER dtm2
	WHERE dts2.PERS_NR = dtm2.PERS_NR);

--
--	neue Syntax:
--

SELECT matr_nr, institution FROM DBS_TAB_STUDENT dts
	LEFT JOIN DBS_TAB_MITARBEITER dtm ON dts.PERS_NR = dtm.PERS_NR;

--
--	3.3	Theta-Join
--
--	Gebe eine Namensliste mit Spielpaarungen aus, in der die 
--	Personalnummer des ersten Spielers kleiner ist als die des 
--	zweiten Spielers wobei alle Personalnummern groesser 
-- 	als 506000 sein sollen.
--
SELECT DISTINCT dth.HO_NAME, dtv.VORNAME, dtm.PERS_NR, dth2.HO_NAME, dtv2.VORNAME, dtm2.PERS_NR FROM DBS_TAB_MITARBEITER dtm, DBS_TAB_MITARBEITER dtm2,
DBS_TAB_HOCHSCHULANGEHOERIGER dth, DBS_TAB_VORNAME dtv,
DBS_TAB_HOCHSCHULANGEHOERIGER dth2, DBS_TAB_VORNAME dtv2 
	WHERE dtm.PERS_NR < dtm2.PERS_NR 
	AND dtm.PERS_NR > 506000 AND dtm2.PERS_NR > 506000
	AND dth.HO_NR =dtv.HO_NR AND dtm.HO_NR =dth.HO_NR --erster
	AND dth2.HO_NR =dtv2.HO_NR AND dtm2.HO_NR =dth2.HO_NR; --zweiter

-- 
--	neue Syntax:
--

--
--	4	Mengenoperationen
--
--	4.1	Vereinigung von Tabellen
--
--	Wie lautet die Menge der Personalnummer, die Professoren oder 
--	Studenten gehoeren?
--
 
--
--	4.2	Schneiden von Tabellen
--
--	Finde die Personalnummern der Mitarbeiter heraus, die Professor 
--	sind und mehr als 4.000 � verdienen.
--
SELECT PERS_NR FROM DBS_TAB_MITARBEITER m
WHERE PERS_NR IN (SELECT PERS_NR FROM DBS_TAB_PROFESSOR p)
AND GEHALT > 4000;
--
--	... auch formulierbar als join:
--
SELECT m.PERS_NR FROM DBS_TAB_MITARBEITER m
JOIN DBS_TAB_PROFESSOR p ON m.PERS_NR = p.PERS_NR
WHERE GEHALT > 4000;
--
--	4.3	Differenz von Tabellen
--
--	Wie lauten die Personalnummern solcher Mitarbeiter, die nicht 
--	Student sind?
--

--
--	5	Aggregatfunktionen
--
--	5.1	Vollstaendige Verdichtung
--
--	Wieviele Mitarbeiter werden beschaeftigt?
--	

--
--	Wie lautet das hoechste, das niedrigste und das 
--	durchschnittliche Gehalt sowie die Summe der Gehaelter der 
--	Mitarbeiter?
--

--
--	5.2	Gruppierung von Verdichtungen
--
--	Wie lauten die Durchschnittsgehaelter der Mitarbeiter 
--	fuer jeden Fachbereiche?
--

--
--	Wie lauten die Durchschnittsgehaelter der Mitarbeiter 
--	fuer jeden Fachbereiche, wenn diese ueber 4.000 � liegen?
--
 
--
--	6	Unterabfragen
--
--	6.1	'IN'-Operator
--
--	Wie lauten die Namen der Mitarbeiter, die nicht in Bonn 
--	wohnen?
--
 
--
--	... auch allgemeiner formulierbar als Join:
--
 
--
--	6.2	Vergleichsoperatoren
--
--	Welcher (!) Hochschulangehoerige wohnt im Auerweg?
--	Achtung: warum "darf" bei "=" in dieser Anfrage nur eine  
--	Person im Auerweg wohnen?
--
 
--					
--	... auch formulierbar als Join (hier d�rfen jedoch auch 
--	mehrere Personen im Auerweg wohnen):
--

--
--	Wie lauten die Namen der Studenten, die zeitlich spaeter 
--	(mit groesserer ho_nr) als Meyer erfasst worden sind ?
--
  
--					
--	6.3	Existenzabfragen
--
--	Welche Fachbereiche bieten keine Lehrveranstaltungen an?
--
 
--
--	Welche Professoren (Personalnummer) halten 
--	Lehrveranstaltungen(mindestens eine)?
--
 
--
--	6.4	All-Quantor
--
--	Welche Mitarbeiter erhalten das groesste Gehalt?
--
 
--
--	Welche Mitarbeiter verdienen weniger als andere?
--
  
--
-- Systemdatum
--
  SELECT user,
         TO_CHAR(SYSDATE, 'dd-mm-yy hh24:mi:ss') 
  FROM   dual
  ;  
--
spool off