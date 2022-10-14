
USE[Bavaria]

DECLARE @FechaInicio Datetime
DECLARE @FechaFin Datetime
--FECHA PARA LAS DOS CONSULTAS SOLO SE CAMBIA ACA Y AFECTA A LAS DOS
Set @FechaInicio='2020-04-30 00:00:01'
Set @FechaFin='2020-04-30 23:59:58'


--ZONAS QUE YA LLENARON LA ENCUSTA

SELECT Zona.DescripcionZona, *
from EncabezadoListaDeChequeo join Usuario
on Usuario.IdUsuario = EncabezadoListaDeChequeo.IdUsuario
join Zona on Usuario.IdZona = Zona.IdZona
where Fecha between @FechaInicio and @FechaFin -- AND DescripcionZona IN ('COM3BF')
order by
Zona.DescripcionZona

--ZONAS CON EL NUMERO DE CEDULA

SELECT
Zona.DescripcionZona,  
DetalleListaChequeo.Observaion,
EncabezadoListaDeChequeo.Fecha
FROM DetalleListaChequeo
inner join EncabezadoListaDeChequeo
On DetalleListaChequeo.IdEncabezadoListaChequeo =EncabezadoListaDeChequeo.IdEncabezadoListaChequeo
inner join Usuario
on EncabezadoListaDeChequeo.IdUsuario =Usuario.IdUsuario
inner join Zona
on Usuario.IdZona = Zona.IdZona
where DetalleListaChequeo.IdPregunta=28 and Fecha between @FechaInicio and @FechaFin
order by EncabezadoListaDeChequeo.Fecha