--DIMENSIONAL

--TipoDespacho

CREATE TABLE [dbo].[DimTipoDespacho] (
    [IDTipoDespacho] INT          NOT NULL,
    [TipoDespacho]   NVARCHAR (8) NOT NULL,
    CONSTRAINT [PK_DimTipoDespacho] PRIMARY KEY CLUSTERED ([IDTipoDespacho] ASC)
);


--Tiempo

CREATE TABLE [dbo].[DimTiempo] (
    [Fecha]     DATE NOT NULL,
    [DiaMes]    INT  NOT NULL,
    [Mes]       INT  NOT NULL,
    [Anno]      INT  NOT NULL,
    [DiaSemana] INT  NOT NULL,
    [Trimestre] INT  NOT NULL,
    [Hora]      INT  NOT NULL,
    CONSTRAINT [PK_FactViajesTerminalesTerrestres] PRIMARY KEY CLUSTERED ([Fecha] ASC, [Hora] ASC)
);


--ClaseVehiculo

CREATE TABLE [dbo].[DimClaseVehiculo] (
    [IDClaseVehiculo]     INT          NOT NULL,
    [NombreClaseVehiculo] NVARCHAR (9) NOT NULL,
    CONSTRAINT [PK_DimClaseVehiculo] PRIMARY KEY CLUSTERED ([IDClaseVehiculo] ASC)
);

--Terminales

CREATE TABLE [dbo].[DimTerminales] (
    [IDTerminal]     INT           NOT NULL,
    [NombreTerminal] NVARCHAR (23) NOT NULL,
    CONSTRAINT [PK_DimTerminales] PRIMARY KEY CLUSTERED ([IDTerminal] ASC)
);

--NivelServicio

CREATE TABLE [dbo].[DimNivelServicio] (
    [IDNivelServicio]     INT           NOT NULL,
    [NombreNivelServicio] NVARCHAR (20) NOT NULL,
    CONSTRAINT [PK_DimNivelServicio] PRIMARY KEY CLUSTERED ([IDNivelServicio] ASC)
);

--Municipios
CREATE TABLE [dbo].[DimMunicipiosDestino] (
    [IDMunicipioDestino]        INT           NOT NULL,
    [MunicipioDestino]    NVARCHAR (27) NOT NULL,
    [DepartamentoDestino] NVARCHAR (56) NOT NULL,
    CONSTRAINT [PK_DimMunicipiosDestino] PRIMARY KEY CLUSTERED ([IDMunicipioDestino] ASC)
);

CREATE TABLE [dbo].[DimMunicipiosOrigen] (
    [IDMunicipioOrigen]        INT           NOT NULL,
    [MunicipioOrigen]    NVARCHAR (27) NOT NULL,
    [DepartamentoOrigen] NVARCHAR (56) NOT NULL,
    CONSTRAINT [PK_DimMunicipiosOrigen] PRIMARY KEY CLUSTERED ([IDMunicipioOrigen] ASC)
);



--FactViajesTerminales

CREATE TABLE [dbo].[FactViajesTerminales] (
    [IDViajes]              INT  NOT NULL,
    [IdClaseVehiculo]       INT  NOT NULL,
    [IdTerminal]            INT  NOT NULL,
    [IdNivelServicio]       INT  NOT NULL,
    [IdMunicipioOrigen]     INT  NOT NULL,
    [IdDepartamentoOrigen]  INT  NOT NULL,
    [IdMunicipioDestino]    INT  NOT NULL,
    [IdDepartamentoDestino] INT  NOT NULL,
    [FechaDespacho]         DATE NOT NULL,
    [HoraDespacho]          INT  NOT NULL,
    [CantidadDespachos]     INT  NOT NULL,
    [CantidadPasajeros]     INT  NOT NULL,
    [IdTipoDespacho]        INT  NOT NULL,
    CONSTRAINT [PK_FactViajesTerminales] PRIMARY KEY CLUSTERED ([IDViajes] ASC),
    CONSTRAINT [FK_DimClaseVehiculo] FOREIGN KEY ([IdClaseVehiculo]) REFERENCES [dbo].[DimClaseVehiculo] ([IDClaseVehiculo]),
    CONSTRAINT [FK_DimMunicipiosDestino] FOREIGN KEY ([IdMunicipioDestino]) REFERENCES [dbo].[DimMunicipiosDestino] ([IDMunicipioDestino]),
    CONSTRAINT [FK_DimMunicipiosOrigen] FOREIGN KEY ([IdMunicipioOrigen]) REFERENCES [dbo].[DimMunicipiosOrigen] ([IDMunicipioOrigen]),
    CONSTRAINT [FK_DimNivelServicio] FOREIGN KEY ([IdNivelServicio]) REFERENCES [dbo].[DimNivelServicio] ([IDNivelServicio]),
    CONSTRAINT [FK_DimTerminales] FOREIGN KEY ([IdTerminal]) REFERENCES [dbo].[DimTerminales] ([IDTerminal]),
    CONSTRAINT [FK_DimTipoDespacho] FOREIGN KEY ([IdTipoDespacho]) REFERENCES [dbo].[DimTipoDespacho] ([IDTipoDespacho]),
    CONSTRAINT [FK_FactViajesTerminales_DimTiempo] FOREIGN KEY ([FechaDespacho], [HoraDespacho]) REFERENCES [dbo].[DimTiempo] ([Fecha], [Hora])
);


-----------CONSULTAS -----------------

SELECT DISTINCT dwhmunicipios.IdMunicipioDestino, dwhmunicipios.MunicipioDestino, dwhdepartamentos.DepartamentoDestino
from MovilidadDWH.dbo.MunicipioDestino as dwhmunicipios
Join [MovilidadDWH].dbo.DepartamentoDestino as dwhdepartamentos on dwhdepartamentos.IdDepartamentoDestino = dwhmunicipios.IdDepartamentoDestino
EXCEPT
SELECT [IDMunicipioDestino], [MunicipioDestino], [DepartamentoDestino]
FROM MovilidadDim.dbo.DimMunicipiosDestino




SELECT DISTINCT dwhmunicipios.IdMunicipioOrigen, dwhmunicipios.MunicipioOrigen, dwhdepartamentos.DepartamentoOrigen
from MovilidadDWH.dbo.MunicipioOrigen as dwhmunicipios
Join [MovilidadDWH].dbo.DepartamentoOrigen as dwhdepartamentos on dwhdepartamentos.IdDepartamentoOrigen = dwhmunicipios.IdDepartamentoOrigen
EXCEPT
SELECT [IDMunicipioOrigen], [MunicipioOrigen], [DepartamentoOrigen]
FROM MovilidadDim.dbo.DimMunicipiosOrigen



SELECT DISTINCT IDNivelServicio, NombreNivelServicio
from MovilidadDWH.dbo.NivelServicio 
EXCEPT
SELECT IDNivelServicio, NombreNivelServicio
FROM MovilidadDim.dbo.DimNivelServicio



SELECT DISTINCT IDTerminal, NombreTerminal
from MovilidadDWH.dbo.Terminal
EXCEPT
SELECT IDTerminal, NombreTerminal
FROM MovilidadDim.dbo.DimTerminales


SELECT DISTINCT CONVERT (DATE, FechaDespacho) as Fecha, DATEPART (dd, FechaDespacho) as DiaMes, DATEPART(mm, FechaDespacho) as Mes, DATEPART (yyyy, FechaDespacho) as Anno, DATEPART(dw, FechaDespacho) as Diasemana, DATEPART(qq, FechaDespacho) as Trimestre, HoraDespacho 
from MovilidadDWH.dbo.ViajesTerminalesTerrestres
--Order By CONVERT (DATE, FechaDespacho)
EXCEPT
SELECT Fecha, DiaMes,Mes, Anno, DiaSemana, Trimestre, Hora
FROM MovilidadDim.dbo.DimTiempo


SELECT *
FROM MovilidadDim.DBO.DimTiempo

SELECT *
FROM MovilidadDWH.DBO.TipoDespacho

SELECT DISTINCT IDTipoDespacho, TipoDespacho
from MovilidadDWH.dbo.TipoDespacho
EXCEPT
SELECT IDTipoDespacho, TipoDespacho
FROM MovilidadDim.dbo.DimTipoDespacho



SELECT DISTINCT IdViaje, IdTerminal, IdClaseVehiculo, IdNivelServicio, IdMunicipioOrigen, IdDepartamentoOrigen, IdMunicipioDestino, IdDepartamentoDestino, FechaDespacho, HoraDespacho, CantidadDespachos, CantidadPasajeros, IdTipoDespacho 
FROM MovilidadDWH.dbo.ViajesTerminalesTerrestres
EXCEPT 
SELECT IdViajes, IdTerminal, IdClaseVehiculo, IdNivelServicio, IdMunicipioOrigen, IdDepartamentoOrigen, IdMunicipioDestino, IdDepartamentoDestino, FechaDespacho, HoraDespacho, CantidadDespachos, CantidadPasajeros, IdTipoDespacho 
FROM MovilidadDim.dbo.FactViajesTerminales




SELECT *
FROM FactViajesTerminales;


INSERT INTO FactViajesTerminales (IDViajes, IdTerminal, IdClaseVehiculo, IdNivelServicio, IdMunicipioOrigen, IdDepartamentoOrigen, IdMunicipioDestino, IdDepartamentoDestino, FechaDespacho, HoraDespacho, CantidadDespachos, CantidadPasajeros, IdTipoDespacho)
SELECT DISTINCT IdViaje, IdTerminal, IdClaseVehiculo, IdNivelServicio, IdMunicipioOrigen, IdDepartamentoOrigen, IdMunicipioDestino, IdDepartamentoDestino, FechaDespacho, HoraDespacho, CantidadDespachos, CantidadPasajeros, IdTipoDespacho
FROM MovilidadDWH.dbo.ViajesTerminalesTerrestres
EXCEPT
SELECT IDViajes, IdTerminal, IdClaseVehiculo, IdNivelServicio, IdMunicipioOrigen, IdDepartamentoOrigen, IdMunicipioDestino, IdDepartamentoDestino, FechaDespacho, HoraDespacho, CantidadDespachos, CantidadPasajeros, IdTipoDespacho
FROM MovilidadDim.dbo.FactViajesTerminales;*/


