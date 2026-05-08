# Caso Propuesto

## Sistema de Gestión de Cuentas de Ahorro y Movimientos Financieros Bancarios

### 1. Contexto del negocio

El banco ficticio **FinanPerú** desea implementar un sistema de información para administrar las cuentas de ahorro de sus clientes. Actualmente, el banco maneja miles de operaciones diarias relacionadas con depósitos, retiros, transferencias y pagos de servicios, por lo que necesita una base de datos eficiente y segura que permita almacenar, consultar y analizar la información financiera.

El sistema debe permitir controlar:

* Registro de clientes.
* Apertura y administración de cuentas de ahorro.
* Manejo de tarjetas bancarias.
* Registro de transacciones financieras.
* Control de agencias bancarias.
* Gestión de empleados bancarios.
* Seguridad y detección de operaciones sospechosas.

Además, el banco busca fortalecer su sistema de prevención de fraude financiero mediante reglas de monitoreo sobre operaciones inusuales.

---

# 2. Problema actual

El banco presenta los siguientes inconvenientes:

* Información duplicada de clientes.
* Errores en el registro de transacciones.
* Dificultad para rastrear movimientos sospechosos.
* Lentitud en consultas históricas.
* Falta de integración entre agencias.
* Poca trazabilidad de operaciones realizadas por cajeros o canales virtuales.

Debido a ello, se propone diseñar un modelo de base de datos relacional que permita centralizar toda la información financiera y mejorar la toma de decisiones.

---

# 3. Objetivo del sistema

Diseñar una base de datos para un sistema bancario de cuentas de ahorro que permita:

* Administrar clientes y sus productos financieros.
* Registrar operaciones bancarias.
* Controlar saldos y movimientos.
* Gestionar tarjetas y accesos digitales.
* Detectar actividades sospechosas.
* Generar reportes financieros y auditorías.

---

# 4. Alcance del proyecto

El sistema abarcará:

## Módulos principales

### a) Gestión de Clientes

Permite registrar información personal del cliente:

* DNI
* Nombres
* Dirección
* Teléfono
* Correo
* Fecha de nacimiento

---

### b) Gestión de Cuentas de Ahorro

Permite:

* Apertura de cuentas
* Consulta de saldo
* Estado de cuenta
* Tipo de moneda
* Estado de la cuenta

---

### c) Gestión de Transacciones

Registrar:

* Depósitos
* Retiros
* Transferencias
* Pago de servicios
* Consumos con tarjeta

Cada operación debe registrar:

* Fecha y hora
* Monto
* Canal utilizado
* Agencia
* Usuario o cajero

---

### d) Gestión de Tarjetas Bancarias

Control de:

* Tarjetas débito
* Fecha de vencimiento
* Estado de la tarjeta
* Intentos fallidos
* Bloqueos

---

### e) Seguridad y Prevención de Fraude

El sistema debe generar alertas cuando:

* Un cliente realiza múltiples retiros en corto tiempo.
* Existen transferencias de alto monto fuera del horario habitual.
* Se detectan operaciones desde distintas ciudades en pocos minutos.
* Hay múltiples intentos fallidos de autenticación.
* Una cuenta recibe depósitos inusuales respecto a su historial.

---

# 5. Reglas de negocio

1. Un cliente puede tener varias cuentas de ahorro.
2. Una cuenta pertenece únicamente a un cliente.
3. Una cuenta puede tener muchas transacciones.
4. Cada transacción pertenece a una sola cuenta.
5. Una tarjeta está asociada a una cuenta.
6. Un empleado puede registrar muchas operaciones.
7. Las transferencias involucran una cuenta origen y una cuenta destino.
8. Toda cuenta debe pertenecer a una agencia.
9. Las alertas de fraude deben quedar registradas.
10. Un cliente no puede tener dos cuentas con el mismo número.
