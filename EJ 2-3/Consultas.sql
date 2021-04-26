use BluePrintf

--1 La cantidad de colaboradores
select count(id) as colaboradores1 from colaboradores

--2 La cantidad de colaboradores nacidos entre 1990 y 2000.
select COUNT(id) as colaboradores2 from Colaboradores as c where c.FechaNacimiento > '1990-01-01' and c.FechaNacimiento < '2000-01-01'

--3 El promedio de precio hora base de los tipos de tareas
select AVG(t.PrecioHoraBase) as PromHoraTarea3 from TiposTarea as t

--4 El promedio de costo de los proyectos iniciados en el año 2019.
select AVG(pro.CostoEstimado) as PromCostoProyectos4 from Proyectos as pro

--5 El costo más alto entre los proyectos de clientes de tipo 'Unicornio'
select AVG(pro.CostoEstimado) as MaxCostClientes5 from Proyectos as pro
join Clientes as c on c.ID = pro.IDCliente
join TiposCliente as tc on tc.ID = c.IDTipo
where tc.Nombre like 'Unicornio'

--6 El costo más bajo entre los proyectos de clientes del país 'Argentina'
select MIN(pro.CostoEstimado) as CostoMinArg6 from Proyectos as pro
join Clientes as c on c.ID=pro.IDCliente
join Ciudades as ciu on ciu.ID = c.IDCiudad
join Paises as pa on pa.ID = ciu.IDPais
where pa.Nombre like 'Argentina'

--7 La suma total de los costos estimados entre todos los proyectos.
select SUM(pro.CostoEstimado) as SumCostosProyectos7 from Proyectos as pro

--8 Por cada ciudad, listar el nombre de la ciudad y la cantidad de clientes.
select ciu.Nombre as NombreCiudad8, COUNT(cli.ID) as Clientes from Clientes as cli
join Ciudades as ciu on ciu.ID = cli.IDCiudad
group by ciu.Nombre

--9 Por cada país, listar el nombre del país y la cantidad de clientes.
select p.Nombre as NombrePais9, count(cli.id) from Clientes as cli
join Ciudades as ciu on ciu.ID = cli.IDCiudad
join Paises as p on p.ID = ciu.IDPais
group by P.Nombre

--10 Por cada tipo de tarea, la cantidad de colaboraciones registradas. Indicar el
--tipo de tarea y la cantidad calculada.
select tt.Nombre as TipoTarea10, count (colab.IDTarea ) as CantidadDeTareas
from Colaboraciones as colab
join Tareas as t on t.id = colab.IDTarea
join TiposTarea as tt on tt.ID = t.ID
--where colab.IDTarea = t.ID
group by tt.Nombre

--11 Por cada tipo de tarea, la cantidad de colaboradores distintos que la hayan
--realizado. Indicar el tipo de tarea y la cantidad calculada.
select tt.Nombre as TipoTarea, COUNT (t.ID) as Cantidad from Colaboraciones as colab
join Colaboradores as col on col.ID = Colab.IDColaborador
join Tareas as t on t.ID = colab.IDTarea
join TiposTarea as tt on tt.ID = t.IDTipo
group by tt.Nombre, t.id

--12 Por cada módulo, la cantidad total de horas trabajadas. Indicar el ID, nombre
--del módulo y la cantidad totalizada. Mostrar los módulos sin horas registradas
--con 0.
select m.id, m.Nombre, datediff(HOUR, m.FechaInicio, m.FechaFin)from modulos as m
--group by m.id, m.nombre


--13 Por cada módulo y tipo de tarea, el promedio de horas trabajadas. Indicar el ID
--y nombre del módulo, el nombre del tipo de tarea y el total calculado.
select distinct m.id as ID13, m.nombre,tt.nombre, AVG(colab.Tiempo) as PromedioHoras From Modulos as m
join Tareas as t on t.IDModulo = m.ID
join TiposTarea as tt on tt.ID = t.IDTipo
join Colaboraciones as colab on colab.IDTarea = t.ID
group by m.ID, m.Nombre, tt.Nombre

--14 Por cada módulo, indicar su ID, apellido y nombre del colaborador y total que
--se le debe abonar en concepto de colaboraciones realizadas en dicho módulo.
select m.id as ID14, COL.apellido, COl.nombre, SUM(colab.PrecioHora*colab.Tiempo) from Modulos as m
join Colaboradores as col on col.ID is not null
join Colaboraciones as colab on colab.IDColaborador = col.ID
group by m.ID, col.Apellido, col.Nombre

--15 Por cada proyecto indicar el nombre del proyecto y la cantidad de horas
--registradas en concepto de colaboraciones y el total que debe abonar en
--concepto de colaboraciones.
select pro.nombre as NombreProyecto15,
sum(colab.Tiempo) as Horas,
sum(colab.PrecioHora*colab.Tiempo) as aAbonar 
from Proyectos as pro
join Modulos as m on m.IDProyecto = pro.ID
join Tareas as t on t.IDModulo = m.ID
join Colaboraciones as colab on colab.IDTarea = t.ID
group by pro.Nombre

--16 Listar los nombres de los proyectos que hayan registrado menos de cinco
--colaboradores distintos y más de 100 horas total de trabajo.
select pro.nombre as NombreProyecto16 from Proyectos as pro
join Modulos as m on m.IDProyecto = pro.ID
join Tareas as t on t.IDModulo = m.ID
join Colaboraciones as colab on colab.IDTarea = t.ID
join Colaboradores as col on col.ID = colab.IDColaborador
group by pro.Nombre
having COUNT(col.ID) < 5 and SUM(colab.Tiempo) > 100

--17 Listar los nombres de los proyectos que hayan comenzado en el año 2020 que
--hayan registrado más de tres módulos.
select PRO.nombre from Proyectos as pro
join Modulos as m on m.IDProyecto=pro.ID
group by pro.Nombre
having count(m.ID) > 3

--18 Listar para cada colaborador externo, el apellido y nombres y el tiempo
--máximo de horas que ha trabajo en una colaboración.
select COL.Apellido, col.Nombre, MAX(colab.Tiempo) as MaximaHoraColaboracion from Colaboradores as col
join Colaboraciones as colab on colab.IDColaborador = col.ID
where col.Tipo like 'E'
group by col.Apellido, col.Nombre

--19 Listar para cada colaborador interno, el apellido y nombres y el promedio
--percibido en concepto de colaboraciones.
select col.Apellido, COL.nombre, AVG(Colab.tiempo * Colab.PrecioHora) as ConceptoMax from Colaboradores as col
join Colaboraciones as colab on colab.IDColaborador = col.ID
where col.Tipo like 'i'
group by col.Apellido, col.Nombre

--20Listar el promedio percibido en concepto de colaboraciones para
--colaboradores internos y el promedio percibido en concepto de
--colaboraciones para colaboradores externos.
select COL.tipo, avg(colab.PrecioHora*colab.Tiempo) as HonorariosPromedio from Colaboradores as col
join Colaboraciones as colab on colab.IDColaborador = col.ID
group by col.Tipo

--21 Listar el nombre del proyecto y el total neto estimado. Este último valor surge
--del costo estimado menos los pagos que requiera hacer en concepto de
--colaboraciones.
select pro.Nombre as NombreProyecto21, SUM((pro.CostoEstimado-(colab.PrecioHora*colab.Tiempo))) from Proyectos as pro
join Modulos as m on m.IDProyecto = pro.ID
join Tareas as t on t.IDModulo = m.ID
join Colaboraciones as colab on colab.IDTarea = t.ID
group by pro.Nombre


--22 Listar la cantidad de colaboradores distintos que hayan colaborado en alguna
--tarea que correspondan a proyectos de clientes de tipo 'Unicornio'.
select count(col.id) as CantColaboradores22 from Colaboradores as col
left join Colaboraciones as colab on colab.IDColaborador = col.ID
left join Tareas as t on t.ID= colab.IDTarea
left join Modulos as m on m.ID = t.IDModulo
left join Proyectos as pro on pro.ID = m.IDProyecto
left join Clientes as cli on cli.ID = pro.IDCliente
left join TiposCliente as tc on tc.ID = cli.IDTipo
where tc.Nombre in('Unicornio') 

--23 La cantidad de tareas realizadas por colaboradores del país 'Argentina'.
select COUNT(t.ID) as CantidadDeTareas from Tareas as t
left join Colaboraciones as colab on colab.IDTarea = t.ID
left join Colaboradores as col on col.ID = colab.IDColaborador
left join Ciudades as ciu on ciu.ID = col.IDCiudad
left join Paises as p on p.ID = ciu.IDPais
where p.Nombre like 'Argentina'

--24 Por cada proyecto, la cantidad de módulos que se haya estimado mal la fecha
--de fin. Es decir, que se haya finalizado antes o después que la fecha estimada.
--Indicar el nombre del proyecto y la cantidad calculada.
select pro.nombre, COUNT(m.FechaFin) as Cantidad from Proyectos as pro
left join Modulos as m on m.IDProyecto = pro.ID
where m.fechafin != m.FechaEstimadaFin
group by pro.Nombre
