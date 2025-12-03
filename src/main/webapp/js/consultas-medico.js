// ============================================
// GESTIÓN DE CONSULTAS - PANEL MÉDICO
// ============================================

let currentCita = null;
let currentPaciente = null;

// ============================================
// CARGAR CITAS DEL DÍA
// ============================================
async function loadCitasDelDia() {
    try {
        const response = await fetch(`${API_URL}/citas`, {credentials: 'include'});
        const todasCitas = await response.json();
        
        const hoy = new Date().toISOString().split('T')[0];
        const citasHoy = todasCitas.filter(c => 
            c.fechaCita && c.fechaCita.startsWith(hoy) &&
            c.paciente && c.paciente.activo === true &&
            c.medico && c.medico.activo === true
        ).sort((a, b) => a.horaCita.localeCompare(b.horaCita));
        
        const tbody = document.getElementById('tbody-citas-dia');
        tbody.innerHTML = '';
        
        if (citasHoy.length === 0) {
            tbody.innerHTML = '<tr><td colspan="5" style="text-align:center;color:#607d8b;">No hay citas programadas para hoy</td></tr>';
            return;
        }
        
        citasHoy.forEach(cita => {
            const tr = document.createElement('tr');
            const pacienteNombre = `${cita.paciente.nombres} ${cita.paciente.apellidos}`;
            const estado = cita.estadoCita ? cita.estadoCita.nombreEstado : 'Pendiente';
            const estadoClass = estado.toLowerCase().replace(/ /g, '-');
            
            tr.innerHTML = `
                <td>${cita.horaCita || 'N/A'}</td>
                <td>${pacienteNombre}</td>
                <td>${cita.motivoConsulta || 'Sin motivo'}</td>
                <td><span class="badge-estado badge-${estadoClass}">${estado}</span></td>
                <td>
                    <button class="btn-sm btn-primary" onclick="abrirConsulta(${cita.idCita})">
                        <i class="fas fa-notes-medical"></i> Atender
                    </button>
                </td>
            `;
            tbody.appendChild(tr);
        });
    } catch (error) {
        console.error('Error cargando citas:', error);
    }
}

// ============================================
// ABRIR MODAL DE CONSULTA
// ============================================
async function abrirConsulta(idCita) {
    try {
        // Cargar datos de la cita
        const response = await fetch(`${API_URL}/citas/${idCita}`, {credentials: 'include'});
        currentCita = await response.json();
        
        if (!currentCita.paciente) {
            showError('No se pudo cargar la información del paciente');
            return;
        }
        
        currentPaciente = currentCita.paciente;
        
        // Verificar si ya existe una consulta para esta cita
        const consultaExistente = await fetch(`${API_URL}/consultas/cita/${idCita}`, {credentials: 'include'});
        
        if (consultaExistente.ok) {
            const consulta = await consultaExistente.json();
            cargarConsultaExistente(consulta);
        } else {
            limpiarFormularioConsulta();
        }
        
        // Llenar datos del paciente
        document.getElementById('paciente-nombre').textContent = `${currentPaciente.nombres} ${currentPaciente.apellidos}`;
        document.getElementById('paciente-cedula').textContent = currentPaciente.cedula;
        document.getElementById('paciente-edad').textContent = currentPaciente.edad ? `${currentPaciente.edad} años` : 'N/A';
        document.getElementById('paciente-alergias').textContent = currentPaciente.alergias || 'Ninguna registrada';
        document.getElementById('paciente-enfermedades').textContent = currentPaciente.enfermedadesCronicas || 'Ninguna registrada';
        
        // Llenar datos de la cita
        document.getElementById('motivo-consulta-display').textContent = currentCita.motivoConsulta || 'Sin motivo especificado';
        document.getElementById('sintomas-previos').textContent = currentCita.sintomas || 'No especificados';
        
        // Cargar historial de consultas previas
        await cargarHistorialConsultas(currentPaciente.idPaciente);
        
        // Mostrar modal
        $('#modalConsulta').modal('show');
        
    } catch (error) {
        console.error('Error abriendo consulta:', error);
        showError('Error al cargar la consulta');
    }
}

// ============================================
// CARGAR CONSULTA EXISTENTE
// ============================================
function cargarConsultaExistente(consulta) {
    document.getElementById('temperatura').value = '';
    document.getElementById('presion-arterial').value = '';
    document.getElementById('frecuencia-cardiaca').value = '';
    document.getElementById('frecuencia-respiratoria').value = '';
    document.getElementById('saturacion-oxigeno').value = '';
    document.getElementById('peso').value = '';
    document.getElementById('altura').value = '';
    
    // Parsear signos vitales si existen
    if (consulta.signosVitales) {
        const signos = typeof consulta.signosVitales === 'string' ? 
            JSON.parse(consulta.signosVitales) : consulta.signosVitales;
        
        document.getElementById('temperatura').value = signos.temperatura || '';
        document.getElementById('presion-arterial').value = signos.presionArterial || '';
        document.getElementById('frecuencia-cardiaca').value = signos.frecuenciaCardiaca || '';
        document.getElementById('frecuencia-respiratoria').value = signos.frecuenciaRespiratoria || '';
        document.getElementById('saturacion-oxigeno').value = signos.saturacionOxigeno || '';
        document.getElementById('peso').value = signos.peso || '';
        document.getElementById('altura').value = signos.altura || '';
    }
    
    document.getElementById('sintomas-actuales').value = consulta.sintomasPresentados || '';
    document.getElementById('examen-fisico').value = consulta.examenFisico || '';
    document.getElementById('diagnostico').value = consulta.diagnostico || '';
    document.getElementById('observaciones-consulta').value = consulta.observaciones || '';
    document.getElementById('recomendaciones').value = consulta.recomendaciones || '';
    document.getElementById('proxima-cita').value = consulta.proximaCita || '';
}

// ============================================
// LIMPIAR FORMULARIO
// ============================================
function limpiarFormularioConsulta() {
    document.getElementById('temperatura').value = '';
    document.getElementById('presion-arterial').value = '';
    document.getElementById('frecuencia-cardiaca').value = '';
    document.getElementById('frecuencia-respiratoria').value = '';
    document.getElementById('saturacion-oxigeno').value = '';
    document.getElementById('peso').value = '';
    document.getElementById('altura').value = '';
    document.getElementById('sintomas-actuales').value = '';
    document.getElementById('examen-fisico').value = '';
    document.getElementById('diagnostico').value = '';
    document.getElementById('observaciones-consulta').value = '';
    document.getElementById('recomendaciones').value = '';
    document.getElementById('proxima-cita').value = '';
}

// ============================================
// CARGAR HISTORIAL DE CONSULTAS
// ============================================
async function cargarHistorialConsultas(idPaciente) {
    try {
        const response = await fetch(`${API_URL}/consultas/paciente/${idPaciente}`, {credentials: 'include'});
        const consultas = await response.json();
        
        const tbody = document.getElementById('tbody-historial-consultas');
        tbody.innerHTML = '';
        
        if (consultas.length === 0) {
            tbody.innerHTML = '<tr><td colspan="3" style="text-align:center;color:#607d8b;">No hay consultas previas</td></tr>';
            return;
        }
        
        // Mostrar solo las últimas 5 consultas
        consultas.slice(0, 5).forEach(c => {
            const tr = document.createElement('tr');
            const fecha = new Date(c.fechaConsulta).toLocaleDateString('es-EC');
            tr.innerHTML = `
                <td>${fecha}</td>
                <td>${c.diagnostico || 'Sin diagnóstico'}</td>
                <td>${c.observaciones || 'Sin observaciones'}</td>
            `;
            tbody.appendChild(tr);
        });
        
    } catch (error) {
        console.error('Error cargando historial:', error);
    }
}

// ============================================
// GUARDAR CONSULTA
// ============================================
async function guardarConsulta() {
    try {
        const diagnostico = document.getElementById('diagnostico').value.trim();
        
        if (!diagnostico) {
            showError('El diagnóstico es obligatorio');
            return;
        }
        
        // Recopilar signos vitales
        const signosVitales = {
            temperatura: document.getElementById('temperatura').value,
            presionArterial: document.getElementById('presion-arterial').value,
            frecuenciaCardiaca: document.getElementById('frecuencia-cardiaca').value,
            frecuenciaRespiratoria: document.getElementById('frecuencia-respiratoria').value,
            saturacionOxigeno: document.getElementById('saturacion-oxigeno').value,
            peso: document.getElementById('peso').value,
            altura: document.getElementById('altura').value
        };
        
        const consulta = {
            cita: { idCita: currentCita.idCita },
            paciente: { idPaciente: currentPaciente.idPaciente },
            medico: { idMedico: currentCita.medico.idMedico },
            fechaConsulta: new Date().toISOString(),
            motivoConsulta: currentCita.motivoConsulta,
            sintomasPresentados: document.getElementById('sintomas-actuales').value.trim(),
            signosVitales: JSON.stringify(signosVitales),
            examenFisico: document.getElementById('examen-fisico').value.trim(),
            diagnostico: diagnostico,
            observaciones: document.getElementById('observaciones-consulta').value.trim(),
            recomendaciones: document.getElementById('recomendaciones').value.trim(),
            proximaCita: document.getElementById('proxima-cita').value || null
        };
        
        const response = await fetch(`${API_URL}/consultas`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            credentials: 'include',
            body: JSON.stringify(consulta)
        });
        
        if (response.ok) {
            // Actualizar estado de la cita a "Atendida" (estado 9)
            await actualizarEstadoCita(currentCita.idCita, 9);
            
            showSuccess('Consulta guardada exitosamente');
            $('#modalConsulta').modal('hide');
            loadCitasDelDia();
        } else {
            const error = await response.text();
            showError('Error al guardar consulta: ' + error);
        }
        
    } catch (error) {
        console.error('Error guardando consulta:', error);
        showError('Error al guardar la consulta');
    }
}

// ============================================
// ACTUALIZAR ESTADO DE CITA
// ============================================
async function actualizarEstadoCita(idCita, idEstado) {
    try {
        const cita = await fetch(`${API_URL}/citas/${idCita}`, {credentials: 'include'}).then(r => r.json());
        cita.estadoCita = { idEstadoCita: idEstado };
        
        await fetch(`${API_URL}/citas/${idCita}`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            credentials: 'include',
            body: JSON.stringify(cita)
        });
    } catch (error) {
        console.error('Error actualizando estado:', error);
    }
}

// ============================================
// FUNCIONES DE UTILIDAD
// ============================================
function showSuccess(message) {
    alert('✅ ' + message);
}

function showError(message) {
    alert('❌ ' + message);
}

// ============================================
// INICIALIZAR
// ============================================
document.addEventListener('DOMContentLoaded', () => {
    loadCitasDelDia();
});
