GO
create database ServicioHosting
GO
use ServicioHosting
GO
create table Cliente(
	ID int primary key identity(1000,1),
	Apellido varchar(30),
	Nombre varchar(30),
	Mail varchar(60)
)
go
create table Servicio(
	ID char(4) primary key,
	Costo smallmoney,
	Plataforma varchar(20)
)
go
create table ServicioXCliente(
	IDCliente int foreign key references Cliente(ID),
	IDServicio char(4) foreign key references Servicio(ID),
	FechaInicio date,
	FechaVencimiento date
)


