-- ============================================
-- SCRIPT: Simplificar Estados de Cita
-- DESCRIPCIÓN: Reduce los estados de cita a solo 3 esenciales
-- FECHA: 4 de diciembre de 2025
-- ============================================

-- Ver estado actual
SELECT 'ANTES DE LA MIGRACIÓN:' as info;
SELECT id_estado_cita, nombre_estado FROM estados_cita ORDER BY id_estado_cita;
SELECT 'Total citas:', COUNT(*) FROM citas;

-- Paso 1: Mapear todas las citas existentes a los estados temporales seguros
-- Mapear a Pendiente (7), Completada (9=Atendida), Cancelada (10)

UPDATE citas 
SET id_estado_cita = 7  -- Pendiente
WHERE id_estado_cita IN (7, 8, 12);  -- Pendiente, Confirmada, Reprogramada

UPDATE citas 
SET id_estado_cita = 9  -- Completada (usando Atendida temporalmente)
WHERE id_estado_cita = 9;  -- Atendida

UPDATE citas 
SET id_estado_cita = 10  -- Cancelada
WHERE id_estado_cita IN (10, 11);  -- Cancelada, No asistió

-- Verificar que todas las citas tienen estados válidos
SELECT 'Citas por estado temporal:' as info;
SELECT ec.nombre_estado, COUNT(c.id_cita) as total
FROM estados_cita ec
LEFT JOIN citas c ON ec.id_estado_cita = c.id_estado_cita
WHERE ec.id_estado_cita IN (7, 9, 10)
GROUP BY ec.nombre_estado;

-- Paso 2: Eliminar estados no utilizados
DELETE FROM estados_cita WHERE id_estado_cita IN (8, 11, 12);

-- Paso 3: Actualizar los estados que vamos a usar con los nuevos valores
UPDATE estados_cita 
SET nombre_estado = 'Pendiente',
    descripcion = 'Cita agendada, esperando atención',
    color_hex = '#FFC107'
WHERE id_estado_cita = 7;

UPDATE estados_cita 
SET nombre_estado = 'Completada',
    descripcion = 'Cita atendida exitosamente',
    color_hex = '#4CAF50'
WHERE id_estado_cita = 9;

UPDATE estados_cita 
SET nombre_estado = 'Cancelada',
    descripcion = 'Cita cancelada por paciente o médico',
    color_hex = '#F44336'
WHERE id_estado_cita = 10;

-- Paso 4: Cambiar los IDs a 1, 2, 3
-- Primero mover citas temporalmente a IDs negativos para evitar conflictos
UPDATE citas SET id_estado_cita = -1 WHERE id_estado_cita = 7;
UPDATE citas SET id_estado_cita = -2 WHERE id_estado_cita = 9;
UPDATE citas SET id_estado_cita = -3 WHERE id_estado_cita = 10;

-- Eliminar los estados antiguos
DELETE FROM estados_cita WHERE id_estado_cita IN (7, 9, 10);

-- Reiniciar la secuencia
ALTER SEQUENCE estados_cita_id_estado_cita_seq RESTART WITH 1;

-- Insertar los 3 estados con IDs 1, 2, 3
INSERT INTO estados_cita (nombre_estado, descripcion, color_hex) VALUES
('Pendiente', 'Cita agendada, esperando atención', '#FFC107'),
('Completada', 'Cita atendida exitosamente', '#4CAF50'),
('Cancelada', 'Cita cancelada por paciente o médico', '#F44336');

-- Actualizar las citas a los nuevos IDs
UPDATE citas SET id_estado_cita = 1 WHERE id_estado_cita = -1;
UPDATE citas SET id_estado_cita = 2 WHERE id_estado_cita = -2;
UPDATE citas SET id_estado_cita = 3 WHERE id_estado_cita = -3;

-- Verificar el resultado final
SELECT 'DESPUÉS DE LA MIGRACIÓN:' as info;
SELECT * FROM estados_cita ORDER BY id_estado_cita;

SELECT 'Resumen de citas por estado:' as info;
SELECT 
    ec.nombre_estado,
    COUNT(c.id_cita) as total_citas
FROM estados_cita ec
LEFT JOIN citas c ON ec.id_estado_cita = c.id_estado_cita
GROUP BY ec.id_estado_cita, ec.nombre_estado
ORDER BY ec.id_estado_cita;
