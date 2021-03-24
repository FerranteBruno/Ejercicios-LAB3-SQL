use ServicioHosting
go


alter table Cliente
alter column Apellido varchar(30) not null
alter table Cliente
alter column Nombre varchar(30) not null
alter table Cliente
alter column Mail varchar(60) not null


go


alter table Servicio
alter column Costo smallmoney not null
alter table Servicio
add constraint CK_Servicio_Costo
check(Costo > 0)
alter table Servicio
alter column Plataforma varchar(20) not null


go


alter table ServicioXCliente
add constraint CK_ServicioXCliente_FechaInicio
check(FechaInicio < FechaVencimiento)

alter table ServicioXCliente
alter column FechaInicio date not null


alter table ServicioXCliente
add constraint CK_ServicioXCliente_FechaVencimiento
check(FechaVencimiento > FechaInicio)

alter table ServicioXCliente
alter column FechaVencimiento date not null