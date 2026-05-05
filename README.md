BankCorp es una entidad financiera que ofrece productos como cuentas de ahorro, créditos personales, hipotecarios y empresariales. Debido al crecimiento de sus operaciones digitales, el banco necesita mejorar su sistema de gestión de préstamos y pagos, incorporando además mecanismos de detección de transacciones sospechosas para prevenir fraudes.

Actualmente, el sistema presenta limitaciones en el seguimiento del comportamiento financiero de los clientes y en la identificación temprana de actividades inusuales.

🎯 Objetivo del Sistema

Diseñar un sistema que permita:

Gestionar solicitudes y aprobaciones de préstamos.
Registrar pagos de cuotas de préstamos.
Monitorear transacciones financieras.
Detectar operaciones sospechosas basadas en reglas de negocio.
👥 Actores del Sistema
Cliente: Persona natural o jurídica que solicita préstamos y realiza pagos.
Analista de Crédito: Evalúa y aprueba/rechaza solicitudes.
Sistema de Monitoreo de Fraude: Detecta patrones sospechosos automáticamente.
Administrador del Banco: Supervisa operaciones y reportes.
🔄 Procesos Principales
1. Solicitud de Préstamo
El cliente solicita un préstamo indicando:
Monto solicitado
Tipo de préstamo (personal, hipotecario, etc.)
Plazo
El sistema registra la solicitud y la envía al analista.
2. Evaluación y Aprobación
El analista revisa:
Historial crediticio
Ingresos del cliente
Nivel de riesgo
Luego:
Aprueba → se genera el préstamo
Rechaza → se registra el motivo
3. Desembolso del Préstamo
Si es aprobado:
Se crea una cuenta de préstamo
Se deposita el monto en la cuenta del cliente
Se genera un cronograma de pagos (cuotas)
4. Registro de Pagos
El cliente realiza pagos periódicos:
Fecha de pago
Monto pagado
Medio de pago (transferencia, efectivo, etc.)
El sistema:
Actualiza saldo pendiente
Marca cuotas como pagadas o vencidas
5. Monitoreo de Transacciones
El sistema analiza operaciones como:
Depósitos
Transferencias
Pagos de préstamos
6. Detección de Operaciones Sospechosas 🚨
El sistema identifica comportamientos inusuales, por ejemplo:
Transferencias de alto monto en horarios inusuales (madrugada).
Pagos de préstamos con cuentas no registradas previamente.
Movimientos repetitivos desde diferentes cuentas hacia un mismo destino.
Actividad fuera del patrón histórico del cliente.
Cuando se detecta una operación sospechosa:
Se genera una alerta
Se registra el evento
Se notifica al área de auditoría o fraude
📊 Reglas de Negocio Iniciales
Un cliente puede tener múltiples préstamos.
Un préstamo genera múltiples cuotas.
Cada cuota puede tener uno o varios pagos.
Una transacción puede estar asociada a un pago.
Una operación sospechosa debe estar vinculada a una transacción.
El sistema debe guardar el historial de comportamiento del cliente (para análisis de fraude).
📁 Posibles Entidades (para el siguiente paso)
Este caso te permitirá crear fácilmente más de 10 tablas, por ejemplo:
Cliente
Cuenta
Préstamo
SolicitudPréstamo
Cuota
Pago
Transacción
TipoTransacción
AlertaFraude
ReglaFraude
Analista
EvaluaciónCrédito
