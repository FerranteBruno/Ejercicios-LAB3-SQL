GO
Create database Bancos
GO
Use Bancos
GO
Create table Sucursales(
	ID int primary key not null identity(100,10),
	Localidad varchar(30) not null,
	apertura datetime not null check(apertura < getdate())	
)
GO
Create table Clientes(
	
	ID char(4) Primary Key not null,
	apeNom varchar(50) not null,
	Sucursal int foreign key references Sucursales(ID),
	CuentaPesos bit not null,
	CuentaDls bit null

)

