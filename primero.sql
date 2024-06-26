CREATE DATABASE PRUEBAS
GO

USE PRUEBAS
GO
/*
ALTER - MODIFICAR
Este comando permite modificar las columnas de una tabla
*/
DROP TABLE EMPLEADO
CREATE TABLE EMPLEADO(
COD_EMPLEADO INT NOT NULL,
NOMBRE_COMPLETO VARCHAR(100),
FECHA_NAC DATE,
FECHA_INGRESO DATETIME,
SUELDO NUMERIC(10,2),
ES_NUEVO BIT
)


--AGREGAR UNA COLUMNA NUEVA
ALTER TABLE EMPLEADO
ADD GENERO VARCHAR(5)

--AGREGAR UNA COLUMNA CON UN VALOR POR DEFECTO
ALTER TABLE EMPLEADO
ADD ESTADO INT DEFAULT(1)

--BORRAR UNA COLUMNA
ALTER TABLE EMPLEADO
DROP COLUMN GENERO

--CAMBIAR TIPO DE DATO
ALTER TABLE EMPLEADO
ALTER COLUMN NOMBRE_COMPLETO VARCHAR(50)

--AGREGAR LLAVE PRIMARIA
----PARA AGREGAR LA LLAVE PRIMARIA LA COLUMNA DEBE DE SER NOT NULL, YA QUE UNA LLACE NO PUEDE ESTAR VACIA
ALTER TABLE EMPLEADO
ADD CONSTRAINT PK_EMPLEADO PRIMARY KEY(COD_EMPLEADO)

--AGREGAR LLAVE FORANEA
---COMO NO EXISTE EL CAMPO PARA HACER LA LLAVE FORANEA, PRIMERO DEBEMOS CREARLO
ALTER TABLE EMPLEADO
ADD COD_JEFE INT NULL

---UNA VEZ AGREGADO EL CAMPO PROCEDEMOS CON HACER LA RELACION
ALTER TABLE EMPLEADO
ADD CONSTRAINT FK_EMPLEADO_JEFE FOREIGN KEY(COD_JEFE) REFERENCES EMPLEADO(COD_EMPLEADO)

--ELIMINAR LLAVE PRIMARIA
----NO SE PUEDE ELIMINAR LA LLAEC PRIMARIA SI EXISTE UNA LLAVE FORANEA
ALTER TABLE EMPLEADO
DROP CONSTRAINT FK_EMPLEADO_JEFE

-------UNA VEZ ELIMINADA LA FK, SE PUEDE ELIMINAR LA PK
ALTER TABLE EMPLEADO
DROP CONSTRAINT PK_EMPLEADO
