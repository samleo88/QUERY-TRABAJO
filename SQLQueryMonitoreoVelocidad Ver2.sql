
	   SELECT
	    Zona.DescripcionZona AS [Zona],
	   Unidad.DescripcionUnidad As [Unindad],
	   Gerencia.DescripcionGerencia AS [Gerencia],
	  Regional.DescripcionRegional AS [Regional],
	   /**/CAST(REC.PuntoRecorrido.Lat AS NVARCHAR(50)) AS [LatitudRecorrido],  
					/**/CAST(REC.PuntoRecorrido.Long AS NVARCHAR(50)) AS [LongitudRecorrido],
        Lim.tiempo    AS [TiempoInfraccionSeg], 
       ( Cast(Isnull(rec.velocidad, 0) AS FLOAT) / 3600 ) * ( Cast( 
       CASE 
         WHEN Lim.tiempo IS 
              NULL THEN 0 
         WHEN Lim.tiempo = 
              0 THEN 10 
         ELSE Lim.tiempo 
       END AS FLOAT) ) AS 
       [DistanciaRecorridaInfraccionKM] /*Km/h * 1h/60s = Km/S * (S) = KM*/ 
       , 
       CASE 
         WHEN Lim.idlimitevelocidadrecorrido IS NULL THEN 0 
         ELSE Cast(Isnull(rec.velocidad, 0) AS FLOAT) 
       END 
       AS [VelocidadInfraccionKM/H], 
       rec.fecha 
       AS [FechaInfracción] 

FROM   [BAVARIA].[DBO].[monitoreo] AS MON 
 INNER JOIN [BAVARIA].[DBO].[Usuario] AS  Usu
	           ON Usu.IdUsuario = Mon.IdUsuario
	   INNER JOIN [BAVARIA].[DBO].[Zona] AS Zona
	           ON Zona.IdZona = Usu.IdZona
       INNER JOIN [BAVARIA].[DBO].[Unidad]
				ON Zona.IdUnidad = Unidad.IdUnidad
	   INNER JOIN [BAVARIA].[DBO].[Gerencia]
	            ON Unidad.IdGerencia = Gerencia.IdGerencia
		INNER JOIN [BAVARIA].[DBO].[Regional]
		        ON Gerencia.IdRegional = Regional.IdRegional
       INNER JOIN [MONITOREO].[DBO].[recorrido] AS REC 
               ON MON.idmonitoreo = REC.idmonitoreo 
       --and rec.Fecha > convert(date, (getdate()-10))and rec.Fecha < convert(date, (getdate()))
       INNER JOIN [MONITOREO].[DBO].limitevelocidadrecorrido AS LIM 
               ON rec.idrecorrido = LIM.idrecorrido 
       --DE CADA RECORRIDO TRAIGAME SUS INFRACCIONES  
       INNER JOIN [MONITOREO].[DBO].[recorrido] AS RecAnt 
               ON rec.idrecorridopredecesor = recant.idrecorrido 
                  AND rec.idmonitoreo = RecAnt.idmonitoreo 
       INNER JOIN [MONITOREO].[DBO].distanciarecorrido AS xRec 
               ON rec.idrecorrido = xRec.idrecorrido 
			   where rec.fecha between '2020-02-01 05:00:00' and '2020-02-29 23:00:00'
			   order by rec.fecha
--WHERE  rec.fecha > CONVERT(DATE, ( Getdate() - 31 )) 
--       AND rec.fecha < CONVERT(DATE, ( Getdate() )) 
--       AND mon.fechacreacion > '2019-11-30 00:00:00.000'; --Salida a Producción;  

