DROP TABLE buchen CASCADE CONSTRAINTS;
DROP TABLE MITARBEITER CASCADE CONSTRAINTS;
DROP TABLE Kunde CASCADE CONSTRAINTS;
DROP TABLE ZIMMER CASCADE CONSTRAINTS;

CREATE TABLE Mitarbeiter(
Mitarbeiter_id NUMERIC(6),
Vorname varchar(20),
Nachname varchar(20),
Gehalt NUMERIC(8,2),
CONSTRAINT pk_Mitarbeiter_mitarbeiter_id PRIMARY KEY (Mitarbeiter_id),
CONSTRAINT nn_Mitarbeiter_Vorname CHECK(Vorname IS NOT NULL),
CONSTRAINT nn_Mitarbeiter_Nachname CHECK(Nachname IS NOT NULL),
CONSTRAINT nn_Mitarbeiter_Gehalt CHECK(Gehalt IS NOT null)
);

CREATE TABLE Zimmer(
Zimmer_Nr NUMERIC(6),
Groesse NUMERIC(6,2),
Betten NUMERIC(2),
Whirlpool char(1),
CONSTRAINT pk_Zimmer_Zimmer_Nr PRIMARY KEY (Zimmer_Nr),
CONSTRAINT nn_Zimmer_Groesse CHECK(Groesse IS NOT null),
CONSTRAINT nn_Zimmer_Betten CHECK(Betten IS NOT NULL),
CONSTRAINT nn_Zimmer_Whirlpool CHECK(Whirlpool IS NOT null)
);

CREATE TABLE Kunde(
K_ID NUMERIC(6),
Vorname varchar(20),
Nachname varchar(20),
Email varchar(50),
Zahlungsart varchar(20),
CONSTRAINT pk_Kunde_K_ID PRIMARY KEY (K_ID),
CONSTRAINT nn_Kunde_Vorname CHECK(Vorname IS NOT NULL),
CONSTRAINT nn_Kunde_Nachname CHECK(Nachname IS NOT null),
CONSTRAINT nn_Kunde_Email CHECK(Email IS NOT NULL),
CONSTRAINT nn_Kunde_Zahlungsart CHECK(Zahlungsart IS NOT null)
);

CREATE TABLE buchen(
K_ID NUMERIC(6),
Zimmer_ID NUMERIC(6),
Mitarbeiter_ID NUMERIC(6),
CONSTRAINT fk_buchen_K_ID FOREIGN KEY (K_ID) REFERENCES Kunde(K_ID),
CONSTRAINT fk_buchen_Zimmer_ID FOREIGN KEY (Zimmer_ID) REFERENCES Zimmer(Zimmer_Nr),
CONSTRAINT fk_buchen_Mitarbeiter_ID FOREIGN KEY (Mitarbeiter_ID) REFERENCES Mitarbeiter(Mitarbeiter_ID)
);

INSERT INTO Kunde WITH names AS (
(1, 'Test1', 'Musterdude1', 'Test1musterdude1@gmail.com', 'Lastschrift'),
(2, 'Test2', 'Musterdude2', 'Test2musterdude2@gmail.com', 'Lastschrift'),
(3, 'Test3', 'Musterdude3', 'Test3musterdude3@gmail.com', 'Lastschrift'),
(4, 'Test4', 'Musterdude4', 'Test4musterdude4@gmail.com', 'Lastschrift'),
(5, 'Test5', 'Musterdude5', 'Test5musterdude5@gmail.com', 'Lastschrift'),
(6, 'Test6', 'Musterdude6', 'Test6musterdude6@gmail.com', 'Lastschrift'),
(7, 'Test7', 'Musterdude7', 'Test7musterdude7@gmail.com', 'Lastschrift'),
(8, 'Test8', 'Musterdude8', 'Test8musterdude8@gmail.com', 'Lastschrift'),
(9, 'Test9', 'Musterdude9', 'Test9musterdude9@gmail.com', 'Lastschrift'),
(10, 'Test10', 'Musterdude10', 'Test10musterdude10@gmail.com', 'Lastschrift'),
(11, 'Test11', 'Musterdude11', 'Test11musterdude11@gmail.com', 'Lastschrift'),
(12, 'Test11', 'Musterdude12', 'Test11musterdude12@gmail.com', 'Lastschrift')

);


























