USE AEROPUERTO
GO

CREATE OR ALTER PROCEDURE SP_DETALLE_VUELOS(
@FECHA DATE
)
AS
BEGIN

DECLARE @AEROPUERTO AS TABLE(
PAIS VARCHAR(500)
,CIUDAD VARCHAR(500)
,AEROPUERTO VARCHAR(500)
,COD_AEROPUERTO INT
)
INSERT INTO @AEROPUERTO
SELECT P.NOMBRE PAIS, C.NOMBRE CIUDAD, A.NOMBRE AEROPUERTO, A.COD_AEROPUERTO 
FROM PAIS P
JOIN CIUDAD C ON C.COD_PAIS = P.COD_PAIS
JOIN AEROPUERTO A ON C.COD_CIUDAD = A.COD_CIUDAD



DECLARE @PRE_BASE AS TABLE (
COD_VUELO INT
,PAIS_ORIGEN VARCHAR(500)
,CIUDAD_ORIGEN VARCHAR(500)
,AEROPUERTO_ORIGEN VARCHAR(500)
,PAIS_DESTINO VARCHAR(500)
,CIUDAD_DESTINO VARCHAR(500)
,AEROPUERTO_DESTINO VARCHAR(500)
,FECHA_SALIDA DATE
,HORA_SALIDA TIME
,HORA_LLEGADA TIME
,HORAS_VUELO INT
)
INSERT INTO @PRE_BASE
SELECT V.COD_VUELO, 
AO.PAIS PAIS_ORIGEN, 
AO.CIUDAD CIUDAD_ORIGEN,
AO.AEROPUERTO AEROPUERTO_ORIGEN,
AD.PAIS PAIS_DESTINO, 
AD.CIUDAD CIUDAD_DESTINO, 
AD.AEROPUERTO AEROPUERTO_DESTINO,
FECHA_SALIDA, 
HORA_SALIDA, 
HORA_LLEGADA, 
DATEDIFF(HOUR, HORA_SALIDA, HORA_LLEGADA) HORAS_VUELO
FROM VUELO V 
LEFT JOIN @AEROPUERTO AD ON V.COD_AEROPUERTO_DESTINO = AD.COD_AEROPUERTO 
LEFT JOIN @AEROPUERTO AO ON V.COD_AEROPUERTO_DESTINO = AO.COD_AEROPUERTO 
WHERE FECHA_SALIDA = @FECHA


TRUNCATE TABLE INFORMACION_VUELOS

INSERT INTO INFORMACION_VUELOS
SELECT 
P.FECHA_SALIDA, 
P.HORA_SALIDA, 
P.HORA_LLEGADA,
P.COD_VUELO, 
P.PAIS_ORIGEN, 
P.CIUDAD_ORIGEN,
P.AEROPUERTO_ORIGEN,
P.PAIS_DESTINO, 
P.CIUDAD_DESTINO, 
P.AEROPUERTO_DESTINO,
P.HORAS_VUELO,
COUNT(COD_PASAJERO) CANTIDAD_PASAJEROS,
COUNT(T.COD_EMPLEADO) CANTIDAD_TRIPULANTE,
SUM(DF.PRECIO) MONTO_GENERADO
FROM @PRE_BASE P
LEFT JOIN BOLETO B ON P.COD_VUELO = B.COD_VUELO
LEFT JOIN TRIPULANTE T ON T.COD_VUELO = P.COD_VUELO
LEFT JOIN DETALLE_FACTURA DF ON DF.COD_BOLETO = B.COD_BOLETO
GROUP BY P.COD_VUELO, 
P.PAIS_ORIGEN, 
P.CIUDAD_ORIGEN,
P.AEROPUERTO_ORIGEN,
P.PAIS_DESTINO, 
P.CIUDAD_DESTINO, 
P.AEROPUERTO_DESTINO,
P.FECHA_SALIDA, 
P.HORA_SALIDA, 
P.HORA_LLEGADA, 
P.HORAS_VUELO

END