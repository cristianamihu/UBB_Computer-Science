USE Orfelinat;
GO
-- folosim Vizite, Donatii si Vizitatori


CREATE OR ALTER PROCEDURE CRUD_Vizite_insert
	@durata TIME, @scopul VARCHAR(255), @comentarii VARCHAR(255)
AS
BEGIN
	IF (dbo.ValidVizite_insert(@durata, @scopul, comentarii) = 0)
	BEGIN
		PRINT 'Datele nu sunt valide pentru tabelul Vizite!'
		RETURN
	END;
	ELSE
	BEGIN
		DECLARE @id_vizitator INT
		DECLARE @id_dosar_copil INT

		SELECT TOP 1 @id_vizitator = id_vizitator FROM Vizitatori ORDER BY NEWID()
		SELECT TOP 1 @id_dosar_copil = id_dosar_copil FROM Copii ORDER BY NEWID()
		INSERT INTO Vizite(id_vizitator, id_dosar_copil, durata, scopul, comentarii) VALUES(@id_vizitator, @id_dosar_copil, @durata, @scopul, @comentarii)
	END;
END;
GO

CREATE OR ALTER PROCEDURE CRUD_Vizite_select
	@scopul VARCHAR(255)
AS
BEGIN
	IF (dbo.ValidVizite(@scopul) = 0)
	BEGIN
		PRINT 'Datele nu sunt valide pentru tabelul Carte!'
		RETURN
	END;
	ELSE
	BEGIN
		SELECT * FROM Vizite WHERE scopul = @scopul ;
	END;
END;
GO

CREATE OR ALTER PROCEDURE CRUD_Vizite_update
	@scopul VARCHAR(255)
AS
BEGIN
	IF (dbo.ValidVizite(@scopul) = 0)
	BEGIN
		PRINT 'Datele nu sunt valide pentru tabelul Carte!'
		RETURN
	END;
	ELSE
	BEGIN
	--update
		UPDATE Vizite SET durata = '01:00:00'
		WHERE scopul = @scopul
	END;
END;
GO

CREATE OR ALTER PROCEDURE CRUD_Vizite_delete
	@scopul VARCHAR(255)
AS
BEGIN
	--delete
	DELETE FROM Vizite
	WHERE scopul = @scopul
END;
GO

CREATE FUNCTION ValidVizite_insert(@durata TIME, @scopul VARCHAR(255), @comentarii VARCHAR(255))
RETURNS INT 
AS 
BEGIN
	DECLARE @r int;
	IF (@durata IS NULL OR @durata > '23:59:59' OR @scopul IS NULL OR LEN(@scopul) = 0 OR @comentarii IS NULL OR LEN(@comentarii) = 0) SET @r = 0;
	ELSE SET @r = 1;
	RETURN @r; 
END;
GO

CREATE FUNCTION ValidVizite_update(@scopul VARCHAR(255))
RETURNS INT 
AS 
BEGIN
	DECLARE @r int;
	IF (@scopul IS NULL OR LEN(@scopul) = 0) SET @r = 0;
	ELSE SET @r = 1;
	RETURN @r; 
END;
GO

SELECT * FROM Vizite;


CREATE OR ALTER PROCEDURE CRUD_Cititor
	@nume VARCHAR(20), @prenume VARCHAR(50),
	@data_n DATE, @oras VARCHAR(20),
	@str VARCHAR(50), @nr INT
AS
BEGIN
	IF (dbo.ValidCititor(@nume,@prenume) = 0)
	BEGIN
		PRINT 'Datele nu sunt valide pentru tabelul Cititor!'
		RETURN
	END;
	ELSE
	BEGIN
	--insert
		INSERT INTO Cititor(nume_c,prenume_c,data_nastere_c,oras_c,strada_c,numar_c)
		VALUES(@nume, @prenume,@data_n,@oras,@str,@nr)
		INSERT INTO Cititor(nume_c,prenume_c,data_nastere_c,oras_c,strada_c,numar_c)
		VALUES(@nume, @prenume,@data_n,@oras,@str,@nr + 5)

	--select
		SELECT * FROM Cititor;
	--update
		UPDATE Cititor SET oras_c = 'Iasi'
		WHERE nume_c LIKE 'A%'
	--delete
		DELETE FROM Cititor
		WHERE nume_c = @nume AND prenume_c = @prenume

		PRINT 'CRUD operations for table Cititor'
	END;
END;

CREATE OR ALTER PROCEDURE CRUD_Imprumut_retur
	@data_imprumut DATE, @data_retur DATE
AS
BEGIN
	IF (dbo.ValidImprumut_retur(@data_imprumut) = 0)
	BEGIN
		PRINT 'Datele nu sunt valide pentru tabela Imprumut_retur!'
		RETURN
	END;
	ELSE
	BEGIN
	--insert
		DECLARE @fk INT
		DECLARE @fk1 INT
		SELECT TOP 1 @fk = idCi FROM Cititor ORDER BY NEWID()
		SELECT TOP 1 @fk1 = idCa FROM Carte ORDER BY NEWID()
		INSERT INTO Imprumut_retur(idCi,idCa,data_imprumut,data_retur)
		VALUES(@fk,@fk1,@data_imprumut,@data_retur)
		SELECT TOP 1 @fk = idCi FROM Cititor ORDER BY NEWID()
		SELECT TOP 1 @fk1 = idCa FROM Carte ORDER BY NEWID()
		INSERT INTO Imprumut_retur(idCi,idCa,data_imprumut,data_retur)
		VALUES(@fk,@fk1,@data_imprumut,@data_retur)
	--select
		SELECT * FROM Imprumut_retur;
	--update
		UPDATE Imprumut_retur SET data_retur = GETDATE()
		WHERE idCi = 5
	--delete
		DELETE FROM Imprumut_retur
		WHERE data_imprumut = @data_imprumut AND data_retur = @data_retur

		PRINT 'CRUD operations for table Imprumut_retur'
	END;
END;

SELECT * FROM Imprumut_retur


CREATE FUNCTION ValidCititor(@nume VARCHAR(20),@prenume VARCHAR(50))
RETURNS INT 
AS 
BEGIN
	DECLARE @r int;
	IF (@nume IS NULL OR @prenume IS NULL) SET @r = 0;
	ELSE SET @r = 1;
	RETURN @r; 
END;

CREATE FUNCTION ValidImprumut_retur(@data_imprumut DATE)
RETURNS INT 
AS 
BEGIN
	DECLARE @r int;
	IF (@data_imprumut IS NULL) SET @r = 0;
	ELSE SET @r = 1;
	RETURN @r; 
END;

SELECT * FROM Carte;
SELECT * FROM Cititor;
SELECT * FROM Imprumut_retur;

CREATE OR ALTER VIEW View_cititor AS
	SELECT nume_c,prenume_c,oras_c FROM Cititor
	WHERE oras_c = 'Cluj-Napoca'
GO

CREATE OR ALTER VIEW View_carte AS
	SELECT c.titlu,c.idA FROM Carte c
	INNER JOIN Imprumut_retur i ON c.idCa=i.idCa
	WHERE c.idA < 40
GO

CREATE OR ALTER PROCEDURE lab5
	@titlu VARCHAR(100), @nr_exemplare INT,
	@nume VARCHAR(20), @prenume VARCHAR(50),
	@data_n DATE, @oras VARCHAR(20),
	@str VARCHAR(50), @nr INT,
	@data_imprumut DATE, @data_retur DATE
AS
BEGIN
	EXEC CRUD_Carte @titlu, @nr_exemplare;
	EXEC CRUD_Cititor @nume, @prenume, @data_n, @oras, @str,@nr;
	EXEC CRUD_Imprumut_retur @data_imprumut, @data_retur;
END;

CREATE NONCLUSTERED INDEX idx_Carte_idAutor ON Carte(idA);
GO

CREATE NONCLUSTERED INDEX idx_Cititor_prenume ON Cititor(prenume_c);
GO

IF EXISTS(SELECT name FROM sys.indexes WHERE name=N'idx_Cititor_oras')DROP INDEX idx_Cititor_oras ON Cititor;
GO

CREATE NONCLUSTERED INDEX idx_Imprumut_idCarte ON Imprumut_retur(idCa);
GO

SELECT * FROM View_carte
ORDER BY idA

SELECT * FROM View_cititor
ORDER BY prenume_c

EXEC lab5 'Mara',15,'Ionescu','Maria','2000-06-10','Cluj-Napoca','Motilor',20,'2021-12-20','2022-01-10'
EXEC lab5 NULL,5,'Ionescu','Maria','2000-06-10','Cluj-Napoca','Motilor',20,'2021-12-20','2022-01-10'
EXEC lab5 'Mara',15,NULL,NULL,'2000-06-10','Cluj-Napoca','Motilor',20,'2021-12-20','2022-01-10'
EXEC lab5 'Mara',15,'Ionescu','Maria','2000-06-10','Cluj-Napoca','Motilor',20,NULL,'2022-01-10'
EXEC lab5 NULL,5,NULL,NULL,'2000-06-10','Cluj-Napoca','Motilor',20,NULL,'2022-01-10'