-- ============================================
-- SCRIPT: Limpiar Base de Datos - Solo Admin
-- DESCRIPCIÓN: Elimina todos los datos y deja solo usuario admin
-- FECHA: 4 de diciembre de 2025
-- ============================================

-- Desactivar restricciones temporalmente
SET session_replication_role = replica;

-- Eliminar todos los datos de las tablas relacionadas
DELETE FROM auditorias;
DELETE FROM tratamientos;
DELETE FROM examenes_laboratorio;
DELETE FROM consultas;
DELETE FROM citas;
DELETE FROM archivos_medicos;
DELETE FROM horarios_medicos;
DELETE FROM medicos;
DELETE FROM recepcionistas;
DELETE FROM pacientes;

-- Eliminar todos los usuarios excepto el admin
DELETE FROM usuarios WHERE id_usuario != 1;

-- Actualizar el usuario admin (usuario: admin, contraseña: 123456)
UPDATE usuarios 
SET nombre_usuario = 'admin',
    email = 'admin@clinica.com',
    contrasena_hash = '$2a$10$MM4V3GCI2byryadvzeMb9uFoph14xRtKnBoqtA7/9Biq3LX1DGWVm',
    activo = true
WHERE id_usuario = 1;

-- Reactivar restricciones
SET session_replication_role = DEFAULT;

-- Reiniciar secuencias
ALTER SEQUENCE usuarios_id_usuario_seq RESTART WITH 2;
ALTER SEQUENCE pacientes_id_paciente_seq RESTART WITH 1;
ALTER SEQUENCE medicos_id_medico_seq RESTART WITH 1;
ALTER SEQUENCE recepcionistas_id_recepcionista_seq RESTART WITH 1;
ALTER SEQUENCE citas_id_cita_seq RESTART WITH 1;
ALTER SEQUENCE consultas_id_consulta_seq RESTART WITH 1;
ALTER SEQUENCE tratamientos_id_tratamiento_seq RESTART WITH 1;
ALTER SEQUENCE examenes_laboratorio_id_examen_seq RESTART WITH 1;
ALTER SEQUENCE archivos_medicos_id_archivo_seq RESTART WITH 1;
ALTER SEQUENCE auditorias_id_auditoria_seq RESTART WITH 1;
ALTER SEQUENCE horarios_medicos_id_horario_seq RESTART WITH 1;

-- Verificar resultado
SELECT 'Base de datos limpiada exitosamente' as resultado;
SELECT 'Usuario administrador:' as info;
SELECT id_usuario, nombre_usuario, email, activo 
FROM usuarios 
WHERE id_usuario = 1;

-- Mostrar conteo de registros
SELECT 'Registros restantes por tabla:' as resumen;
SELECT 'usuarios' as tabla, COUNT(*) as total FROM usuarios
UNION ALL SELECT 'pacientes', COUNT(*) FROM pacientes
UNION ALL SELECT 'medicos', COUNT(*) FROM medicos
UNION ALL SELECT 'recepcionistas', COUNT(*) FROM recepcionistas
UNION ALL SELECT 'citas', COUNT(*) FROM citas
UNION ALL SELECT 'consultas', COUNT(*) FROM consultas
UNION ALL SELECT 'tratamientos', COUNT(*) FROM tratamientos
UNION ALL SELECT 'auditorias', COUNT(*) FROM auditorias;
