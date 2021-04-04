use Blueprint
GO
Alter table Modulo
Add constraint CHK_FechaFin CHECK (FechaFin > getdate() AND FechaFin > FechaInicio)
GO
Alter table Colaborador
Add constraint CHK_Mail CHECK (Celular > 0 OR Mail > 0)
GO
Alter table Colaborador
Add constraint CHK_Celular CHECK (Celular > 0 OR Mail > 0)