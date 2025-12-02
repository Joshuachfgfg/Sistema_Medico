-- Actualizar hash de medico1
UPDATE usuarios 
SET contrasena_hash = '$2a$10$AkEFHkTT7/Pi3ukCV08s4.j9mKo.mUx5C/dV9PXlbC2U0PmAfq/9O'
WHERE nombre_usuario = 'medico1';

-- Verificar
SELECT id_usuario, nombre_usuario, LENGTH(contrasena_hash) as hash_length 
FROM usuarios 
WHERE nombre_usuario = 'medico1';
