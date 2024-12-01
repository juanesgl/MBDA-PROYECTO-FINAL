/*ActoresE*/
CREATE OR REPLACE PACKAGE PA_administrador IS
    PROCEDURE adicionarPerfil(
        xIdAdmin  IN NUMBER,
        xNombre   IN VARCHAR2,
        xPerfil   IN VARCHAR2
    );

    FUNCTION consultarPerfil RETURN SYS_REFCURSOR;
    FUNCTION consultarPerfil(xIdAdmin IN NUMBER) RETURN SYS_REFCURSOR;

    PROCEDURE modificarPerfil(
        xIdAdmin  IN NUMBER,
        xNombre   IN VARCHAR2,
        xPerfil   IN VARCHAR2
    );

    PROCEDURE eliminarPerfil(xIdAdmin IN NUMBER);
END PA_administrador;

CREATE OR REPLACE PACKAGE PA_entidadGubernamental IS
    PROCEDURE adicionarPerfil(
        xIdEntidad    IN NUMBER,
        xNombre       IN VARCHAR2,
        xTipoEntidad  IN VARCHAR2
    );

    FUNCTION consultarPerfil RETURN SYS_REFCURSOR;
    FUNCTION consultarPerfil(xIdEntidad IN NUMBER) RETURN SYS_REFCURSOR;

    PROCEDURE modificarPerfil(
        xIdEntidad    IN NUMBER,
        xNombre       IN VARCHAR2,
        xTipoEntidad  IN VARCHAR2
    );

    PROCEDURE eliminarPerfil(xIdEntidad IN NUMBER);
END PA_entidadGubernamental;

CREATE OR REPLACE PACKAGE PA_maestro IS
    PROCEDURE adicionarPerfil(
        xIdMaestro    IN NUMBER,
        xNombre       IN VARCHAR2,
        xMateria      IN VARCHAR2
    );

    FUNCTION consultarPerfil RETURN SYS_REFCURSOR;
    FUNCTION consultarPerfil(xIdMaestro IN NUMBER) RETURN SYS_REFCURSOR;

    PROCEDURE modificarPerfil(
        xIdMaestro    IN NUMBER,
        xNombre       IN VARCHAR2,
        xMateria      IN VARCHAR2
    );

    PROCEDURE eliminarPerfil(xIdMaestro IN NUMBER);
END PA_maestro;

CREATE OR REPLACE PACKAGE PA_infante IS
    PROCEDURE adicionarPerfil(
        xIdInfante    IN NUMBER,
        xNombre       IN VARCHAR2,
        xEdad         IN NUMBER
    );

    FUNCTION consultarPerfil RETURN SYS_REFCURSOR;
    FUNCTION consultarPerfil(xIdInfante IN NUMBER) RETURN SYS_REFCURSOR;

    PROCEDURE modificarPerfil(
        xIdInfante    IN NUMBER,
        xNombre       IN VARCHAR2,
        xEdad         IN NUMBER
    );

    PROCEDURE eliminarPerfil(xIdInfante IN NUMBER);
END PA_infante;

CREATE OR REPLACE PACKAGE PA_padreDeFamilia IS
    PROCEDURE adicionarPerfil(
        xIdPadre   IN NUMBER,
        xNombre    IN VARCHAR2,
        xRelacion  IN VARCHAR2
    );

    FUNCTION consultarPerfil RETURN SYS_REFCURSOR;
    FUNCTION consultarPerfil(xIdPadre IN NUMBER) RETURN SYS_REFCURSOR;

    PROCEDURE modificarPerfil(
        xIdPadre   IN NUMBER,
        xNombre    IN VARCHAR2,
        xRelacion  IN VARCHAR2
    );

    PROCEDURE eliminarPerfil(xIdPadre IN NUMBER);
END PA_padreDeFamilia;

CREATE OR REPLACE PACKAGE PA_tutor IS
    PROCEDURE adicionarPerfil(
        xIdTutor   IN NUMBER,
        xNombre    IN VARCHAR2,
        xMateria   IN VARCHAR2
    );

    FUNCTION consultarPerfil RETURN SYS_REFCURSOR;
    FUNCTION consultarPerfil(xIdTutor IN NUMBER) RETURN SYS_REFCURSOR;

    PROCEDURE modificarPerfil(
        xIdTutor   IN NUMBER,
        xNombre    IN VARCHAR2,
        xMateria   IN VARCHAR2
    );

    PROCEDURE eliminarPerfil(xIdTutor IN NUMBER);
END PA_tutor;

CREATE OR REPLACE PACKAGE PA_proveedorDeContenido IS
    PROCEDURE adicionarPerfil(
        xIdProveedor    IN NUMBER,
        xNombre         IN VARCHAR2,
        xTipoContenido  IN VARCHAR2
    );

    FUNCTION consultarPerfil RETURN SYS_REFCURSOR;
    FUNCTION consultarPerfil(xIdProveedor IN NUMBER) RETURN SYS_REFCURSOR;

    PROCEDURE modificarPerfil(
        xIdProveedor    IN NUMBER,
        xNombre         IN VARCHAR2,
        xTipoContenido  IN VARCHAR2
    );

    PROCEDURE eliminarPerfil(xIdProveedor IN NUMBER);
END PA_proveedorDeContenido;




/*ActoresI*/
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

CREATE OR REPLACE PACKAGE BODY PA_entidadGubernamental IS

    -- CREATE
    PROCEDURE adicionarPerfil(
        xIdEntidad IN NUMBER,
        xNombre IN VARCHAR2,
        xTipoEntidad IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO entidadesGubernamentales(id, nombre, tipoEntidad)
        VALUES(xIdEntidad, xNombre, xTipoEntidad);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001, 'Error al adicionar entidad gubernamental');
    END adicionarPerfil;

    -- READ
    FUNCTION consultarPerfil RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT id, nombre, tipoEntidad FROM entidadesGubernamentales;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20002, 'Error al consultar entidades gubernamentales');
    END consultarPerfil;

    FUNCTION consultarPerfil(xIdEntidad IN NUMBER) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT id, nombre, tipoEntidad FROM entidadesGubernamentales
        WHERE id = xIdEntidad;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003, 'Error al consultar entidad por ID');
    END consultarPerfil;

    -- UPDATE
    PROCEDURE modificarPerfil(
        xIdEntidad IN NUMBER,
        xNombre IN VARCHAR2,
        xTipoEntidad IN VARCHAR2
    ) IS
    BEGIN
        UPDATE entidadesGubernamentales
        SET nombre = xNombre, tipoEntidad = xTipoEntidad
        WHERE id = xIdEntidad;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20004, 'Error al modificar entidad gubernamental');
    END modificarPerfil;

    -- DELETE
    PROCEDURE eliminarPerfil(xIdEntidad IN NUMBER) IS
    BEGIN
        DELETE FROM entidadesGubernamentales
        WHERE id = xIdEntidad;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20005, 'Error al eliminar entidad gubernamental');
    END eliminarPerfil;

END PA_entidadGubernamental;

CREATE OR REPLACE PACKAGE BODY PA_maestro IS

    -- CREATE
    PROCEDURE adicionarPerfil(
        xIdMaestro IN NUMBER,
        xNombre IN VARCHAR2,
        xMateria IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO maestros(id, nombre, materia)
        VALUES(xIdMaestro, xNombre, xMateria);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001, 'Error al adicionar maestro');
    END adicionarPerfil;

    -- READ
    FUNCTION consultarPerfil RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT id, nombre, materia FROM maestros;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20002, 'Error al consultar maestros');
    END consultarPerfil;

    FUNCTION consultarPerfil(xIdMaestro IN NUMBER) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT id, nombre, materia FROM maestros
        WHERE id = xIdMaestro;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003, 'Error al consultar maestro por ID');
    END consultarPerfil;

    -- UPDATE
    PROCEDURE modificarPerfil(
        xIdMaestro IN NUMBER,
        xNombre IN VARCHAR2,
        xMateria IN VARCHAR2
    ) IS
    BEGIN
        UPDATE maestros
        SET nombre = xNombre, materia = xMateria
        WHERE id = xIdMaestro;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20004, 'Error al modificar maestro');
    END modificarPerfil;

    -- DELETE
    PROCEDURE eliminarPerfil(xIdMaestro IN NUMBER) IS
    BEGIN
        DELETE FROM maestros
        WHERE id = xIdMaestro;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20005, 'Error al eliminar maestro');
    END eliminarPerfil;

END PA_maestro;

CREATE OR REPLACE PACKAGE BODY PA_padreDeFamilia IS

    -- CREATE
    PROCEDURE adicionarPerfil(
        xIdPadre IN NUMBER,
        xNombre IN VARCHAR2,
        xRelacion IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO padresDeFamilia(id, nombre, relacion)
        VALUES(xIdPadre, xNombre, xRelacion);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001, 'Error al adicionar padre de familia');
    END adicionarPerfil;

    -- READ
    FUNCTION consultarPerfil RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT id, nombre, relacion FROM padresDeFamilia;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20002, 'Error al consultar padres de familia');
    END consultarPerfil;

    FUNCTION consultarPerfil(xIdPadre IN NUMBER) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT id, nombre, relacion FROM padresDeFamilia
        WHERE id = xIdPadre;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003, 'Error al consultar padre por ID');
    END consultarPerfil;

    -- UPDATE
    PROCEDURE modificarPerfil(
        xIdPadre IN NUMBER,
        xNombre IN VARCHAR2,
        xRelacion IN VARCHAR2
    ) IS
    BEGIN
        UPDATE padresDeFamilia
        SET nombre = xNombre, relacion = xRelacion
        WHERE id = xIdPadre;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20004, 'Error al modificar padre de familia');
    END modificarPerfil;

    -- DELETE
    PROCEDURE eliminarPerfil(xIdPadre IN NUMBER) IS
    BEGIN
        DELETE FROM padresDeFamilia
        WHERE id = xIdPadre;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20005, 'Error al eliminar padre de familia');
    END eliminarPerfil;

END PA_padreDeFamilia;

CREATE OR REPLACE PACKAGE BODY PA_tutor IS

    -- CREATE
    PROCEDURE adicionarPerfil(
        xIdTutor IN NUMBER,
        xNombre IN VARCHAR2,
        xTipoTutor IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO tutores(id, nombre, tipoTutor)
        VALUES(xIdTutor, xNombre, xTipoTutor);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001, 'Error al adicionar tutor');
    END adicionarPerfil;

    -- READ
    FUNCTION consultarPerfil RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT id, nombre, tipoTutor FROM tutores;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20002, 'Error al consultar tutores');
    END consultarPerfil;

    FUNCTION consultarPerfil(xIdTutor IN NUMBER) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT id, nombre, tipoTutor FROM tutores
        WHERE id = xIdTutor;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003, 'Error al consultar tutor por ID');
    END consultarPerfil;

    -- UPDATE
    PROCEDURE modificarPerfil(
        xIdTutor IN NUMBER,
        xNombre IN VARCHAR2,
        xTipoTutor IN VARCHAR2
    ) IS
    BEGIN
        UPDATE tutores
        SET nombre = xNombre, tipoTutor = xTipoTutor
        WHERE id = xIdTutor;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20004, 'Error al modificar tutor');
    END modificarPerfil;

    -- DELETE
    PROCEDURE eliminarPerfil(xIdTutor IN NUMBER) IS
    BEGIN
        DELETE FROM tutores
        WHERE id = xIdTutor;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20005, 'Error al eliminar tutor');
    END eliminarPerfil;

END PA_tutor;

CREATE OR REPLACE PACKAGE BODY PA_proveedorDeContenido IS

    -- CREATE
    PROCEDURE adicionarPerfil(
        xIdProveedor IN NUMBER,
        xNombre IN VARCHAR2,
        xTipoContenido IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO proveedoresDeContenido(id, nombre, tipoContenido)
        VALUES(xIdProveedor, xNombre, xTipoContenido);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001, 'Error al adicionar proveedor de contenido');
    END adicionarPerfil;

    -- READ
    FUNCTION consultarPerfil RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT id, nombre, tipoContenido FROM proveedoresDeContenido;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20002, 'Error al consultar proveedores de contenido');
    END consultarPerfil;

    FUNCTION consultarPerfil(xIdProveedor IN NUMBER) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT id, nombre, tipoContenido FROM proveedoresDeContenido
        WHERE id = xIdProveedor;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003, 'Error al consultar proveedor por ID');
    END consultarPerfil;

    -- UPDATE
    PROCEDURE modificarPerfil(
        xIdProveedor IN NUMBER,
        xNombre IN VARCHAR2,
        xTipoContenido IN VARCHAR2
    ) IS
    BEGIN
        UPDATE proveedoresDeContenido
        SET nombre = xNombre, tipoContenido = xTipoContenido
        WHERE id = xIdProveedor;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20004, 'Error al modificar proveedor de contenido');
    END modificarPerfil;

    -- DELETE
    PROCEDURE eliminarPerfil(xIdProveedor IN NUMBER) IS
    BEGIN
        DELETE FROM proveedoresDeContenido
        WHERE id = xIdProveedor;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20005, 'Error al eliminar proveedor de contenido');
    END eliminarPerfil;

END PA_proveedorDeContenido;

CREATE OR REPLACE PACKAGE BODY PA_infante IS

    -- CREATE
    PROCEDURE adicionarPerfil(
        xIdInfante IN NUMBER,
        xNombre IN VARCHAR2,
        xFechaNacimiento IN DATE,
        xEdad IN NUMBER,
        xNombrePadre IN VARCHAR2,
        xNombreMadre IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO infantes(id, nombre, fechaNacimiento, edad, nombrePadre, nombreMadre)
        VALUES(xIdInfante, xNombre, xFechaNacimiento, xEdad, xNombrePadre, xNombreMadre);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001, 'Error al adicionar infante');
    END adicionarPerfil;

    -- READ
    FUNCTION consultarPerfil RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT id, nombre, fechaNacimiento, edad, nombrePadre, nombreMadre FROM infantes;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20002, 'Error al consultar infantes');
    END consultarPerfil;

    FUNCTION consultarPerfil(xIdInfante IN NUMBER) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT id, nombre, fechaNacimiento, edad, nombrePadre, nombreMadre FROM infantes
        WHERE id = xIdInfante;
        RETURN v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003, 'Error al consultar infante por ID');
    END consultarPerfil;

    -- UPDATE
    PROCEDURE modificarPerfil(
        xIdInfante IN NUMBER,
        xNombre IN VARCHAR2,
        xFechaNacimiento IN DATE,
        xEdad IN NUMBER,
        xNombrePadre IN VARCHAR2,
        xNombreMadre IN VARCHAR2
    ) IS
    BEGIN
        UPDATE infantes
        SET nombre = xNombre, 
            fechaNacimiento = xFechaNacimiento, 
            edad = xEdad, 
            nombrePadre = xNombrePadre, 
            nombreMadre = xNombreMadre
        WHERE id = xIdInfante;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20004, 'Error al modificar infante');
    END modificarPerfil;

    -- DELETE
    PROCEDURE eliminarPerfil(xIdInfante IN NUMBER) IS
    BEGIN
        DELETE FROM infantes
        WHERE id = xIdInfante;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20005, 'Error al eliminar infante');
    END eliminarPerfil;

END PA_infante;

/*Seguridad*/
-- Crear roles
CREATE ROLE PA_administrador;
GRANT PA_administrador
TO bd1000100279;

CREATE ROLE PA_entidadGubernamental;
GRANT PA_entidadGubernamental
TO bd1000100279;

CREATE ROLE PA_maestro;
GRANT PA_maestro
TO bd1000100279;

CREATE ROLE PA_infante;
GRANT PA_infante
TO bd1000100279;

CREATE ROLE PA_padreDeFamilia;
GRANT PA_padreDeFamilia
TO bd1000100279;

CREATE ROLE PA_tutor;
GRANT PA_tutor
TO bd1000100279;

CREATE ROLE PA_provedorDeContenido;
GRANT PA_provedorDeContenido
TO bd1000100279;

CREATE ROLE PA_perfil;
GRANT PA_perfil
TO bd1000100279;

--dar privilegios
GRANT UPDATE, INSERT, DELETE
ON ofertas 
TO  PA_administrador;

GRANT INSERT, DELETE
ON ofertas 
TO  PA_entidadGubernamental;

GRANT UPDATE
ON ofertas 
TO  PA_maestro;

GRANT SELECT
ON ofertas 
TO PA_infante;

GRANT UPDATE, INSERT
ON ofertas 
TO  PA_padreDeFamilia;

GRANT UPDATE, INSERT, DELETE
ON ofertas 
TO  PA_tutor;

GRANT UPDATE, INSERT, DELETE
ON ofertas 
TO  PA_provedorDeContenido;

GRANT UPDATE, INSERT, DELETE
ON ofertas 
TO  PA_perfil;
/*Xseguridad*/
-- Revocar privilegios de la tabla 'ofertas' para cada rol
REVOKE UPDATE, INSERT, DELETE
ON ofertas 
FROM PA_administrador;

REVOKE INSERT, DELETE
ON ofertas 
FROM PA_entidadGubernamental;

REVOKE UPDATE
ON ofertas 
FROM PA_maestro;

REVOKE SELECT
ON ofertas 
FROM PA_infante;

REVOKE UPDATE, INSERT
ON ofertas 
FROM PA_padreDeFamilia;

REVOKE UPDATE, INSERT, DELETE
ON ofertas 
FROM PA_tutor;

REVOKE UPDATE, INSERT, DELETE
ON ofertas 
FROM PA_provedorDeContenido;

REVOKE UPDATE, INSERT, DELETE
ON ofertas 
FROM PA_perfil;
-- Eliminar roles de la base de datos
DROP ROLE PA_administrador;
DROP ROLE PA_entidadGubernamental;
DROP ROLE PA_maestro;
DROP ROLE PA_infante;
DROP ROLE PA_padreDeFamilia;
DROP ROLE PA_tutor;
DROP ROLE PA_provedorDeContenido;
DROP ROLE PA_perfil;
/*SeguridadOk*/
BEGIN
    PA_administrador.adicionarPerfil(
        xIdAdmin  => 1,               -- ID del administrador
        xNombre   => 'Juan Pérez',    -- Nombre del administrador
        xPerfil   => 'Administrador General' -- Perfil del administrador
    );
END;
/
BEGIN
    PA_entidadGubernamental.adicionarPerfil(
        xIdEntidad    => 101,           -- ID de la entidad
        xNombre       => 'Gobierno Local', -- Nombre de la entidad
        xTipoEntidad  => 'Municipal'   -- Tipo de entidad
    );
END;
/
BEGIN
    PA_maestro.adicionarPerfil(
        xIdMaestro    => 1001,           -- ID del maestro
        xNombre       => 'Pedro Gómez',  -- Nombre del maestro
        xMateria      => 'Matemáticas'   -- Materia que enseña
    );
END;
/
BEGIN
    PA_infante.adicionarPerfil(
        xIdInfante    => 2001,           -- ID del infante
        xNombre       => 'Ana López',    -- Nombre del infante
        xEdad         => 8               -- Edad del infante
    );
END;
/
BEGIN
    PA_padreDeFamilia.adicionarPerfil(
        xIdPadre   => 5001,              -- ID del padre
        xNombre    => 'Carlos Ruiz',     -- Nombre del padre
        xRelacion  => 'Padre'            -- Relación con el infante
    );
END;
/
BEGIN
    PA_tutor.adicionarPerfil(
        xIdTutor   => 3001,              -- ID del tutor
        xNombre    => 'Laura Martínez',  -- Nombre del tutor
        xMateria   => 'Ciencias Sociales' -- Materia que enseña
    );
END;
/
BEGIN
    PA_proveedorDeContenido.adicionarPerfil(
        xIdProveedor    => 7001,          -- ID del proveedor
        xNombre         => 'Contenido Digital', -- Nombre del proveedor
        xTipoContenido  => 'Educativo'    -- Tipo de contenido
    );
END;
/


