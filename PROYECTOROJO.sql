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
