use BD_Ahorros_Bancario
go

/******************************************************
		CONSULTAS BÁSICAS e INTERMEDIAS
*******************************************************/

/************* 1. Mostrar clientes y su cuentas ************/

SELECT
    per_nat.nombres,
    per_nat.apellido_paterno,
    c.numero_cuenta,
    c.saldo_actual
FROM CUENTA c
    INNER JOIN CLIENTE cl
        ON c.id_cliente = cl.id_cliente
    INNER JOIN PERSONA_NATURAL per_nat
        ON cl.id_cliente = per_nat.id_cliente

/************* 2. Total de cuentas por producto ************/

SELECT
    tc.nombre_tipo_cuenta,
    COUNT(*) cantidad
FROM CUENTA c
    INNER JOIN TIPO_CUENTA tc
        ON c.id_tipo_cuenta = tc.id_tipo_cuenta
GROUP BY tc.nombre_tipo_cuenta

/************* 3. Saldo promedio por tipo de cuenta ************/

SELECT
    tc.nombre_tipo_cuenta,
    AVG(c.saldo_actual) saldo_promedio
FROM CUENTA c
    INNER JOIN TIPO_CUENTA tc
        ON c.id_tipo_cuenta = tc.id_tipo_cuenta
GROUP BY tc.nombre_tipo_cuenta

/************* 4. Operaciones realizadas por canal ************/

SELECT
    ca.nombre_canal,
    COUNT(*) cantidad
FROM OPERACION o
INNER JOIN CANAL ca
ON o.id_canal = ca.id_canal
GROUP BY ca.nombre_canal

/************* 5. Top 10 de cuentas con mayor saldo ************/

SELECT TOP 10
    numero_cuenta,
    saldo_actual
FROM CUENTA
ORDER BY saldo_actual DESC

/************* 6. Clientes con saldo superior al promedio ************/

SELECT
    numero_cuenta,
    saldo_actual
FROM CUENTA
WHERE saldo_actual >
(
    SELECT AVG(saldo_actual)
    FROM CUENTA
)

/************* 7. Cuentas sin movimientos ************/

SELECT
    c.numero_cuenta
FROM CUENTA c
    LEFT JOIN OPERACION o
        ON c.id_cuenta = o.id_cuenta
WHERE o.id_operacion IS NULL

/************* 8. Clientes con más de una cuenta ************/

SELECT
    id_cliente,
    COUNT(*) cantidad
FROM CUENTA
GROUP BY id_cliente
HAVING COUNT(*) > 1

/************* 9. Cuentas con mayor número de operaciones ************/

SELECT TOP 1
    id_cuenta,
    COUNT(*) total
FROM OPERACION
GROUP BY id_cuenta
ORDER BY total DESC

/************* 10. Crecimiento de saldo ************/

SELECT
    id_cuenta,
    fecha_saldo,
    saldo_final,
    LAG(saldo_final)
    OVER
    (
        PARTITION BY id_cuenta
        ORDER BY fecha_saldo
    ) saldo_anterior
FROM HISTORIAL_SALDO