-- ***************************************************************
-- * File Name:                  dbs_extern.sql                  *
-- * File Creator:               Knolle                          *
-- * CreationDate:               20.12.2021                      *
-- *                                                             *
-- * <ChangeLogDate>             <ChangeLogText>                 *
-- ***************************************************************
--
-- ***************************************************************
-- * Datenbanksysteme WS 2021/22
-- * Uebung 9 
--
-- ***************************************************************
-- * SQL*plus Job Control Section
--
set 	echo 		on
set 	linesize 	256
set 	pagesize 	50
--
-- Spaltenformatierung (nur fuer die Ausgabe)
--
column 	ho_name     format A20 WORD_WRAPPED
column 	beruf       format A25 WORD_WRAPPED
column 	fb_name     format A25 WORD_WRAPPED
column 	institution format A20 WORD_WRAPPED
column 	strasse     format A20 WORD_WRAPPED
column 	haus_nr     format A5  WORD_WRAPPED
column 	ort         format A15 WORD_WRAPPED
column 	titel       format A10 WORD_WRAPPED
column 	vorname     format A10 WORD_WRAPPED
column 	ort         format A20 WORD_WRAPPED
column 	fachgebiet  format A17 WORD_WRAPPED
column 	pers_nr     format A11 WORD_WRAPPED
column 	NULL        format A6  WORD_WRAPPED
--
-- Protokolldatei
--
-- Systemdatum
--
spool ./dbs_extern.log
--
  SELECT user,
         TO_CHAR(SYSDATE, 'dd-mm-yy hh24:mi:ss') 
  FROM   dual
  ;  
--
-- ***************************************************************
-- * S Q L - B E I S P I E L - V I E W S 
CREATE OR 
REPLACE VIEW  
;

DESCRIBE      


SELECT	      *
FROM     dbs_tab_student     
;
SELECT	      *
FROM     DBS_TAB_FACHBEREICH;     


--
--      Erstellen Sie die folgenden Sichten:
--
--      Virtuelle Tabelle �Fachbereich� mit allen Spalten der 
--      korrespondierenden Tabelle der konzeptionellen Ebene 
--      (Beispiel einer sehr einfachen View, die exakt der zugrunde 
--      liegenden Tabelle entspricht).
--      
CREATE OR REPLACE VIEW dbs_v_fachbereich AS
SELECT * FROM DBS_TAB_FACHBEREICH;

SELECT * FROM dbs_v_fachbereich;




CREATE OR 
REPLACE VIEW dbs_v_student AS
SELECT * FROM dbs_tab_student 
;

DESCRIBE dbs_v_student;  

SELECT	      *
FROM  dbs_v_student        
;

--      
--      Virtuelle Tabelle �Fachbereich hat Dekan�. Die View soll 
--      nur die Spalten Name des Fachbereichs und Name des Dekans 
--      enthalten.
--      

CREATE OR REPLACE VIEW dbs_v_fachbereich_hat_dekan AS
SELECT f.FB_NAME, v.VORNAME, h.HO_NAME FROM DBS_TAB_FACHBEREICH f
JOIN DBS_TAB_MITARBEITER m ON f.DEKAN = m.PERS_NR
JOIN DBS_TAB_HOCHSCHULANGEHOERIGER h ON m.HO_NR = h.HO_NR
JOIN DBS_TAB_VORNAME v ON h.HO_NR = v.HO_NR ;

SELECT * FROM dbs_v_fachbereich_hat_dekan;
--      
--      Virtuelle Tabelle �Fachbereich beschaeftigt Mitarbeiter�. 
--      Die View soll nur die Spalten Name des Fachbereichs und 
--      Name des Mitarbeiters enthalten und standardmae�ig nach 
--      dem Namen des Fachbereichs und bei Gleichheit nach dem 
--      Namen des Mitarbeiters sortiert werden.
      
 CREATE OR REPLACE VIEW dbs_v_fachbe_beschae_mitarb AS
SELECT f.FB_NAME, v.VORNAME, h.HO_NAME FROM  DBS_TAB_MITARBEITER m
JOIN DBS_TAB_FACHBEREICH f ON m.FB_NR = f.FB_NR 
JOIN DBS_TAB_HOCHSCHULANGEHOERIGER h ON m.HO_NR = h.HO_NR
JOIN DBS_TAB_VORNAME v ON h.HO_NR = v.HO_NR 
ORDER BY f.FB_NAME, h.HO_NAME;

SELECT * FROM dbs_v_fachbe_beschae_mitarb;
 
--      
--      Virtuelle Tabelle �Fachberteich bietet lehrveranstaltung�. 
--      Die View soll lediglich den Namen des Fachbereichs und den 
--      Namen der Lehrveranstaltung enthalten und nach dem Namen 
--      des Fachbereichs sowie  bei Gleichheit nach dem Namen der 
--      Lehrveranstaltung sortiert werden.
--      
CREATE OR REPLACE VIEW dbs_v_fachb_bietet_lehrv AS
SELECT l.LV_NAME, f.FB_NAME FROM DBS_TAB_LEHRVERANSTALTUNG l
JOIN DBS_TAB_FACHBEREICH f ON l.FB_NR = f.FB_NR
ORDER BY f.FB_NAME, l.LV_NAME;

SELECT * FROM dbs_v_fachb_bietet_lehrv;
--      
--      Virtuelle Tabelle Lehrveranstaltungen des Fachbereichs 
--      Informatik�. Nutzen Sie zur Erstellung dieser View die zuvor 
--      erstellte View �Fachbereich bietet Lehrveranstaltung�.
--      
CREATE OR REPLACE VIEW dbs_v_lehrveranstaltungen_info AS
SELECT fbl.LV_NAME FROM dbs_v_fachb_bietet_lehrv fbl
WHERE FB_NAME LIKE 'Informatik'; 

SELECT * FROM dbs_v_lehrveranstaltungen_info;
--      
--      Virtuelle Tabelle �Hochschulangehoeriger�. Die View soll 
--      lediglich die relevanten und objektidentifizierenden Spalten 
--      des semantisch ausdrucksstarken Objekts �Hochschulangehoeriger� 
--      enthalten (also nicht die Spalten an_nr und vo_nr). Die View 
--      soll standardmae�ig nach dem Namen des Hochschulangehoerigen 
--      sortiert werden.
--      
--      Frage: Warum ist dieses Sortierkriterium nicht immer 
--      hilfreich?
--      Frage: Warum tauchen einige der Hochschulangehoerigen 
--      offenbar mehrfach auf? 
--
--      Da mansche meherere Anschriften haben.
/*
 * 	ho_name
	vorname[1-3] list
	anschrift[1-3] list
	plz
	ort
	strasse
	haus_nr[0-1]
 */
CREATE OR REPLACE VIEW dbs_v_hochschulangehoeriger AS
SELECT h.HO_NAME, v.VORNAME, a.PLZ, a.ORT, a.STRASSE, a.HAUS_NR FROM DBS_TAB_HOCHSCHULANGEHOERIGER h
JOIN DBS_TAB_VORNAME v ON h.HO_NR = v.HO_NR 
JOIN DBS_TAB_ANSCHRIFT a ON h.HO_NR = a.HO_NR 
ORDER BY h.HO_NAME;

SELECT * FROM dbs_v_hochschulangehoeriger;
--      
--      Virtuelle Tabelle �Mitarbeiter�. Die View soll lediglich 
--      die relevanten und objektidentifizierenden Spalten des 
--      semantisch ausdrucksstarken Objekts �Mitarbeiter� sowie 
--      den Namen des Fachbereichs wo dieser angestellt ist, enthalten. 
--      Bitte lassen Sie Spalte Gehalt weg. Die View soll standardmae�ig 
--      nach dem Namen des Fachbereichs und bei Gleichheit, nach dem 
--      Namen des Mitarbeiters sortiert werden.
--  
--      Frage: Warum w�re ein zweites Sortierkriterium nach der 
--      Personalnummer hilfreicher?
--      
--pers_nr
--institution
--beruf
--gehalt
CREATE OR REPLACE VIEW dbs_v_mitarbeiter AS
SELECT m.PERS_NR, m.INSTITUTION, m.BERUF, f.FB_NAME FROM DBS_TAB_MITARBEITER m 
JOIN DBS_TAB_FACHBEREICH f ON m.FB_NR = f.FB_NR
JOIN DBS_TAB_HOCHSCHULANGEHOERIGER h ON m.HO_NR = h.HO_NR
ORDER BY f.FB_NAME, h.HO_NAME;


SELECT * FROM dbs_v_mitarbeiter;

--      
--      Virtuelle Tabelle "Professor". Die View soll lediglich 
--      die relevanten und objektidentifizierenden Spalten des 
--      semantisch ausdrucksstarken Objekts �Professor� sowie 
--      den Namen des Fachbereichs wo dieser angestellt ist, enthalten. 
--      Bitte lassen Sie Spalte Gehalt weg. Die View soll standardmae�ig 
--      nach dem Namen des Fachbereichs und bei Gleichheit, nach der 
--      Personalnummer des Professors sortiert werden.
--      
--      Frage: Kann man zur Erstellung dieser View auf die zuvor 
--      erstellte View �Mitarbeiter� zurueckgreifen?
--      

CREATE OR REPLACE VIEW dbs_v_professor AS
SELECT m.PERS_NR, p.TITEL, v.VORNAME, h.HO_NAME, f.FB_NAME, p.FACHGEBIET, m.INSTITUTION, m.BERUF FROM DBS_TAB_PROFESSOR p
JOIN DBS_TAB_MITARBEITER m ON p.PERS_NR  = m.PERS_NR 
JOIN DBS_TAB_HOCHSCHULANGEHOERIGER h ON m.HO_NR = m.HO_NR
JOIN DBS_TAB_VORNAME v ON h.HO_NR = v.HO_NR
JOIN DBS_TAB_FACHBEREICH f ON m.FB_NR = f.FB_NR
WHERE v.VO_NR = 1
ORDER BY f.FB_NAME, p.PERS_NR;


SELECT * FROM dbs_v_professor m;
--      
--      Virtuelle Tabelle �Student�. Die View soll lediglich die relevanten 
--      und objektidentifizierenden Spalten des semantisch ausdrucksstarken 
--      Objekts �Student� sowie den Namen des Fachbereichs, wo dieser 
--      immatrikuliert ist, enthalten. Bitte lassen Sie Spalte Personalnummer 
--      weg. Die View soll standardmae�ig nach dem Namen des Fachbereichs und 
--      bei Gleichheit, nach der Matrikelnummer des Studenten sortiert werden.

CREATE OR REPLACE VIEW 

SELECT * FROM DBS_V_STUDENT

--      
--      Virtuelle Tabelle �Studentischer Mitarbeiter�. Die View soll lediglich 
--      die relevanten und objektidentifizierenden Spalten des semantisch 
--      ausdrucksstarken Objekts �Student� sowie den Namen des Fachbereichs, 
--      wo dieser angestellt ist und den Namen des Fachbereichs, wo dieser 
--      immatrikuliert ist, enthalten. Bitte lassen Sie Spalten Matrikelnummer 
--      und Gehalt weg. Die View soll standardmae�ig nach dem Namen des 
--      Fachbereichs der Mitarbeit und bei Gleichheit, nach der Personalnummer 
--      des Studenten sortiert werden.

--      Frage: Kann man zur Erstellung dieser View auf die zuvor erstellte 
--      View �Mitarbeiter� und / oder �Student� zurueckgreifen?
--      

CREATE OR REPLACE VIEW dbs_v_studentische_mitabreiter AS
SELECT m1.PERS_NR, m1.INSTITUTION, m1.BERUF,
(SELECT f2.fb_name FROM DBS_TAB_FACHBEREICH f2 
WHERE f2.FB_NR = m1.FB_NR) angestellt,
(SELECT f3.FB_NAME FROM DBS_TAB_FACHBEREICH f3 WHERE f3.FB_NR = s.FB_NR) eingeschrieben 
FROM DBS_V_STUDENT s
LEFT JOIN DBS_TAB_MITARBEITER m1 ON m1.PERS_NR = s.PERS_NR
JOIN DBS_TAB_FACHBEREICH f1 ON m1.FB_NR = f1.FB_NR 
JOIN DBS_TAB_HOCHSCHULANGEHOERIGER h ON m1.HO_NR = h.HO_NR
JOIN DBS_TAB_VORNAME v ON h.HO_NR = v.HO_NR
WHERE v.VO_NR = 1;
ORDER BY f1.FB_NAME, s.PERS_NR;

SELECT * FROM dbs_v_studentische_mitabreiter;
--      
--      Virtuelle Tabelle �Professor haelt Lehrveranstaltung�. Die View 
--      soll lediglich Titel und Name des Professors und den Namen 
--      der Lehrveranstaltung enthalten. Die View soll nach der Nummer des 
--      Hochschulangehoerigen sortiert werden (auch wenn diese nicht 
--      Bestandteil der View ist).
--      
--      Frage: Warum ist an dieser Stelle ein �distinct� hilfreich?
--      weil Professoren meherere Lehrveranstaltung

CREATE OR REPLACE VIEW DBS_V_PROF_HAELT_LV AS
SELECT TITEL, VORNAME, HO_NAME, LV_NAME FROM (
SELECT DISTINCT p1.TITEL, v1.VORNAME, h1.HO_NAME, l1.LV_NAME, m1.HO_NR FROM DBS_TAB_PROF_HAELT_LV phl1
JOIN DBS_TAB_LEHRVERANSTALTUNG l1 ON phl1.LV_NR = l1.LV_NR
JOIN DBS_TAB_professor p1 ON phl1.PERS_NR = p1.PERS_NR
JOIN DBS_TAB_MITARBEITER m1 ON p1.PERS_NR = m1.PERS_NR 
JOIN dbs_TAB_hochschulangehoeriger h1 ON m1.HO_NR = h1.HO_NR
JOIN DBS_TAB_VORNAME v1 ON h1.HO_NR = v1.HO_NR
WHERE v1.VO_NR = 1;
ORDER BY m1.HO_NR);

SELECT * FROM DBS_V_PROF_HAELT_LV;
--	
--      Virtuelle Tabelle �Pruefungen�. Die View soll lediglich
--	    die relevanten und objekt-identifizierenden Spalten des
--	    semantisch ausdrucksstarken Objekts �Pruefungen� enthalten.
--	    Die View soll namentlich: Lehrveranstaltung, Professor und
--	    Student mit Name und erstem Vornamen in einer Spalte,
--	    in der Form: "Name, ersterVorname"
--	    (Bsp. Konkatenation: name || �,� || vorname), sowie die
--	    Note enthalten. Standardm��ig aufsteigend sortiert nach
--	    Lehrveranstaltung und Professor, absteigend nach Student
--	    und aufsteigend nach Note.
--
--      Frage: Wie l�sen Sie das Problem, dass der ho_name sowohl f�r 
--      Professoren als auch f�r Studenten ben�tigt wird? In wie fern 
--      ist hierbei distinct zu verwenden, bzw. welche Gefahr besteht durch 
--      die Verwendung.

CREATE OR REPLACE VIEW DBS_V_PRUEFUNGEN AS
SELECT
(SELECT l.LV_NAME FROM DBS_TAB_LEHRVERANSTALTUNG l WHERE l.LV_NR = p.LV_NR) lvname,
pr.titel, v.VORNAME, h.HO_NAME, p.NOTE, p.VERSUCH,
(SELECT h.HO_NAME || ',' || v.vorname FROM DBS_TAB_HOCHSCHULANGEHOERIGER h, DBS_V_STUDENT s, DBS_TAB_VORNAME v 
WHERE h.HO_NR = s.HO_NR AND h.HO_NR = v.HO_NR AND v.VO_NR = 1 AND s.MATR_NR = p.MATR_NR) StudentName
FROM DBS_TAB_PRUEFUNG p, DBS_TAB_PROFESSOR pr, DBS_TAB_MITARBEITER m, DBS_TAB_HOCHSCHULANGEHOERIGER h, DBS_TAB_VORNAME v
WHERE pr.PERS_NR = m.PERS_NR AND m.HO_NR = h.HO_NR AND h.HO_NR = v.HO_NR AND v.VO_NR = 1 AND p.PROFESSOR = pr.PERS_NR ;

SELECT * FROM DBS_V_PRUEFUNGEN;
--
--      Virtuelle Tabelle �MA_BlockedDate� mit dem Namen und erstem Vornamen
--      (wie oben), der Personalnummer, sowie den Namen der Lehrveranstaltung 
--      bei der sich der Mitarbeiter f�r eine Pr�fung angemeldet hat. Erg�nzen 
--      Sie um eine leere Spalte: "vorauss. Pr�fungs-Datum", um im m�glichen 
--      Ausdruck ein Datum von Hand eintragen zu k�nnen. Die Sicht zeigt die 
--      m�glicherweise durch Pr�fung geblockten Termine von studentischen 
--      Hilfskr�ften.
CREATE OR REPLACE VIEW DBS_V_MA_BLOCKEDDATE AS
SELECT l.LV_NAME, s.pers_NR,
(SELECT h.HO_NAME || ',' || v.vorname FROM DBS_TAB_HOCHSCHULANGEHOERIGER h, DBS_V_STUDENT s, DBS_TAB_VORNAME v 
WHERE h.HO_NR = s.HO_NR AND h.HO_NR = v.HO_NR AND v.VO_NR = 1 AND s.MATR_NR = p.MATR_NR) StudentName, NULL AS pruefungs_datum
FROM DBS_TAB_PRUEFUNG p
JOIN DBS_TAB_LEHRVERANSTALTUNG l ON p.LV_NR = l.LV_NR 
JOIN DBS_TAB_STUDENT s ON p.MATR_NR = s.MATR_NR
JOIN DBS_TAB_MITARBEITER m ON s.PERS_NR = m.PERS_NR;


SELECT * FROM DBS_V_MA_BLOCKEDDATE p;

--      Einf�gen in Views
--      
--      Testen Sie den Einf�gevorgang in der zuvor erstellten View "Fachbereich".
--
--      Frage: Warum ist ein Einf�gen m�glich?
--  	Da Fachbereich tabelle keine Referenzen auf andere Tabellen besitzt und die View nur aus Fachbereich besteht ist einfügen möglich
INSERT INTO dbs_v_fachbereich values(4, 'Cybersec', 508321);
SELECT * FROM DBS_TAB_PROFESSOR;

SELECT * FROM dbs_v_fachbereich;
FB_NR|FB_NAME                  |DEKAN     |
-----+-------------------------+----------+
3    |Elektrotechnik           |508311    |
1    |Wirtschaftswissenschaften|508514    |
2    |Informatik               |508523    |

SELECT * FROM DBS_TAB_FACHBEREICH dtf ;
--
--      Testen Sie den Einfügevorgang in die zuvor erstellte View 
--      �Hochschulangehoeriger�
--
--      Frage: Warum ist ein Einf�gen hier grunds�tzlich nicht m�glich?
--	da z.B. die Mitarbeiter Tabelle auf Hochschulangehörige referenziert und deshalbe die view nicht das erfüllen kann.

SELECT * FROM dbs_v_hochschulangehoeriger;

--
--      �nderung von Datens�tzen in Views
--    
--      �ndern Sie den Namen eines Fachbereichs in der zuvor erstellten 
--      View �Fachbereich�.
--      
--      Frage: Warum ist die �nderung m�glich?
--


--
--     �ndern Sie den Namen eines Hochschulangehoerigen in der zuvor 
--     erstellten View "Hochschulangehoeriger"
--     
--     Frage: Warum sollte diese �nderung grunds�tzlich m�glich sein? 
--     Welcher Grund wird f�r dennoch die Ablehnung angegeben?
--     


--
--     L�schen von Datens�tzen in Views
--  
--     L�schen Sie den zuvor erstellten neuen Fachbereich in der View 
--     "Fachbereich".
--  
--     Frage: Warum ist die L�schung m�glich?
--


--
--     L�schen Sie den Hochschulangehoerigen mit der Nr 1020 in der zuvor 
--     erstellten View "Hochschulangehoeriger"
-- 
--     Frage: Warum sollte diese L�schung grunds�tzlich m�glich sein? 
--     Welcher Grund wird f�r dennoch die Ablehnung angegeben?
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
