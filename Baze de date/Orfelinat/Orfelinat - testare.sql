USE Orfelinat;
GO

INSERT INTO Tables(Name) VALUES ('Vizitatori'), ('Copii'), ('Vizite');
SELECT * FROM Tables;
GO


CREATE OR ALTER VIEW View_1 AS
	SELECT id_vizitator, nume, numar_telefon, relatie_cu_copilul
	FROM Vizitatori
GO

CREATE OR ALTER VIEW View_2 AS
--Extragem toate inregistrarile din tabelul Vizitatori pentru care vizitatorii au numarul de telefon si afisam copiii pe care acestia i-au vizitat
	SELECT V.id_vizitator, V.nume, C.nume AS nume_copil
	FROM Vizitatori V
	LEFT OUTER JOIN Vizite Vz ON V.id_vizitator = Vz.id_vizitator
	LEFT OUTER JOIN Copii C ON Vz.id_dosar_copil = C.id_dosar_copil
	WHERE V.numar_telefon IS NOT NULL;
GO

CREATE OR ALTER VIEW View_3 AS
--Afiseaza numarul total de vizite pentru copiii care au mai mult de o vizita, si vizitatorii lor
	SELECT C.nume AS nume_copil, COUNT(V.id_vizitator) AS numar_vizite, STRING_AGG(VI.nume, ', ') AS vizitatori
	FROM Copii C
	INNER JOIN Vizite V ON C.id_dosar_copil = V.id_dosar_copil
	INNER JOIN Vizitatori VI ON VI.id_vizitator = V.id_vizitator
	GROUP BY C.nume
	HAVING COUNT(V.id_vizitator) > 1;
GO

INSERT INTO Views(Name) VALUES ('View_1'), ('View_2'), ('View_3');
SELECT * FROM Views;
GO


INSERT INTO Tests(Name) VALUES ('delete'), ('insert'), ('select');
SELECT * FROM Tests;

INSERT INTO TestViews(TestID, ViewID)
VALUES (3,1), (3,2), (3,3);

INSERT INTO TestTables(TestID, TableID, NoOfRows, Position)
VALUES (1,1,100,3),(1,2,100,2),(1,3,100,1),(2,1,100,1),(2,2,100,2),(2,3,100,3);
GO


CREATE OR ALTER PROCEDURE insert_1
AS
BEGIN
	DECLARE @NoOFRows int
	DECLARE @id_vizitator int
	DECLARE @nume VARCHAR(255)
	DECLARE @numar_telefon VARCHAR(20)
	DECLARE @relatie_cu_copilul VARCHAR(255)

	SELECT TOP 1 @NoOfRows = NoOfRows 
	FROM dbo.TestTables 
	WHERE TableID = 1 AND TestID = 2

	SET @id_vizitator = 1 
	WHILE @id_vizitator <= @NoOfRows
	BEGIN
		SET @nume ='Nume' + CONVERT(VARCHAR(10), @id_vizitator)
		SET @numar_telefon ='Numar telefon' + CONVERT(VARCHAR(10), @id_vizitator)
		SET @relatie_cu_copilul ='Relatie cu copilul' + CONVERT(VARCHAR(10), @id_vizitator)

		INSERT INTO Vizitatori(id_vizitator, nume, numar_telefon, relatie_cu_copilul)VALUES (@id_vizitator, @nume, @numar_telefon, @relatie_cu_copilul)
		SET @id_vizitator = @id_vizitator + 1
	END
END;
GO

CREATE OR ALTER PROCEDURE insert_2
AS
BEGIN
	DECLARE @NoOFRows int
	DECLARE @id_dosar_copil int
	DECLARE @CNP bigint
	DECLARE @nume VARCHAR(255)
	DECLARE @data_nastere date
	DECLARE @gen VARCHAR(10)
	DECLARE @numar_incapere int
	DECLARE @informatii_medicale VARCHAR(255)

	SELECT TOP 1 @NoOfRows =NoOfRows FROM dbo.TestTables 
	WHERE TableID = 2 AND TestID = 2

	SET @id_dosar_copil = 1 
	WHILE @id_dosar_copil <= @NoOfRows
	BEGIN
		SET @CNP = CAST(CONVERT(VARCHAR(10), @id_dosar_copil) + '123456789' AS BIGINT)
		SET @nume = 'Nume' + CONVERT(VARCHAR(15), @id_dosar_copil)
		SET @data_nastere =  DATEADD(DAY, @id_dosar_copil, '20000101')
		SET @gen = 'gen' + CONVERT(VARCHAR(5), @id_dosar_copil)
		SELECT TOP 1 @numar_incapere = numar_incapere FROM Incaperi ORDER BY NEWID()
		SET @informatii_medicale = 'Informatii medicale' + CONVERT(VARCHAR(15), @id_dosar_copil)

		INSERT INTO Copii(id_dosar_copil, CNP, nume, data_nastere, gen, numar_incapere, informatii_medicale) VALUES (@id_dosar_copil, @CNP, @nume, @data_nastere, @gen, @numar_incapere, @informatii_medicale)
		SET @id_dosar_copil = @id_dosar_copil + 1
	END
END;
GO

CREATE OR ALTER PROCEDURE insert_3
AS
BEGIN
	DECLARE @NoOfRows int
	DECLARE @ID int
	DECLARE @id_vizitator int
	DECLARE @id_dosar_copil int
	DECLARE @durata time
	DECLARE @scopul VARCHAR(255)
	DECLARE @comentarii VARCHAR(255)
	DECLARE @count int

	SELECT TOP 1 @NoOfRows = NoOfRows FROM dbo.TestTables 
	WHERE TableID=3 AND TestID=2

	SET @ID = 1 

	WHILE @ID <= @NoOfRows
	BEGIN
		SELECT TOP 1 @id_vizitator = id_vizitator FROM Vizitatori ORDER BY NEWID()
		SELECT TOP 1 @id_dosar_copil = id_dosar_copil FROM Copii ORDER BY NEWID()
		SET @durata = DATEADD(MINUTE, @ID, '00:00')
		SET @scopul = 'Scopul' + CONVERT(VARCHAR(20), @ID)
		SET @comentarii = 'Comentarii' + CONVERT(VARCHAR(20), @ID)
		
		SELECT @count = COUNT(id_vizitator) FROM Vizite v WHERE V.id_vizitator = @id_vizitator AND v.id_dosar_copil = @id_dosar_copil
		
		IF @count = 0 
		BEGIN
			INSERT INTO Vizite(id_vizitator, id_dosar_copil, durata, scopul, comentarii) VALUES (@id_vizitator, @id_dosar_copil, @durata, @scopul, @comentarii)
		END;
		SET @ID = @ID + 1
	END;
END;
GO


CREATE OR ALTER PROCEDURE OneTest @id_tabel INT, @id_view INT
AS
BEGIN
	DECLARE @date_start DATETIME
	DECLARE @date_intermediar DATETIME
	DECLARE @date_end DATETIME

	DECLARE @nume_tabel NVARCHAR(50)
	DECLARE @nume_view NVARCHAR(50)
	DECLARE @position INT 
	DECLARE @id_test INT

	SELECT @nume_tabel = Name FROM Tables WHERE TableID = @id_tabel
	SELECT @nume_view = Name FROM Views WHERE ViewID = @id_view

	SET @date_start = GETDATE()

	--Stergere
	SELECT @id_test = TestID FROM Tests WHERE Name = 'delete'
	SELECT @position = Position FROM TestTables WHERE TestID = @id_test AND TableID = @id_tabel

	IF (@position = 3)
	BEGIN 
		DELETE FROM Vizitatori;
		PRINT('delete3')
	END;
	IF (@position = 2)
	BEGIN
		DELETE FROM Copii;
		PRINT('delete2')
	END;
	IF (@position = 1)
	BEGIN
		DELETE FROM Vizite;
		PRINT('delete1')
	END;

	--Inserare
	SELECT @id_test = TestID FROM Tests WHERE Name = 'insert'
	SELECT @position = Position FROM TestTables WHERE TestID = @id_test AND TableID = @id_tabel
	
	IF (@position = 3)
	BEGIN 
		EXEC insert_3;
	END;
	IF (@position = 2)
	BEGIN
		EXEC insert_2;
	END;
	IF (@position = 1)
	BEGIN
		EXEC insert_1;
	END;

	SET @date_intermediar = GETDATE()

	IF (@nume_view = 'View_1')
	BEGIN
		SELECT *FROM View_1
	END;
	IF (@nume_view = 'View_2')
	BEGIN
		SELECT *FROM View_2
	END;
	IF (@nume_view = 'View_3')
	BEGIN
		SELECT *FROM View_3
	END;

	SET @date_end = GETDATE()

	Insert into TestRunTables(TableID, StartAt, EndAt) VALUES(@id_tabel, @date_start, @date_intermediar)
	Insert into TestRunViews(ViewID, StartAt, EndAt) VALUES(@id_view, @date_intermediar, @date_end)
END;
GO

CREATE OR ALTER PROCEDURE main
AS
BEGIN
	DECLARE @date_start DATETIME
	DECLARE @date_end DATETIME

	SET @date_start = GETDATE()

	exec OneTest 1,1
	exec OneTest 2,2
	exec OneTest 3,3

	SET @date_end = GETDATE()
	
	DECLARE @test_run INT
	Insert into TestRuns(StartAt, EndAt) VALUES (@date_start, @date_end)
END;

exec main;

DELETE FROM Vizite;
DELETE FROM Copii;
DELETE FROM Vizitatori;

exec insert_1;
exec insert_2;
exec insert_3;

SELECT * FROM Vizitatori;
SELECT * FROM Copii;
SELECT * FROM Vizite;

SELECT * FROM View_1;
SELECT * FROM View_2;
SELECT * FROM View_3;

SELECT * FROM TestRuns;
SELECT * FROM TestRunViews;
SELECT * FROM TestRunTables;

DELETE FROM TestRuns;
DELETE FROM TestRunViews;
DELETE FROM TestRunTables;
