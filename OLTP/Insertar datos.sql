--====== INSERTAMOS DATOS =================

INSERT INTO AGENCIA
(codigo_agencia,nombre_agencia,departamento,provincia,direccion,estado)
VALUES
('001','LIMA CENTRO','LIMA','LIMA','AV AREQUIPA 100','ACTIVO'),
('002','SAN ISIDRO','LIMA','LIMA','AV JAVIER PRADO 500','ACTIVO'),
('003','HUANCAYO','JUNIN','HUANCAYO','REAL 123','ACTIVO'),
('004','CUSCO','CUSCO','CUSCO','SOL 456','ACTIVO'),
('005','AREQUIPA','AREQUIPA','AREQUIPA','MERCADERES 789','ACTIVO');

INSERT INTO MONEDA
(codigo_moneda,nombre_moneda)
VALUES
('PEN','SOLES'),
('USD','DOLARES');

INSERT INTO TIPO_CUENTA
(nombre_tipo_cuenta,descripcion,saldo_minimo,mantenimiento)
VALUES
('AHORRO SIMPLE','CUENTA BASICA',0,0),
('CTS','CUENTA CTS',0,0),
('PLAZO FIJO','DEPOSITO A PLAZO',1000,0),
('AHORRO MUJER','CUENTA PROMOCIONAL',50,5),
('CUENTA SUELDO','PAGO HABERES',0,0);

INSERT INTO CANAL
(nombre_canal,descripcion)
VALUES
('APP','APLICACION MOVIL'),
('WEB','BANCA INTERNET'),
('VENTANILLA','ATENCION PRESENCIAL'),
('ATM','CAJERO AUTOMATICO'),
('AGENTE','AGENTE BANCARIO');

INSERT INTO TIPO_OPERACION
(nombre_operacion,descripcion)
VALUES
('DEPOSITO','INGRESO DINERO'),
('RETIRO','SALIDA DINERO'),
('TRANSFERENCIA','TRANSFERENCIA BANCARIA'),
('INTERES','ABONO INTERESES');

INSERT INTO CAMPANIA
(nombre_campania,fecha_inicio,fecha_fin,descripcion,estado)
VALUES
('ESCOLAR','2026-01-01','2026-03-31','CAMPAÑA ESCOLAR','ACTIVO'),
('CTS PLUS','2026-05-01','2026-07-31','PROMOCION CTS','ACTIVO'),
('AHORRA MAS','2026-08-01','2026-12-31','PROMOCION AHORRO','ACTIVO');

;WITH numeros AS
(
    SELECT TOP (100)
    ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) n
    FROM sys.objects
)

INSERT INTO CLIENTE
(
    tipo_cliente,
    fecha_registro,
    estado
)

SELECT

CASE
    WHEN n % 10 = 0 THEN 'JURIDICO'
    ELSE 'NATURAL'
END,

DATEADD(DAY,-n,GETDATE()),

'ACTIVO'

FROM numeros;

;WITH numeros AS
(
    SELECT TOP (90)
    ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) n
    FROM sys.objects
)

INSERT INTO PERSONA_NATURAL
(
    id_cliente,
    dni,
    nombres,
    apellido_paterno,
    apellido_materno,
    fecha_nacimiento,
    celular,
    correo,
    direccion
)

SELECT

n,

RIGHT('00000000'+CAST(n AS VARCHAR),8),

'NOMBRE_'+CAST(n AS VARCHAR),

'APELLIDO_P_'+CAST(n AS VARCHAR),

'APELLIDO_M_'+CAST(n AS VARCHAR),

DATEADD(YEAR,-20-(n%30),GETDATE()),

'999'+RIGHT('000000'+CAST(n AS VARCHAR),6),

'cliente'+CAST(n AS VARCHAR)+'@gmail.com',

'LIMA'

FROM numeros;

;WITH numeros AS
(
    SELECT TOP (10)
    ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) n
    FROM sys.objects
)

INSERT INTO PERSONA_JURIDICA
(
    id_cliente,
    ruc,
    razon_social,
    representante_legal,
    sector_empresarial,
    correo_empresa,
    telefono
)

SELECT

90+n,

'20'+RIGHT('000000000'+CAST(n AS VARCHAR),9),

'EMPRESA_'+CAST(n AS VARCHAR),

'REPRESENTANTE_'+CAST(n AS VARCHAR),

CASE
    WHEN n%3=0 THEN 'MINERIA'
    WHEN n%2=0 THEN 'COMERCIO'
    ELSE 'SERVICIOS'
END,

'empresa'+CAST(n AS VARCHAR)+'@gmail.com',

'014'+RIGHT('000000'+CAST(n AS VARCHAR),6)

FROM numeros;

;WITH numeros AS
(
    SELECT TOP (150)
    ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) n
    FROM sys.objects a
    CROSS JOIN sys.objects b
)

INSERT INTO CUENTA
(
    numero_cuenta,
    id_cliente,
    id_tipo_cuenta,
    id_moneda,
    id_agencia,
    fecha_apertura,
    saldo_actual,
    estado
)

SELECT

'001'+RIGHT('000000000'+CAST(n AS VARCHAR),9),

((n-1)%100)+1,

((n-1)%5)+1,

CASE
    WHEN n%4=0 THEN 2
    ELSE 1
END,

((n-1)%5)+1,

DATEADD(DAY,-n,GETDATE()),

ROUND((ABS(CHECKSUM(NEWID()))%50000)+500,2),

'ACTIVO'

FROM numeros;

INSERT INTO TASA_INTERES
(id_tipo_cuenta,id_campania,tasa_anual,monto_minimo,fecha_vigencia)
VALUES
(1,NULL,2.50,0,'2026-01-01'),
(2,NULL,5.00,0,'2026-01-01'),
(3,NULL,7.50,1000,'2026-01-01'),
(4,NULL,4.00,100,'2026-01-01'),
(5,NULL,1.50,0,'2026-01-01'),
(1,1,4.50,500,'2026-01-01'),
(2,2,6.50,1000,'2026-05-01'),
(3,3,8.00,5000,'2026-08-01');

;WITH numeros AS
(
    SELECT TOP (50)
    ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) n
    FROM sys.objects
)

INSERT INTO BENEFICIARIO
(
    nombre_beneficiario,
    documento,
    tipo_documento
)

SELECT

'BENEFICIARIO_'+CAST(n AS VARCHAR),

RIGHT('00000000'+CAST(n AS VARCHAR),8),

'DNI'

FROM numeros;

;WITH numeros AS
(
    SELECT TOP (20)
    ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) n
    FROM sys.objects
)

INSERT INTO COLABORADOR
(
   codigo_colaborador,
    nombres,
    cargo,
    id_agencia,
    estado
)

SELECT

'OP'+RIGHT('000'+CAST(n AS VARCHAR),3),

'COLABORADOR_'+CAST(n AS VARCHAR),

CASE
    WHEN n%2=0 THEN 'CAJERO'
    ELSE 'ASESOR'
END,

((n-1)%5)+1,

'ACTIVO'

FROM numeros;

;WITH numeros AS
(
    SELECT TOP (500)
    ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) n
    FROM sys.objects a
    CROSS JOIN sys.objects b
)

INSERT INTO OPERACION
(
    codigo_operacion,
    id_cuenta,
    id_tipo_operacion,
    id_canal,
    id_colaborador,
    fecha_operacion,
    monto,
    saldo_anterior,
    saldo_posterior,
    observacion
)

SELECT

'OP'+RIGHT('0000000'+CAST(n AS VARCHAR),7),

((n-1)%150)+1,

((n-1)%4)+1,

((n-1)%5)+1,

((n-1)%20)+1,

DATEADD(DAY,-n,GETDATE()),

ROUND((ABS(CHECKSUM(NEWID()))%10000)+100,2),

ROUND((ABS(CHECKSUM(NEWID()))%30000)+500,2),

ROUND((ABS(CHECKSUM(NEWID()))%50000)+1000,2),

CASE
    WHEN n%4=0 THEN 'TRANSFERENCIA WEB'
    WHEN n%3=0 THEN 'RETIRO ATM'
    WHEN n%2=0 THEN 'DEPOSITO APP'
    ELSE 'VENTANILLA'
END

FROM numeros;

;WITH numeros AS
(
    SELECT TOP (200)
    ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) n
    FROM sys.objects
)

INSERT INTO DEPOSITO
(
    id_operacion,
    id_beneficiario,
    cuenta_origen,
    agencia_deposito
)

SELECT

n,

((n-1)%50)+1,

'999'+RIGHT('000000'+CAST(n AS VARCHAR),6),

CASE
    WHEN n%2=0 THEN 'LIMA'
    ELSE 'HUANCAYO'
END

FROM numeros;

;WITH numeros AS
(
    SELECT TOP (150)
    ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) n
    FROM sys.objects
)

INSERT INTO TRANSFERENCIA
(
    id_operacion,
    cuenta_destino,
    banco_destino,
    tipo_transferencia
)

SELECT

n,

'888'+RIGHT('000000'+CAST(n AS VARCHAR),6),

CASE
    WHEN n%3=0 THEN 'BCP'
    WHEN n%2=0 THEN 'INTERBANK'
    ELSE 'BBVA'
END,

CASE
    WHEN n%2=0 THEN 'INTERBANCARIA'
    ELSE 'INTERNA'
END

FROM numeros;

;WITH numeros AS
(
    SELECT TOP (500)
    ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) n
    FROM sys.objects a
    CROSS JOIN sys.objects b
)

INSERT INTO HISTORIAL_SALDO
(
    id_cuenta,
    fecha_saldo,
    saldo_inicial,
    saldo_final
)

SELECT

((n-1)%150)+1,

DATEADD(DAY,-n,GETDATE()),

ROUND((ABS(CHECKSUM(NEWID()))%30000)+1000,2),

ROUND((ABS(CHECKSUM(NEWID()))%50000)+2000,2)

FROM numeros;