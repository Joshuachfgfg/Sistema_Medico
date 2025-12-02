# Sistema Médico - Credenciales de Acceso

## URL de Acceso
**Login:** http://localhost:8080/consultorio-medico/

---

## Usuarios Disponibles

### 1️⃣ Administrador
- **Usuario:** `admin`
- **Contraseña:** `admin123`
- **Rol:** Administrador
- **Redirección:** `admin/dashboard.html` (Panel administrativo con estadísticas, gestión de pacientes, médicos, citas)

---

### 2️⃣ Médico
- **Usuario:** `medico1`
- **Contraseña:** `password123`
- **Rol:** Médico
- **Redirección:** `medico.html` (Panel del médico con citas del día, historia clínica de pacientes, consultas)
- **Datos:**
  - Nombre: Dr. Juan Pérez
  - Cédula: 0912345678
  - Especialidad: Medicina General
  - Licencia: MED-001

---

### 3️⃣ Recepcionista
- **Usuario:** `recepcion1`
- **Contraseña:** `password123`
- **Rol:** Recepcionista
- **Redirección:** `recepcionista.html` (Panel de recepción con buscador de pacientes, gestión de citas del día)
- **Datos:**
  - Nombre: María García
  - Cédula: 0923456789

---

## Estructura de Archivos

### 📁 Vista de Administrador (`/admin/`)
- `admin/dashboard.html` - Panel principal con estadísticas
- `admin/pacientes.html` - Gestión completa de pacientes
- `admin/medicos.html` - Gestión de médicos
- `admin/citas.html` - Gestión de citas

### 📁 Vistas de Roles Específicos (raíz)
- `medico.html` - Panel del médico (consumiendo REST API)
- `recepcionista.html` - Panel de recepcionista (consumiendo REST API)
- `paciente.html` - Portal del paciente (consumiendo REST API)

### 📁 Recursos Comunes
- `css/styles.css` - Estilos para vistas de administrador
- `js/common.js` - Funciones compartidas (checkSession, logout, etc.)
- `js/session-check.jsp.js` - Verificación de sesión para vistas HTML
- `js/login.js` - Manejo del formulario de login con redirección por rol
- `js/dashboard.js`, `js/pacientes.js`, `js/citas.js`, `js/medicos.js` - Scripts específicos del admin

---

## Funcionalidades por Rol

### 🔐 Administrador (dashboard.html)
- ✅ Estadísticas del sistema (total pacientes, médicos, citas, tratamientos)
- ✅ Gestión completa de pacientes (CRUD con búsqueda)
- ✅ Gestión de médicos (CRUD con filtros por especialidad)
- ✅ Gestión de citas (CRUD con filtros por fecha)
- ✅ Visualización de próximas citas
- ✅ Listado de pacientes recientes
- ✅ Acceso a todas las funcionalidades del sistema REST API

### 👨‍⚕️ Médico (medico.html)
- ✅ Resumen de citas del día (total programadas, pacientes atendidos, consultas realizadas, pendientes)
- ✅ Tabla de citas diarias con datos reales desde la base de datos
- ✅ Búsqueda de pacientes con selector dinámico
- ✅ Visualización de historia clínica del paciente
- ✅ Visualización de consultas anteriores del paciente desde la base de datos
- ✅ **Conectado al REST API y base de datos PostgreSQL**

### 📋 Recepcionista (recepcionista.html)
- ✅ Buscador de pacientes con selector dinámico
- ✅ Visualización de datos básicos del paciente (cédula, edad, teléfono, email, dirección)
- ✅ Consultas anteriores del paciente con información del médico
- ✅ Gestión de citas del día con datos en tiempo real
- ✅ Tabla de citas mostrando paciente, médico, motivo y estado
- ✅ **Conectado al REST API y base de datos PostgreSQL**

### 👤 Paciente (paciente.html)
- ✅ Información de la clínica
- ✅ Visualización de citas futuras programadas
- ✅ Visualización de consultas anteriores
- ✅ Datos cargados dinámicamente según el usuario logueado
- ✅ **Conectado al REST API y base de datos PostgreSQL**
- ⚠️ **Nota:** Requiere que el usuario tenga un registro en la tabla `pacientes` asociado

---

## Sistema de Autenticación

### Características
- ✅ **Sesión basada en HttpSession** (no JWT)
- ✅ **Contraseñas hasheadas con BCrypt** (60 caracteres, algoritmo $2a$10)
- ✅ **Timeout de sesión:** 3600 segundos (1 hora)
- ✅ **Redirección automática según rol** después del login
- ✅ **Verificación de sesión** en todas las páginas JSP y HTML
- ✅ **Protección de endpoints REST** mediante `AuthFilter` (excepto `/auth/*`)
- ✅ **Botón de cerrar sesión** en todas las vistas

### Endpoints de Autenticación
- `POST /consultorio-medico/resources/auth/login` - Iniciar sesión
- `POST /consultorio-medico/resources/auth/logout` - Cerrar sesión
- `GET /consultorio-medico/resources/auth/session` - Verificar sesión activa

---

## Estado de la Base de Datos

### Datos Actuales
- **Usuarios:** 3 (admin, medico1, recepcion1)
- **Médicos:** 1 (Dr. Juan Pérez - Medicina General)
- **Recepcionistas:** 1 (María García)
- **Pacientes:** 0 (base de datos limpia)
- **Citas:** 0
- **Consultas:** 0
- **Tratamientos:** 0

### Notas Importantes
✅ **Todas las vistas HTML** (`admin/`, `medico.html`, `recepcionista.html`, `paciente.html`) están **conectadas al REST API** y consumen datos reales de la base de datos PostgreSQL.

⚠️ La vista de **paciente.html** requiere que el usuario logueado tenga un registro asociado en la tabla `pacientes`. Si no existe, mostrará un mensaje indicando que no se encontró información.

---

## Próximos Pasos (Opcional)

Funcionalidades adicionales que se pueden implementar:
1. **Vista de paciente:** Agregar formulario para agendar nuevas citas
2. **Vista de médico:** Agregar formulario para registrar nuevas consultas
3. **Vista de recepcionista:** Agregar botones de acción para confirmar/cancelar/reprogramar citas
4. **Todas las vistas:** Implementar paginación para tablas con muchos registros
5. **Seguridad:** Agregar validación de roles en el backend (AuthFilter por rol)

---

## Tecnologías Utilizadas
- **Backend:** Java 21, Jakarta EE 11, Hibernate 6.4.4, Jersey 3.1.5
- **Frontend:** HTML5, CSS3, JavaScript (Vanilla), Bootstrap 4.5.2
- **Base de datos:** PostgreSQL 18.1
- **Servidor:** Apache Tomcat 10.1.28
- **Autenticación:** BCrypt para hashing de contraseñas
- **Arquitectura:** REST API + Vistas JSP/HTML con redirección basada en roles

---

## Documentación Completa

Para más información sobre el sistema REST API:
- Ver `README.md` para documentación completa de endpoints
- Consultar `seed_data.sql` para la estructura de la base de datos
- Revisar `pom.xml` para dependencias y configuración del proyecto
