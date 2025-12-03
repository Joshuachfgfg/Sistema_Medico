-- ============================================
-- AGREGAR CAMPO ACTIVO A TABLA CITAS
-- Para implementar borrado lógico
-- ============================================

-- Agregar columna activo si no existe
ALTER TABLE citas 
ADD COLUMN IF NOT EXISTS activo BOOLEAN DEFAULT TRUE;

-- Actualizar registros existentes
UPDATE citas SET activo = TRUE WHERE activo IS NULL;

-- Verificar
SELECT id_cita, fecha_cita, hora_cita, activo 
FROM citas 
ORDER BY id_cita DESC 
LIMIT 10;
