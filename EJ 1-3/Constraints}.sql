use Blueprint

alter Table Proyecto
add constraint CK_Proyecto_FechaFin
check(FechaFin > FechaInicio)