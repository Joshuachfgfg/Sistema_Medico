-- ============================================
-- LIMPIEZA COMPLETA DE LA BASE DE DATOS
-- ============================================

-- Eliminar todos los datos (respetando foreign keys)
DELETE FROM seguimientos_tratamiento;
DELETE FROM tratamientos;
DELETE FROM examenes_laboratorio;
DELETE FROM consultas;
DELETE FROM citas;
DELETE FROM archivos_medicos;
DELETE FROM horarios_medicos;
DELETE FROM recepcionistas;
DELETE FROM medicos;
DELETE FROM pacientes;
DELETE FROM usuarios;

-- Resetear secuencias
ALTER SEQUENCE citas_id_cita_seq RESTART WITH 1;
ALTER SEQUENCE consultas_id_consulta_seq RESTART WITH 1;
ALTER SEQUENCE pacientes_id_paciente_seq RESTART WITH 1;
ALTER SEQUENCE tratamientos_id_tratamiento_seq RESTART WITH 1;
ALTER SEQUENCE examenes_laboratorio_id_examen_seq RESTART WITH 1;
ALTER SEQUENCE seguimientos_tratamiento_id_seguimiento_seq RESTART WITH 1;
ALTER SEQUENCE archivos_medicos_id_archivo_seq RESTART WITH 1;
ALTER SEQUENCE horarios_medicos_id_horario_seq RESTART WITH 1;
ALTER SEQUENCE medicos_id_medico_seq RESTART WITH 1;
ALTER SEQUENCE recepcionistas_id_recepcionista_seq RESTART WITH 1;
ALTER SEQUENCE usuarios_id_usuario_seq RESTART WITH 1;

-- NO crear ningún usuario
-- La base de datos queda completamente vacía
-- El primer usuario (administrador) se creará desde el frontend

-- Verificar que no hay usuarios
SELECT COUNT(*) as total_usuarios FROM usuarios;

-- Verificar conteo de todas las tablas
SELECT 
    (SELECT COUNT(*) FROM usuarios) as usuarios,
    (SELECT COUNT(*) FROM medicos) as medicos,
    (SELECT COUNT(*) FROM pacientes) as pacientes,
    (SELECT COUNT(*) FROM recepcionistas) as recepcionistas,
    (SELECT COUNT(*) FROM citas) as citas,
    (SELECT COUNT(*) FROM consultas) as consultas,
    (SELECT COUNT(*) FROM tratamientos) as tratamientos;
