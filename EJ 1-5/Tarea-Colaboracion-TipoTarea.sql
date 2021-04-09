use Blueprint
go
create table TipoTarea(
	ID int primary key not null identity(1,1),
	NombreTarea varchar(50) not null
)
go
create table Tarea(
	ID int primary key not null identity(1,1),
	IDModulo int not null foreign key references Modulo(ID),
	IDTipoTarea int foreign key references TipoTarea(ID),
	FechaInicio date null,
	FechaFin date null,
	Estado bit,

	constraint CHK_FechaFinInicio check(FechaFin > FechaInicio)
)
go
create table Colaboracion(
	IDTarea int foreign key references Tarea(ID),
	IDColaborador int foreign key references Colaborador(ID),
	HorasRealizadas smallint not null,
	ValorXHora smallmoney not null,
	Estado bit not null,

	constraint CHK_HorasRealizadas check(HorasRealizadas > 0),
	constraint CHK_ValorXHora check(ValorXHora > 0)
)