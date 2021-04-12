Use Blueprint2
--  1) Listado de todos los clientes.
SELECT * FROM Clientes
--  2) Listado de todos los proyectos.
SELECT * FROM Proyectos
--  3) Listado con nombre, descripción, costo, fecha de inicio y de fin de todos los proyectos.
Select Nombre, Descripcion, Costo, FechaInicio, FechaFin From Proyectos
--  4) Listado con nombre, descripción, costo y fecha de inicio de todos los proyectos con costo mayor a cien mil pesos.
SELECT Nombre, Descripcion, Costo, FechaInicio FROM Proyectos where Costo >= 100000 
--  5) Listado con nombre, descripción, costo y fecha de inicio de todos los proyectos con costo menor a cincuenta mil pesos .
SELECT Nombre, Descripcion, Costo, FechaInicio FROM Proyectos WHERE Costo < 50000
--  6) Listado con todos los datos de todos los proyectos que comiencen en el año 2020.
SELECT * from Proyectos WHERE Year(FechaInicio) > 2020
--  7) Listado con nombre, descripción y costo de los proyectos que comiencen en el año 2020 y cuesten más de cien mil pesos.
Select Nombre, Descripcion, Costo From Proyectos Where Year(FechaInicio) = 2020 AND Costo > 100000
--  8) Listado con nombre del proyecto, costo y año de inicio del proyecto.
SELECT Nombre, Costo, year(FechaInicio) from Proyectos
--  9) Listado con nombre del proyecto, costo, fecha de inicio, fecha de fin y días de duración de los proyectos.
SELECT Nombre, Costo, FechaInicio, Fechafin, DATEDIFF(day,FechaInicio,FechaFin) as DiasTranscurridos from Proyectos
-- 10) Listado con razón social, cuit y teléfono de todos los clientes cuyo IDTipo sea 1, 3, 5 o 6
SELECT RazonSocial, Cuit, TelefonoFijo, TelefonoMovil, ID from Clientes where ID in (1,3,5,6)
-- 11) Listado con nombre del proyecto, costo, fecha de inicio y fin de todos los proyectos que no pertenezcan a los clientes 1, 5 ni 10.
SELECT Nombre, Costo, FechaInicio, FechaFin, ID from Proyectos where IDCliente not in (1,5,10)
-- 12) Listado con nombre del proyecto, costo y descripción de aquellos proyectos que hayan comenzado entre el 1/1/2018 y el 24/6/2018.
SELECT Nombre, Costo, Descripcion from Proyectos WHERE FechaInicio between '2018/1/1' and '2018/06/24'
-- 13) Listado con nombre del proyecto, costo y descripción de aquellos proyectos que hayan finalizado entre el 1/1/2019 y el 12/12/2019.
SELECT Nombre, Costo, Descripcion from proyectos where FechaFin between '2019/1/1' and '2019/12/12'
-- 14) Listado con nombre de proyecto y descripción de aquellos proyectos que aún no hayan finalizado.
select Nombre, Descripcion from Proyectos where FechaFin is null
-- 15) Listado con nombre de proyecto y descripción de aquellos proyectos que aún no hayan comenzado.
select Nombre, Descripcion from Proyectos where Estado = 0
-- 16) Listado de clientes cuya razón social comience con letra vocal.
select * from Clientes where RazonSocial like '[aeiou]%'
-- 17) Listado de clientes cuya razón social finalice con vocal.
select * from Clientes where RazonSocial like '%[aeiou]'
-- 18) Listado de clientes cuya razón social finalice con la palabra 'Inc'
select * from Clientes where RazonSocial like '%inc'
-- 19) Listado de clientes cuya razón social no finalice con vocal.
select * from Clientes where RazonSocial like '%[^aeiou]'
-- 20) Listado de clientes cuya razón social no contenga espacios.
select * from Clientes where RazonSocial like '%^_%'
-- 21) Listado de clientes cuya razón social contenga más de un espacio.
select * from Clientes where RazonSocial like '^_^'
-- 22) Listado de razón social, cuit, email y celular de aquellos clientes que tengan mail pero no teléfono.
select RazonSocial, Cuit, Email, TelefonoMovil from Clientes where Email is not null and TelefonoFijo is null
-- 23) Listado de razón social, cuit, email y celular de aquellos clientes que no tengan mail pero sí teléfono.
select RazonSocial, Cuit, Email, TelefonoMovil from Clientes where Email is null and TelefonoFijo is not null
-- 24) Listado de razón social, cuit, email, teléfono o celular de aquellos clientes que tengan mail o teléfono o celular .
select RazonSocial, Cuit, Email, TelefonoMovil as Telefono, TelefonoFijo as Telefono from Clientes where email is not null or telefonofijo is not null or telefonomovil is not null
-- 25) Listado de razón social, cuit y mail. Si no dispone de mail debe aparecer el texto "Sin mail".
select RazonSocial, Cuit, Email from Clientes Where Email in ('Sin Mail')
-- 26) Listado de razón social, cuit y una columna llamada Contacto con el mail,
--si no posee mail, con el número de celular y si no posee número de celular con un texto que diga
--"Incontactable".
select RazonSocial, Cuit,
case when Email is not null  then Email end Contacto,
case when TelefonoMovil is not null and Email is null then TelefonoMovil end Contacto,
case when Email is null and TelefonoMovil is null then 'Incontactable' end Contacto from Clientes
