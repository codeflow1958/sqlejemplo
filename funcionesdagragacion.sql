USE AEROPUERTO
GO
/*
Las funciones de agregación son funciones que operan sobre un conjunto de valores y devuelven un único valor resumen. 
*/

--SUM(): Calcula la suma de valores en una columna.
SELECT SUM(precio) AS total_ventas
FROM DETALLE_FACTURA


--COUNT(): Cuenta el número de filas en un conjunto de resultados.
SELECT COUNT(*) AS cantidad_clientes
FROM cliente

--AVG(): Calcula el promedio de valores en una columna.
SELECT AVG(PRECIO) AS promedio_ventas
FROM DETALLE_FACTURA

--MAX(): Encuentra el valor máximo en una columna.
SELECT MAX(PRECIO) AS precio_maximo
FROM DETALLE_FACTURA

--MIN(): Encuentra el valor mínimo en una columna.
SELECT MIN(PRECIO) AS precio_minima
FROM DETALLE_FACTURA

/*
GROUP BY en SQL:
*/
--SUM() con GROUP BY:
--Calcula la suma de valores en una columna para cada grupo definido por una o más columnas.
SELECT F.FECHA_FACTURA, SUM(PRECIO) AS TOTAL_VENTAS
FROM DETALLE_FACTURA D
JOIN FACTURA F ON D.COD_FACTURA = F.COD_FACTURA
GROUP BY F.FECHA_FACTURA
HAVING SUM(PRECIO) < 1000000

--COUNT() con GROUP BY:
--Cuenta el número de filas para cada grupo definido por una o más columnas.
SELECT F.FECHA_FACTURA, COUNT(PRECIO) AS CANTIDAD_VENTAS
FROM DETALLE_FACTURA D
JOIN FACTURA F ON D.COD_FACTURA = F.COD_FACTURA
GROUP BY F.FECHA_FACTURA
HAVING COUNT(PRECIO) < 1000

--AVG() con GROUP BY:
--Calcula el promedio de valores en una columna para cada grupo definido por una o más columnas.
SELECT F.FECHA_FACTURA, AVG(PRECIO) AS PROMEDIO_VENTAS
FROM DETALLE_FACTURA D
JOIN FACTURA F ON D.COD_FACTURA = F.COD_FACTURA
GROUP BY F.FECHA_FACTURA


--MAX() con GROUP BY:
--Encuentra el valor máximo en una columna para cada grupo definido por una o más columnas.
SELECT F.FECHA_FACTURA, MAX(PRECIO) AS PRECIO_MAXIMO
FROM DETALLE_FACTURA D
JOIN FACTURA F ON D.COD_FACTURA = F.COD_FACTURA
GROUP BY F.FECHA_FACTURA

--MIN() con GROUP BY:
--Encuentra el valor mínimo en una columna para cada grupo definido por una o más columnas.
SELECT F.FECHA_FACTURA, MIN(PRECIO) AS PRECIO_MINIMO
FROM DETALLE_FACTURA D
JOIN FACTURA F ON D.COD_FACTURA = F.COD_FACTURA
GROUP BY F.FECHA_FACTURA

/*
APLICANDO FILTROS SOBRE UNA FUNCION DE AGREGACION
*/
--SUM() con GROUP BY:
--Calcula la suma de valores en una columna para cada grupo definido por una o más columnas.
SELECT F.FECHA_FACTURA, SUM(PRECIO) AS TOTAL_VENTAS
FROM DETALLE_FACTURA D
JOIN FACTURA F ON D.COD_FACTURA = F.COD_FACTURA
GROUP BY F.FECHA_FACTURA
HAVING SUM(PRECIO) < 1000000

--COUNT() con GROUP BY:
--Cuenta el número de filas para cada grupo definido por una o más columnas.
SELECT F.FECHA_FACTURA, COUNT(PRECIO) AS CANTIDAD_VENTAS
FROM DETALLE_FACTURA D
JOIN FACTURA F ON D.COD_FACTURA = F.COD_FACTURA
GROUP BY F.FECHA_FACTURA
HAVING COUNT(PRECIO) < 1000

--AVG() con GROUP BY:
--Calcula el promedio de valores en una columna para cada grupo definido por una o más columnas.
SELECT F.FECHA_FACTURA, AVG(PRECIO) AS PROMEDIO_VENTAS
FROM DETALLE_FACTURA D
JOIN FACTURA F ON D.COD_FACTURA = F.COD_FACTURA
GROUP BY F.FECHA_FACTURA
HAVING AVG(PRECIO) < 5500


--MAX() con GROUP BY:
--Encuentra el valor máximo en una columna para cada grupo definido por una o más columnas.
SELECT F.FECHA_FACTURA, MAX(PRECIO) AS PRECIO_MAXIMO
FROM DETALLE_FACTURA D
JOIN FACTURA F ON D.COD_FACTURA = F.COD_FACTURA
GROUP BY F.FECHA_FACTURA
HAVING MAX(PRECIO) < 7900

--MIN() con GROUP BY:
--Encuentra el valor mínimo en una columna para cada grupo definido por una o más columnas.
SELECT F.FECHA_FACTURA, MIN(PRECIO) AS PRECIO_MINIMO
FROM DETALLE_FACTURA D
JOIN FACTURA F ON D.COD_FACTURA = F.COD_FACTURA
GROUP BY F.FECHA_FACTURA
HAVING MIN(PRECIO) > 3200


/*
APLICANDO FILTROS SOBRE UNA FUNCION DE AGREGACION Y FILTROS SOBRE DATOS ESPECIFICOS
*/
--SUM() con GROUP BY:
--Calcula la suma de valores en una columna para cada grupo definido por una o más columnas.
SELECT F.FECHA_FACTURA, SUM(PRECIO) AS TOTAL_VENTAS
FROM DETALLE_FACTURA D
JOIN FACTURA F ON D.COD_FACTURA = F.COD_FACTURA
WHERE F.FECHA_FACTURA BETWEEN '20221001' AND '20221031'
GROUP BY F.FECHA_FACTURA
HAVING SUM(PRECIO) < 1000000

--COUNT() con GROUP BY:
--Cuenta el número de filas para cada grupo definido por una o más columnas.
SELECT F.FECHA_FACTURA, COUNT(PRECIO) AS CANTIDAD_VENTAS
FROM DETALLE_FACTURA D
JOIN FACTURA F ON D.COD_FACTURA = F.COD_FACTURA
WHERE F.FECHA_FACTURA BETWEEN '20221001' AND '20221031'
GROUP BY F.FECHA_FACTURA
HAVING COUNT(PRECIO) < 1000

--AVG() con GROUP BY:
--Calcula el promedio de valores en una columna para cada grupo definido por una o más columnas.
SELECT F.FECHA_FACTURA, AVG(PRECIO) AS PROMEDIO_VENTAS
FROM DETALLE_FACTURA D
JOIN FACTURA F ON D.COD_FACTURA = F.COD_FACTURA
WHERE F.FECHA_FACTURA BETWEEN '20221001' AND '20221031'
GROUP BY F.FECHA_FACTURA
HAVING AVG(PRECIO) < 5500


--MAX() con GROUP BY:
--Encuentra el valor máximo en una columna para cada grupo definido por una o más columnas.
SELECT F.FECHA_FACTURA, MAX(PRECIO) AS PRECIO_MAXIMO
FROM DETALLE_FACTURA D
JOIN FACTURA F ON D.COD_FACTURA = F.COD_FACTURA
WHERE F.FECHA_FACTURA BETWEEN '20221001' AND '20221031'
GROUP BY F.FECHA_FACTURA
HAVING MAX(PRECIO) < 7900

--MIN() con GROUP BY:
--Encuentra el valor mínimo en una columna para cada grupo definido por una o más columnas.
SELECT F.FECHA_FACTURA, MIN(PRECIO) AS PRECIO_MINIMO
FROM DETALLE_FACTURA D
JOIN FACTURA F ON D.COD_FACTURA = F.COD_FACTURA
WHERE F.FECHA_FACTURA BETWEEN '20221001' AND '20221031'
GROUP BY F.FECHA_FACTURA
HAVING MIN(PRECIO) > 3200
