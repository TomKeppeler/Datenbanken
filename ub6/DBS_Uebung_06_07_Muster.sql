-- ***************************************************************
-- * File Name:                  dbs_query.sql                   *
-- * File Creator:               Knolle                          *
-- * Revision:                   Bernd Klein                     *
-- * LastDate:                   2020-06-04                      *
-- *                                                             *
-- * <ChangeLogDate>             <ChangeLogText>                 *
-- ***************************************************************
--
-- ***************************************************************
-- * Datenbanksysteme SS 2020
-- * Uebungen 6 und 7 
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
  SELECT   lv_name
  FROM     dbs_tab_lehrveranstaltung
  ;
--
--	Welche Berufe haben die Mitarbeiter und wie hoch ist ihr 
--	Gehalt?
--
  SELECT   beruf, 
           gehalt
  FROM     dbs_tab_mitarbeiter
  ;
--
--	Wie lauten die Daten der Tabelle 'Professor'?
--
  SELECT   *
  FROM     dbs_tab_professor
  ;
--
-- 	1.2	Umbenennen von Spalten
--
--	Die Daten der Tabelle 'Gebaeude' sollen ausgegeben werden, 
-- 	wobei die Spalte 'haus_nr' in 'Hausnummer' umzubenennen ist.
--
  SELECT   gebaeude, 
           strasse, 
           haus_nr AS hausnummer
  FROM     dbs_tab_gebaeude
  ;
--
-- 	1.3	Berechnen bzw. Ableiten von neuen Eigenschaften (Spalten)
--
--	Die Orte sollen mit der Landeskennung '(D)' ausgegeben werden 
--	(kuenstliche Spalte mit konstantem Wert).
--
  SELECT   '(D) ', 
           ort
  FROM     dbs_tab_anschrift
  ;
--
--	Zu jeder Personalnummer soll der Stundenlohn ausgegeben und als 
--	solcher benannt werden (Monat = 20 Tage zu je 8 Stunden).
--
  SELECT   pers_nr, 
           gehalt/20/8 AS stundenlohn
  FROM     dbs_tab_mitarbeiter
  ;
--
--	2	Selektion
--
--	2.1	Ausblenden identischer Zeilen
--
--	In welchen unterschiedlichen Orten leben die 
--	Hochschulangehoerigen?
--
  SELECT   DISTINCT ort
  FROM     dbs_tab_anschrift
  ;
--
--	Zu welchen Zeiten wird in der Woche gelehrt?
--
  SELECT   DISTINCT tag, 
           zeit
  FROM     dbs_tab_lv_ort
  ;
--
--	2.2	Sortierung der Ausgabe
--
--	Die Personalnummern sind aufsteigend nach ihrem zugehoerigen 
--	Gehalt auszugeben.
--
  SELECT   pers_nr, 
           gehalt
  FROM     dbs_tab_mitarbeiter
  ORDER BY gehalt ASC --ist standard und kann somit hier entfallen
  ;
--
--	Die Orte und Strassen sind absteigend sortiert nach Ort und bei 
--	gleichen Orten dann aufsteigend nach Strasse auszugeben.
--
  SELECT   ort, 
           strasse
  FROM     dbs_tab_anschrift
  ORDER BY ort     DESC, 
           strasse ASC
  ;
--
--	2.3	Auswahl bestimmter Tupel (Zeilen, Informationstraeger)
--
--	Welche Gebaeude werden am Montag belegt?
--
  SELECT    gebaeude
  FROM      dbs_tab_lv_ort
  WHERE     tag = 'Mo'
  ;
--
--	Wie lauten die Personalnummern derjenigen Mitarbeiter, die weniger 
--	als 20 € in der Stunde verdienen?
--
  SELECT   pers_nr, 
           gehalt/20/8 AS stundenlohn
  FROM     dbs_tab_mitarbeiter
  WHERE    gehalt/20/8 < 20
  ;
--
--	2.4	Auswahl von Tupeln, die mehreren Bedingungen genuegen
--
--	Es sollen die Nummern der Lehrveranstaltungen ausgegeben 
--	werden, die im Gebaeude 'C' oder freitags abgehalten werden.
--
  SELECT   lv_nr,
           tag,
           gebaeude
  FROM     dbs_tab_lv_ort
  WHERE    tag = 'Fr'
  OR       gebaeude = 'C'
  ;
--
--	Welche Mitarbeiter des Fachbereichs 2 verdienen mehr als 
--	5.000 €?
--
  SELECT   fb_nr, 
           pers_nr,
           gehalt
  FROM     dbs_tab_mitarbeiter
  WHERE    fb_nr = 2
  AND      gehalt > 5000
  ;
--
--	2.5	Vergleich mit einem Muster
--
--	Wie viele Hochschulangehoerige mit einem Namen, der wie 'Meier' 
--	ausgesprochen wird, werden im System verwaltet?
--
  SELECT   ho_name
  FROM     dbs_tab_hochschulangehoeriger
  WHERE    ho_name like 'M__er'
  ;
--
--	Welche unterschiedlichen Vornamen, die mit 'M' beginnen, 
--	existieren im System?
--
  SELECT   DISTINCT vorname
  FROM     dbs_tab_vorname
  WHERE    vorname like 'M%'
  ;
--
--	Welche Fachgebiete von Professoren enthalten das Wort 
--	'system'?
--
  SELECT   fachgebiet
  FROM     dbs_tab_professor
  WHERE    fachgebiet like '%system%'
  OR       fachgebiet like '%System%'
  ;
--
--	2.6	Vergleich mit NULL-Werten
--
--	Gebe die Matrikelnummern solcher Studenten aus, die einen Job 
--	haben?
--
  SELECT   matr_nr
  FROM     dbs_tab_student
  WHERE    pers_nr IS NOT NULL
  ;
--
--	Gebe die Daten der Studenten aus, deren Personalnummer nicht dem Wert 
--	507263 entsprechen.
--
  SELECT   *
  FROM     dbs_tab_Student
  WHERE    pers_nr != 507263
  OR       pers_nr IS NULL
  ;
--
--	3	Verbund von Tabellen
--
--	3.1	Equi-Join
--
--	Gebe eine Liste aller Fachbereichsnamen mit den Namen ihrer 
--	zugehoerigen Lehrveranstaltungen aus.
--
  SELECT   fb_name, 
           lv_name
  FROM     dbs_tab_fachbereich f, 
           dbs_tab_lehrveranstaltung l
  WHERE    f.fb_nr = l.fb_nr
  ;
--
--	neue Syntax:
--
  SELECT   fb_name, 
           lv_name
  FROM	   dbs_tab_fachbereich f INNER JOIN dbs_tab_lehrveranstaltung l
           ON  f.fb_nr = l.fb_nr
  ;
--
--	In welchen unterschiedlichen Strassen finden am Freitag 
--	Lehrveranstaltungen statt?
--
  SELECT   DISTINCT strasse
  FROM	   dbs_tab_lv_ort l, 
           dbs_tab_gebaeude g
  WHERE	   tag = 'Fr'
  AND      l.gebaeude = g.gebaeude
  ;
--
--	neue Syntax:
--
  SELECT   DISTINCT strasse
  FROM	   dbs_tab_lv_ort l INNER JOIN dbs_tab_gebaeude g
           ON  l.gebaeude = g.gebaeude
  WHERE    tag = 'Fr'
  ;
--
--	Welche Studenten arbeiten nicht am Fachbereich, an dem 
--	sie eingeschrieben sind?
--
  SELECT   matr_nr, 
           m.fb_nr, 
           s.fb_nr
  FROM	   dbs_tab_student s,
           dbs_tab_mitarbeiter m
  WHERE	   s.pers_nr = m.pers_nr
  AND		   s.fb_nr != m.fb_nr
  ;
--	
--	neue Syntax:
--
  SELECT   matr_nr, 
           m.fb_nr, 
           s.fb_nr
  FROM	   dbs_tab_student s INNER JOIN dbs_tab_mitarbeiter m
           ON  s.pers_nr = m.pers_nr
  WHERE	   s.fb_nr != m.fb_nr
  ;
--
--	Wie lautet die Adresse des Professors des Fachgebiets 
--	'Mathematik'?
-- 	
  SELECT   ho_name, 
           plz, 
           ort, 
           strasse, 
           haus_nr
  FROM 	   dbs_tab_professor p, 
           dbs_tab_mitarbeiter m, 
           dbs_tab_hochschulangehoeriger h, 
           dbs_tab_anschrift a
  WHERE	   fachgebiet = 'Mathematik'
  AND		   p.pers_nr = m.pers_nr
  AND		   m.ho_nr = h.ho_nr
  AND		   h.ho_nr = a.ho_nr
  ;
--
--	neue Syntax:
--
  SELECT   ho_name, 
           plz, 
           ort, 
           strasse, 
           haus_nr
  FROM     (((dbs_tab_professor p INNER JOIN dbs_tab_mitarbeiter m
           ON  p.pers_nr = m.pers_nr) INNER JOIN dbs_tab_hochschulangehoeriger h
             ON  m.ho_nr = h.ho_nr) INNER JOIN dbs_tab_anschrift a
               ON  h.ho_nr = a.ho_nr)
  WHERE    fachgebiet = 'Mathematik'
  ;
--
--	3.2	Equi-Join mit NULL-Werten (Outer Equi-Join)
--
--	In welchen Institutionen arbeiten Studenten. Zeige auch solche 
--	Studenten an, die nicht arbeiten.
--
--	spezielle Oracle Syntax (+):
--
  SELECT   matr_nr,
           institution
  FROM     dbs_tab_student s,
           dbs_tab_mitarbeiter m
  WHERE	   s.pers_nr = m.pers_nr (+)
  ;
--
--	neue Syntax:
--
  SELECT   matr_nr, 
           institution
  FROM	   dbs_tab_student s LEFT OUTER JOIN dbs_tab_mitarbeiter m
           ON  s.pers_nr = m.pers_nr
  ;
--
--	3.3	Theta-Join
--
--	Gebe eine Namensliste mit Spielpaarungen aus, in der die 
--	Personalnummer des ersten Spielers groesser ist als die des 
--	zweiten Spielers wobei alle Personalnummern groesser 
-- 	als 508000 sein sollen.
--
  SELECT   g.pers_nr, 
           gg.ho_name,
		   k.pers_nr, 
           kk.ho_name
  FROM	   dbs_tab_mitarbeiter g,
           dbs_tab_hochschulangehoeriger gg,
           dbs_tab_mitarbeiter k,
           dbs_tab_hochschulangehoeriger kk
  WHERE    g.pers_nr > k.pers_nr
  AND      g.ho_nr = gg.ho_nr
  AND      k.ho_nr = kk.ho_nr
--  AND      g.pers_nr > 508000 --nicht erforderlich
  AND      k.pers_nr > 508000
  ;
--
--	neue Syntax:
--
  SELECT   g.pers_nr, 
           gg.ho_name, 
           k.pers_nr, 
           kk.ho_name
  FROM     (((dbs_tab_mitarbeiter g INNER JOIN dbs_tab_hochschulangehoeriger gg
           ON  g.ho_nr = gg.ho_nr) INNER JOIN dbs_tab_mitarbeiter k
             ON  g.pers_nr > k.pers_nr) INNER JOIN dbs_tab_hochschulangehoeriger kk
               ON  k.ho_nr = kk.ho_nr)
  WHERE	   g.pers_nr > 508000 --könnte entfallen
  AND      k.pers_nr > 508000
  ;
  --
  -- weitere mgl. Alternative
  --
  
   SELECT  g.pers_nr, 
           gg.ho_name, 
           k.pers_nr, 
           kk.ho_name
  FROM     (dbs_tab_mitarbeiter g INNER JOIN dbs_tab_hochschulangehoeriger gg
                                  ON  g.ho_nr = gg.ho_nr) 
           INNER JOIN 
           (dbs_tab_mitarbeiter k INNER JOIN dbs_tab_hochschulangehoeriger kk
                                  ON  k.ho_nr = kk.ho_nr)
           ON  g.pers_nr > k.pers_nr
  WHERE	   g.pers_nr > 508000
  AND      k.pers_nr > 508000
  ;
--
--	4	Mengenoperationen
--
--	4.1	Vereinigung von Tabellen
--
--	Wie lautet die Menge der Personalnummer, die Professoren oder 
--	Studenten gehoeren?
--
  SELECT   pers_nr, 
           'Professor'
  FROM	   dbs_tab_professor
    UNION
  SELECT   pers_nr, 
           'Student'
  FROM	   dbs_tab_student
  WHERE    pers_nr IS NOT NULL
  ;
--
--	4.2	Schneiden von Tabellen
--
--	Finde die Personalnummern der Mitarbeiter heraus, die Professor 
--	sind und mehr als 5.200 € verdienen.
--
  SELECT   pers_nr
  FROM	   dbs_tab_mitarbeiter
  WHERE	   gehalt > 5000
  	INTERSECT
  SELECT   pers_nr
  FROM	   dbs_tab_professor
  ;
--
--	... auch formulierbar als join:
--
  SELECT   m.pers_nr
  FROM	   dbs_tab_mitarbeiter m,
           dbs_tab_professor p
  WHERE	   m.pers_nr = p.pers_nr
  AND		   gehalt > 5000
  ;
--
--	4.3	Differenz von Tabellen
--
--	Wie lauten die Personalnummern solcher Mitarbeiter, die nicht 
--	Student sind?
--
  SELECT   pers_nr
  FROM	   dbs_tab_mitarbeiter
  	MINUS
  SELECT   pers_nr
  FROM	   dbs_tab_student
  ;
--
--	5	Aggregatfunktionen
--
--	5.1	Vollstaendige Verdichtung
--
--	Wieviele Mitarbeiter sind bisher erfasst?
--	
  SELECT   COUNT(*)
  FROM	   dbs_tab_mitarbeiter
  ;
--
--	Wie lautet das hoechste, das niedrigste und das 
--	durchschnittliche Gehalt sowie die Summe der Gehaelter der 
--	Mitarbeiter?
--
  SELECT   MIN(gehalt), 
           MAX(gehalt), 
           AVG(gehalt),
           SUM(gehalt)
  FROM	   dbs_tab_mitarbeiter
 ;
--
--	5.2	Gruppierung von Verdichtungen
--
--	Wie lauten die Durchschnittsgehaelter der Mitarbeiter 
--	fuer jeden Fachbereiche?
--
  SELECT   fb_name, 
           AVG(gehalt)
  FROM	   dbs_tab_mitarbeiter m,
           dbs_tab_fachbereich f
  WHERE	   m.fb_nr = f.fb_nr
  GROUP BY fb_name
  ;
--
--	Wie lauten die Durchschnittsgehaelter der Mitarbeiter 
--	fuer jeden Fachbereiche, wenn diese ueber 5.000 € liegen?
--
  SELECT   fb_name, 
           AVG(gehalt)
  FROM	   dbs_tab_mitarbeiter m,
           dbs_tab_fachbereich f
  WHERE    m.fb_nr = f.fb_nr
  having   AVG(gehalt) > 5000
  GROUP BY fb_name
  ;
--
--	6	Unterabfragen
--
--	6.1	'IN'-Operator
--
--	Wie lauten die Namen der Mitarbeiter, 
--  die andere Anschrift(en) als Bonn haben?
--
 
  SELECT   h.ho_name, 
           'hat andere Anschrift(en) als Bonn' as "notBonn"
  FROM	   dbs_tab_hochschulangehoeriger h
  WHERE	   h.ho_nr IN ( SELECT   a.ho_nr
                        FROM     dbs_tab_anschrift a
                        WHERE    a.ort != 'Bonn'
                      )
  ;
  
--
--	... auch allgemeiner formulierbar als Join:
--	...aber.....
--  
--  ... man kann in der (aeusseren) Projektion lediglich Spaltenwerte 
--  projizieren, die in den (aeusseren) FROM-Tabellen enthalten sind, 
--  daher funktioniert die folgende Anfrage nicht:
--
  SELECT   h.ho_name, 
           a.ort
  FROM	   dbs_tab_hochschulangehoeriger h
  WHERE	   h.ho_nr IN ( SELECT   a.ho_nr
                        FROM     dbs_tab_anschrift a
                        WHERE    a.ort != 'Bonn'
                      )
  ;
--
--	... eine korrekte Formulierung als Join wäre:
--
  SELECT   ho_name, 
           a.ort
  FROM	   dbs_tab_hochschulangehoeriger h,
           dbs_tab_anschrift a
  WHERE	   a.ort != 'Bonn'
  AND      a.ho_nr = h.ho_nr
  ;
 
--
--	6.2	Vergleichsoperatoren
--
--	Welcher (!) Hochschulangehoerige wohnt im Auerweg?
--	Achtung: warum "darf" bei "=" in dieser Anfrage nur eine  
--	Person im Auerweg wohnen?
--
  SELECT   h.ho_name,
           'Auerweg'
  FROM	   dbs_tab_hochschulangehoeriger h
  WHERE	   h.ho_nr = ( SELECT   a.ho_nr
                       FROM     dbs_tab_anschrift a
                       WHERE    a.strasse = 'Auerweg'
                     )
  ;
--
--	... auch allgemeiner formulierbar als Join:
--	...aber.....
--
--  ... man kann in der (aeusseren) Projektion lediglich Spaltenwerte 
--  projezieren, die in den (aeusseren) FROM-Tabellen enthalten sind, 
--  daher funktioniert die folgende Anfrage nicht:
--
  SELECT   h.ho_name,
           a.strasse
  FROM 	   dbs_tab_hochschulangehoeriger h
  WHERE	   h.ho_nr = ( SELECT   a.ho_nr
                       FROM     dbs_tab_anschrift a
                       WHERE    a.strasse = 'Auerweg'
                     )
 ;
--
--	... eine korrekte Formulierung als Join wäre (hier dürfen jedoch auch 
--	mehrere Personen im Auerweg wohnen):
--
  SELECT   ho_name, 
           a.strasse
  FROM	   dbs_tab_hochschulangehoeriger h,
           dbs_tab_anschrift a
  WHERE	   a.strasse = 'Auerweg'
  AND      a.ho_nr = h.ho_nr
  ;

--
--	Wie lauten die Namen der Studenten, die zeitlich spaeter 
--	(mit groesserer ho_nr) als Meyer erfasst worden sind ?
--
  SELECT   s.ho_name, 
           s.ho_nr
  FROM	   dbs_tab_hochschulangehoeriger s
  WHERE	   s.ho_nr >  ( SELECT	 f.ho_nr
                        FROM     dbs_tab_hochschulangehoeriger f 
                        WHERE    f.ho_name = 'Meyer'
                      )
  AND      s.ho_nr in ( SELECT   st.ho_nr
                        FROM     dbs_tab_student st
                      )
  ;
--					
--	6.3	Existenzabfragen
--
--	Welche Fachbereiche bieten keine Lehrveranstaltungen an?
--
  SELECT   fb_name
  FROM	   dbs_tab_fachbereich f
  WHERE	   NOT EXISTS ( SELECT   *
                        FROM     dbs_tab_lehrveranstaltung l
                        WHERE    f.fb_nr = l.fb_nr
                      )
  ;
--
--	Welche Professoren (Personalnummer) halten 
--	Lehrveranstaltungen(mindestens eine)?
--
  SELECT   pers_nr
  FROM	   dbs_tab_professor p
  WHERE	   EXISTS ( SELECT   *
                    FROM     dbs_tab_prof_haelt_lv h
                    WHERE    h.pers_nr = p.pers_nr
                  )
  ;
--
--	6.4	All-Operator
--
--	Welche Mitarbeiter erhalten das groesste Gehalt?
--
  SELECT   ho_name, 
           gehalt
  FROM	   dbs_tab_hochschulangehoeriger g,
           dbs_tab_mitarbeiter gg
  WHERE	   gg.gehalt >= all ( SELECT   kk.gehalt
                              FROM     dbs_tab_mitarbeiter kk
                            )
  AND      g.ho_nr = gg.ho_nr
  ;
--
--	Welche Mitarbeiter verdienen weniger als andere?
--
  SELECT   w.ho_name, 
           ww.gehalt
  FROM	   dbs_tab_hochschulangehoeriger w,
           dbs_tab_mitarbeiter ww
  WHERE	   ww.gehalt < ANY ( SELECT   mm.gehalt
                             FROM     dbs_tab_mitarbeiter mm
                           )
  AND      w.ho_nr = ww.ho_nr
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