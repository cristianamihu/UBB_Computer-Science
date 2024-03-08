USE Orfelinat;
GO


--start version is version 0

--version 1
--Procedura pentru modificarea tipului unei coloane:
CREATE PROCEDURE ModifyTypeOfColumn
AS
BEGIN
	ALTER TABLE Departamente
	ALTER COLUMN numar_angajati SMALLINT;
	PRINT 'S-a modificat tipul coloanei numar_angajati a tabelului Departamente din INT in SMALLINT!';
END;
GO

--Procedura pentru inversarea modificarii tipului coloanei:
CREATE PROCEDURE UndoModifyTypeOfColumn
AS
BEGIN
	ALTER TABLE Departamente
	ALTER COLUMN numar_angajati INT;
	PRINT 'S-a facut UNDO la modificarea tipului coloanei numar_angajati din tabelul Departamente!';
END;
GO



--version 2
--Procedura pentru adaugarea unei constrangeri de "valoare implicita" pentru un camp:
CREATE PROCEDURE AddDefaultConstraint
AS
BEGIN
	ALTER TABLE Vizite
	ADD CONSTRAINT df_durata DEFAULT '00:30:00' FOR durata;
	PRINT 'S-a adaugat o constrangere default in tabelul Vizite, coloana durata!';
END;
GO

--Procedura pentru inversarea adaugarii constrangerii de "valoare implicita" pentru camp, pentru stergerea constrangerii:
CREATE PROCEDURE RemoveDefaultConstraint
AS
BEGIN
	ALTER TABLE Vizite
	DROP CONSTRAINT df_durata;
	PRINT 'S-a sters constrangerea default!';
END;
GO



--version 3
--Procedura pentru crearea unui nou tabel:
CREATE PROCEDURE CreateTable
AS
BEGIN
	CREATE TABLE ProiecteVoluntariat (
		cod_proiect INT PRIMARY KEY,
		nume_proiect VARCHAR(255),
		data_start DATETIME,
		data_finalizare DATETIME,
		coordonator_proiect VARCHAR(255),
		numar_voluntari INT,
		numar_ore_total INT
	);
	PRINT 'S-a creat un nou tabel, ProiecteVoluntariat!';
END;
GO

--Procedura pentru inversarea adaugarii tabelului, stergerea tabelului:
CREATE PROCEDURE RemoveTable
AS
BEGIN
	DROP TABLE ProiecteVoluntariat;
	PRINT 'S-a sters tabelul ProiecteVoluntariat!';
END;
GO



--version 4
--Procedura pentru adaugarea unui camp nou:
CREATE PROCEDURE AddColumn
AS
BEGIN
	ALTER TABLE Activitati
	ADD cod_proiect INT;
	PRINT 'S-a adaugat coloana cod_proiect in tabelul Activitati!';
END;
GO

--Procedura pentru inversarea adaugarii campului, stergerea campului:
CREATE PROCEDURE RemoveColumn
AS
BEGIN
	ALTER TABLE Activitati
	DROP COLUMN cod_proiect;
	PRINT 'S-a sters coloana cod_proiect din tabelul Activitati!';
END;
GO



--version 5
--Procedura pentru adaugarea unei constrangeri de cheie straina:
CREATE PROCEDURE CreateForeignKey
AS
BEGIN
	ALTER TABLE Activitati
	ADD CONSTRAINT fk_ProiecteVoluntariat FOREIGN KEY(cod_proiect) REFERENCES ProiecteVoluntariat(cod_proiect);
	PRINT 'S-a adaugat o cheie straina in tabelul Activitati ce refera tabelul ProiectVoluntariat!';
END;
GO

--Procedura pentru inversarea adaugarii constrangerii de cheie straina, stergerea constrangerii:
CREATE PROCEDURE RemoveForeignKey
AS
BEGIN
	ALTER TABLE Activitati
	DROP CONSTRAINT fk_ProiecteVoluntariat;
	PRINT 'S-a sters constrangerea de cheie straina pentru coloana cod_proiect!';
END;
GO



--Dezvoltarea unui mecanism de versionare care sa faciliteze tranzitia de la o versiune a bazei de date la alta

--Tabela noua ce memoreaza versiunea structurii bazei de date Orfelinat (presupunand ca aceasta versiune este pur si simplu un numar intreg)
CREATE TABLE Version (
  id INT PRIMARY KEY IDENTITY,
  versiune_curenta INT
);

INSERT INTO Version (versiune_curenta) Values (0);
SELECT * FROM Version;
GO



--Procedura stocata ce primeste ca parametru un numar de versiune si aduce baza de date la versiunea respectiva
--Procedura prin care actualizam versiunea
CREATE PROCEDURE UpdateVersion @numar_versiune INT
AS
BEGIN
	UPDATE Version SET versiune_curenta=@numar_versiune WHERE ID=1;
	--se limiteaza actualizarea la randul cu id=1, presupunand ca exista un singur rand in tabelul Version
	PRINT 'S-a actualizat versiunea!';
END;
GO



--Procedura main care va face trecerea de la versiunea actuala la versiunea data ca si parametru
CREATE PROCEDURE Main @numar_versiune INT
AS
BEGIN
	DECLARE @curent_version AS INT; --variabila locala
	SELECT @curent_version=versiune_curenta FROM Version WHERE ID=1; --stocam versiunea curenta
	IF ((@numar_versiune >= 0) AND (@numar_versiune <= 5))
	BEGIN
		IF (@curent_version < @numar_versiune) --se executa pasii de actualizare succesivi pana cand se ajunge la versiunea specificata
		BEGIN
			IF ((@curent_version = 0) AND (@curent_version != @numar_versiune))
			BEGIN
				EXEC ModifyTypeOfColumn;
				EXEC UpdateVersion 1;
				SET @curent_version = 1;
			END;
			IF ((@curent_version = 1) AND (@curent_version != @numar_versiune))
			BEGIN
				EXEC AddDefaultConstraint;
				EXEC UpdateVersion 2;
				SET @curent_version = 2;
			END;
			IF ((@curent_version = 2) AND (@curent_version != @numar_versiune))
			BEGIN
				EXEC CreateTable;
				EXEC UpdateVersion 3;
				SET @curent_version = 3;
			END;
			IF ((@curent_version = 3) AND (@curent_version != @numar_versiune))
			BEGIN
				EXEC AddColumn;
				EXEC UpdateVersion 4;
				SET @curent_version = 4;
			END;
			IF ((@curent_version = 4) AND (@curent_version != @numar_versiune))
			BEGIN
				EXEC CreateForeignKey;
				EXEC UpdateVersion 5;
				SET @curent_version = 5;
			END;
		END;
		ELSE --se executa pasii de degradare succesivi pana cand se ajunge la versiunea specificata
		BEGIN
			IF ((@curent_version = 5) AND (@curent_version != @numar_versiune))
			BEGIN
				EXEC RemoveForeignKey;
				EXEC UpdateVersion 4;
				SET @curent_version = 4;
			END;
			IF ((@curent_version = 4) AND (@curent_version != @numar_versiune))
			BEGIN
				EXEC RemoveColumn;
				EXEC UpdateVersion 3;
				SET @curent_version = 3;
			END;
			IF ((@curent_version = 3) AND (@curent_version != @numar_versiune))
			BEGIN
				EXEC RemoveTable;
				EXEC UpdateVersion 2;
				SET @curent_version = 2;
			END;
			IF ((@curent_version = 2) AND (@curent_version != @numar_versiune))
			BEGIN
				EXEC RemoveDefaultConstraint;
				EXEC UpdateVersion 1;
				SET @curent_version = 1;
			END;
			IF ((@curent_version = 1) AND (@curent_version != @numar_versiune))
			BEGIN
				EXEC UndoModifyTypeOfColumn;
				EXEC UpdateVersion 0;
				SET @curent_version = 0;
			END;
		END;
	END;
	ELSE
	BEGIN
		RAISERROR('Numarul de versiune nu este corect! Versiunea trebuie sa fie un numar intreg intre 0 si 5 inclusiv!', 16, 1);
		RETURN;
	END;
END;
GO

EXEC Main 6;
GO

