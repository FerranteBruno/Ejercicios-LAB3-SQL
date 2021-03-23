GO
create database JuegoDeCarreras
GO
use JuegoDeCarreras
GO
create table Corredor(
	ID int primary key not null identity(100,1),
	Nombre varchar(30) not null,
	Apellido varchar(30) not null,
	Rating int not null,
	Nacimiento date not null check(Nacimiento < GETDATE())
)
GO
create table DatosExtraCorredor(
	IDCorredor int not null primary key foreign key references Corredor(ID),
	CategoriaFavorita varchar(20) not null,
	DescripcionPersonal varchar(150)
)