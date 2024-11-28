
--tublasNoOk
-- Tuplas que provocan errores debido a restricciones no cumplidas

-- 1. Tutor con correo y número telefónico nulos (violación de ck_tutores_correo_telefono)
INSERT INTO tutores (correo, numeroTelefono) 
VALUES (NULL, NULL);

-- 2. Página web con protocolo HTTPS pero sin políticas de privacidad (violación de ck_paginasweb_https_politicas)
INSERT INTO paginasWeb (protocolo, politicasPrivacidad) 
VALUES ('HTTPS', NULL);

-- 3. Videojuego en modo Multijugador sin requisitos de conectividad (violación de ck_videojuegos_multijugador_requisitos)
INSERT INTO videojuegos (modoJuego, requisitos) 
VALUES ('Multijugador', NULL);

-- 4. Bloqueo sin motivo y duración (violación de ck_bloqueos_motivo_duracion)
INSERT INTO bloqueos (motivo, duracionDias) 
VALUES (NULL, NULL);

-- 5. Streaming con duración de 0 horas (violación de ck_streamings_duracion)
INSERT INTO streamings (duracionHoras) 
VALUES (0);

-- 6. Perfil con fecha de registro anterior a la fecha de edad (violación de ck_perfiles_fecha_registro)
INSERT INTO perfiles (fechaRegistro, fechaEdad) 
VALUES ('2022-01-01', '2023-01-01');

-- 7. Tutor con correo duplicado (violación de uk_tutores_correo)
INSERT INTO tutores (correo, numeroTelefono) 
VALUES ('tutor@example.com', '1234567890');

INSERT INTO tutores (correo, numeroTelefono) 
VALUES ('tutor@example.com', '0987654321');

-- 8. Tutor con número telefónico duplicado (violación de uk_tutores_telefono)
INSERT INTO tutores (correo, numeroTelefono) 
VALUES ('tutor1@example.com', '1234567890');

INSERT INTO tutores (correo, numeroTelefono) 
VALUES ('tutor2@example.com', '1234567890');

-- 9. Canal televisivo con género 'Infantil' y audiencia objetivo distinta de 'Niños' (violación de ck_canalesTelevisivos_audiencia_objetivo)
INSERT INTO canalesTelevisivos (generoCanal, audienciaObjetivo) 
VALUES ('Infantil', 'Adultos');

-- 10. Contenido interactivo con popularidad negativa (violación de ck_contenidosInteractivos_popularidad)
INSERT INTO contenidosInteractivos (popularidad) 
VALUES (-1);

-- 11. Streaming que requiere registro pero sin calidad (violación de ck_streamings_calidad_requiereRegistro)
INSERT INTO streamings (requiereRegistro) 
VALUES (1);

-- 12. Bloqueo con motivo 'Uso excesivo' pero duración de días no mayor a 100 (violación de ck_bloqueos_motivo_duracion)
INSERT INTO bloqueos (motivo, duracionDias) 
VALUES ('Uso excesivo', 50);

-- 13. Streaming con duración en horas de menos de 1 (violación de ck_streamings_duracion_minima)
INSERT INTO streamings (duracionHoras) 
VALUES (0);

--AccionesOK

--usuarios
--si se borran un perfil de debe eliminar la verificacion
ALTER TABLE perfiles
DROP CONSTRAINT FK_Perfiles_Verificaciones; 
ALTER TABLE perfiles
ADD CONSTRAINT FK_perfiles_verificaciones
FOREIGN KEY (id)
REFERENCES verificaciones(id) 
ON DELETE CASCADE;
--Entidad gubernamental
--si se borra una ley se debe eliminar las normas asociadas
ALTER TABLE leyes
ADD CONSTRAINT FK_leyes_normas
FOREIGN KEY (id)
REFERENCES normas(id) 
ON DELETE CASCADE;
--administrador
-- Si se elimina un videojuego, se elimina la clasificacion
ALTER TABLE videojuegos
DROP CONSTRAINT FK_Videojuegos_Clasificaciones; 

ALTER TABLE videojuegos
ADD CONSTRAINT FK_Videojuegos_Clasificaciones
FOREIGN KEY (idContenidosInteractivos) 
REFERENCES clasificaciones(id) 
ON DELETE CASCADE;

-- Si se elimina la pagina web, se elimina la clasificacion
ALTER TABLE paginasWeb
DROP CONSTRAINT FK_PaginasWeb_Clasificaciones; 

ALTER TABLE paginasWeb
ADD CONSTRAINT FK_PaginasWeb_Clasificaciones
FOREIGN KEY (idContenidosInteractivos) 
REFERENCES clasificaciones(id) 
ON DELETE CASCADE;


--DisparadoresOK--
/*EntidadGubernamental*/
/* Trigger para asignar fecha de publicación y generar ID único al insertar */
CREATE OR REPLACE TRIGGER TR_ley_insert
BEFORE INSERT ON leyes
FOR EACH ROW
DECLARE
  v_year VARCHAR2(4);
  v_seq NUMBER;
  v_id VARCHAR2(20);
BEGIN
  -- Asignar fecha de publicación a la fecha del sistema
  :NEW.fechaPublicacion := SYSDATE;

  -- Generar ID único
  SELECT TO_CHAR(SYSDATE, 'YYYY') INTO v_year FROM DUAL;
  SELECT NVL(MAX(TO_NUMBER(SUBSTR(id, 9))), 0) + 1 INTO v_seq FROM leyes WHERE SUBSTR(id, 5, 4) = v_year;
  v_id := 'LEY-' || v_year || '-' || LPAD(v_seq, 3, '0');
  :NEW.id := v_id;
END;
/

/* Trigger para actualizar la fecha de última modificación al modificar */
CREATE OR REPLACE TRIGGER TR_ley_update
BEFORE UPDATE ON leyes
FOR EACH ROW
BEGIN
  -- Actualizar la fecha de última modificación
  :NEW.fechaPublicacion := SYSDATE;

  -- Prevenir la modificación del nombre
  IF :OLD.nombre != :NEW.nombre THEN
    RAISE_APPLICATION_ERROR(-20001, 'No se puede modificar el nombre de la Ley una vez registrada.');
  END IF;
END;
/

/* Trigger para asignar fecha de creación y generar ID único al insertar un Contenido Visual */
CREATE OR REPLACE TRIGGER TR_contenido_visual_insert
BEFORE INSERT ON contenidosVisuales
FOR EACH ROW
BEGIN
  -- Asignar fecha de creación a la fecha del sistema
  :NEW.fechaCreacion := SYSDATE;
END;
/

/* Trigger para prevenir la modificación del ID al modificar un Contenido Visual */
CREATE OR REPLACE TRIGGER TR_contenido_visual_update
BEFORE UPDATE ON contenidosVisuales
FOR EACH ROW
BEGIN
  -- Prevenir la modificación del ID
  IF :OLD.id != :NEW.id THEN
    RAISE_APPLICATION_ERROR(-20002, 'No se puede modificar el ID del Contenido Visual una vez registrado.');
  END IF;
END;
/

-- Trigger para registrar la creación de un Responsable Legal
CREATE OR REPLACE TRIGGER TR_responsable_legal_insert
BEFORE INSERT ON responsablesLegales
FOR EACH ROW
BEGIN
  -- Registro en el log de la base de datos
  DBMS_OUTPUT.PUT_LINE('Registro de creación para Responsable Legal con ID: ' || :NEW.id || ' en fecha: ' || SYSDATE);
END;
/

-- Trigger para registrar la modificación de un Responsable Legal
CREATE OR REPLACE TRIGGER TR_responsable_legal_update
BEFORE UPDATE ON responsablesLegales
FOR EACH ROW
BEGIN
  -- Registro en el log de la base de datos
  DBMS_OUTPUT.PUT_LINE('Registro de modificación para Responsable Legal con ID: ' || :OLD.id || ' en fecha: ' || SYSDATE);
END;
/

/*Administrador*/

/* Trigger para asignar fecha de creación al insertar una Clasificación */
CREATE OR REPLACE TRIGGER TR_clasificacion_insert
BEFORE INSERT ON clasificaciones
FOR EACH ROW
BEGIN
  -- Asignar fecha de creación a la fecha del sistema
  :NEW.fechaEmision := SYSDATE;
END;
/

/* Trigger para prevenir la modificación del ID al modificar una Clasificación */
CREATE OR REPLACE TRIGGER TR_clasificacion_update
BEFORE UPDATE ON clasificaciones
FOR EACH ROW
BEGIN
  -- Prevenir la modificación del ID
  IF :OLD.id != :NEW.id THEN
    RAISE_APPLICATION_ERROR(-20004, 'No se puede modificar el ID de la Clasificación una vez registrado.');
  END IF;
END;
/

/* Trigger para asignar fecha de creación al insertar un Perfil */
CREATE OR REPLACE TRIGGER TR_perfil_insert
BEFORE INSERT ON perfiles
FOR EACH ROW
BEGIN
  -- Asignar fecha de creación a la fecha del sistema
  :NEW.fechaRegistro := SYSDATE;
END;
/

/* Trigger para actualizar la fecha de última modificación al modificar un Perfil */
CREATE OR REPLACE TRIGGER TR_perfil_update
BEFORE UPDATE ON perfiles
FOR EACH ROW
BEGIN
  :NEW.fechaRegistro := SYSDATE;
END;
/

/* Trigger para asignar fecha de creación al insertar una Norma */
CREATE OR REPLACE TRIGGER TR_norma_insert
BEFORE INSERT ON normas
FOR EACH ROW
BEGIN
  :NEW.fechaModificacion := SYSDATE;
END;
/

/* Trigger para prevenir la modificación del ID al modificar una Norma */
CREATE OR REPLACE TRIGGER TR_norma_update
BEFORE UPDATE ON normas
FOR EACH ROW
BEGIN
  -- Prevenir la modificación del ID
  IF :OLD.id != :NEW.id THEN
    RAISE_APPLICATION_ERROR(-20005, 'No se puede modificar el ID de la Norma.');
  END IF;
END;
/

/*XDisparadores*/

-- Eliminar los triggers creados
DROP TRIGGER TR_ley_insert;
DROP TRIGGER TR_ley_update;

DROP TRIGGER TR_contenido_visual_insert;
DROP TRIGGER TR_contenido_visual_update;

DROP TRIGGER TR_responsable_legal_insert;
DROP TRIGGER TR_responsable_legal_update;

DROP TRIGGER TR_clasificacion_insert;
DROP TRIGGER TR_clasificacion_update;

DROP TRIGGER TR_perfil_insert;
DROP TRIGGER TR_perfil_update;

DROP TRIGGER TR_norma_insert;
DROP TRIGGER TR_norma_update;

