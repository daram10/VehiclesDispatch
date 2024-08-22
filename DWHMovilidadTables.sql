--ER AND PHYSICAL MODEL TABLE CREATIONS

USE [MovilidadDWH]

--TABLES TO CREATE THE ID AND RELATION INFORMATION ARE:


-- ** TERMINAL**-- 

--TABLE
CREATE TABLE [dbo].[Terminal](
	[IDTerminal] INT IDENTITY NOT NULL PRIMARY KEY,
	[NombreTerminal] [nvarchar](23) NOT NULL,
 );

--SSIS QUERY 
SELECT DISTINCT [TERMINAL]
FROM [MovilidadSource].[dbo].[Terminales]


-- ** CLASE_VEHICULO

--TABLE
CREATE TABLE ClaseVehiculo (
    [IDVehiculo]     INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    [NombreVehiculo] NVARCHAR (9) NOT NULL,
	);

--SSIS QUERY 
SELECT DISTINCT CLASE_VEHICULO
FROM [MovilidadSource].[dbo].[Terminales]


-- ** NIVEL_SERVICIO

--TABLE
CREATE TABLE [dbo].[NivelServicio] (
    [IDNivelServicio]     INT           NOT NULL,
    [NombreNivelServicio] NVARCHAR (20) NOT NULL,
    CONSTRAINT [PK_NivelServicio] PRIMARY KEY CLUSTERED ([IDNivelServicio] ASC)
);

--SSIS QUERY
SELECT DISTINCT NIVEL_SERVICIO
FROM [MovilidadSource].[dbo].[Terminales]


--** TIPO DESPACHO **-- 

--TABLE
CREATE TABLE TipoDespacho (
	[IDTipoDespacho] INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
	TipoDespacho NVARCHAR(8) NOT NULL
);

--SSIS QUERY
SELECT DISTINCT TIPO_DESPACHO
FROM [MovilidadSource].[dbo].[Terminales]


-- ** DEPARTAMENTO **-

--TABLES
--DepartamentoDestino 
CREATE TABLE [dbo].[DepartamentoDestino] (
    [IdDepartamentoDestino]     INT           NOT NULL,
    [DepartamentoDestino] NVARCHAR (56) NOT NULL,
    CONSTRAINT [PK_DepartamentoDestino] PRIMARY KEY CLUSTERED ([IdDepartamentoDestino] ASC)
);

--DepartamentoOrigen
CREATE TABLE [dbo].[DepartamentoOrigen] (
    [IdDepartamentoOrigen]     INT           NOT NULL,
    [DepartamentoOrigen] NVARCHAR (56) NOT NULL,
    CONSTRAINT [PK_DepartamentoOrigen] PRIMARY KEY CLUSTERED ([IdDepartamentoOrigen] ASC)
);

--SSIS QUERY
SELECT DISTINCT Codigo_Departamento, Nombre_Departamento
FROM [MovilidadSource].dbo.[DIVIPOLA-_C_digos_municipios_20240706]
WHERE Codigo_Municipio IS NOT NULL;


-- ** MUNICIPIO

--TABLES

--MunicipioDestino
CREATE TABLE MunicipioDestino (
    [IdMunicipioDestino]     INT NOT NULL PRIMARY KEY,
    [MunicipioDestino] NVARCHAR (27) NOT NULL,
	[IdDepartamentoDestino] INT NOT NULL,
	CONSTRAINT FK_DepartamentoDestino FOREIGN KEY (IdDepartamentoDestino)
		REFERENCES [dbo].[DepartamentoDestino](IdDepartamentoDestino)
);

--MunicipioOrigen
CREATE TABLE MunicipioOrigen (
    [IdMunicipioOrigen]     INT NOT NULL PRIMARY KEY,
    [MunicipioOrigen] NVARCHAR (27) NOT NULL,
	[IdDepartamentoOrigen] INT NOT NULL,
	CONSTRAINT FK_DepartamentoOrigen FOREIGN KEY (IdDepartamentoOrigen)
		REFERENCES [dbo].[DepartamentoOrigen](IdDepartamentoOrigen)
);

-- SSIS QUERY
SELECT  Codigo_Municipio, Nombre_Municipio, Codigo_Departamento, Nombre_Departamento
FROM [MovilidadSource].dbo.[DIVIPOLA-_C_digos_municipios_20240706]
WHERE Codigo_Municipio IS NOT NULL

--**VIAJES TERMINALES TERRESTRES **--

CREATE TABLE ViajesTerminalesTerrestres (
    [IdViaje]                INT  IDENTITY (1, 1) NOT NULL,
    [IdTerminal]             INT  NOT NULL,
    [IdClaseVehiculo]        INT  NOT NULL,
    [IdNivelServicio]        INT  NOT NULL,
    [IdMunicipioOrigen]      INT  NOT NULL,
    [IdDepartamentoOrigen]   INT  NOT NULL,
    [IdMunicipioDestino]     INT  NOT NULL,
    [IdDepartamentoDestino] INT  NOT NULL,
    [FechaDespacho]          DATE NOT NULL,
    [HoraDespacho]           INT  NOT NULL,
    [CantidadDespachos]      INT  NOT NULL,
    [CantidadPasajeros]      INT  NOT NULL,
    [IdTipoDespacho]         INT  NOT NULL,
    CONSTRAINT [PK_ViajesTerminalesTerrestres] PRIMARY KEY CLUSTERED ([IdViaje] ASC),
    CONSTRAINT [FK_ClaseVehiculo] FOREIGN KEY ([IdClaseVehiculo]) REFERENCES [dbo].[ClaseVehiculo] ([IDVehiculo]),
    CONSTRAINT [FK_ViajeDepartamentoDestino] FOREIGN KEY (IdDepartamentoDestino) REFERENCES [dbo].[DepartamentoDestino] ([IdDepartamentoDestino]),
    CONSTRAINT [FK_ViajeDepartamentoOrigen] FOREIGN KEY ([IdDepartamentoOrigen]) REFERENCES [dbo].[DepartamentoOrigen] ([IdDepartamentoOrigen]),
    CONSTRAINT [FK_ViajeMunicipioDestino] FOREIGN KEY ([IdMunicipioDestino]) REFERENCES [dbo].[MunicipioDestino] ([IdMunicipioDestino]),
    CONSTRAINT [FK_ViajeMunicipoOrigen] FOREIGN KEY ([IdMunicipioOrigen]) REFERENCES [dbo].[MunicipioOrigen] ([IdMunicipioOrigen]),
    CONSTRAINT [FK_NivelServicio] FOREIGN KEY ([IdNivelServicio]) REFERENCES [dbo].[NivelServicio] ([IDNivelServicio]),
    CONSTRAINT [FK_TipoDespacho] FOREIGN KEY ([IdTipoDespacho]) REFERENCES [dbo].[TipoDespacho] ([IDTipoDespacho]),
    CONSTRAINT [FK_ViajesTerminales] FOREIGN KEY ([IdTerminal]) REFERENCES [dbo].[Terminal] ([IDTerminal])
);


--** Auxiliar from SSIS to check the migration lote from source to DWH
ALTER TABLE [dbo].[ViajesTerminalesTerrestres]
ADD ROWID INT;

ALTER TABLE [dbo].[ViajesTerminalesTerrestres]
ADD ViewSource VARCHAR(50);

-- **FOREIGN KEYS LIST** --

--Method 1

SELECT CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'ViajesTerminalesTerrestres'
AND CONSTRAINT_TYPE = 'FOREIGN KEY';

--Method 2

SELECT 
    fk.name AS ForeignKeyName,
    tp.name AS ParentTable,
    cp.name AS ParentColumn,
    tr.name AS ReferencedTable,
    cr.name AS ReferencedColumn
FROM 
    sys.foreign_keys AS fk
INNER JOIN 
    sys.foreign_key_columns AS fkc ON fk.object_id = fkc.constraint_object_id
INNER JOIN 
    sys.tables AS tp ON fk.parent_object_id = tp.object_id
INNER JOIN 
    sys.columns AS cp ON fkc.parent_object_id = cp.object_id AND fkc.parent_column_id = cp.column_id
INNER JOIN 
    sys.tables AS tr ON fk.referenced_object_id = tr.object_id
INNER JOIN 
    sys.columns AS cr ON fkc.referenced_object_id = cr.object_id AND fkc.referenced_column_id = cr.column_id
WHERE 
    tp.name = 'MunicipioDestino';



	ALTER TABLE dbo.Municipio CHECK CONSTRAINT FK_Departamentos;

SELECT *
FROM DepartamentoOrigen
[dbo].[MunicipioDestino]

SELECT  Codigo_Municipio, Nombre_Municipio, Codigo_Departamento
FROM [MovilidadSource].dbo.[DIVIPOLA-_C_digos_municipios_20240706]
WHERE Codigo_Municipio IS NOT NULL


USE MovilidadSource
GO

SELECT COUNT(*)
FROM TerminalesIdentificada



SELECT TOP (10) *
FROM [MovilidadDWH].DBO.ViajesTerminalesTerrestres

SELECT COUNT(*)
FROM [MovilidadDWH].DBO.ViajesTerminalesTerrestres