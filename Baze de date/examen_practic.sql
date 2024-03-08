CREATE DATABASE Competitie;

USE Competitie;
go

CREATE TABLE Concurenti (
    ConcurentID INT PRIMARY KEY,
    Nume NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    TaraOrigine NVARCHAR(50),
    DataNastere DATE NOT NULL
);

CREATE TABLE TipuriPrajituri (
    TipID INT PRIMARY KEY,
    Denumire NVARCHAR(50) NOT NULL
);

CREATE TABLE IngredientePrincipale (
    IngredientID INT PRIMARY KEY,
    Nume NVARCHAR(100) NOT NULL,
    Descriere NVARCHAR(500),
    Alergen BIT
);

CREATE TABLE Prajituri (
    PrajituraID INT PRIMARY KEY,
    Nume NVARCHAR(100) NOT NULL,
    Descriere NVARCHAR(500),
    Calorii INT,
    Gramaj INT,
    Mentiuane NVARCHAR(100),
    TipID INT FOREIGN KEY REFERENCES TipuriPrajituri(TipID),
    IngredientPrincipalID INT FOREIGN KEY REFERENCES IngredientePrincipale(IngredientID)
);

CREATE TABLE ConsumPrajitura (
    ConcurentID INT,
    PrajituraID INT,
    Cantitate INT,
    PRIMARY KEY (ConcurentID, PrajituraID),
    FOREIGN KEY (ConcurentID) REFERENCES Concurenti(ConcurentID),
    FOREIGN KEY (PrajituraID) REFERENCES Prajituri(PrajituraID)
);
GO

INSERT INTO Concurenti (ConcurentID, Nume, Email, TaraOrigine, DataNastere) VALUES
(1, 'Ion Popescu', 'ion.popescu@email.com', 'Romania', '1990-05-15'),
(2, 'Maria Ionescu', 'maria.ionescu@email.com', 'Romania', '1988-03-22'),
(3, 'Andrei Vasile', 'andrei.vasile@email.com', 'Romania', '1992-07-30');

INSERT INTO IngredientePrincipale (IngredientID, Nume, Descriere, Alergen) VALUES
(1, 'mousse de fructe', 'Mousse cu diferite fructe', 0),
(2, 'ciocolata', 'Ciocolata buna', 1),
(3, 'mousse de vanilie', 'Mousse fin cu extract de vanilie', 0),
(4, 'mousse de ciocolata', 'Mousse fin de ciocolata', 0);

INSERT INTO TipuriPrajituri (TipID, Denumire) VALUES
(1, 'Tort'),
(2, 'Cheesecake'),
(3, 'Tarta');

INSERT INTO Prajituri (PrajituraID, Nume, Descriere, Calorii, Gramaj, Mentiuane, TipID, IngredientPrincipalID) VALUES
(1, 'Tort Fructe', 'Tort cu mousse de fructe', 500, 1000, 'vegan', 1, 1),
(2, 'Cheesecake Ciocolata', 'Cheesecake cu ciocolata', 450, 800, 'nu e vegana', 2, 2),
(3, 'Tarta Vanilie', 'Tarta cu mousse de vanilie', 300, 500, 'vegan', 3, 3);

INSERT INTO ConsumPrajitura (ConcurentID, PrajituraID, Cantitate) VALUES
(1, 1, 2),
(2, 2, 1),
(1, 3, 3),
(3, 1, 1);

SELECT * FROM Concurenti;
SELECT * FROM IngredientePrincipale;
SELECT * FROM TipuriPrajituri;
SELECT * FROM Prajituri;
SELECT * FROM ConsumPrajitura;
GO

CREATE PROCEDURE AdaugaPrajituraConcurentului
    @ConcurentID INT,
    @PrajituraID INT,
    @Cantitate INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM ConsumPrajitura WHERE ConcurentID = @ConcurentID AND PrajituraID = @PrajituraID)
		BEGIN
			UPDATE ConsumPrajitura
			SET Cantitate = @Cantitate
			WHERE ConcurentID = @ConcurentID AND PrajituraID = @PrajituraID;
		END
    ELSE
		BEGIN
			INSERT INTO ConsumPrajitura (ConcurentID, PrajituraID, Cantitate)
			VALUES (@ConcurentID, @PrajituraID, @Cantitate);
		END
END;
GO

EXEC AdaugaPrajituraConcurentului @ConcurentID = 1, @PrajituraID = 2, @Cantitate = 3;
SELECT * FROM ConsumPrajitura;
GO

CREATE VIEW ConcurentiCuMousseDeFructe AS
SELECT C.Nume, C.Email
FROM Concurenti C
JOIN ConsumPrajitura CP ON C.ConcurentID = CP.ConcurentID
JOIN Prajituri P ON CP.PrajituraID = P.PrajituraID
JOIN IngredientePrincipale I ON P.IngredientPrincipalID = I.IngredientID
WHERE I.Nume = 'mousse de fructe' AND C.ConcurentID NOT IN (
      SELECT C.ConcurentID
      FROM Concurenti C
      JOIN ConsumPrajitura CP ON C.ConcurentID = CP.ConcurentID
      JOIN Prajituri P ON CP.PrajituraID = P.PrajituraID
      JOIN IngredientePrincipale I ON P.IngredientPrincipalID = I.IngredientID
      WHERE I.Nume = 'mousse de vanilie'
);
GO

SELECT * FROM ConcurentiCuMousseDeFructe;

SELECT * FROM Concurenti;
SELECT * FROM IngredientePrincipale;
SELECT * FROM Prajituri;
SELECT * FROM ConsumPrajitura;