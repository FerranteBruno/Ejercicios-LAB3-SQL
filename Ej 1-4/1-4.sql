GO
use Blueprint
GO
create table ClienteCiudad(
	IDCliente int primary key foreign key references Cliente(ID),
	Ciudad varchar(40)
)
GO
create table Modulo(
	ID int primary key not null identity(1,1),
	IDProyecto char(5) not null foreign key references Proyecto(ID),
	Nombre varchar(30) not null,
	Descripcion varchar(200) null,
	HorasEstimadas smallint not null,
	CostoPesos money not null,
	FechaFinAprox smalldatetime not null,
	FechaInicio smalldatetime not null,
	FechaFin smalldatetime null
)
GO
Create table Colaborador(
	ID int primary key identity(1,1) not null,
	Nombres varchar(40) not null,
	Apellidos varchar(40) not null,
	Mail varchar(60) null,
	Celular varchar(20) null,
	Edad tinyint not null,
	Pais varchar(40) not null,
	Ciudad varchar(40) not null,
	Domicilio varchar(60) not null,
	TipoColaborador char not null check(TipoColaborador = 'I' or TipoColaborador = 'E')
)