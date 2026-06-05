use BD_Ahorros_Bancario
go

/******************************************************
		CONSULTAS AVANZADAS Y EXPERTAS
*******************************************************/

/************* 1. Ranking de clientes por saldo total ************/

SELECT
    id_cliente,
    SUM(saldo_actual) saldo_total,
    RANK() OVER
    (
        ORDER BY SUM(saldo_actual) DESC
    ) ranking
FROM CUENTA
GROUP BY id_cliente

/************* 2. Agencias con mayor volumen de depósito ************/

SELECT TOP 10
    a.nombre_agencia,
    SUM(o.monto) total
FROM OPERACION o
INNER JOIN CUENTA c
    ON o.id_cuenta = c.id_cuenta
INNER JOIN AGENCIA a
    ON c.id_agencia = a.id_agencia
WHERE o.id_tipo_operacion = 1
GROUP BY a.nombre_agencia
ORDER BY total DESC

/************* 3. Porcentaje de participación de cada producto ************/

SELECT
    tc.nombre_tipo_cuenta,
    SUM(c.saldo_actual) saldo_total,
    ROUND(
        SUM(c.saldo_actual) * 100.0 /
        SUM(SUM(c.saldo_actual)) OVER(),
    2) porcentaje
FROM CUENTA c
    INNER JOIN TIPO_CUENTA tc
        ON c.id_tipo_cuenta = tc.id_tipo_cuenta
GROUP BY tc.nombre_tipo_cuenta

/************* 4. Operaciones realizadas fuera del horario laboral ************/

SELECT *
FROM OPERACION
WHERE DATEPART(HOUR,fecha_operacion) NOT BETWEEN 8 AND 18

/************* 5. Clientes con depósitos en múltiples agencias ************/

SELECT
    cu.id_cliente,
    COUNT(DISTINCT cu.id_agencia) agencias
FROM CUENTA cu
    INNER JOIN OPERACION o
        ON cu.id_cuenta = o.id_cuenta
GROUP BY cu.id_cliente
HAVING COUNT(DISTINCT cu.id_agencia) > 1

/************* 6. Detección de operaciones consecutivas altas ************/

;WITH movimientos AS
(
    SELECT
        id_cuenta,
        fecha_operacion,
        monto,
        LAG(monto)
        OVER
        (
            PARTITION BY id_cuenta
            ORDER BY fecha_operacion
        ) monto_anterior
    FROM OPERACION
)
SELECT *
FROM movimientos
WHERE monto > 5000
AND monto_anterior > 5000

/************* 7. Reporte bancario ************/

SELECT
    a.nombre_agencia,
    COUNT(DISTINCT c.id_cliente) clientes,
    COUNT(DISTINCT cu.id_cuenta) cuentas,
    SUM(cu.saldo_actual) saldo_total,
    COUNT(o.id_operacion) operaciones,
    SUM(ISNULL(o.monto,0)) monto_movido
FROM AGENCIA a
LEFT JOIN CUENTA cu
    ON a.id_agencia = cu.id_agencia
LEFT JOIN CLIENTE c
    ON cu.id_cliente = c.id_cliente
LEFT JOIN OPERACION o
    ON cu.id_cuenta = o.id_cuenta
GROUP BY a.nombre_agencia
ORDER BY saldo_total DESC

/************* 8. Ranking mensual de clientes por dépositos ************/

SELECT
    YEAR(fecha_operacion) anio,
    MONTH(fecha_operacion) mes,
    c.id_cliente,
    SUM(o.monto) total_depositado,
    DENSE_RANK() OVER
    (
        PARTITION BY YEAR(fecha_operacion),
                     MONTH(fecha_operacion)
        ORDER BY SUM(o.monto) DESC
    ) ranking
FROM OPERACION o
    INNER JOIN CUENTA cu
        ON o.id_cuenta=cu.id_cuenta
    INNER JOIN CLIENTE c
        ON cu.id_cliente=c.id_cliente
WHERE o.id_tipo_operacion=1
GROUP BY
YEAR(fecha_operacion),
MONTH(fecha_operacion),
c.id_cliente

/************* 9. Intereses acumulados ************/

SELECT
c.numero_cuenta,
c.saldo_actual,
t.tasa_anual,
ROUND
(c.saldo_actual * (t.tasa_anual/100), 2)
interes_anual
FROM CUENTA c
    INNER JOIN TASA_INTERES t
        ON c.id_tipo_cuenta=t.id_tipo_cuenta

/************* 10. Ranking por agencia y producto ************/

SELECT
    a.nombre_agencia,
    tc.nombre_tipo_cuenta,
    SUM(c.saldo_actual) saldo_total,
    RANK() OVER
    (
        PARTITION BY a.id_agencia
        ORDER BY SUM(c.saldo_actual) DESC
    ) ranking
FROM CUENTA c
INNER JOIN AGENCIA a
    ON c.id_agencia = a.id_agencia
INNER JOIN TIPO_CUENTA tc
    ON c.id_tipo_cuenta = tc.id_tipo_cuenta
GROUP BY
    a.id_agencia,
    a.nombre_agencia,
    tc.nombre_tipo_cuenta