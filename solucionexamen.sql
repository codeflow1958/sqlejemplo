/*
Encuentra el promedio del total de ventas diarias de todos los pedidos para cada mes del año 2023. Muestra el mes, el año y el promedio del total de ventas diarias redondeado a dos decimales. 
Crea una tabla llamada "TopClientes" que almacene los cinco clientes principales en términos de cantidad total gastada. La tabla debe contener las columnas: IDCliente, Nombre y TotalGastado. 
Encuentra los productos más vendidos por mes durante el año 2023. Crea una tabla llamada "ProductosMasVendidos" que contenga el mes, el año, el nombre del producto y la cantidad total vendida para cada producto en cada mes. 
Encuentra la diferencia en días entre la fecha del primer pedido y la fecha del último pedido para cada cliente. Muestra el ID del cliente y la diferencia en días. 
Crea una tabla llamada "ResultadoTransformacion" que almacene los resultados de todas las consultas anteriores. Asegúrate de que la tabla esté correctamente estructurada para contener los resultados de cada consulta. 
*/
USE BD_EXAMEN
GO

SET NOCOUNT ON
IF OBJECT_ID('tempdb..#BASE') IS NOT NULL
BEGIN
	DROP TABLE #BASE
END
SELECT 
YEAR(P.FechaPedido) ANIO
,MONTH(P.FechaPedido) MES
,P.FechaPedido
,C.IDCliente
,C.NombreCompleto AS CLIENTE
,D.Cantidad
,PR.NombreProducto AS PRODUCTO
,PR.Precio
,PR.Precio*D.Cantidad AS TOTAL
INTO #BASE
FROM CLIENTE C 
JOIN PEDIDO P ON C.IDCliente = P.IDCliente
JOIN DETALLE D ON D.IDPedido = P.IDPedido
JOIN PRODUCTO PR ON PR.IDProducto = D.IDProducto
WHERE YEAR(P.FechaPedido) = 2023

--IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'rs')
--BEGIN
--    -- Crea el esquema si no existe
--    EXEC('CREATE SCHEMA rs')
--    PRINT 'El esquema ha sido creado.'
--END
--ELSE
--BEGIN
--    -- Borra el esquema si existe
--    DROP SCHEMA rs
--    PRINT 'El esquema ha sido eliminado.'
--END


/*
Encuentra el promedio del total de ventas diarias de todos los pedidos para cada mes del año 2023. Muestra el mes, el año y el promedio del total de ventas diarias redondeado a dos decimales. 
*/

TRUNCATE TABLE RS.PROMEDIO_MENSUAL
INSERT INTO RS.PROMEDIO_MENSUAL(ANIO, MES, PROMEDIO)
SELECT ANIO, MES, CAST(AVG(TOTAL) AS NUMERIC(16,2)) PROMEDIO--, ROUND(AVG(TOTAL),2)
--INTO RS.PROMEDIO_MENSUAL
FROM #BASE
GROUP BY ANIO, MES

/*
Crea una tabla llamada "TopClientes" que almacene los cinco clientes principales en términos de cantidad total gastada. La tabla debe contener las columnas: IDCliente, Nombre y TotalGastado. 
*/

TRUNCATE TABLE RS.TOP_CLIENTES
INSERT INTO RS.TOP_CLIENTES(CLIENTE, TOTAL)
SELECT TOP 5 CLIENTE, SUM(TOTAL) TOTAL
FROM #BASE
GROUP BY CLIENTE
ORDER BY TOTAL DESC


/*
Encuentra los productos más vendidos por mes durante el año 2023. Crea una tabla llamada "ProductosMasVendidos" que contenga el mes, el año, el nombre del producto y la cantidad total vendida para cada producto en cada mes. 
*/

--SET LANGUAGE Spanish;
IF OBJECT_ID('tempdb..#PRODUCTOS') IS NOT NULL
BEGIN
	DROP TABLE #PRODUCTOS
END
SELECT *, ROW_NUMBER() OVER (PARTITION BY ANIO, MES ORDER BY TOTAL DESC) RN
INTO #PRODUCTOS
FROM (
SELECT ANIO, MES, DATENAME(MONTH, FechaPedido) NOMBRE_MES, PRODUCTO, SUM(TOTAL) TOTAL
FROM #BASE
GROUP BY ANIO, MES, DATENAME(MONTH, FechaPedido), PRODUCTO
) A

TRUNCATE TABLE RS.TOP_PRODUCTO_MENSUAL
INSERT INTO RS.TOP_PRODUCTO_MENSUAL(ANIO, MES, PRODUCTO, TOTAL)
SELECT ANIO, MES, PRODUCTO, TOTAL
--INTO RS.TOP_PRODUCTO_MENSUAL
FROM #PRODUCTOS
WHERE RN = 1

/*
Encuentra la diferencia en días entre la fecha del primer pedido y la fecha del último pedido para cada cliente. Muestra el ID del cliente y la diferencia en días. 
*/

TRUNCATE TABLE RS.DIFERENCIA_CLIENTE
INSERT INTO RS.DIFERENCIA_CLIENTE(IDCliente, DIAS_DIFERENCIA)
SELECT IDCliente, DATEDIFF(DAY, MIN(FECHAPEDIDO), MAX(FECHAPEDIDO)) DIAS_DIFERENCIA
--INTO RS.DIFERENCIA_CLIENTE
FROM #BASE
GROUP BY IDCliente




--ResultadoTransformacion
TRUNCATE TABLE RS.ResultadoTransformacion
INSERT INTO RS.ResultadoTransformacion(CATEGORIA,ANIO, MES, DESCRIPCION, CANTIDAD)
SELECT 'TOP_PRODUCTO_MENSUAL' CATEGORIA, ANIO, MES, PRODUCTO AS DESCRIPCION, TOTAL AS CANTIDAD 
--INTO RS.ResultadoTransformacion
FROM RS.TOP_PRODUCTO_MENSUAL
UNION ALL
SELECT 'PROMEDIO_MENSUAL' CATEGORIA, ANIO, MES, NULL ,PROMEDIO AS CANTIDAD FROM RS.PROMEDIO_MENSUAL
UNION ALL
SELECT 'TOP_CLIENTES' CATEGORIA, NULL, NULL, CLIENTE, TOTAL FROM RS.TOP_CLIENTES

INSERT INTO RS.ResultadoTransformacion(CATEGORIA,ANIO, MES, DESCRIPCION, CANTIDAD)
SELECT 'DIFERENCIA_CLIENTE' CATEGORIA, NULL, NULL, IDCliente, DIAS_DIFERENCIA AS CANTIDAD FROM RS.DIFERENCIA_CLIENTE

