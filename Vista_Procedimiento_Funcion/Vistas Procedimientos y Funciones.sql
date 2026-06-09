use BD_Ahorros_Bancario
go

/*****************************************************************************
		Ejercicios de Vistas, Procedimientos Almacenados y Funciones
******************************************************************************/


/*******************************************
		Vistas
********************************************/

/* 1. Vista de cuentas activas */

CREATE VIEW VW_CUENTAS_ACTIVAS
AS
SELECT *
FROM CUENTA
WHERE estado='ACTIVO';

--select * from VW_CUENTAS_ACTIVAS

/* 2. Vista de cuentas y clientes */

CREATE VIEW VW_CUENTA_CLIENTE
AS
SELECT
    cu.numero_cuenta,
    cu.saldo_actual,
    tc.nombre_tipo_cuenta,
    m.nombre_moneda,
    cl.id_cliente
FROM CUENTA cu
INNER JOIN CLIENTE cl
ON cu.id_cliente = cl.id_cliente
INNER JOIN TIPO_CUENTA tc
ON cu.id_tipo_cuenta = tc.id_tipo_cuenta
INNER JOIN MONEDA m
ON cu.id_moneda = m.id_moneda;

--select * from VW_CUENTA_CLIENTE

/* 3 Vista de transferencias */

CREATE VIEW VW_TRANSFERENCIAS
AS
SELECT
    o.codigo_operacion,
    o.monto,
    t.cuenta_destino,
    t.banco_destino
FROM TRANSFERENCIA t
INNER JOIN OPERACION o
ON t.id_operacion=o.id_operacion;

--select * from VW_TRANSFERENCIAS

/*******************************************
		Procedimientos
********************************************/

/* 4. Buscar cuenta   */

CREATE PROCEDURE SP_BUSCAR_CUENTA
(
    @numero_cuenta VARCHAR(20)
)
AS
BEGIN

SELECT *
FROM CUENTA
WHERE numero_cuenta=@numero_cuenta

END

/* 5. Consulta saldo */

CREATE PROCEDURE SP_CONSULTAR_SALDO
(
    @id_cuenta INT
)
AS
BEGIN

SELECT
numero_cuenta,
saldo_actual
FROM CUENTA
WHERE id_cuenta=@id_cuenta

END

/* 6. Operaciones por rango de fechas */

CREATE PROCEDURE SP_OPERACIONES_FECHA
(
 @fecha_inicio DATE,
 @fecha_fin DATE
)
AS
BEGIN

SELECT *
FROM OPERACION
WHERE fecha_operacion
BETWEEN @fecha_inicio AND @fecha_fin

END

/* 7. Actualizar estado cuenta*/

CREATE PROCEDURE SP_ACTUALIZAR_ESTADO_CUENTA
(
 @id_cuenta INT,
 @estado VARCHAR(20)
)
AS
BEGIN

UPDATE CUENTA
SET estado=@estado
WHERE id_cuenta=@id_cuenta

END

/*******************************************
		Funciones
********************************************/

/* 8. Calcular interés anual*/

CREATE FUNCTION FN_INTERES_ANUAL
(
 @saldo DECIMAL(18,2),
 @tasa DECIMAL(5,2)
)
RETURNS DECIMAL(18,2)
AS
BEGIN

RETURN @saldo * (@tasa/100)

END

/* 9. Obtener saldo total del cliente*/

CREATE FUNCTION FN_SALDO_TOTAL_CLIENTE
(
 @id_cliente INT
)
RETURNS DECIMAL(18,2)
AS
BEGIN

DECLARE @saldo DECIMAL(18,2)

SELECT
@saldo=SUM(saldo_actual)
FROM CUENTA
WHERE id_cliente=@id_cliente

RETURN ISNULL(@saldo,0)

END

/* 10. Total depósitos cuenta*/

CREATE FUNCTION FN_TOTAL_DEPOSITOS
(
 @id_cuenta INT
)
RETURNS DECIMAL(18,2)
AS
BEGIN

DECLARE @total DECIMAL(18,2)

SELECT
@total=SUM(monto)
FROM OPERACION
WHERE id_cuenta=@id_cuenta
AND id_tipo_operacion=1

RETURN ISNULL(@total,0)

END