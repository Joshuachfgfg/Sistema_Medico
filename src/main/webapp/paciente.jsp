<%-- 
    Document   : paciente
    Created on : 27 nov 2025, 1:54:27?a. m.
    Author     : Ariel
--%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Página del Paciente</title>

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
            font-size: 2.5em;
            margin: 0;
        }

        .welcome-text {
            font-size: 1.5em;
        }

        .welcome-banner {
            background-color: #ffcc00;
            color: #004b6f;
            text-align: center;
            padding: 15px 0;
            font-size: 1.2em;
            font-weight: bold;
        }

        section {
            margin: 30px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 80%;
            max-width: 900px;
        }

        h2 {
            text-align: center;
            color: #004b6f;
            font-size: 1.8em;
            margin-bottom: 20px;
        }

        .carousel-inner img {
            width: 100%;
            height: auto;
        }

        .appointment-form .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            font-size: 1.1em;
            color: #333;
        }

        .form-control {
            width: 100%;
            padding: 12px;
            margin-top: 8px;
            border-radius: 8px;
            border: 1px solid #ddd;
            font-size: 1.1em;
            box-sizing: border-box;
        }

        .form-control:focus {
            border-color: #004b6f;
            box-shadow: 0 0 5px rgba(0, 75, 111, 0.5);
        }

        .btn-main {
            width: 100%;
            padding: 15px;
            background-color: #004b6f;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1.2em;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .btn-main:hover:enabled {
            background-color: #006f8e;
            transform: scale(1.05);
        }

        .btn-main:disabled {
            background-color: #b0c4de;
            cursor: not-allowed;
            transform: none;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .data-table th,
        .data-table td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
            font-size: 0.95em;
        }

        .data-table th {
            background-color: #004b6f;
            color: white;
        }

        .data-table td {
            background-color: #f9f9f9;
        }

        .btn-cancel {
            background-color: #c62828;
            color: #fff;
            border: none;
            border-radius: 6px;
            padding: 6px 10px;
            font-size: 0.9em;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn-cancel:hover {
            background-color: #e53935;
        }

        .btn-float {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #004b6f;
            color: white;
            border: none;
            border-radius: 50%;
            padding: 15px;
            font-size: 20px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn-float:hover {
            background-color: #006f8e;
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

    <div class="welcome-banner">
        ¡Bienvenido a la Clínica Salud y Bienestar! Para tu seguridad, hemos implementado nuevas medidas sanitarias. ¡Cuídate y agenda tu cita!
    </div>

    <header>
        <h1>Bienvenido a la Clínica Salud y Bienestar</h1>
        <p class="welcome-text">Tu salud es nuestra prioridad. ¡Agenda tu cita hoy mismo!</p>
    </header>

    <!-- Info clínica -->
    <section>
        <h2>Conoce más sobre nosotros</h2>
        <p>
            En la Clínica Salud y Bienestar, nos dedicamos a ofrecer atención médica integral y personalizada
            a cada uno de nuestros pacientes. Contamos con un equipo de médicos altamente calificados y un
            ambiente cómodo y acogedor. Nuestro objetivo es brindar soluciones médicas eficaces para mejorar
            la salud y bienestar de nuestra comunidad.
        </p>
    </section>

    <!-- Carrusel -->
    <section>
        <div id="carouselExample" class="carousel slide carousel-fade" data-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="images/carrusel-2.jpg" class="d-block w-100" alt="Imagen 1">
                </div>
                <div class="carousel-item">
                    <img src="images/Carruselcon.jpg" class="d-block w-100" alt="Imagen 2">
                </div>
                <div class="carousel-item">
                    <img src="images/carrusel3.jpg" class="d-block w-100" alt="Imagen 3">
                </div>
            </div>
            <a class="carousel-control-prev" href="#carouselExample" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Anterior</span>
            </a>
            <a class="carousel-control-next" href="#carouselExample" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Siguiente</span>
            </a>
        </div>
    </section>

    <!-- AGENDA TU CITA -->
    <section>
        <h2>Agenda tu cita</h2>
        <form action="#" method="post" class="appointment-form" onsubmit="return agregarCita(event);">
            <div class="form-group">
                <label for="doctor"><i class="fa fa-user-md"></i> Selecciona el doctor:</label>
                <select name="doctor" id="doctor" class="form-control" onchange="validarFormulario()">
                    <option value="" disabled selected>Seleccione</option>
                    <option value="Dr. Juan Pérez (Medicina General)">Dr. Juan Pérez (Medicina General)</option>
                    <option value="Dra. María González (Cardiología)">Dra. María González (Cardiología)</option>
                    <option value="Dr. Luis Rodríguez (Pediatría)">Dr. Luis Rodríguez (Pediatría)</option>
                    <option value="Dra. Juliana Muñoz (Medicina Interna)">Dra. Juliana Muñoz (Medicina Interna)</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="fecha"><i class="fa fa-calendar-alt"></i> Selecciona la fecha de tu cita:</label>
                <input type="date" id="fecha" name="fecha" class="form-control"
                       onchange="validarFormulario()">
            </div>

            <div class="form-group">
                <label for="sintomas"><i class="fa fa-heartbeat"></i> Descripción de tus síntomas:</label>
                <textarea id="sintomas" name="sintomas" class="form-control" rows="4"
                          placeholder="Escribe una breve descripción de tus síntomas"></textarea>
            </div>

            <div class="form-group">
                <input type="submit" value="Agendar cita" class="btn-main" id="btn-agendar" disabled>
            </div>
        </form>
    </section>

    <!-- CITAS AGENDADAS -->
    <section>
        <h2>Citas agendadas</h2>
        <table class="data-table">
            <thead>
                <tr>
                    <th>Fecha</th>
                    <th>Médico</th>
                    <th>Síntomas</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody id="tbody-citas-agendadas">
                <!-- Filas dinámicas -->
            </tbody>
        </table>
        <p id="mensaje-sin-citas" style="font-size: 0.9em; color: #607d8b; margin-top: 10px;">
            Aún no tienes citas agendadas.
        </p>
    </section>

    <!-- CONSULTAS ANTERIORES (ejemplo estático) -->
    <section>
        <h2>Consultas anteriores</h2>
        <button class="btn-main" style="width:auto; padding:8px 18px;"
                data-toggle="collapse" data-target="#consultasAnteriores">
            Ver consultas anteriores
        </button>
        <div id="consultasAnteriores" class="collapse" style="margin-top:15px;">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Fecha</th>
                        <th>Doctor</th>
                        <th>Diagnóstico</th>
                        <th>Tratamiento</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>2025-10-10</td>
                        <td>Dr. Juan Pérez</td>
                        <td>Consulta general</td>
                        <td>Reposo y líquidos</td>
                    </tr>
                    <tr>
                        <td>2025-06-01</td>
                        <td>Dra. María González</td>
                        <td>Chequeo de rutina</td>
                        <td>Vitamina D y ejercicio moderado</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </section>

    <button class="btn-float" title="Llamar a la clínica">
        <i class="fa fa-phone"></i>
    </button>

    <script>
        // Habilitar / deshabilitar botón de agendar
        function validarFormulario() {
            var doctor = document.getElementById("doctor").value;
            var fecha  = document.getElementById("fecha").value;
            var btn    = document.getElementById("btn-agendar");

            btn.disabled = !(doctor && fecha);
        }

        // Agregar cita a la tabla "Citas agendadas"
        function agregarCita(event) {
            event.preventDefault();

            var doctorSelect = document.getElementById("doctor");
            var doctorTexto  = doctorSelect.value;
            var fecha        = document.getElementById("fecha").value;
            var sintomas     = document.getElementById("sintomas").value.trim();
            var tbody        = document.getElementById("tbody-citas-agendadas");
            var msgSinCitas  = document.getElementById("mensaje-sin-citas");

            if (!doctorTexto || !fecha) {
                alert("Por favor, selecciona un doctor y una fecha.");
                return false;
            }

            if (msgSinCitas) {
                msgSinCitas.style.display = "none";
            }

            var tr = document.createElement("tr");
            var html = "";
            html += "<td>" + fecha + "</td>";
            html += "<td>" + doctorTexto + "</td>";
            html += "<td>" + (sintomas ? sintomas : "Sin descripción") + "</td>";
            html += "<td>";
            html += "<button type='button' class='btn-cancel' onclick='eliminarCita(this)'>";
            html += "<i class=\"fa fa-times\"></i> Cancelar";
            html += "</button>";
            html += "</td>";
            tr.innerHTML = html;
            tbody.appendChild(tr);

            // Limpiar formulario
            doctorSelect.selectedIndex = 0;
            document.getElementById("fecha").value    = "";
            document.getElementById("sintomas").value = "";
            document.getElementById("btn-agendar").disabled = true;

            return false;
        }

        // Eliminar cita de la tabla
        function eliminarCita(btn) {
            if (confirm("¿Estás seguro de que deseas cancelar esta cita?")) {
                var row   = btn.closest("tr");
                var tbody = document.getElementById("tbody-citas-agendadas");
                row.remove();

                if (tbody.children.length === 0) {
                    var msgSinCitas = document.getElementById("mensaje-sin-citas");
                    if (msgSinCitas) {
                        msgSinCitas.style.display = "block";
                    }
                }
            }
        }
    </script>

</body>
</html>