document.getElementById('loginForm').addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;
    const errorDiv = document.getElementById('errorMessage');
    
    console.log('Intentando login con usuario:', username);
    
    try {
        const response = await fetch('/consultorio-medico/resources/auth/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            credentials: 'include',
            body: JSON.stringify({
                nombreUsuario: username,
                contrasena: password
            })
        });
        
        console.log('Response status:', response.status);
        
        if (response.ok) {
            const data = await response.json();
            console.log('Login exitoso, datos:', data);
            
            // Redirigir según el rol del usuario
            let redirectUrl = 'admin/dashboard.html'; // Por defecto (Administrador)
            
            if (data.rol === 'Médico' || data.rol === 'Medico') {
                redirectUrl = 'medico.html';
            } else if (data.rol === 'Recepcionista') {
                redirectUrl = 'recepcionista.html';
            } else if (data.rol === 'Paciente') {
                redirectUrl = 'paciente.html';
            } else if (data.rol === 'Administrador') {
                redirectUrl = 'admin/dashboard.html';
            }
            
            console.log('Redirigiendo a:', redirectUrl, '(Rol:', data.rol + ')');
            window.location.href = redirectUrl;
        } else {
            const error = await response.json();
            console.error('Error de login:', error);
            errorDiv.textContent = error.error || 'Usuario o contraseña incorrectos';
            errorDiv.style.display = 'block';
        }
    } catch (error) {
        console.error('Error de conexión:', error);
        errorDiv.textContent = 'Error de conexión con el servidor: ' + error.message;
        errorDiv.style.display = 'block';
    }
});

// ============================================
// FUNCIONALIDAD CAMBIAR CONTRASEÑA
// ============================================
function cerrarModalPassword() {
    const modal = document.getElementById('modalCambiarPassword');
    const form = document.getElementById('formCambiarPassword');
    const errorDiv = document.getElementById('errorMessageModal');
    const successDiv = document.getElementById('successMessageModal');
    
    if (modal) modal.style.display = 'none';
    if (form) form.reset();
    if (errorDiv) errorDiv.textContent = '';
    if (successDiv) successDiv.style.display = 'none';
}

// Registrar evento cuando el DOM esté listo
window.addEventListener('DOMContentLoaded', () => {
    const formCambiarPassword = document.getElementById('formCambiarPassword');
    
    if (formCambiarPassword) {
        formCambiarPassword.addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const cedula = document.getElementById('recuperarCedula').value.trim();
    const nombreUsuario = document.getElementById('recuperarUsuario').value.trim();
    const nuevaPassword = document.getElementById('nuevaPassword').value;
    const confirmarPassword = document.getElementById('confirmarPassword').value;
    const errorDiv = document.getElementById('errorMessageModal');
    const successDiv = document.getElementById('successMessageModal');
    
    // Limpiar mensajes
    errorDiv.textContent = '';
    successDiv.style.display = 'none';
    
    // Validaciones
    if (!/^\d{10}$/.test(cedula)) {
        errorDiv.textContent = 'La cédula debe tener 10 dígitos';
        return;
    }
    
    if (nuevaPassword.length < 6) {
        errorDiv.textContent = 'La contraseña debe tener al menos 6 caracteres';
        return;
    }
    
    if (nuevaPassword !== confirmarPassword) {
        errorDiv.textContent = 'Las contraseñas no coinciden';
        return;
    }
    
    try {
        // Llamar al endpoint de cambio de contraseña
        const response = await fetch('/consultorio-medico/resources/usuarios/cambiar-password', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                cedula: cedula,
                nombreUsuario: nombreUsuario,
                nuevaPassword: nuevaPassword
            })
        });
        
        const data = await response.json();
        
        if (response.ok) {
            successDiv.textContent = '✓ Contraseña actualizada exitosamente. Ahora puedes iniciar sesión con tu nueva contraseña.';
            successDiv.style.display = 'block';
            errorDiv.textContent = '';
            
            // Limpiar formulario
            document.getElementById('formCambiarPassword').reset();
            
            // Cerrar modal después de 3 segundos
            setTimeout(() => {
                cerrarModalPassword();
            }, 3000);
        } else {
            errorDiv.textContent = data.error || 'Error al cambiar la contraseña';
            successDiv.style.display = 'none';
        }
        
    } catch (error) {
        console.error('Error:', error);
        errorDiv.textContent = 'Error de conexión con el servidor';
        successDiv.style.display = 'none';
    }
        });
    }
});

// Cerrar modal al hacer clic fuera
window.onclick = function(event) {
    const modal = document.getElementById('modalCambiarPassword');
    if (event.target === modal) {
        cerrarModalPassword();
    }
};
