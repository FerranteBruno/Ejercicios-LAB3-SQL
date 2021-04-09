GO
use Blueprint
go
create table Modulo(
	ID int primary key not null identity(1,1),
	IDProyecto char(5) not null foreign key references Proyecto(ID),
	Nombre varchar(30) not null,
	Descripcion varchar(200) null,
	HorasEstimadas smallint not null,
	CostoPesos money not null,
	FechaFinAprox smalldatetime not null,
	FechaInicio smalldatetime not null,
	FechaFin smalldatetime not null,

	constraint CHK_FechaFin CHECK (FechaFin > getdate() AND FechaFin > FechaInicio)
)
GO
Create table Colaborador(
	ID int primary key identity(1,1) not null,
	Nombres varchar(40) not null,
	Apellidos varchar(40) not null,
	Mail varchar(60) null,
	Celular varchar(20) null,
	FechaNacimiento date not null,
	IDCiudad int null foreign key references Ciudad(ID),
	Domicilio varchar(100) not null,
	TipoColaborador char not null check(TipoColaborador = 'I' or TipoColaborador = 'E'),

	CONSTRAINT CHK_MailCelular check(Mail is not null or Celular is not null)
)
