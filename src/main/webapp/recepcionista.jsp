<%-- 
    Document   : recepcionista
    Created on : 28 nov 2025, 3:08:28 p. m.
    Author     : Ariel
--%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel de Recepción</title>

    <style>
        body {
            background: linear-gradient(to bottom, #add8e6, white);
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        header {
            text-align: center;
            padding: 30px;
            color: white;
            background: url('images/fondo-clinica.jpg') no-repeat center center;
            background-size: cover;
        }

        h1 {
            font-size: 2.3em;
            margin: 0;
        }

        .welcome-text {
            font-size: 1.2em;
        }

        .top-bar {
            background-color: #004b6f;
            color: #fff;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.95em;
        }

        .top-bar a {
            color: #ffeb3b;
            text-decoration: none;
            margin-left: 15px;
        }

        .top-bar a:hover {
            text-decoration: underline;
        }

        section {
            margin: 25px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 1100px;
        }

        h2 {
            color: #004b6f;
            margin-bottom: 15px;
        }

        .search-row {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            align-items: center;
        }

        .search-row label {
            font-weight: bold;
            margin-right: 5px;
        }

        .search-row select,
        .search-row input[type="text"] {
            flex: 1 1 220px;
            padding: 8px 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 0.95em;
        }

        .btn-main {
            border: none;
            border-radius: 8px;
            padding: 8px 16px;
            background-color: #004b6f;
            color: #fff;
            cursor: pointer;
            font-size: 0.95em;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .btn-main:hover {
            background-color: #006f8e;
            transform: scale(1.02);
        }

        /* Tarjeta de info del paciente */
        .patient-card {
            margin-top: 15px;
            display: none;
            border-radius: 10px;
            background-color: #e3f2fd;
            padding: 15px 18px;
        }

        .patient-card h3 {
            margin-top: 0;
            color: #0d47a1;
        }

        .patient-info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 8px 20px;
            font-size: 0.9em;
        }

        .patient-info-item span {
            font-weight: bold;
            color: #37474f;
        }

        /* Tabla de consultas anteriores / citas */
        .data-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        .data-table th,
        .data-table td {
            padding: 8px 10px;
            text-align: left;
            border: 1px solid #ddd;
            font-size: 0.9em;
        }

        .data-table th {
            background-color: #004b6f;
            color: white;
        }

        .data-table td {
            background-color: #f9f9f9;
        }

        .tag {
            display: inline-block;
            padding: 2px 8px;
            border-radius: 10px;
            font-size: 0.8em;
        }

        .tag-si {
            background-color: #c8e6c9;
            color: #2e7d32;
        }

        .tag-no {
            background-color: #ffccbc;
            color: #d84315;
        }

        .tag-parcial {
            background-color: #fff9c4;
            color: #f57f17;
        }

        /* Botones de acción en citas */
        .btn-accion {
            border: none;
            border-radius: 6px;
            padding: 5px 8px;
            font-size: 0.8em;
            cursor: pointer;
            margin-right: 4px;
        }

        .btn-confirmar {
            background-color: #2e7d32;
            color: #fff;
        }

        .btn-reprogramar {
            background-color: #f9a825;
            color: #fff;
        }

        .btn-cancelar-cita {
            background-color: #c62828;
            color: #fff;
        }

        .btn-accion:hover {
            opacity: 0.9;
        }

        .tag-estado {
            padding: 2px 8px;
            border-radius: 10px;
            font-size: 0.8em;
        }

        .estado-pendiente {
            background-color: #fff3cd;
            color: #856404;
        }

        .estado-confirmada {
            background-color: #c8e6c9;
            color: #2e7d32;
        }

        .estado-cancelada {
            background-color: #ffcdd2;
            color: #c62828;
        }
    </style>

    <!-- Bootstrap -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

    <!-- FontAwesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>

    <!-- Barra superior -->
    <div class="top-bar">
        <div>
            Rol: <strong>Recepcionista</strong> | Usuario: <strong>(nombre recepción)</strong>
        </div>
        <div>
            Ir a:
            <a href="paciente.jsp">Paciente</a>
            <a href="medico.jsp">Médico</a>
        </div>
    </div>

    <header>
        <h1>Clínica Salud y Bienestar</h1>
        <p class="welcome-text">Panel de recepción – gestión de pacientes y citas</p>
    </header>

    <!-- BUSCADOR DE PACIENTE -->
    <section>
        <h2>Buscador de paciente</h2>
        <p style="font-size:0.9em; color:#607d8b;">
            Busca al paciente para ver sus datos básicos y revisar si está siguiendo el tratamiento
            según sus consultas anteriores.
        </p>

        <div class="search-row">
            <label for="pacienteSelect"><i class="fas fa-search"></i> Seleccionar paciente:</label>
            <select id="pacienteSelect">
                <option value="" selected disabled>Elige un paciente</option>
                <option value="ana">Ana López</option>
                <option value="carlos">Carlos Pérez</option>
                <option value="maria">María García</option>
            </select>

            <button type="button" class="btn-main" onclick="mostrarPaciente()">
                Buscar
            </button>
        </div>

        <!-- FICHA DEL PACIENTE -->
        <div id="patientCard" class="patient-card">
            <h3 id="nombrePacienteTitulo">Paciente</h3>
            <div class="patient-info-grid">
                <div class="patient-info-item">
                    <span>Cédula:</span> <span id="pacienteCedula"></span>
                </div>
                <div class="patient-info-item">
                    <span>Edad:</span> <span id="pacienteEdad"></span>
                </div>
                <div class="patient-info-item">
                    <span>Teléfono:</span> <span id="pacienteTelefono"></span>
                </div>
                <div class="patient-info-item">
                    <span>Correo:</span> <span id="pacienteCorreo"></span>
                </div>
                <div class="patient-info-item">
                    <span>Dirección:</span> <span id="pacienteDireccion"></span>
                </div>
                <div class="patient-info-item">
                    <span>Seguro médico:</span> <span id="pacienteSeguro"></span>
                </div>
            </div>

            <h4 style="margin-top:18px; color:#004b6f;">Consultas anteriores</h4>
            <table class="data-table" id="tablaConsultas">
                <thead>
                    <tr>
                        <th>Fecha</th>
                        <th>Médico</th>
                        <th>Motivo / Diagnóstico</th>
                        <th>Tratamiento indicado</th>
                        <th>¿Sigue tratamiento?</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Se llena dinámicamente -->
                </tbody>
            </table>

            <p id="mensajeConsultas" style="font-size:0.85em; color:#607d8b; margin-top:8px;"></p>
        </div>
    </section>

    <!-- CITAS DEL DÍA (RECEPCIÓN) -->
    <section>
        <h2>Citas del día</h2>
        <p style="font-size:0.9em; color:#607d8b;">
            Desde aquí la recepción puede confirmar, reprogramar o cancelar las citas agendadas por los pacientes.
            (Simulado, sin conexión a base de datos todavía).
        </p>

        <table class="data-table" id="tablaCitasDia">
            <thead>
                <tr>
                    <th>Hora</th>
                    <th>Paciente</th>
                    <th>Médico</th>
                    <th>Motivo</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <!-- Se llenará con JS -->
            </tbody>
        </table>
    </section>

    <script>
        // =======================
        // Datos simulados pacientes
        // =======================
        var pacientes = {
            "ana": {
                nombre: "Ana López",
                cedula: "0923456789",
                edad: "28 años",
                telefono: "099 123 4567",
                correo: "ana.lopez@example.com",
                direccion: "Av. Principal 123, Guayaquil",
                seguro: "Seguros Andinos",
                consultas: [
                    {
                        fecha: "2025-10-10",
                        medico: "Dr. Juan Pérez",
                        motivo: "Fiebre y malestar general",
                        tratamiento: "Paracetamol cada 8h por 5 días, reposo e hidratación",
                        seguimiento: "si"
                    },
                    {
                        fecha: "2025-09-02",
                        medico: "Dr. Juan Pérez",
                        motivo: "Dolor de garganta",
                        tratamiento: "Antibiótico por 7 días y enjuagues",
                        seguimiento: "parcial"
                    }
                ]
            },
            "carlos": {
                nombre: "Carlos Pérez",
                cedula: "0912345678",
                edad: "45 años",
                telefono: "098 555 6677",
                correo: "carlos.perez@example.com",
                direccion: "Cdla. Los Ceibos, Guayaquil",
                seguro: "Plan Particular",
                consultas: [
                    {
                        fecha: "2025-08-20",
                        medico: "Dra. María González",
                        motivo: "Control de hipertensión",
                        tratamiento: "Medicamento antihipertensivo diario, dieta baja en sal",
                        seguimiento: "si"
                    },
                    {
                        fecha: "2025-05-10",
                        medico: "Dra. María González",
                        motivo: "Chequeo general",
                        tratamiento: "Continuar medicación y control trimestral",
                        seguimiento: "si"
                    }
                ]
            },
            "maria": {
                nombre: "María García",
                cedula: "0956781234",
                edad: "35 años",
                telefono: "097 222 3344",
                correo: "maria.garcia@example.com",
                direccion: "Centro de la ciudad, Guayaquil",
                seguro: "Seguro VidaSalud",
                consultas: [
                    {
                        fecha: "2025-07-15",
                        medico: "Dr. Luis Rodríguez",
                        motivo: "Migrañas frecuentes",
                        tratamiento: "Analgésicos según necesidad, control del estrés",
                        seguimiento: "parcial"
                    },
                    {
                        fecha: "2025-04-03",
                        medico: "Dr. Luis Rodríguez",
                        motivo: "Dolor de espalda",
                        tratamiento: "Ejercicios de fisioterapia y analgésicos",
                        seguimiento: "no"
                    }
                ]
            }
        };

        function mostrarPaciente() {
            var select = document.getElementById("pacienteSelect");
            var id     = select.value;

            if (!id) {
                alert("Por favor, selecciona un paciente.");
                return;
            }

            var paciente = pacientes[id];
            if (!paciente) {
                alert("No se encontró información para este paciente.");
                return;
            }

            var card = document.getElementById("patientCard");
            card.style.display = "block";

            document.getElementById("nombrePacienteTitulo").innerText = paciente.nombre;
            document.getElementById("pacienteCedula").innerText    = paciente.cedula;
            document.getElementById("pacienteEdad").innerText      = paciente.edad;
            document.getElementById("pacienteTelefono").innerText  = paciente.telefono;
            document.getElementById("pacienteCorreo").innerText    = paciente.correo;
            document.getElementById("pacienteDireccion").innerText = paciente.direccion;
            document.getElementById("pacienteSeguro").innerText    = paciente.seguro;

            var tbody = document.querySelector("#tablaConsultas tbody");
            tbody.innerHTML = "";

            if (!paciente.consultas || paciente.consultas.length === 0) {
                document.getElementById("mensajeConsultas").innerText =
                    "Este paciente no registra consultas anteriores en el sistema.";
                return;
            } else {
                document.getElementById("mensajeConsultas").innerText =
                    "Revisa la columna \"¿Sigue tratamiento?\" para verificar si el paciente está cumpliendo con las indicaciones médicas.";
            }

            for (var i = 0; i < paciente.consultas.length; i++) {
                var c = paciente.consultas[i];
                var tr = document.createElement("tr");

                var tagHtml = "";
                if (c.seguimiento === "si") {
                    tagHtml = "<span class='tag tag-si'>Sí</span>";
                } else if (c.seguimiento === "no") {
                    tagHtml = "<span class='tag tag-no'>No</span>";
                } else {
                    tagHtml = "<span class='tag tag-parcial'>Parcial</span>";
                }

                var html = "";
                html += "<td>" + c.fecha + "</td>";
                html += "<td>" + c.medico + "</td>";
                html += "<td>" + c.motivo + "</td>";
                html += "<td>" + c.tratamiento + "</td>";
                html += "<td>" + tagHtml + "</td>";

                tr.innerHTML = html;
                tbody.appendChild(tr);
            }
        }

        // =======================
        // Citas del día (simuladas)
        // =======================
        var citasDia = [
            {
                hora: "08:30",
                paciente: "Ana López",
                medico: "Dr. Juan Pérez",
                motivo: "Fiebre y malestar",
                estado: "pendiente"
            },
            {
                hora: "09:15",
                paciente: "Carlos Pérez",
                medico: "Dra. María González",
                motivo: "Control de hipertensión",
                estado: "pendiente"
            },
            {
                hora: "10:00",
                paciente: "María García",
                medico: "Dr. Luis Rodríguez",
                motivo: "Dolor de espalda",
                estado: "pendiente"
            }
        ];

        function cargarCitasDia() {
            var tbody = document.querySelector("#tablaCitasDia tbody");
            tbody.innerHTML = "";

            for (var i = 0; i < citasDia.length; i++) {
                var c = citasDia[i];
                var tr = document.createElement("tr");

                var estadoHtml = obtenerHtmlEstado(c.estado);

                var html = "";
                html += "<td>" + c.hora + "</td>";
                html += "<td>" + c.paciente + "</td>";
                html += "<td>" + c.medico + "</td>";
                html += "<td>" + c.motivo + "</td>";
                html += "<td class='col-estado'>" + estadoHtml + "</td>";
                html += "<td>";
                html += "<button type='button' class='btn-accion btn-confirmar' onclick='confirmarCita(" + i + ", this)'><i class=\"fas fa-check\"></i> Confirmar</button>";
                html += "<button type='button' class='btn-accion btn-reprogramar' onclick='reprogramarCita(" + i + ", this)'><i class=\"fas fa-clock\"></i> Reprogramar</button>";
                html += "<button type='button' class='btn-accion btn-cancelar-cita' onclick='cancelarCita(" + i + ", this)'><i class=\"fas fa-times\"></i> Cancelar</button>";
                html += "</td>";

                tr.innerHTML = html;
                tbody.appendChild(tr);
            }
        }

        function obtenerHtmlEstado(estado) {
            var htmlEstado = "";
            if (estado === "pendiente") {
                htmlEstado = "<span class='tag-estado estado-pendiente'>Pendiente</span>";
            } else if (estado === "confirmada") {
                htmlEstado = "<span class='tag-estado estado-confirmada'>Confirmada</span>";
            } else if (estado === "cancelada") {
                htmlEstado = "<span class='tag-estado estado-cancelada'>Cancelada</span>";
            } else {
                htmlEstado = "<span class='tag-estado estado-pendiente'>" + estado + "</span>";
            }
            return htmlEstado;
        }

        function confirmarCita(index, btn) {
            citasDia[index].estado = "confirmada";
            actualizarEstadoEnFila(btn, "confirmada");
        }

        function cancelarCita(index, btn) {
            if (confirm("¿Seguro que quieres cancelar esta cita?")) {
                citasDia[index].estado = "cancelada";
                actualizarEstadoEnFila(btn, "cancelada");
            }
        }

        function reprogramarCita(index, btn) {
            var nuevaHora = prompt("Nueva hora para la cita (ej. 11:30):", citasDia[index].hora);
            if (nuevaHora && nuevaHora.trim() !== "") {
                citasDia[index].hora = nuevaHora.trim();
                // Actualizamos la hora en la fila
                var fila = btn.closest("tr");
                if (fila) {
                    fila.cells[0].innerText = citasDia[index].hora;
                }
            }
        }

        function actualizarEstadoEnFila(btn, nuevoEstado) {
            var fila = btn.closest("tr");
            if (!fila) return;
            var colEstado = fila.querySelector(".col-estado");
            if (!colEstado) return;
            colEstado.innerHTML = obtenerHtmlEstado(nuevoEstado);
        }

        // Cargar las citas al abrir la página
        window.onload = function() {
            cargarCitasDia();
        };
    </script>

</body>
</html>
