USE AEROPUERTO
GO

/*
 ROW_NUMBER() en SQL actúa como un contador para las filas de datos. Es como un asistente que enumera cada fila en una tabla, asignándoles un número en función del orden en que aparecen.

Cuando se utiliza ROW_NUMBER(), se le indica en qué orden enumerar las filas. Por ejemplo, se puede decir que enumere las filas en orden alfabético por un determinado campo. Luego, ROW_NUMBER() asigna números a cada fila en ese orden, comenzando desde el número 1.

Cuando se ejecuta una consulta que incluye ROW_NUMBER(), se obtiene una lista de datos junto con números de fila asignados a cada fila. Estos números de fila pueden ser útiles para identificar o realizar cálculos basados en el orden de los datos.

*/
--Asignar números de fila a cada registro en una tabla
SELECT ROW_NUMBER() OVER (ORDER BY COD_CLIENTE) AS numero_fila, nombre
FROM CLIENTE;

--Asignar números de fila a cada vuelo y mostrar solo los primeros 10 registros:
SELECT numero_fila, COD_VUELO, FECHA_SALIDA, hora_salida
FROM (
    SELECT ROW_NUMBER() OVER (ORDER BY FECHA_SALIDA, hora_salida) AS numero_fila, COD_VUELO, FECHA_SALIDA, hora_salida
    FROM VUELO
) AS vuelos_numerados
WHERE numero_fila <= 10;

--Calcular el ranking de vuelos por ciudad de destino
/*
Cada vez que aparezca un nuevo COD_AEROPUERTO_DESTINO la numeracion se reinicia
*/
SELECT COD_VUELO, FECHA_SALIDA, hora_salida, hora_llegada, COD_AEROPUERTO_DESTINO,
       ROW_NUMBER() OVER (PARTITION BY COD_AEROPUERTO_DESTINO ORDER BY FECHA_SALIDA, hora_salida) AS ranking_vuelos
FROM VUELO;
