go
create database Blueprint
go
use Blueprint
go
create table Cliente(
	ID int primary key not null identity(1,1),
	RazonSocial varchar(30) not null,
	CUIT char(15) not null unique
)
go
create table ContactoCliente(
	IDCliente int primary key foreign key references Cliente(ID),
	TelefonoFijo varchar(16) null,
	Celular varchar(16) null,
	Mail varchar(60) null
)
go
create table ClientesTipo(
	IDCliente int foreign key references Cliente(ID),
	TipoDeCliente varchar(30)
)
go
create table Proyecto(
	ID char(5) primary key not null,
	IDCliente int foreign key references Cliente(ID),
	Nombre varchar(50) not null,
	FechaInicio date not null,
	FechaFin date null,
	Estado bit not null
)
go
create table ProyAdicionales(
	IDProyecto char(5) foreign key references Proyecto(ID),
	Descripcion varchar(150) null,
	CostoEstimado money not null check(CostoEstimado > 0)
)