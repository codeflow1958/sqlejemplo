USE AEROPUERTO
GO

/*
Cuando se utiliza JOIN, se especifica una condición de unión que determina cómo las filas de una tabla se relacionan con las filas de otra tabla. Esto generalmente implica comparar los valores de una columna en una tabla con los valores de una columna correspondiente en otra tabla.

Hay varios tipos de JOIN en SQL Server, incluyendo:

INNER JOIN: Retorna las filas que tienen al menos una coincidencia en ambas tablas basándose en la condición de unión.

LEFT JOIN (también conocido como LEFT OUTER JOIN): Retorna todas las filas de la tabla izquierda y las filas coincidentes de la tabla derecha, y NULL en las columnas de la tabla derecha cuando no hay coincidencias.

RIGHT JOIN (también conocido como RIGHT OUTER JOIN): Retorna todas las filas de la tabla derecha y las filas coincidentes de la tabla izquierda, y NULL en las columnas de la tabla izquierda cuando no hay coincidencias.

FULL JOIN (también conocido como FULL OUTER JOIN): Retorna todas las filas cuando hay una coincidencia en una de las tablas. Esto incluye filas de la tabla izquierda cuando no hay coincidencia en la tabla derecha, y viceversa.

CROSS JOIN: Retorna el producto cartesiano de las filas de las tablas unidas. Es decir, combina cada fila de la primera tabla con cada fila de la segunda tabla.
*/

--INNER JOIN:
--Este INNER JOIN devolverá solo los vuelos que tienen una correspondencia en la tabla de aeropuertos, es decir, solo los vuelos que tienen un aeropuerto de salida asociado.
SELECT V.COD_VUELO, V.FECHA_SALIDA, V.hora_salida, A.nombre AS nombre_aeropuerto
FROM VUELO V
INNER JOIN AEROPUERTO A ON V.COD_AEROPUERTO_DESTINO = A.COD_AEROPUERTO;

--LEFT JOIN:
--Este LEFT JOIN devolverá todos empleados que no han sido tripulantes en ningun vuelo 
SELECT E.NOMBRE EMPLEADO, T.COD_VUELO, T.COD_TRIPULANTE
FROM EMPLEADO E
LEFT JOIN TRIPULANTE T ON E.COD_EMPLEADO = T.COD_EMPLEADO

--RIGHT JOIN:
--Este RIGHT JOIN devolverá todos empleados que no han sido tripulantes en ningun vuelo 
SELECT E.NOMBRE EMPLEADO, T.COD_VUELO, T.COD_TRIPULANTE
FROM TRIPULANTE T
LEFT JOIN EMPLEADO E ON E.COD_EMPLEADO = T.COD_EMPLEADO

--FULL JOIN:
--Este FULL JOIN devolverá todas las filas de ambas tablas, incluyendo las que no tienen correspondencia en la otra tabla. Si no hay coincidencia, las columnas de la tabla sin coincidencia serán NULL.
SELECT E.NOMBRE EMPLEADO, T.COD_VUELO, T.COD_TRIPULANTE
FROM TRIPULANTE T
FULL JOIN EMPLEADO E ON E.COD_EMPLEADO = T.COD_EMPLEADO



--CROSS JOIN:
--Este CROSS JOIN combina cada fila de la tabla de vuelos con cada fila de la tabla de aeropuertos, generando un producto cartesiano de las dos tablas.
SELECT V.COD_VUELO, V.FECHA_SALIDA, V.hora_salida, A.nombre AS nombre_aeropuerto
FROM VUELO V
CROSS JOIN AEROPUERTO A 