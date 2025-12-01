<%-- 
    Document   : medico
    Created on : 28 nov 2025, 12:13:10 p. m.
    Author     : Ariel
--%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel del Médico</title>

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

        /* Tarjetas de resumen */
        .cards {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 10px;
        }

        .card-mini {
            flex: 1 1 180px;
            background-color: #e3f2fd;
            border-radius: 8px;
            padding: 12px 15px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.08);
        }

        .card-mini-title {
            font-size: 0.9em;
            color: #1565c0;
            margin-bottom: 5px;
        }

        .card-mini-value {
            font-size: 1.5em;
            font-weight: bold;
            color: #0d47a1;
        }

        .card-mini-sub {
            font-size: 0.8em;
            color: #546e7a;
        }

        /* Tablas */
        .data-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
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

        .btn-accion {
            border: none;
            border-radius: 6px;
            padding: 5px 10px;
            font-size: 0.85em;
            cursor: pointer;
            margin-right: 4px;
        }

        .btn-ver {
            background-color: #0277bd;
            color: #fff;
        }

        .btn-atendido {
            background-color: #2e7d32;
            color: #fff;
        }

        .btn-reprogramar {
            background-color: #f9a825;
            color: #fff;
        }

        .btn-accion:hover {
            opacity: 0.9;
        }

        .tag {
            display: inline-block;
            padding: 2px 8px;
            border-radius: 10px;
            font-size: 0.8em;
        }

        .tag-pendiente {
            background-color: #fff3cd;
            color: #856404;
        }

        .tag-atendido {
            background-color: #c8e6c9;
            color: #2e7d32;
        }

        .tag-control {
            background-color: #e3f2fd;
            color: #0d47a1;
        }

        /* Buscador de paciente del médico */
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

        .search-row select {
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

        .textarea-notas {
            width: 100%;
            border-radius: 8px;
            border: 1px solid #ccc;
            padding: 8px 10px;
            font-size: 0.9em;
            resize: vertical;
            min-height: 70px;
        }

        .block-notas {
            margin-top: 15px;
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
            Rol: <strong>Médico</strong> | Dr./Dra. <strong>(nombre aquí)</strong>
        </div>
        <div>
            Ir a:
            <a href="paciente.jsp">Paciente</a>
            <a href="recepcionista.jsp">Recepcionista</a>
        </div>
    </div>

    <header>
        <h1>Clínica Salud y Bienestar</h1>
        <p class="welcome-text">Panel del médico – gestión de citas y pacientes</p>
    </header>

    <!-- Resumen de hoy -->
    <section>
        <h2>Resumen de hoy</h2>
        <div class="cards">
            <div class="card-mini">
                <div class="card-mini-title">Citas programadas</div>
                <div class="card-mini-value">8</div>
                <div class="card-mini-sub">Total de citas para hoy</div>
            </div>
            <div class="card-mini">
                <div class="card-mini-title">Pacientes nuevos</div>
                <div class="card-mini-value">3</div>
                <div class="card-mini-sub">Primera vez en la clínica</div>
            </div>
            <div class="card-mini">
                <div class="card-mini-title">Controles</div>
                <div class="card-mini-value">5</div>
                <div class="card-mini-sub">Seguimiento / control</div>
            </div>
            <div class="card-mini">
                <div class="card-mini-title">Citas pendientes</div>
                <div class="card-mini-value">4</div>
                <div class="card-mini-sub">Aún por atender</div>
            </div>
        </div>
    </section>

    <!-- Citas del día -->
    <section>
        <h2>Citas del día</h2>
        <table class="data-table">
            <thead>
                <tr>
                    <th>Hora</th>
                    <th>Paciente</th>
                    <th>Motivo / Síntomas</th>
                    <th>Tipo</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>08:30</td>
                    <td>Ana López</td>
                    <td>Fiebre y malestar general</td>
                    <td><span class="tag tag-pendiente">Primera vez</span></td>
                    <td>
                        <button class="btn-accion btn-ver"><i class="fas fa-eye"></i> Ver ficha</button>
                        <button class="btn-accion btn-atendido"><i class="fas fa-check"></i> Marcar atendida</button>
                    </td>
                </tr>
                <tr>
                    <td>09:15</td>
                    <td>Carlos Pérez</td>
                    <td>Control de presión arterial</td>
                    <td><span class="tag tag-control">Control</span></td>
                    <td>
                        <button class="btn-accion btn-ver"><i class="fas fa-eye"></i> Ver ficha</button>
                        <button class="btn-accion btn-atendido"><i class="fas fa-check"></i> Marcar atendida</button>
                    </td>
                </tr>
                <tr>
                    <td>10:00</td>
                    <td>María García</td>
                    <td>Dolor torácico leve</td>
                    <td><span class="tag tag-pendiente">Prioritario</span></td>
                    <td>
                        <button class="btn-accion btn-ver"><i class="fas fa-eye"></i> Ver ficha</button>
                        <button class="btn-accion btn-reprogramar"><i class="fas fa-clock"></i> Reprogramar</button>
                    </td>
                </tr>
            </tbody>
        </table>
        <p style="font-size:0.85em; color:#607d8b; margin-top:8px;">
            Más adelante estas citas se cargarán desde la base de datos según el médico que haya iniciado sesión.
        </p>
    </section>

    <!-- BUSCADOR DE PACIENTE (MÉDICO) -->
    <section>
        <h2>Historia clínica rápida del paciente</h2>
        <p style="font-size:0.9em; color:#607d8b;">
            Selecciona un paciente para ver sus datos básicos, revisar sus consultas anteriores
            y registrar notas de la consulta actual.
        </p>

        <div class="search-row">
            <label for="pacienteSelectMedico"><i class="fas fa-user"></i> Paciente:</label>
            <select id="pacienteSelectMedico">
                <option value="" selected disabled>Elige un paciente</option>
                <option value="ana">Ana López</option>
                <option value="carlos">Carlos Pérez</option>
                <option value="maria">María García</option>
            </select>

            <button type="button" class="btn-main" onclick="mostrarPacienteMedico()">
                Ver historia
            </button>
        </div>

        <!-- Ficha + consultas + notas -->
        <div id="patientCardMedico" class="patient-card">
            <h3 id="nombrePacienteTituloMedico">Paciente</h3>

            <div class="patient-info-grid">
                <div class="patient-info-item">
                    <span>Cédula:</span> <span id="pacienteCedulaMedico"></span>
                </div>
                <div class="patient-info-item">
                    <span>Edad:</span> <span id="pacienteEdadMedico"></span>
                </div>
                <div class="patient-info-item">
                    <span>Teléfono:</span> <span id="pacienteTelefonoMedico"></span>
                </div>
                <div class="patient-info-item">
                    <span>Correo:</span> <span id="pacienteCorreoMedico"></span>
                </div>
                <div class="patient-info-item">
                    <span>Antecedentes clave:</span> <span id="pacienteAntecedentesMedico"></span>
                </div>
            </div>

            <h4 style="margin-top:18px; color:#004b6f;">Consultas anteriores</h4>
            <table class="data-table" id="tablaConsultasMedico">
                <thead>
                    <tr>
                        <th>Fecha</th>
                        <th>Diagnóstico</th>
                        <th>Tratamiento</th>
                        <th>Observaciones</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- dinámico -->
                </tbody>
            </table>

            <div class="block-notas">
                <h4 style="color:#004b6f;">Notas de la consulta actual</h4>
                <textarea id="notasConsulta" class="textarea-notas"
                          placeholder="Escribe aquí tus hallazgos clínicos, evolución, signos y síntomas relevantes."></textarea>
            </div>

            <div class="block-notas">
                <h4 style="color:#004b6f;">Plan / Tratamiento actual</h4>
                <textarea id="planConsulta" class="textarea-notas"
                          placeholder="Indica medicación, exámenes complementarios, recomendaciones y próxima cita."></textarea>
            </div>

            <button type="button" class="btn-main" style="margin-top:10px;" onclick="simularGuardar()">
                Guardar (simulado)
            </button>

            <p id="mensajeGuardar" style="font-size:0.85em; color:#2e7d32; margin-top:8px; display:none;">
                Información de la consulta registrada (simulada). En la versión final se guardará en la base de datos.
            </p>
        </div>
    </section>

    <!-- Historial rápido de pacientes -->
    <section>
        <h2>Historial rápido de pacientes</h2>
        <table class="data-table">
            <thead>
                <tr>
                    <th>Paciente</th>
                    <th>Última visita</th>
                    <th>Diagnóstico principal</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Ana López</td>
                    <td>10/10/2025</td>
                    <td>Infección respiratoria alta</td>
                    <td>
                        <button class="btn-accion btn-ver"><i class="fas fa-folder-open"></i> Ver historial</button>
                    </td>
                </tr>
                <tr>
                    <td>Carlos Pérez</td>
                    <td>05/09/2025</td>
                    <td>Hipertensión controlada</td>
                    <td>
                        <button class="btn-accion btn-ver"><i class="fas fa-folder-open"></i> Ver historial</button>
                    </td>
                </tr>
                <tr>
                    <td>María García</td>
                    <td>20/08/2025</td>
                    <td>Chequeo general</td>
                    <td>
                        <button class="btn-accion btn-ver"><i class="fas fa-folder-open"></i> Ver historial</button>
                    </td>
                </tr>
            </tbody>
        </table>
    </section>

    <script>
        // Datos simulados para el médico (mismos pacientes que recepción, pero enfocado a diagnóstico)
        var pacientesMedico = {
            "ana": {
                nombre: "Ana López",
                cedula: "0923456789",
                edad: "28 años",
                telefono: "099 123 4567",
                correo: "ana.lopez@example.com",
                antecedentes: "Sin enfermedades crónicas registradas.",
                consultas: [
                    {
                        fecha: "2025-10-10",
                        diagnostico: "Infección respiratoria alta",
                        tratamiento: "Paracetamol + reposo + líquidos",
                        observaciones: "Buena respuesta al tratamiento, sin complicaciones."
                    },
                    {
                        fecha: "2025-09-02",
                        diagnostico: "Faringitis aguda",
                        tratamiento: "Antibiótico de 7 días + enjuagues",
                        observaciones: "Se indicó control si no mejora en 72 h."
                    }
                ]
            },
            "carlos": {
                nombre: "Carlos Pérez",
                cedula: "0912345678",
                edad: "45 años",
                telefono: "098 555 6677",
                correo: "carlos.perez@example.com",
                antecedentes: "Hipertensión arterial, en manejo con medicación.",
                consultas: [
                    {
                        fecha: "2025-08-20",
                        diagnostico: "Hipertensión controlada",
                        tratamiento: "Mantener medicación actual, control cada 3 meses.",
                        observaciones: "PA en valores aceptables, se refuerza dieta baja en sal."
                    },
                    {
                        fecha: "2025-05-10",
                        diagnostico: "Chequeo general",
                        tratamiento: "Recomendación de ejercicio moderado 3 veces por semana.",
                        observaciones: "Sin hallazgos patológicos relevantes."
                    }
                ]
            },
            "maria": {
                nombre: "María García",
                cedula: "0956781234",
                edad: "35 años",
                telefono: "097 222 3344",
                correo: "maria.garcia@example.com",
                antecedentes: "Migrañas recurrentes, episodios esporádicos de dolor lumbar.",
                consultas: [
                    {
                        fecha: "2025-07-15",
                        diagnostico: "Migraña sin aura",
                        tratamiento: "Analgésicos según necesidad, control de factores desencadenantes.",
                        observaciones: "Se sugiere diario de dolores de cabeza."
                    },
                    {
                        fecha: "2025-04-03",
                        diagnostico: "Lumbalgia mecánica",
                        tratamiento: "Fisioterapia + ejercicios de estiramiento.",
                        observaciones: "Mejora parcial, pendiente control."
                    }
                ]
            }
        };

        function mostrarPacienteMedico() {
            var select = document.getElementById("pacienteSelectMedico");
            var id     = select.value;

            if (!id) {
                alert("Por favor, selecciona un paciente.");
                return;
            }

            var paciente = pacientesMedico[id];
            if (!paciente) {
                alert("No se encontró información para este paciente.");
                return;
            }

            var card = document.getElementById("patientCardMedico");
            card.style.display = "block";

            document.getElementById("nombrePacienteTituloMedico").innerText = paciente.nombre;
            document.getElementById("pacienteCedulaMedico").innerText       = paciente.cedula;
            document.getElementById("pacienteEdadMedico").innerText         = paciente.edad;
            document.getElementById("pacienteTelefonoMedico").innerText     = paciente.telefono;
            document.getElementById("pacienteCorreoMedico").innerText       = paciente.correo;
            document.getElementById("pacienteAntecedentesMedico").innerText = paciente.antecedentes;

            var tbody = document.querySelector("#tablaConsultasMedico tbody");
            tbody.innerHTML = "";

            if (!paciente.consultas || paciente.consultas.length === 0) {
                var tr = document.createElement("tr");
                tr.innerHTML = "<td colspan='4'>Este paciente no registra consultas anteriores.</td>";
                tbody.appendChild(tr);
            } else {
                for (var i = 0; i < paciente.consultas.length; i++) {
                    var c = paciente.consultas[i];
                    var tr = document.createElement("tr");

                    var html = "";
                    html += "<td>" + c.fecha + "</td>";
                    html += "<td>" + c.diagnostico + "</td>";
                    html += "<td>" + c.tratamiento + "</td>";
                    html += "<td>" + c.observaciones + "</td>";

                    tr.innerHTML = html;
                    tbody.appendChild(tr);
                }
            }

            // Limpiamos mensaje de guardado al cambiar de paciente
            document.getElementById("mensajeGuardar").style.display = "none";
            document.getElementById("notasConsulta").value = "";
            document.getElementById("planConsulta").value  = "";
        }

        function simularGuardar() {
            // Solo simulación visual
            document.getElementById("mensajeGuardar").style.display = "block";
        }
    </script>

</body>
</html>
