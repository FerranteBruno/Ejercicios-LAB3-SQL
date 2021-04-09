go
create database Blueprint
go
use Blueprint

go
create table Pais(
	ID int primary key identity(1,1),
	Nombre varchar(100) not null
)

GO
create table Ciudad(
	ID int primary key identity(1,1),
	Nombre varchar(100) not null,
	IDPais int foreign key references Pais(ID)
)
go

create table ClientesTipo(
	ID int primary key identity(1,1) not null,
	TipoDeCliente varchar(30)
)
go
create table Cliente(
	ID int primary key not null identity(1,1),
	RazonSocial varchar(30) not null,
	CUIT char(15) not null unique,
	TelefonoFijo varchar(16) null,
	Celular varchar(16) null,
	Mail varchar(60) null,
	TipoCliente int foreign key references ClientesTipo(ID),
	IDCiudad int null foreign key references Ciudad(ID)
)
go
create table Proyecto(
	ID char(5) primary key not null,
	IDCliente int foreign key references Cliente(ID),
	Nombre varchar(50) not null,
	FechaInicio date not null,
	FechaFin date null,
	Estado bit not null,
	Descripcion varchar(150) null,
	CostoEstimado money not null check(CostoEstimado > 0)
)