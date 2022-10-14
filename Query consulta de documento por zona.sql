
USE[Bavaria]
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
where DetalleListaChequeo.IdPregunta=28 and Fecha between '2020-03-13 01:00:00.000' and '2020-03-13 23:59:59.998'
order by EncabezadoListaDeChequeo.Fecha

