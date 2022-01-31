-- ***************************************************************
-- * File Name:                  dbs_extern.sql                  *
-- * File Creator:               Knolle                          *
-- * CreationDate:               16. Januar 2022                 *
-- *                                                             *
-- * <ChangeLogDate>             <ChangeLogText>                 *
-- ***************************************************************
--
-- ***************************************************************
-- * Datenbanksysteme WS 2021/22
-- * Uebungen 9 
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
FROM          
;

--
--      Erstellen Sie die folgenden Sichten:
--
--      Virtuelle Tabelle „Fachbereich“ mit allen Spalten der 
--      korrespondierenden Tabelle der konzeptionellen Ebene 
--      (Beispiel einer sehr einfachen View, die exakt der zugrunde 
--      liegenden Tabelle entspricht).
--      
CREATE OR 
REPLACE VIEW  dbs_view_fachbereich
AS SELECT     fb_nr, fb_name, dekan
FROM          dbs_tab_fachbereich
;

DESCRIBE      dbs_view_fachbereich

SELECT	      *
FROM          dbs_view_fachbereich
;


--      
--      Virtuelle Tabelle „Fachbereich hat Dekan“. Die View soll 
--      nur die Spalten Name des Fachbereichs und Name des Dekans 
--      enthalten.
--      
CREATE OR 
REPLACE VIEW  dbs_view_fb_hat_dekan
AS SELECT     fb_name, ho_name as dekan
FROM          dbs_tab_fachbereich f, 
              dbs_tab_mitarbeiter m, 
              dbs_tab_hochschulangehoeriger h
WHERE         f.dekan = m.pers_nr
AND           m.ho_nr = h.ho_nr
;

DESCRIBE      dbs_view_fb_hat_dekan

SELECT	      *
FROM          dbs_view_fb_hat_dekan
;

--      
--      Virtuelle Tabelle „Fachbereich beschaeftigt Mitarbeiter“. 
--      Die View soll nur die Spalten Name des Fachbereichs und 
--      Name des Mitarbeiters enthalten und standardmaeßig nach 
--      dem Namen des Fachbereichs und bei Gleichheit nach dem 
--      Namen des Mitarbeiters sortiert werden.
      
CREATE OR 
REPLACE VIEW  dbs_view_fb_beschaeftigt_ma
AS SELECT     fb_name, ho_name
FROM          dbs_tab_fachbereich f, 
              dbs_tab_mitarbeiter m,
              dbs_tab_hochschulangehoeriger h
WHERE         f.fb_nr = m.fb_nr
AND           m.ho_nr = h.ho_nr
ORDER BY      fb_name ASC, ho_name ASC
;

DESCRIBE dbs_view_fb_beschaeftigt_ma;

SELECT *
FROM dbs_view_fb_beschaeftigt_ma;

--      
--      Virtuelle Tabelle „Fachberteich bietet lehrveranstaltung“. 
--      Die View soll lediglich den Namen des Fachbereichs und den 
--      Namen der Lehrveranstaltung enthalten und nach dem Namen 
--      des Fachbereichs sowie  bei Gleichheit nach dem Namen der 
--      Lehrveranstaltung sortiert werden.
--      
CREATE OR
REPLACE VIEW  dbs_view_fb_bietet_lv
AS SELECT     fb_name, lv_name
FROM          dbs_tab_fachbereich f, 
              dbs_tab_lehrveranstaltung lv
WHERE         f.fb_nr = lv.fb_nr
ORDER BY      fb_name ASC, lv_name ASC
;

DESCRIBE      dbs_view_fb_bietet_lv

SELECT        *
FROM          dbs_view_fb_bietet_lv
;


--      
--      Virtuelle Tabelle Lehrveranstaltungen des Fachbereichs 
--      Informatik“. Nutzen Sie zur Erstellung dieser View die zuvor 
--      erstellte View „Fachbereich bietet Lehrveranstaltung“.
--      
CREATE OR
REPLACE VIEW  dbs_view_fb_inf_bietet_lv
AS SELECT     *
FROM          dbs_view_fb_bietet_lv
WHERE         fb_name = 'Informatik'
;

DESCRIBE      dbs_view_fb_inf_bietet_lv

SELECT        *
FROM          dbs_view_fb_inf_bietet_lv
;


--      
--      Virtuelle Tabelle „Hochschulangehoeriger“. Die View soll 
--      lediglich die relevanten und objektidentifizierenden Spalten 
--      des semantisch ausdrucksstarken Objekts „Hochschulangehoeriger“ 
--      enthalten (also nicht die Spalten an_nr und vo_nr). Die View 
--      soll standardmaeßig nach dem Namen des Hochschulangehoerigen 
--      sortiert werden.
--      
--      Frage: Warum ist dieses Sortierkriterium nicht immer 
--      hilfreich?
--      Frage: Warum tauchen einige der Hochschulangehoerigen 
--      offenbar mehrfach auf? 
--      
CREATE OR 
REPLACE VIEW  dbs_view_hochschulangehoeriger
AS SELECT     h.ho_nr, vorname, ho_name,
			  plz, ort, strasse, haus_nr
FROM          dbs_tab_hochschulangehoeriger h, 
              dbs_tab_vorname v, 
              dbs_tab_anschrift a
WHERE         h.ho_nr = v.ho_nr
AND           h.ho_nr = a.ho_nr
ORDER BY      ho_name
;

DESCRIBE      dbs_view_hochschulangehoeriger

SELECT        *
FROM          dbs_view_hochschulangehoeriger
ORDER BY      ho_name ASC, vorname ASC, ort ASC
;

--neue Syntax:
CREATE OR 
REPLACE VIEW  dbs_view_hochschulangehoeriger
AS SELECT     ho_nr, vorname, ho_name,
			  plz, ort, strasse, haus_nr
FROM          dbs_tab_hochschulangehoeriger h
natural join  dbs_tab_vorname v
natural join  dbs_tab_anschrift a
ORDER BY      ho_name
;

DESCRIBE      dbs_view_hochschulangehoeriger;

SELECT        *
FROM          dbs_view_hochschulangehoeriger
ORDER BY      ho_name ASC, vorname ASC, ort ASC
;


--      
--      Virtuelle Tabelle „Mitarbeiter“. Die View soll lediglich 
--      die relevanten und objektidentifizierenden Spalten des 
--      semantisch ausdrucksstarken Objekts „Mitarbeiter“ sowie 
--      den Namen des Fachbereichs wo dieser angestellt ist, enthalten. 
--      Bitte lassen Sie Spalte Gehalt weg. Die View soll standardmaeßig 
--      nach dem Namen des Fachbereichs und bei Gleichheit, nach dem 
--      Namen des Mitarbeiters sortiert werden.
--  
--      Frage: Warum wäre ein zweites Sortierkriterium nach der 
--      Personalnummer hilfreicher?
--      
CREATE OR 
REPLACE VIEW  dbs_view_mitarbeiter
AS SELECT     pers_nr, vorname, ho_name, ort,
			  strasse, haus_nr, fb_name,
			  beruf, institution
FROM          dbs_tab_mitarbeiter m, 
              dbs_tab_hochschulangehoeriger h, 
              dbs_tab_vorname v, 
              dbs_tab_anschrift a,
              dbs_tab_fachbereich f
WHERE         h.ho_nr = v.ho_nr
AND           h.ho_nr = a.ho_nr
AND           h.ho_nr = m.ho_nr
AND           m.fb_nr = f.fb_nr
ORDER BY      fb_name ASC, h.ho_name ASC
;

DESCRIBE      dbs_view_mitarbeiter

SELECT        *
FROM          dbs_view_mitarbeiter
;

--neue Syntax:
CREATE OR 
REPLACE VIEW  dbs_view_mitarbeiter
AS SELECT     pers_nr, vorname, ho_name, ort,
			  strasse, haus_nr, fb_name,
			  beruf, institution
FROM          dbs_tab_mitarbeiter m
natural join  dbs_tab_hochschulangehoeriger h
natural join  dbs_tab_vorname v
natural join  dbs_tab_anschrift a
natural join  dbs_tab_fachbereich f
ORDER BY      fb_name ASC, h.ho_name ASC
;

DESCRIBE      dbs_view_mitarbeiter

SELECT        *
FROM          dbs_view_mitarbeiter
;


--      
--      Virtuelle Tabelle „Professor“. Die View soll lediglich 
--      die relevanten und objektidentifizierenden Spalten des 
--      semantisch ausdrucksstarken Objekts „Professor“ sowie 
--      den Namen des Fachbereichs wo dieser angestellt ist, enthalten. 
--      Bitte lassen Sie Spalte Gehalt weg. Die View soll standardmaeßig 
--      nach dem Namen des Fachbereichs und bei Gleichheit, nach der 
--      Personalnummer des Professors sortiert werden.
--      
--      Frage: Kann man zur Erstellung dieser View auf die zuvor 
--      erstellte View „Mitarbeiter“ zurueckgreifen?
--      
CREATE OR 
REPLACE VIEW  dbs_view_professor
AS SELECT     p.pers_nr, titel, vorname,
			  ho_name, ort, strasse, haus_nr,
			  fb_name, fachgebiet, beruf, institution 
FROM          dbs_tab_mitarbeiter m, 
              dbs_tab_hochschulangehoeriger h, 
              dbs_tab_vorname v, 
              dbs_tab_anschrift a,
              dbs_tab_fachbereich f,
              dbs_tab_professor p
WHERE         h.ho_nr = v.ho_nr
AND           h.ho_nr = a.ho_nr
AND           h.ho_nr = m.ho_nr
AND           m.fb_nr = f.fb_nr
AND           p.pers_nr = m.pers_nr
ORDER BY      fb_name ASC, p.pers_nr ASC
;

DESCRIBE      dbs_view_professor

SELECT        *
FROM          dbs_view_professor
;

--mittels view mitarbeiter
CREATE OR 
REPLACE VIEW  dbs_view_professor
AS SELECT     p.pers_nr, titel, vorname,
			  ho_name, ort, strasse,
			  haus_nr, fb_name, fachgebiet,
			  beruf, institution 
FROM          dbs_view_mitarbeiter m, 
              dbs_tab_professor p
WHERE         p.pers_nr = m.pers_nr
ORDER BY      fb_name ASC, p.pers_nr ASC
;

DESCRIBE      dbs_view_professor

SELECT        *
FROM          dbs_view_professor
;

--neue Syntax:

CREATE OR 
REPLACE VIEW  dbs_view_professor
AS SELECT     pers_nr,vorname, ho_name, titel,
			  ort, strasse, haus_nr,
			  fb_name, fachgebiet, beruf, institution 
FROM          dbs_tab_mitarbeiter m
natural join  dbs_tab_hochschulangehoeriger h
natural join  dbs_tab_vorname v
natural join  dbs_tab_anschrift a
natural join  dbs_tab_fachbereich f
natural join  dbs_tab_professor p
ORDER BY      fb_name ASC, pers_nr ASC
;

DESCRIBE      dbs_view_professor

SELECT        *
FROM          dbs_view_professor
;

--mittels view mitarbeiter
CREATE OR 
REPLACE VIEW  dbs_view_professor
AS SELECT     pers_nr, vorname, ho_name,
              titel, ort, strasse,
              haus_nr, fb_name, fachgebiet,
			  beruf, institution 
FROM          dbs_view_mitarbeiter m
natural join  dbs_tab_professor p
ORDER BY      fb_name ASC, pers_nr ASC
;

DESCRIBE      dbs_view_professor

SELECT        *
FROM          dbs_view_professor
;

--      
--      Virtuelle Tabelle „Student“. Die View soll lediglich die relevanten 
--      und objektidentifizierenden Spalten des semantisch ausdrucksstarken 
--      Objekts „Student“ sowie den Namen des Fachbereichs, wo dieser 
--      immatrikuliert ist, enthalten. Bitte lassen Sie Spalte Personalnummer 
--      weg. Die View soll standardmaeßig nach dem Namen des Fachbereichs und 
--      bei Gleichheit, nach der Matrikelnummer des Studenten sortiert werden.
--      
CREATE OR 
REPLACE VIEW  dbs_view_student
AS SELECT     matr_nr, vorname, ho_name,
			  ort, strasse, haus_nr, fb_name  
FROM          dbs_tab_hochschulangehoeriger h, 
              dbs_tab_vorname v, 
              dbs_tab_anschrift a,
              dbs_tab_fachbereich f,
              dbs_tab_student s
WHERE         h.ho_nr = v.ho_nr
AND           h.ho_nr = a.ho_nr
AND           h.ho_nr = s.ho_nr
AND           s.fb_nr = f.fb_nr
ORDER BY      fb_name ASC, s.matr_nr ASC
;

DESCRIBE      dbs_view_student

SELECT        *
FROM          dbs_view_student
;

--neue Syntax:
CREATE OR 
REPLACE VIEW  dbs_view_student
AS SELECT     matr_nr, vorname, ho_name,
			  ort, strasse, haus_nr, fb_name  
FROM          dbs_tab_hochschulangehoeriger h
natural join  dbs_tab_vorname v
natural join  dbs_tab_anschrift a
natural join  dbs_tab_fachbereich f
natural join  dbs_tab_student s
ORDER BY      fb_name ASC, s.matr_nr ASC
;

DESCRIBE      dbs_view_student

SELECT        *
FROM          dbs_view_student
;


--      
--      Virtuelle Tabelle „Studentischer Mitarbeiter“. Die View soll lediglich 
--      die relevanten und objektidentifizierenden Spalten des semantisch 
--      ausdrucksstarken Objekts „Student“ sowie den Namen des Fachbereichs, 
--      wo dieser angestellt ist und den Namen des Fachbereichs, wo dieser 
--      immatrikuliert ist, enthalten. Bitte lassen Sie Spalten Matrikelnummer 
--      und Gehalt weg. Die View soll standardmaeßig nach dem Namen des 
--      Fachbereichs der Mitarbeit und bei Gleichheit, nach der Personalnummer 
--      des Studenten sortiert werden.

--      Frage: Kann man zur Erstellung dieser View auf die zuvor erstellte 
--      View „Mitarbeiter“ und / oder „Student“ zurueckgreifen?
--      
CREATE OR 
REPLACE VIEW  dbs_view_stud_mitarbeiter
AS SELECT     s.pers_nr, vorname, ho_name,
			  ort, strasse, haus_nr,
			  mitarb.fb_name AS arbeitet,
			  beruf, institution,
			  stud.fb_name AS studiert 
FROM          dbs_tab_mitarbeiter m, 
              dbs_tab_hochschulangehoeriger h, 
              dbs_tab_vorname v, 
              dbs_tab_anschrift a,
              dbs_tab_fachbereich stud,
              dbs_tab_fachbereich mitarb,
              dbs_tab_student s
WHERE         h.ho_nr = v.ho_nr
AND           h.ho_nr = a.ho_nr
AND           h.ho_nr = m.ho_nr
AND           m.fb_nr = mitarb.fb_nr
AND           s.fb_nr = stud.fb_nr
AND           s.pers_nr = m.pers_nr
ORDER BY      mitarb.fb_name ASC, s.matr_nr ASC
;

DESCRIBE      dbs_view_stud_mitarbeiter

SELECT        *
FROM          dbs_view_stud_mitarbeiter
;


CREATE OR 
REPLACE VIEW  dbs_view_stud_mitarbeiter
AS SELECT     s.pers_nr, vorname, ho_name,
			  ort, strasse, haus_nr,
			  mitarb.fb_name AS arbeitet,
			  beruf, institution,
			  stud.fb_name AS studiert 
FROM          dbs_view_mitarbeiter mitarb, 
              dbs_tab_fachbereich stud,
              dbs_tab_student s
WHERE         s.fb_nr = stud.fb_nr
AND           s.pers_nr = mitarb.pers_nr
ORDER BY      mitarb.fb_name ASC, s.matr_nr ASC
;

DESCRIBE      dbs_view_stud_mitarbeiter

SELECT        *
FROM          dbs_view_stud_mitarbeiter
;


--      
--      Virtuelle Tabelle „Professor haelt Lehrveranstaltung“. Die View 
--      soll lediglich Titel und Name des Professors und den Namen 
--      der Lehrveranstaltung enthalten. Die View soll nach der Nummer des 
--      Hochschulangehoerigen sortiert werden (auch wenn diese nicht 
--      Bestandteil der View ist).
--      
--      Frage: Warum ist an dieser Stelle ein „distinct“ hilfreich?
--      
CREATE OR 
REPLACE VIEW  dbs_view_prof_haelt_lv
AS SELECT     distinct titel, ho_name, lv_name
FROM          dbs_tab_hochschulangehoeriger h,
              dbs_tab_mitarbeiter m,
              dbs_tab_professor p, 
              dbs_tab_prof_haelt_lv plv,
              dbs_tab_lv_ort lvo,              
              dbs_tab_lehrveranstaltung l
WHERE         h.ho_nr = m.ho_nr
AND           m.pers_nr = p.pers_nr
AND           p.pers_nr = plv.pers_nr
AND           plv.lv_nr = lvo.lv_nr
AND           plv.zeit = lvo.zeit
AND           plv.tag = lvo.tag
AND           lvo.lv_nr = l.lv_nr
ORDER BY      h.ho_name
;

DESCRIBE      dbs_view_prof_haelt_lv

SELECT        *
FROM          dbs_view_prof_haelt_lv
ORDER BY      ho_name, lv_name
;


--	
--      Virtuelle Tabelle „Pruefungen“. Die View soll lediglich
--	    die relevanten und objekt-identifizierenden Spalten des
--	    semantisch ausdrucksstarken Objekts „Pruefungen“ enthalten.
--	    Die View soll namentlich: Lehrveranstaltung, Professor und
--	    Student mit Name und erstem Vornamen in einer Spalte,
--	    in der Form: "Name, ersterVorname"
--	    (Bsp. Konkatenation: name || ´,´ || vorname), sowie die
--	    Note enthalten. Standardmäßig aufsteigend sortiert nach
--	    Lehrveranstaltung und Professor, absteigend nach Student
--	    und aufsteigend nach Note.
--
--      Frage: Wie lösen Sie das Problem, dass der ho_name sowohl für 
--      Professoren als auch für Studenten benötigt wird? In wie fern 
--      ist hierbei distinct zu verwenden, bzw. welche Gefahr besteht durch 
--      die Verwendung.
--      
CREATE OR 
REPLACE VIEW    dbs_view_pruefung
AS select       l.lv_name, h.ho_name as Professor,
                hs.ho_name || ', ' || v.vorname as Studierender,
                note
from 		dbs_tab_pruefung pru
inner join dbs_tab_lehrveranstaltung        l   on l.lv_nr      =pru.lv_nr
inner join dbs_tab_professor                pro on pro.pers_nr  =pru.professor
inner join dbs_tab_mitarbeiter              m   on m.pers_nr    =pro.pers_nr
inner join dbs_tab_hochschulangehoeriger    h   on h.ho_nr      =m.ho_nr
inner join dbs_tab_student                  s   on s.matr_nr    =pru.matr_nr
inner join dbs_tab_hochschulangehoeriger    hs  on hs.ho_nr     =s.ho_nr
inner join dbs_tab_vorname                  v   on v.ho_nr      =hs.ho_nr
where vo_nr=1
order by lv_name, h.ho_name, (hs.ho_name || ', ' || v.vorname) desc, note
;
 
DESCRIBE      dbs_view_pruefung
;

SELECT        *
FROM          dbs_view_pruefung
;


--
--      Virtuelle Tabelle „MA_BlockedDate“ mit dem Namen und erstem Vornamen
--      (wie oben), der Personalnummer, sowie den Namen der Lehrveranstaltung 
--      bei der sich der Mitarbeiter für eine Prüfung angemeldet hat. Ergänzen 
--      Sie um eine leere Spalte: "vorauss. Prüfungs-Datum", um im möglichen 
--      Ausdruck ein Datum von Hand eintragen zu können. Die Sicht zeigt die 
--      möglicherweise durch Prüfung geblockten Termine von studentischen 
--      Hilfskräften.
--      
CREATE OR REPLACE
VIEW	 	dbs_view_ma_blockedDate 
AS SELECT h.ho_name, v.vorname, m.pers_nr, lv_name, ' ' AS "vorauss. Prüfungs-Datum"
FROM      dbs_tab_student s
        , dbs_tab_mitarbeiter m
        , dbs_tab_hochschulangehoeriger h
        , dbs_tab_vorname v
        , dbs_tab_pruefung Pru
        , dbs_tab_lehrveranstaltung l
        WHERE s.pers_nr = m.pers_nr
        AND m.ho_nr = h.ho_nr
        AND v.ho_nr = h.ho_nr
        AND s.matr_nr = Pru.matr_nr
        and pru.lv_nr = l.lv_nr
        AND vo_nr = 1
        AND pru.datum IS NULL
;

DESCRIBE      dbs_view_ma_blockeddate

SELECT	      *
FROM          dbs_view_ma_blockedDate
;

--neue Syntax:

CREATE OR REPLACE VIEW dbs_view_ma_blockedDate
AS SELECT ho_name, vorname, pers_nr, lv_name, ' ' AS "vorauss. Prüfungs-Datum"
FROM dbs_tab_hochschulangehoeriger h
NATURAL JOIN dbs_tab_vorname v
NATURAL JOIN dbs_tab_mitarbeiter m
NATURAL JOIN dbs_tab_lehrveranstaltung l
NATURAL JOIN dbs_tab_pruefung p
NATURAL JOIN dbs_tab_student s
WHERE vo_nr=1
AND datum IS NULL
;

describe dbs_view_ma_blockedDate
;
select * from dbs_view_ma_blockedDate
;


--      Einfügen in Views
--      
--      Testen Sie den Einfügevorgang in der zuvor erstellten View "Fachbereich".
--
--      Frage: Warum ist ein Einfügen möglich?
--      
INSERT INTO dbs_view_fachbereich
VALUES      (7, 'Wirtschaftsrecht', '509514')
;

SELECT * 
FROM   dbs_view_fachbereich
;

COMMIT
;


--
--      Testen Sie den Einfügevorgang in die zuvor erstellte View 
--      „Hochschulangehoeriger“
--
--      Frage: Warum ist ein Einfügen hier grundsätzlich nicht möglich?
--      
INSERT INTO dbs_view_hochschulangehoeriger
VALUES      (1030, 'Koch', 'Peter', '53111', 'Bonn', 'Bergstraße', '18')
;

describe dbs_view_hochschulangehoeriger
;

--
--      Änderung von Datensätzen in Views
--    
--      Ändern Sie den Namen eines Fachbereichs in der zuvor erstellten 
--      View „Fachbereich“.
--      
--      Frage: Warum ist die Änderung möglich?
--      
UPDATE dbs_view_fachbereich
SET    fb_name = 'Maschinenbau'
where  fb_nr = 7
;

SELECT * 
FROM   dbs_view_fachbereich
;

COMMIT
;


--
--     Ändern Sie den Namen eines Hochschulangehoerigen in der zuvor 
--     erstellten View "Hochschulangehoeriger"
--     
--     Frage: Warum sollte diese Änderung grundsätzlich möglich sein? 
--     Welcher Grund wird für dennoch die Ablehnung angegeben?
--     
UPDATE dbs_view_hochschulangehoeriger
SET    ho_name = 'Koch'
where  ho_nr = 1020
;


--
--     Löschen von Datensätzen in Views
--  
--     Löschen Sie den zuvor erstellten neuen Fachbereich in der View 
--     "Fachbereich".
--  
--     Frage: Warum ist die Löschung möglich?
--
DELETE 
FROM   dbs_view_fachbereich
WHERE  fb_nr = 7
;

COMMIT
;


--
--     Löschen Sie den Hochschulangehoerigen mit der Nr 1020 in der zuvor 
--     erstellten View "Hochschulangehoeriger"
-- 
--     Frage: Warum sollte diese Löschung grundsätzlich möglich sein? 
--     Welcher Grund wird für dennoch die Ablehnung angegeben?
--     
DELETE 
FROM   dbs_view_hochschulangehoeriger
WHERE  ho_name = 'Neumann'
;

--
-- Systemdatum
--
  SELECT user,
         TO_CHAR(SYSDATE, 'dd-mm-yy hh24:mi:ss') 
  FROM   dual
  ;  
--
spool off
