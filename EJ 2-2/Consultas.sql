Use BluePrintf

-- 2)
-- Por cada cliente listar razón social, cuit y nombre de la ciudad y nombre del país. Sólo de aquellos
-- clientes que posean ciudad y país.
select CL.RazonSocial, CL.Cuit, C.Nombre as Ciudad, P.Nombre as Pais
From Clientes as CL
inner join Ciudades as C on C.ID = CL.IDCiudad 
inner join Paises as P on P.ID = C.IDPais

-- 3)
-- Por cada cliente listar razón social, cuit y nombre de la ciudad y nombre del país.
-- Listar también los datos de aquellos clientes que no tengan ciudad relacionada.
select cl.RazonSocial, cl.CUIT, c.Nombre as Ciudad, P.Nombre as Pais
from Clientes as cl
left join Ciudades as c on c.ID = cl.IDCiudad
left join Paises as p on c.IDPais = p.ID


-- 4)
-- Por cada cliente listar razón social, cuit y nombre de la ciudad y nombre del país.
--Listar también los datos de aquellas ciudades y países que no tengan clientes relacionados.
select cl.RazonSocial, cl.CUIT, c.Nombre as Ciudad, P.Nombre as Pais
from Clientes as cl
right join Ciudades as c on c.ID = cl.IDCiudad
right join Paises as p on c.IDPais = p.ID

-- 5)
-- Listar los nombres de las ciudades que no tengan clientes asociados. Listar también el nombre del país al que pertenece la ciudad.

--select C.nombre as Ciudad, P.nombre as Pais
--From Clientes as CL
--Right Join Ciudades as C ON C.ID = CL.IDCiudad
--Right Join Paises as P ON P.ID = C.IDPais
--Where CL.ID is null
select  c.Nombre as Ciudad, p.Nombre as Pais
from Clientes as cl
right join Ciudades as c on c.ID = cl.IDCiudad
right join Paises as p on c.IDPais = p.ID
where cl.ID is null 

-- 6)
--Listar para cada proyecto el nombre del proyecto, el costo, la razón social del
--cliente, el nombre del tipo de cliente y el nombre de la ciudad (si la tieneregistrada)
--de aquellos clientes cuyo tipo de cliente sea 'Extranjero' o
--'Unicornio'.
select
pro.Nombre as proyecto, pro.CostoEstimado, cl.RazonSocial, tc.Nombre as TipoCliente, c.Nombre as Ciudad 
from Proyectos as pro
join Clientes as cl on pro.IDCliente = cl.ID
join TiposCliente as tc on tc.ID = cl.IDTipo
join Ciudades as c on c.ID = cl.IDCiudad
where tc.Nombre = 'Extrajero' or tc.Nombre = 'Unicornio'

--7 Listar los nombre de los proyectos de aquellos clientes que sean de los países
--'Argentina' o 'Italia'.
select Pro.Nombre
from Proyectos as Pro
join Clientes as cli on cli.ID = Pro.IDCliente
join Ciudades as ciu on ciu.ID = cli.IDCiudad
join Paises as p on p.ID = ciu.IDPais
where p.Nombre = 'Argentina' or p.Nombre = 'Italia'

--8 Listar para cada módulo el nombre del módulo, el costo estimado del módulo,
--el nombre del proyecto, la descripción del proyecto y el costo estimado del
--proyecto de todos aquellos proyectos que hayan finalizado.
select
m.Nombre as Modulo, m.CostoEstimado as Costo, pro.Nombre as Proyecto, pro.Descripcion as DescProyecto, pro.CostoEstimado as CostoProyecto
from Modulos as m
join Proyectos as pro on pro.ID = m.IDProyecto
where pro.FechaFin < GETDATE()

--9 Listar los nombres de los módulos y el nombre del proyecto de aquellos
--módulos cuyo tiempo estimado de realización sea de más de 100 horas.
select 
m.Nombre as Modulo, pro.Nombre as Proyecto 
from Modulos as m
join Proyectos as pro on pro.ID = m.IDProyecto
where m.TiempoEstimado > 100

--10 Listar nombres de módulos, nombre del proyecto, descripción y tiempo
--estimado de aquellos módulos cuya fecha estimada de fin sea mayor a la
--fecha real de fin y el costo estimado del proyecto sea mayor a cien mil.
select m.Nombre as Modulos, pro.Nombre as Proyectos, m.Descripcion as DescModulo, m.TiempoEstimado 
from Modulos as m
join Proyectos as pro on pro.ID = m.IDProyecto
where m.FechaEstimadaFin > m.FechaFin and pro.CostoEstimado > 100000

--11 Listar nombre de proyectos, sin repetir, que registren módulos que hayan
--finalizado antes que el tiempo estimado.
select distinct pro.Nombre
from Proyectos as pro
join Modulos as M on M.IDProyecto = pro.ID
where M.FechaEstimadaFin < M.FechaFin 

--12 Listar nombre de ciudades, sin repetir, que no registren clientes pero sí
--colaboradores.
select distinct ciu.Nombre as Ciudades
from Ciudades as ciu
join Clientes as cli on cli.IDCiudad is null
join Colaboradores as col on col.IDCiudad = ciu.ID

--13 Listar el nombre del proyecto y nombre de módulos de aquellos módulos que
--contengan la palabra 'login' en su nombre o descripción.
select pro.Nombre as Proyecto, m.Nombre as Modulo
from Proyectos as pro
join Modulos as m on m.IDProyecto = pro.ID
where m.Descripcion like '%login%' or m.Nombre like '%login%'

--14 Listar el nombre del proyecto y el nombre y apellido de todos los
--colaboradores que hayan realizado algún tipo de tarea cuyo nombre contenga
--'Programación' o 'Testing'. Ordenarlo por nombre de proyecto de manera
--ascendente.
select pro.Nombre as Proyecto, col.Nombre as ColaboradorNombre, col.Apellido as ColaboradorApellido
from Proyectos as pro
join Modulos as m on m.IDProyecto = pro.id
join Tareas as tar on tar.IDModulo = m.ID
join TiposTarea as ttar on ttar.ID = tar.IDTipo
join Colaboraciones as colab on colab.IDTarea = Tar.ID
join Colaboradores as col on col.ID = colab.IDColaborador
where ttar.Nombre like '%Programación%' or ttar.Nombre like '%Testing%'

--15 Listar nombre y apellido del colaborador
--, nombre del módulo,
--nombre del tipo de tarea,
--precio hora de la colaboración y precio hora base
--de aquellos
--colaboradores que hayan cobrado su valor hora de colaboración más del 50%
--del valor hora base.
select col.Nombre, col.Apellido, m.Nombre as Modulo,
ttar.Nombre as TipoTarea,colab.PrecioHora as PrecioColaboracion,
ttar.PrecioHoraBase as PrecioBase
from Modulos as m
join Tareas as tar on tar.IDModulo = m.ID
join TiposTarea as ttar on ttar.ID = tar.IDTipo
join Colaboraciones as colab on colab.IDTarea = Tar.ID
join Colaboradores as col on col.ID = colab.IDColaborador
where colab.PrecioHora > ttar.PrecioHoraBase *1.5

--16 Listar nombres y apellidos de las tres colaboraciones de colaboradores
--externos que más hayan demorado en realizar alguna tarea cuyo nombre de
--tipo de tarea contenga 'Testing'.
select top 16 col.Nombre, col.Apellido
from Proyectos as pro
join Modulos as m on m.ID = m.IDProyecto
join Colaboradores as col on col.ID is not null
join Tareas as tar on tar.IDModulo = m.ID
join TiposTarea as ttar on ttar.ID = tar.IDTipo
where ttar.Nombre like 'Testing'

--17 Listar apellido, nombre y mail de los colaboradores argentinos que sean
--internos y cuyo mail no contenga '.com'.
select col.Apellido, col.Nombre, col.EMail
from Colaboradores as col
join Ciudades as ciu on ciu.ID = col.IDCiudad
join Paises as p on p.ID = ciu.IDPais
where col.Tipo like'Interno' and col.Nombre in ('Argentina') and col.EMail like '^.com'

--18 Listar nombre del proyecto, nombre del módulo y tipo de tarea de aquellas
--tareas realizadas por colaboradores externos.
select pro.Nombre, m.Nombre as Modulo, ttar.Nombre as Tarea
from Proyectos as pro
join Modulos as m on m.IDProyecto = pro.ID
join Tareas as tar on tar.IDModulo = m.ID
join TiposTarea as ttar on ttar.ID = tar.ID
join Colaboradores as col on col.ID is not null
where col.Tipo in ('Externo')


--19 Listar nombre de proyectos que no hayan registrado tareas.
select pro.Nombre
from Proyectos as pro
join Modulos as m on m.IDProyecto = pro.ID
join Tareas as tar on tar.ID is null

--20 Listar apellidos y nombres, sin repeticiones, de aquellos colaboradores que
--hayan trabajado en algún proyecto que aún no haya finalizado
select distinct col.Apellido, col.Nombre
from Proyectos as pro
right join Modulos as m on m.IDProyecto = pro.ID
right join Tareas as tar on tar.IDModulo = m.ID
right join Colaboradores as col on col.ID is not null
right join Colaboraciones as colab on colab.IDColaborador = col.ID
where tar.FechaFin > GETDATE()

