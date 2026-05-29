CREATE DATABASE BD_Ahorros_Bancario;
GO

USE BD_Ahorros_Bancario
GO

CREATE TABLE AGENCIA (
    id_agencia INT PRIMARY KEY IDENTITY(1,1),
    codigo_agencia VARCHAR(10),
    nombre_agencia VARCHAR(100),
    departamento VARCHAR(100),
    provincia VARCHAR(100),
    direccion VARCHAR(200),
    estado VARCHAR(20)
);

CREATE TABLE CLIENTE (
    id_cliente INT PRIMARY KEY IDENTITY(1,1),
    tipo_cliente VARCHAR(20), -- NATURAL / JURIDICO
    fecha_registro DATE,
    estado VARCHAR(20)
);

CREATE TABLE PERSONA_NATURAL (
    id_persona_natural INT PRIMARY KEY IDENTITY(1,1),
    id_cliente INT,
    dni VARCHAR(8),
    nombres VARCHAR(100),
    apellido_paterno VARCHAR(100),
    apellido_materno VARCHAR(100),
    fecha_nacimiento DATE,
    celular VARCHAR(20),
    correo VARCHAR(100),
    direccion VARCHAR(200),

    FOREIGN KEY (id_cliente)
    REFERENCES CLIENTE(id_cliente)
);

CREATE TABLE PERSONA_JURIDICA (
    id_persona_juridica INT PRIMARY KEY IDENTITY(1,1),
    id_cliente INT,
    ruc VARCHAR(11),
    razon_social VARCHAR(150),
    representante_legal VARCHAR(150),
    sector_empresarial VARCHAR(100),
    correo_empresa VARCHAR(100),
    telefono VARCHAR(20),

    FOREIGN KEY (id_cliente)
    REFERENCES CLIENTE(id_cliente)
);

CREATE TABLE TIPO_CUENTA (
    id_tipo_cuenta INT PRIMARY KEY IDENTITY(1,1),
    nombre_tipo_cuenta VARCHAR(100),
    descripcion VARCHAR(200),
    saldo_minimo DECIMAL(18,2),
    mantenimiento DECIMAL(18,2)
);

CREATE TABLE MONEDA (
    id_moneda INT PRIMARY KEY IDENTITY(1,1),
    codigo_moneda VARCHAR(5),
    nombre_moneda VARCHAR(50)
);

CREATE TABLE CUENTA (
    id_cuenta INT PRIMARY KEY IDENTITY(1,1),
    numero_cuenta VARCHAR(20),
    id_cliente INT,
    id_tipo_cuenta INT,
    id_moneda INT,
    id_agencia INT,
    fecha_apertura DATE,
    saldo_actual DECIMAL(18,2),
    estado VARCHAR(20),

    FOREIGN KEY (id_cliente)
    REFERENCES CLIENTE(id_cliente),

    FOREIGN KEY (id_tipo_cuenta)
    REFERENCES TIPO_CUENTA(id_tipo_cuenta),

    FOREIGN KEY (id_moneda)
    REFERENCES MONEDA(id_moneda),

    FOREIGN KEY (id_agencia)
    REFERENCES AGENCIA(id_agencia)
);

CREATE TABLE CAMPANIA (
    id_campania INT PRIMARY KEY IDENTITY(1,1),
    nombre_campania VARCHAR(100),
    fecha_inicio DATE,
    fecha_fin DATE,
    descripcion VARCHAR(200),
    estado VARCHAR(20)
);

CREATE TABLE TASA_INTERES (
    id_tasa INT PRIMARY KEY IDENTITY(1,1),
    id_tipo_cuenta INT,
    id_campania INT NULL,
    tasa_anual DECIMAL(5,2),
    monto_minimo DECIMAL(18,2),
    fecha_vigencia DATE,

    FOREIGN KEY (id_tipo_cuenta)
    REFERENCES TIPO_CUENTA(id_tipo_cuenta),

    FOREIGN KEY (id_campania)
    REFERENCES CAMPANIA(id_campania)
);

CREATE TABLE CANAL (
    id_canal INT PRIMARY KEY IDENTITY(1,1),
    nombre_canal VARCHAR(50),
    descripcion VARCHAR(150)
);

CREATE TABLE COLABORADOR (
    id_colaborador INT PRIMARY KEY IDENTITY(1,1),
    codigo_colaborador VARCHAR(20),
    nombres VARCHAR(150),
    cargo VARCHAR(100),
    id_agencia INT,
    estado VARCHAR(20),

    FOREIGN KEY (id_agencia)
    REFERENCES AGENCIA(id_agencia)
);

CREATE TABLE TIPO_OPERACION (
    id_tipo_operacion INT PRIMARY KEY IDENTITY(1,1),
    nombre_operacion VARCHAR(50),
    descripcion VARCHAR(150)
);

CREATE TABLE OPERACION (
    id_operacion INT PRIMARY KEY IDENTITY(1,1),
    codigo_operacion VARCHAR(20),
    id_cuenta INT,
    id_tipo_operacion INT,
    id_canal INT,
    id_colaborador INT,
    fecha_operacion DATETIME,
    monto DECIMAL(18,2),
    saldo_anterior DECIMAL(18,2),
    saldo_posterior DECIMAL(18,2),
    observacion VARCHAR(200),

    FOREIGN KEY (id_cuenta)
    REFERENCES CUENTA(id_cuenta),

    FOREIGN KEY (id_tipo_operacion)
    REFERENCES TIPO_OPERACION(id_tipo_operacion),

    FOREIGN KEY (id_canal)
    REFERENCES CANAL(id_canal),

    FOREIGN KEY (id_colaborador)
    REFERENCES colaborador(id_colaborador)
);
CREATE TABLE BENEFICIARIO (
    id_beneficiario INT PRIMARY KEY IDENTITY(1,1),
    nombre_beneficiario VARCHAR(150),
    documento VARCHAR(20),
    tipo_documento VARCHAR(20)
);

CREATE TABLE DEPOSITO (
    id_deposito INT PRIMARY KEY IDENTITY(1,1),
    id_operacion INT,
    id_beneficiario INT,
    cuenta_origen VARCHAR(20),
    agencia_deposito VARCHAR(100),

    FOREIGN KEY (id_operacion)
    REFERENCES OPERACION(id_operacion),

    FOREIGN KEY (id_beneficiario)
    REFERENCES BENEFICIARIO(id_beneficiario)
);

CREATE TABLE TRANSFERENCIA (
    id_transferencia INT PRIMARY KEY IDENTITY(1,1),
    id_operacion INT,
    cuenta_destino VARCHAR(20),
    banco_destino VARCHAR(100),
    tipo_transferencia VARCHAR(50),

    FOREIGN KEY (id_operacion)
    REFERENCES OPERACION(id_operacion)
);

CREATE TABLE HISTORIAL_SALDO (
    id_historial INT PRIMARY KEY IDENTITY(1,1),
    id_cuenta INT,
    fecha_saldo DATE,
    saldo_inicial DECIMAL(18,2),
    saldo_final DECIMAL(18,2),

    FOREIGN KEY (id_cuenta)
    REFERENCES CUENTA(id_cuenta)
);