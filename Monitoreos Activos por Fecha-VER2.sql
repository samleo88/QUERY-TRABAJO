USE[Bavaria]
DECLARE @FechaInicio Datetime
DECLARE @FechaFin Datetime

--select * from BI_Dim_Infraccion
--where FechaInfracción between '2020-03-13 02:00:00' and '2020-03-13 23:00:00'
--Admiistracion
/*
select FechaAutenticacion,usuario.Login
from sesion join usuario 
on sesion.idusuario = usuario.idusuario
where FechaAutenticacion between '2020-01-02 00:00:00' and '2020-01-02 23:00:00'
order by FechaAutenticacion desc
*/

--USUARIOS QUE ESTAN EN LA BD BAVARIA
/*
select 
Usuario.Identificacion,
Usuario.PrimerNombre,
Usuario.PrimerApellido,
Usuario.Telefonos,
Usuario.Genero,
Regional.DescripcionRegional,
Gerencia.DescripcionGerencia,
Unidad.DescripcionUnidad,
Zona.CodigoZona 
from usuario left join Zona
ON 
Usuario.IdZona = Zona.IdZona
INNER JOIN Unidad
ON
Unidad.IdUnidad= Zona.IdUnidad
INNER JOIN Gerencia
ON 
Gerencia.IdGerencia = Unidad.IdGerencia
INNER JOIN Regional
ON
Regional.IdRegional =Gerencia.IdRegional
order by
Zona.CodigoZona
*/
--insertar unidad con gerencia
/*
INSERT INTO Unidad(DescripcionUnidad,CodigoUnidad,Estado,IdGerencia)
VALUES ('FDBREP1TM','FDBREP1TM',1,10);
*/
--ZONAS QUE YA LLENARON LA ENCUSTA
/*
SELECT Zona.DescripcionZona, *
from EncabezadoListaDeChequeo join Usuario
on Usuario.IdUsuario = EncabezadoListaDeChequeo.IdUsuario
join Zona on Usuario.IdZona = Zona.IdZona
where Fecha between '2020-01-22 05:00:00' and '2020-01-22 23:00:00'
order by 
Zona.DescripcionZona
*/

Set @FechaInicio='2020-03-13 05:00:00'
Set @FechaFin='2020-03-13 23:59:00'

-- Usuarios con Monitoreo
SELECT 
UsuBav.Identificacion,
UsuBav.PrimerNombre Usuario,
UsuBav.PrimerApellido Usuario,
ZonaBav.CodigoZona Zona,
RegionalBav.DescripcionRegional Regional,
GerenciaBav.DescripcionGerencia Gerencia,
UnidadBav.DescripcionUnidad Unidad,
Mon.IdDispositivo Dispositivo,
Mon.idmonitoreo,
DATEADD(HH,-5,Mon.fechaCreacion) Fecha
FROM Usuario AS UsuBav
INNER JOIN Monitoreo AS Mon
ON 
UsuBav.IdUsuario = Mon.IdUsuario
INNER JOIN Zona AS ZonaBav
ON 
UsuBav.IdZona = ZonaBav.IdZona
INNER JOIN Unidad AS UnidadBav
ON 
ZonaBav.IdUnidad = UnidadBav.IdUnidad
INNER JOIN Gerencia AS GerenciaBav
ON 
UnidadBav.IdGerencia = GerenciaBav.IdGerencia
INNER JOIN Regional AS RegionalBav
ON 
GerenciaBav.IdRegional = RegionalBav.IdRegional
WHERE 
Mon.FechaCreacion between @FechaInicio and @FechaFin --AND DescripcionZona = 'Com1r5'
order by
ZonaBav.CodigoZona


-- Usuarios Sin Monitoreo
/*
SELECT 
UsuBav.Identificacion,
UsuBav.PrimerNombre Usuario,
ZonaBav.CodigoZona Zona,
RegionalBav.DescripcionRegional Regional,
GerenciaBav.DescripcionGerencia Gerencia,
UnidadBav.DescripcionUnidad Unidad,
DATEADD(HH,-5,Mon.fechaCreacion) Fecha
FROM Usuario AS UsuBav
LEFT JOIN Monitoreo AS Mon
ON 
UsuBav.IdUsuario = Mon.IdUsuario and Mon.FechaCreacion between @FechaInicio and @FechaFin
INNER JOIN Zona AS ZonaBav
ON 
UsuBav.IdZona = ZonaBav.IdZona
INNER JOIN Unidad AS UnidadBav
ON 
ZonaBav.IdUnidad = UnidadBav.IdUnidad
INNER JOIN Gerencia AS GerenciaBav
ON 
UnidadBav.IdGerencia = GerenciaBav.IdGerencia
INNER JOIN Regional AS RegionalBav
ON 
GerenciaBav.IdRegional = RegionalBav.IdRegional
WHERE Mon.IdMonitoreo is null
order by
ZonaBav.CodigoZona
*/