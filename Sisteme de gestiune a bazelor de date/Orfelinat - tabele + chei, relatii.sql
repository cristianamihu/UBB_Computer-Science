CREATE DATABASE Orfelinat;
GO

USE Orfelinat;

CREATE TABLE Departamente (
  id_departament INT PRIMARY KEY,
  nume VARCHAR(255),
  numar_angajati INT
);

CREATE TABLE Slujba (
  id_slujba INT PRIMARY KEY,
  id_departament INT FOREIGN KEY REFERENCES Departamente(id_departament),
  descriere VARCHAR(255),
  salariu DECIMAL(10, 2),
  ora_inceput DATE,
  ora_sfarsit DATE,
  cerinte_calificare VARCHAR(255),
  responsabilitati VARCHAR(255),
  stoc_necesar VARCHAR(255)
);

CREATE TABLE Angajati (
  id_angajat INT PRIMARY KEY,
  nume VARCHAR(255),
  adresa VARCHAR(255),
  email VARCHAR(255),
  numar_telefon VARCHAR(20),
  experienta VARCHAR(255),
  data_angajarii DATE,
  id_slujba INT FOREIGN KEY REFERENCES Slujba(id_slujba)
);

CREATE TABLE Incaperi (
  numar_incapere INT PRIMARY KEY,
  etaj INT,
  tip_incapere VARCHAR(255),
  id_departament INT FOREIGN KEY REFERENCES Departamente(id_departament),
  capacitate_maxima INT
);

CREATE TABLE Copii (
  id_dosar_copil INT PRIMARY KEY IDENTITY,
  CNP BIGINT UNIQUE,
  nume VARCHAR(255),
  data_nastere DATE,
  gen VARCHAR(10),
  numar_incapere INT FOREIGN KEY REFERENCES Incaperi(numar_incapere),
  informatii_medicale VARCHAR(255)
);

CREATE TABLE Vizitatori (
  id_vizitator INT PRIMARY KEY,
  nume VARCHAR(255),
  CNP BIGINT,
  numar_telefon VARCHAR(20),
  relatie_cu_copilul VARCHAR(255)
);

CREATE TABLE Vizite (
  id_vizitator INT FOREIGN KEY REFERENCES Vizitatori(id_vizitator),
  id_dosar_copil INT FOREIGN KEY REFERENCES Copii(id_dosar_copil),
  durata TIME,
  scopul VARCHAR(255),
  comentarii VARCHAR(255),
  CONSTRAINT pk_Vizite PRIMARY KEY (id_vizitator, id_dosar_copil)
);

CREATE TABLE Activitati (
  cod_activitate INT IDENTITY,
  id_dosar_copil INT FOREIGN KEY REFERENCES Copii(id_dosar_copil),
  descriere VARCHAR(255),
  indrumator_activitate VARCHAR(255),
  locatie VARCHAR(255),
  numar_maxim_participanti INT,
  lucruri_necesare VARCHAR(255)
);

CREATE TABLE Donatori (
  id_donator INT PRIMARY KEY,
  nume VARCHAR(255),
  email VARCHAR(255),
  numar_telefon VARCHAR(20),
  data_inscrierii DATETIME,
  stare_donator VARCHAR(50)--activ, inactiv, suspendat
);

CREATE TABLE Donatii (
  id_departament INT FOREIGN KEY REFERENCES Departamente(id_departament),
  id_donator INT FOREIGN KEY REFERENCES Donatori(id_donator),
  CONSTRAINT pk_Donatii PRIMARY KEY (id_departament, id_donator),
  continut VARCHAR(255),
  suma DECIMAL(10, 2)
);