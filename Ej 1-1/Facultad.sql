create database Facultad
GO
use Facultad
GO
create table Carreras(
	ID varchar(4) not null primary key,
	Nombre varchar(60) not null,
	Fecha date not null check(Fecha < GETDATE()),
	Mail varchar(100) not null,
	Nivel varchar(11) not null check(Nivel = 'Diplomatura' or Nivel = 'Pregrado' or Nivel = 'Grado' or Nivel = 'Posgrado'),
)
GO
create table Alumnos(
	Legajo int not null primary key identity(1000,1),
	IDCarrera varchar(4) not null foreign key references Carreras(ID),
	Apellidos varchar(50) not null,
	Nombres varchar(50) not null,
	Nacimiento date not null check(Nacimiento <= GETDATE()),
	Mail varchar(100) not null unique,
	Telefono varchar(16),   
)
GO
create table Materias(
	ID int not null primary key identity(1,1),
	IDCarrera varchar(4) not null foreign key references Carreras(ID),
	Nombre varchar(40) not null,
	CargaHoraria int not null check(CargaHoraria > 0),
	)