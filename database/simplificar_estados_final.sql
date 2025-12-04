-- ============================================
-- SCRIPT: Simplificar Estados de Cita (Versión Segura)
-- DESCRIPCIÓN: Reduce los estados de cita a solo 3 esenciales
-- FECHA: 4 de diciembre de 2025
-- ============================================

BEGIN;

-- Ver estado actual
SELECT 'ANTES:' as momento, id_estado_cita, nombre_estado FROM estados_cita ORDER BY id_estado_cita;

-- Crear tabla temporal para estados
CREATE TEMP TABLE nuevos_estados (
    id_viejo INT,
    id_nuevo INT,
    nombre VARCHAR(50)
);

INSERT INTO nuevos_estados VALUES
(7, 1, 'Pendiente'),   -- Pendiente
(8, 1, 'Pendiente'),   -- Confirmada -> Pendiente
(9, 2, 'Completada'),  -- Atendida -> Completada
(10, 3, 'Cancelada'),  -- Cancelada
(11, 3, 'Cancelada'),  -- No asistió -> Cancelada
(12, 1, 'Pendiente');  -- Reprogramada -> Pendiente

-- Deshabilitar triggers temporalmente
SET session_replication_role = replica;

-- Insertar los nuevos estados si no existen
INSERT INTO estados_cita (id_estado_cita, nombre_estado, descripcion, color_hex) VALUES
(1, 'Pendiente', 'Cita agendada, esperando atención', '#FFC107'),
(2, 'Completada', 'Cita atendida exitosamente', '#4CAF50'),
(3, 'Cancelada', 'Cita cancelada por paciente o médico', '#F44336')
ON CONFLICT (id_estado_cita) DO UPDATE 
SET nombre_estado = EXCLUDED.nombre_estado,
    descripcion = EXCLUDED.descripcion,
    color_hex = EXCLUDED.color_hex;

-- Actualizar todas las citas para usar los nuevos IDs
UPDATE citas c
SET id_estado_cita = ne.id_nuevo
FROM nuevos_estados ne
WHERE c.id_estado_cita = ne.id_viejo;

-- Eliminar estados antiguos que ya no se usan
DELETE FROM estados_cita WHERE id_estado_cita NOT IN (1, 2, 3);

-- Reiniciar la secuencia
SELECT setval('estados_cita_id_estado_cita_seq', 3);

-- Rehabilitar triggers
SET session_replication_role = DEFAULT;

-- Verificar el resultado
SELECT 'DESPUÉS:' as momento, id_estado_cita, nombre_estado, color_hex FROM estados_cita ORDER BY id_estado_cita;

SELECT 'Citas por estado:' as info, ec.nombre_estado, COUNT(c.id_cita) as total
FROM estados_cita ec
LEFT JOIN citas c ON ec.id_estado_cita = c.id_estado_cita
GROUP BY ec.nombre_estado
ORDER BY ec.id_estado_cita;

COMMIT;
