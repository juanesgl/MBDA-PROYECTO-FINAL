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
        xNombreUsuario IN VARCHAR2,
        xNivelAcceso IN VARCHAR2,
        xCorreo IN VARCHAR2
    );
    PROCEDURE modificar(
        xIdUsuario IN NUMBER,
        xNombreUsuario IN VARCHAR2,
        xNivelAcceso IN VARCHAR2,
        xCorreo IN VARCHAR2
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

    -- Adicionar entidad
    PROCEDURE adicionar(
        xIdEntidad IN NUMBER,
        xNombre IN VARCHAR2,
        xAutoridad IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO entidadesGubernamentales (id, nombre, autoridad)
        VALUES (xIdEntidad, xNombre, xAutoridad);
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003, 'Error al adicionar entidad gubernamental');
    END adicionar;

    -- Modificar entidad
    PROCEDURE modificar(
        xIdEntidad IN NUMBER,
        xNombre IN VARCHAR2,
        xAutoridad IN VARCHAR2
    ) IS
    BEGIN
        UPDATE entidadesGubernamentales
        SET nombre = xNombre, autoridad = xAutoridad
        WHERE id = xIdEntidad;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20004, 'Error al modificar entidad gubernamental');
    END modificar;

    -- Eliminar entidad
    PROCEDURE eliminar(
        xIdEntidad IN NUMBER
    ) IS
    BEGIN
        DELETE FROM entidadesGubernamentales WHERE id = xIdEntidad;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20005, 'Error al eliminar entidad gubernamental');
    END eliminar;

    -- Consultar entidad
    PROCEDURE consultar(
        xIdEntidad IN NUMBER,
        xResultado OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN xResultado FOR
        SELECT id, nombre, autoridad
        FROM entidadesGubernamentales
        WHERE id = xIdEntidad;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20006, 'Error al consultar entidad gubernamental');
    END consultar;

END PK_entidadesGubernamentales;
/
-------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY PK_maestros AS

    -- Adicionar maestro
    PROCEDURE adicionar(
        xIdMaestro IN NUMBER,
        xNombre IN VARCHAR2,
        xEspecialidad IN VARCHAR2,
        xContacto IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO tutores (id, nombre, responsabilidad, correo, numeroTelefono, documentoIdentidad, direccion)
        VALUES (xIdMaestro, xNombre, xEspecialidad, xContacto, 1234567890, 100000, 'Direccion ejemplo');
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20007, 'Error al adicionar maestro');
    END adicionar;

    -- Modificar maestro
    PROCEDURE modificar(
        xIdMaestro IN NUMBER,
        xNombre IN VARCHAR2,
        xEspecialidad IN VARCHAR2,
        xContacto IN VARCHAR2
    ) IS
    BEGIN
        UPDATE tutores
        SET nombre = xNombre, responsabilidad = xEspecialidad, correo = xContacto
        WHERE id = xIdMaestro;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20008, 'Error al modificar maestro');
    END modificar;

    -- Eliminar maestro
    PROCEDURE eliminar(
        xIdMaestro IN NUMBER
    ) IS
    BEGIN
        DELETE FROM tutores WHERE id = xIdMaestro;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20009, 'Error al eliminar maestro');
    END eliminar;

    -- Consultar maestro
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

END PK_maestros;
/
-------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY PK_usuarios AS

    -- Adicionar usuario
    PROCEDURE adicionar(
        xIdUsuario IN NUMBER,
        xNombreUsuario IN VARCHAR2,
        xNivelAcceso IN VARCHAR2,
        xCorreo IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO perfiles (id, nombreUsuario, nivelAcceso, correo)
        VALUES (xIdUsuario, xNombreUsuario, xNivelAcceso, xCorreo);
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20011, 'Error al adicionar usuario');
    END adicionar;

    -- Modificar usuario
    PROCEDURE modificar(
        xIdUsuario IN NUMBER,
        xNombreUsuario IN VARCHAR2,
        xNivelAcceso IN VARCHAR2,
        xCorreo IN VARCHAR2
    ) IS
    BEGIN
        UPDATE perfiles
        SET nombreUsuario = xNombreUsuario, nivelAcceso = xNivelAcceso, correo = xCorreo
        WHERE id = xIdUsuario;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20012, 'Error al modificar usuario');
    END modificar;

    -- Eliminar usuario
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

    -- Consultar usuario
    PROCEDURE consultar(
        xIdUsuario IN NUMBER,
        xResultado OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN xResultado FOR
        SELECT id, nombreUsuario, nivelAcceso, correo
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


/*CRUDNoOK */


