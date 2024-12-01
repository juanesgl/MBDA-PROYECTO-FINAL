---CREACIÓN DE PAQUETES ---
/*CRUDE*/
-------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE PK_padresDeFamilia 
IS
    PROCEDURE adicionar(
        xIdPadre   IN NUMBER,
        xNombre           IN VARCHAR2,
        xRelacion         IN VARCHAR2
    );
 
    FUNCTION consultar RETURN SYS_REFCURSOR;
    FUNCTION consultar(xIdPadre IN NUMBER) RETURN SYS_REFCURSOR;

    
    PROCEDURE modificar(
        xIdPadre   	IN NUMBER,
        xNombre     IN VARCHAR2,
        xRelacion   IN VARCHAR2
    );
    PROCEDURE eliminar(xIdPadre  IN NUMBER);
END PK_padresDeFamilia;
/

-------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE PK_INFANTES IS
    PROCEDURE consultar(
        xIdInfante IN NUMBER,
        xResultado OUT SYS_REFCURSOR
    );
    FUNCTION contenidoAdecuado(
        xEdad IN NUMBER
    ) RETURN SYS_REFCURSOR;
END;
/
-------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE PK_entidadesGubernamentales IS
    PROCEDURE adicionar(
        xIdEntidad IN NUMBER,
        xNombre IN VARCHAR2,
        xAutoridad IN VARCHAR2
    );
    PROCEDURE modificar(
        xIdEntidad IN NUMBER,
        xNombre IN VARCHAR2,
        xAutoridad IN VARCHAR2
    );
    PROCEDURE eliminar(
        xIdEntidad IN NUMBER
    );
    PROCEDURE consultar(
        xIdEntidad IN NUMBER,
        xResultado OUT SYS_REFCURSOR
    );
    FUNCTION contenidoReportado RETURN SYS_REFCURSOR;
END;
/
-------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE PK_maestros IS
    PROCEDURE adicionar(
        xIdMaestro IN NUMBER,
        xNombre IN VARCHAR2,
        xEspecialidad IN VARCHAR2,
        xContacto IN VARCHAR2
    );
    PROCEDURE modificar(
        xIdMaestro IN NUMBER,
        xNombre IN VARCHAR2,
        xEspecialidad IN VARCHAR2,
        xContacto IN VARCHAR2
    );
    PROCEDURE eliminar(
        xIdMaestro IN NUMBER
    );
    PROCEDURE consultar(
        xIdMaestro IN NUMBER,
        xResultado OUT SYS_REFCURSOR
    );
    FUNCTION responsablesVigentes RETURN SYS_REFCURSOR;
    FUNCTION contenidoInteractivo RETURN SYS_REFCURSOR;
END;
/
-------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE PK_usuarios IS
    PROCEDURE adicionar(
        xIdUsuario IN NUMBER,
        xIdVerificaciones IN NUMBER,
        xNombreUsuario IN VARCHAR2,
        xFechaEdad IN DATE,
        xNivelAcceso IN VARCHAR2,
        xPaisOrigen IN VARCHAR2,
        xRol IN VARCHAR2
    );

    PROCEDURE modificar(
        xIdUsuario IN NUMBER,
        xNombreUsuario IN VARCHAR2,
        xNivelAcceso IN VARCHAR2,
        xPaisOrigen IN VARCHAR2,
        xRol IN VARCHAR2
    );

    PROCEDURE eliminar(
        xIdUsuario IN NUMBER
    );

    PROCEDURE consultar(
        xIdUsuario IN NUMBER,
        xResultado OUT SYS_REFCURSOR
    );
END;
/ 

-------------------------------------------------------------------------------------
/*CRUDI*/
-------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY PK_padresDeFamilia IS

    -- CREATE
    PROCEDURE adicionar(
        xIdPadre   IN NUMBER,
        xNombre           IN VARCHAR2,
        xRelacion         IN VARCHAR2
    ) IS
    BEGIN 
        INSERT INTO responsablesLegales(id, nombre, relacion)
        VALUES(xIdPadre, xNombre , xRelacion );
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001, 'Error al adicionar un padre de familia');
    END adicionar;

    -- READ
    FUNCTION consultar RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT id, nombre, relacion FROM responsablesLegales;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20002, 'Error al consultar padres de familia');
    END consultar;

    FUNCTION consultar(xIdPadre IN NUMBER) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT id, nombre, relacion FROM responsablesLegales
        WHERE id = xIdPadre;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003, 'Error al consultar el padre por ID');
    END consultar;

    -- UPDATE
    PROCEDURE modificar(
        xIdPadre   	IN NUMBER,
        xNombre          IN VARCHAR2,
        xRelacion         IN VARCHAR2
    ) IS
    BEGIN
        UPDATE responsablesLegales
        SET nombre = xNombre, relacion = xRelacion 
        WHERE id = xIdPadre ;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20004, 'Error al modificar los datos del padre de familia');
    END modificar;

    -- DELETE
    PROCEDURE eliminar(xIdPadre  IN NUMBER) IS
    BEGIN
        DELETE FROM responsablesLegales
        WHERE id = xIdPadre ;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20005, 'Error al eliminar el padre de familia');
    END eliminar;

END PK_padresDeFamilia;
/



-------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY PK_INFANTES AS

    -- Consultar infante
    PROCEDURE consultar(
        xIdInfante IN NUMBER,
        xResultado OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN xResultado FOR
        SELECT r.id AS responsableId, r.nombre, r.relacion
        FROM responsablesLegales r
        JOIN tutores t ON t.idResponsablesLegales = r.id
        WHERE r.id = xIdInfante;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001, 'Error al consultar infante');
    END consultar;

    -- Función para determinar contenido adecuado según edad
    FUNCTION contenidoAdecuado(
        xEdad IN NUMBER
    ) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT c.id, c.subtitulos, c.productora
        FROM contenidosVisuales c
        WHERE c.id IN (
            SELECT idContenidosVisuales
            FROM categorias
            WHERE categoria = 'Educativo' -- Suponiendo que los contenidos adecuados para la edad son educativos
        ) AND c.fechaCreacion <= SYSDATE;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20002, 'Error al obtener contenido adecuado');
    END contenidoAdecuado;

END PK_INFANTES;
/
-------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY PK_entidadesGubernamentales AS
    PROCEDURE adicionar(
        xIdEntidad IN NUMBER,
        xNombre IN VARCHAR2,
        xAutoridad IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO leyes (id, nombre, autoridadFiscal, entidades, sancion, fechaPublicacion)
        VALUES (xIdEntidad, xNombre, xAutoridad, xAutoridad, 0, SYSDATE);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003, 'Error al adicionar entidad gubernamental');
    END adicionar;

    PROCEDURE modificar(
        xIdEntidad IN NUMBER,
        xNombre IN VARCHAR2,
        xAutoridad IN VARCHAR2
    ) IS
    BEGIN
        UPDATE leyes
        SET nombre = xNombre, 
            autoridadFiscal = xAutoridad, 
            entidades = xNombre
        WHERE id = xIdEntidad;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20004, 'Error al modificar entidad gubernamental');
    END modificar;

    PROCEDURE eliminar(
        xIdEntidad IN NUMBER
    ) IS
    BEGIN
        DELETE FROM leyes WHERE id = xIdEntidad;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20005, 'Error al eliminar entidad gubernamental');
    END eliminar;

    PROCEDURE consultar(
        xIdEntidad IN NUMBER,
        xResultado OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN xResultado FOR
        SELECT id, nombre, autoridadFiscal AS autoridad
        FROM leyes
        WHERE id = xIdEntidad;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20006, 'Error al consultar entidad gubernamental');
    END consultar;

    FUNCTION contenidoReportado RETURN SYS_REFCURSOR IS
        vResultado SYS_REFCURSOR;
    BEGIN
        OPEN vResultado FOR
        SELECT id, nombre, autoridadFiscal AS autoridad
        FROM leyes;
        
        RETURN vResultado;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20007, 'Error al obtener contenido reportado');
    END contenidoReportado;
END PK_entidadesGubernamentales;
/
-------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY PK_maestros AS
    
    PROCEDURE adicionar(
        xIdMaestro IN NUMBER,
        xNombre IN VARCHAR2,
        xEspecialidad IN VARCHAR2,
        xContacto IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO tutores (
            id, nombre, responsabilidad, correo, 
            numeroTelefono, documentoIdentidad, direccion, 
            idResponsablesLegales, idPerfil
        ) VALUES (
            xIdMaestro, xNombre, xEspecialidad, xContacto, 
            1234567890, 100000, 'Direccion ejemplo', 
            1, 1  
        );
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20007, 'Error al adicionar maestro');
    END adicionar;

    PROCEDURE modificar(
        xIdMaestro IN NUMBER,
        xNombre IN VARCHAR2,
        xEspecialidad IN VARCHAR2,
        xContacto IN VARCHAR2
    ) IS
    BEGIN
        UPDATE tutores
        SET nombre = xNombre, 
            responsabilidad = xEspecialidad, 
            correo = xContacto
        WHERE id = xIdMaestro;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20008, 'Error al modificar maestro');
    END modificar;

    PROCEDURE eliminar(
        xIdMaestro IN NUMBER
    ) IS
    BEGIN
        DELETE FROM tutores WHERE id = xIdMaestro;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20009, 'Error al eliminar maestro');
    END eliminar;

    PROCEDURE consultar(
        xIdMaestro IN NUMBER,
        xResultado OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN xResultado FOR
        SELECT id, nombre, responsabilidad, correo
        FROM tutores
        WHERE id = xIdMaestro;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20010, 'Error al consultar maestro');
    END consultar;

    FUNCTION responsablesVigentes RETURN SYS_REFCURSOR IS
        vResultado SYS_REFCURSOR;
    BEGIN
        OPEN vResultado FOR
        SELECT t.id, t.nombre, t.responsabilidad, t.correo, rl.nombre as responsableLegal
        FROM tutores t
        JOIN responsablesLegales rl ON t.idResponsablesLegales = rl.id;
        
        RETURN vResultado;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20011, 'Error al obtener responsables vigentes');
    END responsablesVigentes;

    FUNCTION contenidoInteractivo RETURN SYS_REFCURSOR IS
        vResultado SYS_REFCURSOR;
    BEGIN
        OPEN vResultado FOR
        SELECT ci.id, ci.nivelInteraccion, ci.plataformasCompatibles, 
               ci.popularidad, ci.accesibilidad
        FROM contenidosInteractivos ci;
        
        RETURN vResultado;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20012, 'Error al obtener contenido interactivo');
    END contenidoInteractivo;
END PK_maestros;
/
-------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY PK_usuarios AS

    -- Procedimiento adicionar
    PROCEDURE adicionar(
        xIdUsuario IN NUMBER,
        xIdVerificaciones IN NUMBER,
        xNombreUsuario IN VARCHAR2,
        xFechaEdad IN DATE,
        xNivelAcceso IN VARCHAR2,
        xPaisOrigen IN VARCHAR2,
        xRol IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO perfiles (
            id, idVerificaciones, nombreUsuario, fechaEdad, fechaRegistro, nivelAcceso, paisOrigen, rol
        ) VALUES (
            xIdUsuario, xIdVerificaciones, xNombreUsuario, xFechaEdad, SYSDATE, xNivelAcceso, xPaisOrigen, xRol
        );
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20011, 'Error al adicionar usuario');
    END adicionar;

    -- Procedimiento modificar
    PROCEDURE modificar(
        xIdUsuario IN NUMBER,
        xNombreUsuario IN VARCHAR2,
        xNivelAcceso IN VARCHAR2,
        xPaisOrigen IN VARCHAR2,
        xRol IN VARCHAR2
    ) IS
    BEGIN
        UPDATE perfiles
        SET nombreUsuario = xNombreUsuario,
            nivelAcceso = xNivelAcceso,
            paisOrigen = xPaisOrigen,
            rol = xRol
        WHERE id = xIdUsuario;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20012, 'Error al modificar usuario');
    END modificar;

    -- Procedimiento eliminar
    PROCEDURE eliminar(
        xIdUsuario IN NUMBER
    ) IS
    BEGIN
        DELETE FROM perfiles WHERE id = xIdUsuario;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20013, 'Error al eliminar usuario');
    END eliminar;

    -- Procedimiento consultar
    PROCEDURE consultar(
        xIdUsuario IN NUMBER,
        xResultado OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN xResultado FOR
        SELECT id, idVerificaciones, nombreUsuario, fechaEdad, fechaRegistro, nivelAcceso, paisOrigen, rol
        FROM perfiles
        WHERE id = xIdUsuario;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20014, 'Error al consultar usuario');
    END consultar;

END PK_usuarios;
/
-------------------------------------------------------------------------------------

/*XCRUD - NO EJECUTAR SI NO SE ENCUENTRA ENTRE ASTERISCO Y SLASH */

DROP PACKAGE PK_padresDeFamilia;
DROP PACKAGE PK_INFANTES;
DROP PACKAGE PK_entidadesGubernamentales;
DROP PACKAGE PK_maestros;
DROP PACKAGE PK_usuarios;

/*CRUDOk */
----------ADICIONAR----------
BEGIN 
    PK_padresDeFamilia.adicionar(16, 'Astryyyy', 'Madre;
END;

BEGIN
    PK_entidadesGubernamentales.adicionar(16, 'Senado', 'Senador');
END;

BEGIN
    PK_maestros.adicionar(16, 'Santiago Ojeda', 'Ingeniero Biomedico', '3012345478');
END;


BEGIN
    PK_usuarios.adicionar(16, 100, 'Pedrito', SYSDATE, 'Alto', 'Uganda', 'Estudiante');
END
----------MODIFICAR----------
BEGIN
    PK_padresDeFamilia.modificar(16, 'Juan', 'Padre');
END;

BEGIN
    PK_entidadesGubernamentales.modificar(16, 'Alcaldia', 'Alcalde');
END;

BEGIN
    PK_maestros.modificar(16, 'Johny', 'Matematico', '3246478');
END;

BEGIN
    PK_usuarios.modificar(16, 'Walter', 'alto', 'Perú', 'Maestro');
END;

----------ELIMINAR----------
BEGIN
    PK_padresDeFamilia.eliminar(16);
END;

BEGIN
    PK_entidadesGubernamentales.eliminar(16);
END;

BEGIN
    PK_maestros.eliminar(16);
END;

BEGIN
    PK_usuarios.eliminar(16);
END;

----------CONSULTAR----------
DECLARE
    v_cursor SYS_REFCURSOR;
BEGIN
    v_cursor := PK_padresDeFamilia.consultar;
    -- Process v_cursor
END;

DECLARE
    v_cursor SYS_REFCURSOR;
BEGIN
    v_cursor := PK_padresDeFamilia.consultar(16);
    -- Process v_cursor
END;

DECLARE
    v_cursor SYS_REFCURSOR;
BEGIN
    PK_INFANTES.consultar(16, v_cursor);
    -- Process v_cursor
END;

DECLARE
    v_cursor SYS_REFCURSOR;
BEGIN
    PK_entidadesGubernamentales.consultar(16, v_cursor);
    -- Process v_cursor
END;

DECLARE
    v_cursor SYS_REFCURSOR;
BEGIN
    PK_maestros.consultar(1, v_cursor);
    -- Process v_cursor
END;

DECLARE
    v_cursor SYS_REFCURSOR;
BEGIN
    PK_usuarios.consultar(1, v_cursor);
    -- Process v_cursor
END;

-------R4 TRASH
--INFANTES

DECLARE
    v_cursor SYS_REFCURSOR;
BEGIN
    v_cursor := PK_INFANTES.contenidoAdecuado(10);
    -- Process v_cursor
END;

--GUBERNAMENTAL

DECLARE
    v_cursor SYS_REFCURSOR;
BEGIN
    v_cursor := PK_entidadesGubernamentales.contenidoReportado;
    -- Process v_cursor
END;

--MAESTROS

DECLARE
    v_cursor SYS_REFCURSOR;
BEGIN
    v_cursor := PK_maestros.responsablesVigentes;
    -- Process v_cursor
END;

DECLARE
    v_cursor SYS_REFCURSOR;
BEGIN
    v_cursor := PK_maestros.contenidoInteractivo;
    -- Process v_cursor
END;

/*CRUDNoOK */
/*DEBERIAN FALLAR PORQUE YA SE ENCUENTRAN */

BEGIN 
    PK_padresDeFamilia.adicionar(16, 'Astryyyy', 'Madre;
END;

BEGIN
    PK_entidadesGubernamentales.adicionar(16, 'Senado', 'Senador');
END;

BEGIN
    PK_maestros.adicionar(16, 'Santiago Ojeda', 'Ingeniero Biomedico', '3012345478');
END;


BEGIN
    PK_usuarios.adicionar(16, 100, 'Pedrito', SYSDATE, 'Alto', 'Uganda', 'Estudiante');
END
----------MODIFICAR----------
BEGIN
    PK_padresDeFamilia.modificar(16, 'Juan', 'Padre');
END;

BEGIN
    PK_entidadesGubernamentales.modificar(16, 'Alcaldia', 'Alcalde');
END;

BEGIN
    PK_maestros.modificar(16, 'Johny', 'Matematico', '3246478');
END;

BEGIN
    PK_usuarios.modificar(16, 'Walter', 'alto', 'Perú', 'Maestro');
END;

----------ELIMINAR----------
BEGIN
    PK_padresDeFamilia.eliminar(16);
END;

BEGIN
    PK_entidadesGubernamentales.eliminar(16);
END;

BEGIN
    PK_maestros.eliminar(16);
END;

BEGIN
    PK_usuarios.eliminar(16);
END;
