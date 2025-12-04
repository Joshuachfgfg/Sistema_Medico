-- ============================================
-- SCRIPT SIMPLE: Solo actualizar IDs existentes a 1, 2, 3
-- ============================================

BEGIN;

-- Actualizar citas de ID 7 a temporal 100
UPDATE citas SET id_estado_cita = 100 WHERE id_estado_cita = 7;

-- Actualizar citas de ID 9 a temporal 200
UPDATE citas SET id_estado_cita = 200 WHERE id_estado_cita = 9;

-- Actualizar citas de ID 10 a temporal 300
UPDATE citas SET id_estado_cita = 300 WHERE id_estado_cita = 10;

-- Eliminar estados 7, 9, 10
DELETE FROM estados_cita WHERE id_estado_cita IN (7, 9, 10);

-- Reiniciar secuencia
ALTER SEQUENCE estados_cita_id_estado_cita_seq RESTART WITH 1;

-- Insertar nuevos estados con IDs 1, 2, 3
INSERT INTO estados_cita (nombre_estado, descripcion, color_hex) VALUES
('Pendiente', 'Cita agendada, esperando atención', '#FFC107'),
('Completada', 'Cita atendida exitosamente', '#4CAF50'),
('Cancelada', 'Cita cancelada por paciente o médico', '#F44336');

-- Actualizar citas a nuevos IDs
UPDATE citas SET id_estado_cita = 1 WHERE id_estado_cita = 100;
UPDATE citas SET id_estado_cita = 2 WHERE id_estado_cita = 200;
UPDATE citas SET id_estado_cita = 3 WHERE id_estado_cita = 300;

-- Verificar
SELECT '=== RESULTADO FINAL ===' as resultado;
SELECT * FROM estados_cita ORDER BY id_estado_cita;
SELECT ec.nombre_estado, COUNT(c.id_cita) as total_citas
FROM estados_cita ec
LEFT JOIN citas c ON ec.id_estado_cita = c.id_estado_cita
GROUP BY ec.nombre_estado
ORDER BY ec.id_estado_cita;

COMMIT;
