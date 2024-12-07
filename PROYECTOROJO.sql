/*ActoresE*/
-- Paquete: administrador
CREATE OR REPLACE PACKAGE PA_administrador AS

    -- Gestión de perfiles
    PROCEDURE adicionar_Perfil(id NUMBER, nombrePerfil VARCHAR2, fechaRegistro DATE);
    PROCEDURE modificar_Perfil(id NUMBER, nombrePerfil VARCHAR2);
    PROCEDURE eliminar_Perfil(id NUMBER, nombrePerfil VARCHAR2, fechaRegistro DATE);
    FUNCTION consultar_contenido_reportado(contenidoReportado VARCHAR2, motivoReporte VARCHAR2, fechaReporte DATE) RETURN SYS_REFCURSOR;
    FUNCTION consultar_perfil_vigente(id NUMBER, nombrePerfil VARCHAR2) RETURN SYS_REFCURSOR;

    -- Gestión de contenido interactivo
    PROCEDURE adicionar_contenidoInteractivo(contenidoInteractivo VARCHAR2, fechaCreacion DATE);

    -- Gestión de contenido visual
    PROCEDURE adicionar_contenidoVisual(contenidoVisual VARCHAR2, nombreContenido VARCHAR2, tipoContenido VARCHAR2);
    PROCEDURE adicionar_tipo_contenido(id NUMBER, tipo VARCHAR2);
    PROCEDURE adicionar_edadMinima_contenido(edadRequerida NUMBER, requisitos VARCHAR2);
    PROCEDURE Eliminar_contenido(idInteractivo VARCHAR2, id NUMBER);
    PROCEDURE Eliminar_contenido(contenidoVisual VARCHAR2, nombreContenido VARCHAR2, tipoContenido VARCHAR2);

END PA_administrador;
/
-- Paquete: ProveedorDeContenido
CREATE OR REPLACE PACKAGE PA_proveedorDeContenido IS
    PROCEDURE adicionar_contenidoInteractivo(contenidoInteractivo VARCHAR2, fechaCreacion DATE);
    PROCEDURE adicionar_contenidoVisual(contenidoVisual VARCHAR2, nombreContenido VARCHAR2, tipoContenido VARCHAR2);
    PROCEDURE adicionar_tipo_contenido(id NUMBER, tipo VARCHAR2);
    PROCEDURE adicionar_edadMinima_contenido(edadRequerida NUMBER, requisitos VARCHAR2, fechaEdad DATE);
    PROCEDURE modificar_edadMinima_contenido(edadRequerida NUMBER, requisitos VARCHAR2, fechaEdad DATE);
    PROCEDURE eliminar_contenido(contenidoInteractivo VARCHAR2, id NUMBER);
    PROCEDURE consultar_contenido_reportado(contenidoReportado VARCHAR2, motivoReporte VARCHAR2, fechaReporte DATE);
END PA_proveedorDeContenido;
/
-- Paquete: Infantes
CREATE OR REPLACE PACKAGE PA_infante IS
    PROCEDURE consultar_contenidoAdecuado(tipo VARCHAR2, nombreContenido VARCHAR2);
    PROCEDURE consultar_contenidoInfantil(tipo VARCHAR2, nombreContenido VARCHAR2);
    PROCEDURE consultar_contenidoEducativo(tipo VARCHAR2, nombreContenido VARCHAR2);
END PA_infante;
/
-- Paquete: EntidadGubernamental
CREATE OR REPLACE PACKAGE PA_entidadGubernamental IS
    PROCEDURE adicionar_responsablesLegal(responsableLegal VARCHAR2);
    PROCEDURE modificar_responsablesLegal(relacion VARCHAR2, responsabilidad VARCHAR2);
    PROCEDURE eliminar_responsablesLegal(nombre VARCHAR2);
    PROCEDURE consultar_responsableLegalVigente(id NUMBER, nombre VARCHAR2);
    PROCEDURE adicionar_normas(nombreNorma VARCHAR2, fechaImplementacion DATE, motivo VARCHAR2);
    PROCEDURE modificar_normas(nombreNorma VARCHAR2, fechaImplementacion DATE, motivo VARCHAR2);
    PROCEDURE eliminar_normas(nombreNorma VARCHAR2);
    PROCEDURE consultar_normasVigentes(normasLey VARCHAR2);
END PA_entidadGubernamental;
/
-- Paquete: Tutor
CREATE OR REPLACE PACKAGE PA_tutor IS
    PROCEDURE adicionar_relacion(relacion VARCHAR2);
    PROCEDURE adicionar_nombre_responsableLegal(nombre VARCHAR2);
    PROCEDURE adicionar_perfil(id NUMBER, nombrePerfil VARCHAR2, fechaRegistro DATE);
    PROCEDURE consultar_contenidoAdecuado(tipo VARCHAR2, nombreContenido VARCHAR2);
    PROCEDURE consultar_clasificacion_contenido(nombreClasificacion VARCHAR2, criterios VARCHAR2);
    PROCEDURE consultar_contenido_reportado(contenidoReportado VARCHAR2, motivoReporte VARCHAR2, fechaReporte DATE);
END PA_tutor;
/
-- Paquete: Usuario
CREATE OR REPLACE PACKAGE PA_usuario IS
    PROCEDURE adicionar_perfil(id NUMBER, nombrePerfil VARCHAR2, fechaRegistro DATE);
    PROCEDURE modificar_perfil(id NUMBER, nombrePerfil VARCHAR2);
    PROCEDURE consultar_contenidoAdecuado(tipo VARCHAR2, nombreContenido VARCHAR2);
    PROCEDURE consultar_clasificacion_contenido(nombreClasificacion VARCHAR2, criterios VARCHAR2);
    PROCEDURE consultar_contenido_reportado(contenidoReportado VARCHAR2, motivoReporte VARCHAR2, fechaReporte DATE);
    PROCEDURE consulta_contenidoInfantil(tipo VARCHAR2, nombreContenido VARCHAR2);
    PROCEDURE consulta_contenidoEducativo(tipo VARCHAR2, nombreContenido VARCHAR2);
END PA_usuario;
/
-- Paquete: maestro
CREATE OR REPLACE PACKAGE PA_maestro IS

    -- Procedimientos
    PROCEDURE consultar_responsableLegal_vigente(id NUMBER, nombre VARCHAR2);
    PROCEDURE consultar_contenidoEducativo(tipo VARCHAR2, nombreContenido VARCHAR2);
    PROCEDURE consultar_perfil_vigente(id NUMBER, nombrePerfil VARCHAR2);

END PA_maestro;
/

-- Paquete: PadreDeFamilia
CREATE OR REPLACE PACKAGE PA_padreDeFamilia IS
    PROCEDURE adicionar_relacion(relacion VARCHAR2);
    PROCEDURE adicionar_nombre_responsableLegal(nombre VARCHAR2);
    PROCEDURE adicionar_perfil(id NUMBER, nombrePerfil VARCHAR2, fechaRegistro DATE);
    PROCEDURE consultar_contenidoAdecuado(tipo VARCHAR2, nombreContenido VARCHAR2);
    PROCEDURE consultar_clasificacion_contenido(nombreClasificacion VARCHAR2, criterios VARCHAR2);
    PROCEDURE consultar_contenido_reportado(contenidoReportado VARCHAR2, motivoReporte VARCHAR2, fechaReporte DATE);
END PA_padreDeFamilia;
/
/*ActoresI*/
-- Paquete Body: administrador
CREATE OR REPLACE PACKAGE BODY PA_administrador AS

    -- Gestión de perfiles
    PROCEDURE adicionar_Perfil(id NUMBER, nombrePerfil VARCHAR2, fechaRegistro DATE) IS
    BEGIN
        -- Lógica para adicionar perfil
        NULL;
    END adicionar_Perfil;

    PROCEDURE modificar_Perfil(id NUMBER, nombrePerfil VARCHAR2) IS
    BEGIN
        -- Lógica para modificar perfil
        NULL;
    END modificar_Perfil;

    PROCEDURE eliminar_Perfil(id NUMBER, nombrePerfil VARCHAR2, fechaRegistro DATE) IS
    BEGIN
        -- Lógica para eliminar perfil
        NULL;
    END eliminar_Perfil;

    FUNCTION consultar_contenido_reportado(contenidoReportado VARCHAR2, motivoReporte VARCHAR2, fechaReporte DATE) RETURN SYS_REFCURSOR IS
        refCursor SYS_REFCURSOR;
    BEGIN
        -- Lógica para consultar contenido reportado
        OPEN refCursor FOR SELECT * FROM DUAL; -- Ejemplo
        RETURN refCursor;
    END consultar_contenido_reportado;

    FUNCTION consultar_perfil_vigente(id NUMBER, nombrePerfil VARCHAR2) RETURN SYS_REFCURSOR IS
        refCursor SYS_REFCURSOR;
    BEGIN
        -- Lógica para consultar perfil vigente
        OPEN refCursor FOR SELECT * FROM DUAL; -- Ejemplo
        RETURN refCursor;
    END consultar_perfil_vigente;

    -- Gestión de contenido interactivo
    PROCEDURE adicionar_contenidoInteractivo(contenidoInteractivo VARCHAR2, fechaCreacion DATE) IS
    BEGIN
        -- Lógica para adicionar contenido interactivo
        NULL;
    END adicionar_contenidoInteractivo;

    -- Gestión de contenido visual
    PROCEDURE adicionar_contenidoVisual(contenidoVisual VARCHAR2, nombreContenido VARCHAR2, tipoContenido VARCHAR2) IS
    BEGIN
        -- Lógica para adicionar contenido visual
        NULL;
    END adicionar_contenidoVisual;

    PROCEDURE adicionar_tipo_contenido(id NUMBER, tipo VARCHAR2) IS
    BEGIN
        -- Lógica para adicionar tipo de contenido
        NULL;
    END adicionar_tipo_contenido;

    PROCEDURE adicionar_edadMinima_contenido(edadRequerida NUMBER, requisitos VARCHAR2) IS
    BEGIN
        -- Lógica para adicionar edad mínima de contenido
        NULL;
    END adicionar_edadMinima_contenido;

    PROCEDURE Eliminar_contenido(idInteractivo VARCHAR2, id NUMBER) IS
    BEGIN
        -- Lógica para eliminar contenido interactivo
        NULL;
    END Eliminar_contenido;

    PROCEDURE Eliminar_contenido(contenidoVisual VARCHAR2, nombreContenido VARCHAR2, tipoContenido VARCHAR2) IS
    BEGIN
        -- Lógica para eliminar contenido visual
        NULL;
    END Eliminar_contenido;

END PA_administrador;
/

-- Paquete Body: ProveedorDeContenido
CREATE OR REPLACE PACKAGE BODY PA_proveedorDeContenido IS
    PROCEDURE adicionar_contenidoInteractivo(contenidoInteractivo VARCHAR2, fechaCreacion DATE) IS
    BEGIN
        -- Implementación del procedimiento para adicionar contenido interactivo
        DBMS_OUTPUT.PUT_LINE('Contenido interactivo agregado: ' || contenidoInteractivo || ' - Fecha: ' || TO_CHAR(fechaCreacion));
    END adicionar_contenidoInteractivo;

    PROCEDURE adicionar_contenidoVisual(contenidoVisual VARCHAR2, nombreContenido VARCHAR2, tipoContenido VARCHAR2) IS
    BEGIN
        -- Implementación del procedimiento para adicionar contenido visual
        DBMS_OUTPUT.PUT_LINE('Contenido visual agregado: ' || contenidoVisual || ' - Nombre: ' || nombreContenido || ' - Tipo: ' || tipoContenido);
    END adicionar_contenidoVisual;

    PROCEDURE adicionar_tipo_contenido(id NUMBER, tipo VARCHAR2) IS
    BEGIN
        -- Implementación del procedimiento para adicionar tipo de contenido
        DBMS_OUTPUT.PUT_LINE('Tipo de contenido agregado - ID: ' || id || ' - Tipo: ' || tipo);
    END adicionar_tipo_contenido;

    PROCEDURE adicionar_edadMinima_contenido(edadRequerida NUMBER, requisitos VARCHAR2, fechaEdad DATE) IS
    BEGIN
        -- Implementación del procedimiento para adicionar edad mínima
        DBMS_OUTPUT.PUT_LINE('Edad mínima requerida: ' || edadRequerida || ' - Requisitos: ' || requisitos || ' - Fecha: ' || TO_CHAR(fechaEdad));
    END adicionar_edadMinima_contenido;

    PROCEDURE modificar_edadMinima_contenido(edadRequerida NUMBER, requisitos VARCHAR2, fechaEdad DATE) IS
    BEGIN
        -- Implementación del procedimiento para modificar edad mínima
        DBMS_OUTPUT.PUT_LINE('Edad mínima modificada: ' || edadRequerida || ' - Requisitos: ' || requisitos || ' - Fecha: ' || TO_CHAR(fechaEdad));
    END modificar_edadMinima_contenido;

    PROCEDURE eliminar_contenido(contenidoInteractivo VARCHAR2, id NUMBER) IS
    BEGIN
        -- Implementación del procedimiento para eliminar contenido
        DBMS_OUTPUT.PUT_LINE('Contenido eliminado - Contenido: ' || contenidoInteractivo || ' - ID: ' || id);
    END eliminar_contenido;

    PROCEDURE consultar_contenido_reportado(contenidoReportado VARCHAR2, motivoReporte VARCHAR2, fechaReporte DATE) IS
    BEGIN
        -- Implementación del procedimiento para consultar contenido reportado
        DBMS_OUTPUT.PUT_LINE('Consulta de contenido reportado: ' || contenidoReportado || ' - Motivo: ' || motivoReporte || ' - Fecha: ' || TO_CHAR(fechaReporte));
    END consultar_contenido_reportado;
END PA_proveedorDeContenido;
/

-- Paquete Body: Infante
CREATE OR REPLACE PACKAGE BODY PA_infante IS
    PROCEDURE consultar_contenidoAdecuado(tipo VARCHAR2, nombreContenido VARCHAR2) IS
    BEGIN
        -- Implementación de la consulta de contenido adecuado
        DBMS_OUTPUT.PUT_LINE('Consulta contenido adecuado - Tipo: ' || tipo || ' - Nombre: ' || nombreContenido);
    END consultar_contenidoAdecuado;

    PROCEDURE consultar_contenidoInfantil(tipo VARCHAR2, nombreContenido VARCHAR2) IS
    BEGIN
        -- Implementación de la consulta de contenido infantil
        DBMS_OUTPUT.PUT_LINE('Consulta contenido infantil - Tipo: ' || tipo || ' - Nombre: ' || nombreContenido);
    END consultar_contenidoInfantil;

    PROCEDURE consultar_contenidoEducativo(tipo VARCHAR2, nombreContenido VARCHAR2) IS
    BEGIN
        -- Implementación de la consulta de contenido educativo
        DBMS_OUTPUT.PUT_LINE('Consulta contenido educativo - Tipo: ' || tipo || ' - Nombre: ' || nombreContenido);
    END consultar_contenidoEducativo;
END PA_infante;
/

-- Paquete Body: EntidadGubernamental
CREATE OR REPLACE PACKAGE BODY PA_entidadGubernamental IS
    PROCEDURE adicionar_responsablesLegal(responsableLegal VARCHAR2) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Responsable legal añadido: ' || responsableLegal);
    END adicionar_responsablesLegal;

    PROCEDURE modificar_responsablesLegal(relacion VARCHAR2, responsabilidad VARCHAR2) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Responsabilidad modificada - Relación: ' || relacion || ' - Responsabilidad: ' || responsabilidad);
    END modificar_responsablesLegal;

    PROCEDURE eliminar_responsablesLegal(nombre VARCHAR2) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Responsable legal eliminado: ' || nombre);
    END eliminar_responsablesLegal;

    PROCEDURE consultar_responsableLegalVigente(id NUMBER, nombre VARCHAR2) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Consulta responsable legal vigente - ID: ' || id || ' - Nombre: ' || nombre);
    END consultar_responsableLegalVigente;

    PROCEDURE adicionar_normas(nombreNorma VARCHAR2, fechaImplementacion DATE, motivo VARCHAR2) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Norma añadida - Nombre: ' || nombreNorma || ' - Fecha: ' || TO_CHAR(fechaImplementacion) || ' - Motivo: ' || motivo);
    END adicionar_normas;

    PROCEDURE modificar_normas(nombreNorma VARCHAR2, fechaImplementacion DATE, motivo VARCHAR2) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Norma modificada - Nombre: ' || nombreNorma || ' - Fecha: ' || TO_CHAR(fechaImplementacion) || ' - Motivo: ' || motivo);
    END modificar_normas;

    PROCEDURE eliminar_normas(nombreNorma VARCHAR2) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Norma eliminada: ' || nombreNorma);
    END eliminar_normas;

    PROCEDURE consultar_normasVigentes(normasLey VARCHAR2) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Consulta normas vigentes: ' || normasLey);
    END consultar_normasVigentes;
END PA_entidadGubernamental;
/

-- Paquete Body: Tutor
CREATE OR REPLACE PACKAGE BODY PA_tutor IS
    PROCEDURE adicionar_relacion(relacion VARCHAR2) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Relación añadida: ' || relacion);
    END adicionar_relacion;

    PROCEDURE adicionar_nombre_responsableLegal(nombre VARCHAR2) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Nombre del responsable legal añadido: ' || nombre);
    END adicionar_nombre_responsableLegal;

    PROCEDURE adicionar_perfil(id NUMBER, nombrePerfil VARCHAR2, fechaRegistro DATE) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Perfil añadido - ID: ' || id || ' - Nombre: ' || nombrePerfil || ' - Fecha: ' || TO_CHAR(fechaRegistro));
    END adicionar_perfil;

    PROCEDURE consultar_contenidoAdecuado(tipo VARCHAR2, nombreContenido VARCHAR2) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Consulta contenido adecuado - Tipo: ' || tipo || ' - Nombre: ' || nombreContenido);
    END consultar_contenidoAdecuado;

    PROCEDURE consultar_clasificacion_contenido(nombreClasificacion VARCHAR2, criterios VARCHAR2) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Consulta clasificación - Clasificación: ' || nombreClasificacion || ' - Criterios: ' || criterios);
    END consultar_clasificacion_contenido;

    PROCEDURE consultar_contenido_reportado(contenidoReportado VARCHAR2, motivoReporte VARCHAR2, fechaReporte DATE) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Consulta contenido reportado - Contenido: ' || contenidoReportado || ' - Motivo: ' || motivoReporte || ' - Fecha: ' || TO_CHAR(fechaReporte));
    END consultar_contenido_reportado;
END PA_tutor;
/

-- Paquete Body: Usuario
CREATE OR REPLACE PACKAGE BODY PA_usuario IS

    -- Procedimiento para adicionar un perfil
    PROCEDURE adicionar_perfil(id NUMBER, nombrePerfil VARCHAR2, fechaRegistro DATE) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Perfil añadido - ID: ' || id || ' - Nombre: ' || nombrePerfil || ' - Fecha: ' || TO_CHAR(fechaRegistro, 'YYYY-MM-DD'));
    END adicionar_perfil;

    -- Procedimiento para modificar un perfil
    PROCEDURE modificar_perfil(id NUMBER, nombrePerfil VARCHAR2) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Perfil modificado - ID: ' || id || ' - Nuevo Nombre: ' || nombrePerfil);
    END modificar_perfil;

    -- Procedimiento para consultar contenido adecuado
    PROCEDURE consultar_contenidoAdecuado(tipo VARCHAR2, nombreContenido VARCHAR2) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Consulta de contenido adecuado - Tipo: ' || tipo || ' - Nombre: ' || nombreContenido);
    END consultar_contenidoAdecuado;

    -- Procedimiento para consultar clasificación de contenido
    PROCEDURE consultar_clasificacion_contenido(nombreClasificacion VARCHAR2, criterios VARCHAR2) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Consulta clasificación - Clasificación: ' || nombreClasificacion || ' - Criterios: ' || criterios);
    END consultar_clasificacion_contenido;

    -- Procedimiento para consultar contenido reportado
    PROCEDURE consultar_contenido_reportado(contenidoReportado VARCHAR2, motivoReporte VARCHAR2, fechaReporte DATE) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Consulta de contenido reportado - Contenido: ' || contenidoReportado || ' - Motivo: ' || motivoReporte || ' - Fecha: ' || TO_CHAR(fechaReporte, 'YYYY-MM-DD'));
    END consultar_contenido_reportado;

    -- Procedimiento para consultar contenido infantil
    PROCEDURE consulta_contenidoInfantil(tipo VARCHAR2, nombreContenido VARCHAR2) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Consulta de contenido infantil - Tipo: ' || tipo || ' - Nombre: ' || nombreContenido);
    END consulta_contenidoInfantil;

    -- Procedimiento para consultar contenido educativo
    PROCEDURE consulta_contenidoEducativo(tipo VARCHAR2, nombreContenido VARCHAR2) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Consulta de contenido educativo - Tipo: ' || tipo || ' - Nombre: ' || nombreContenido);
    END consulta_contenidoEducativo;

END PA_usuario;
/

   
-- Paquete Body: PadreDeFamilia
CREATE OR REPLACE PACKAGE BODY PA_padreDeFamilia IS
    PROCEDURE adicionar_relacion(relacion VARCHAR2) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Relación añadida: ' || relacion);
    END adicionar_relacion;

    PROCEDURE adicionar_nombre_responsableLegal(nombre VARCHAR2) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Nombre del responsable legal añadido: ' || nombre);
    END adicionar_nombre_responsableLegal;

    PROCEDURE adicionar_perfil(id NUMBER, nombrePerfil VARCHAR2, fechaRegistro DATE) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Perfil añadido - ID: ' || id || ' - Nombre: ' || nombrePerfil || ' - Fecha: ' || TO_CHAR(fechaRegistro));
    END adicionar_perfil;

    PROCEDURE consultar_contenidoAdecuado(tipo VARCHAR2, nombreContenido VARCHAR2) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Consulta contenido adecuado - Tipo: ' || tipo || ' - Nombre: ' || nombreContenido);
    END consultar_contenidoAdecuado;

    PROCEDURE consultar_clasificacion_contenido(nombreClasificacion VARCHAR2, criterios VARCHAR2) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Consulta clasificación - Clasificación: ' || nombreClasificacion || ' - Criterios: ' || criterios);
    END consultar_clasificacion_contenido;

    PROCEDURE consultar_contenido_reportado(contenidoReportado VARCHAR2, motivoReporte VARCHAR2, fechaReporte DATE) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Consulta contenido reportado - Contenido: ' || contenidoReportado || ' - Motivo: ' || motivoReporte || ' - Fecha: ' || TO_CHAR(fechaReporte));
    END consultar_contenido_reportado;
END PA_padreDeFamilia;
/

-- Paquete Body: maestro
CREATE OR REPLACE PACKAGE BODY PA_maestro IS

    -- Procedimiento para consultar responsable legal vigente
    PROCEDURE consultar_responsableLegal_vigente(id NUMBER, nombre VARCHAR2) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Consulta de responsable legal vigente - ID: ' || id || ' - Nombre: ' || nombre);
    END consultar_responsableLegal_vigente;

    -- Procedimiento para consultar contenido educativo
    PROCEDURE consultar_contenidoEducativo(tipo VARCHAR2, nombreContenido VARCHAR2) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Consulta de contenido educativo - Tipo: ' || tipo || ' - Nombre del contenido: ' || nombreContenido);
    END consultar_contenidoEducativo;

    -- Procedimiento para consultar perfil vigente
    PROCEDURE consultar_perfil_vigente(id NUMBER, nombrePerfil VARCHAR2) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Consulta de perfil vigente - ID: ' || id || ' - Nombre del perfil: ' || nombrePerfil);
    END consultar_perfil_vigente;

END PA_maestro;
/
-- Eliminar el cuerpo y la especificación del paquete PA_maestro
DROP PACKAGE BODY PA_maestro;
DROP PACKAGE PA_maestro;

-- Eliminar el cuerpo y la especificación del paquete PA_usuario
DROP PACKAGE BODY PA_usuario;
DROP PACKAGE PA_usuario;

-- Eliminar el cuerpo y la especificación del paquete PA_proveedorDeContenido
DROP PACKAGE BODY PA_proveedorDeContenido;
DROP PACKAGE PA_proveedorDeContenido;

-- Eliminar el cuerpo y la especificación del paquete PA_tutor
DROP PACKAGE BODY PA_tutor;
DROP PACKAGE PA_tutor;

-- Eliminar el cuerpo y la especificación del paquete PA_infantes
DROP PACKAGE BODY PA_infantes;
DROP PACKAGE PA_infantes;

-- Eliminar el cuerpo y la especificación del paquete PA_entidadGubernamental
DROP PACKAGE BODY PA_entidadGubernamental;
DROP PACKAGE PA_entidadGubernamental;

-- Eliminar el cuerpo y la especificación del paquete PA_administrador
DROP PACKAGE BODY PA_administrador;
DROP PACKAGE PA_administrador;

-- Eliminar el cuerpo y la especificación del paquete PA_padreDeFamilia
DROP PACKAGE BODY PA_padreDeFamilia;
DROP PACKAGE PA_padreDeFamilia;

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

CREATE ROLE PA_proveedorDeContenido;
GRANT PA_provedorDeContenido
TO bd1000100279;

CREATE ROLE PA_usuario;
GRANT PA_usuario
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
TO  PA_usuario;
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
FROM PA_usuario;
-- Eliminar roles de la base de datos
DROP ROLE PA_administrador;
DROP ROLE PA_entidadGubernamental;
DROP ROLE PA_maestro;
DROP ROLE PA_infante;
DROP ROLE PA_padreDeFamilia;
DROP ROLE PA_tutor;
DROP ROLE PA_provedorDeContenido;
DROP ROLE PA_usuario;
/*SeguridadOk*/
-- Procedimiento para ingresar un nuevo usuario con validación previa
BEGIN
    -- Llamar al procedimiento de validación y agregar usuario
    PA_usuario.validar_usuario( :nombreUsuario, :fechaRegistro);
    PA_usuario.agregar_usuario( :nombreUsuario, :fechaRegistro);
END;
-- Ingreso de un nuevo usuario
BEGIN
    -- Validar los datos del usuario
    PA_usuario.validar_usuario( :nombreUsuario, :fechaRegistro);
    
    -- Si la validación es exitosa, agregar el usuario
    PA_usuario.agregar_usuario( :nombreUsuario, :fechaRegistro);
END;
-- Ingreso de un nuevo contenido interactivo
BEGIN
    -- Validar los datos del contenido
    PA_proveedorDeContenido.validar_contenido( :contenidoInteractivo, :fechaCreacion, :tipoContenido);
    
    -- Si la validación es exitosa, agregar el contenido interactivo
    PA_proveedorDeContenido.agregar_contenido( :contenidoInteractivo, :fechaCreacion, :tipoContenido);
END;
-- Ingreso de una nueva relación legal
BEGIN
    -- Validar la relación legal
    PA_entidadGubernamental.validar_relacion( :relacion);
    
    -- Si la validación es exitosa, agregar la relación
    PA_entidadGubernamental.agregar_relacion( :relacion);
END;
-- Asignar un tutor a un estudiante
BEGIN
    -- Validar la asignación del tutor
    PA_tutor.validar_asignacion_tutor( :idEstudiante, :idTutor);
    
    -- Si la validación es exitosa, realizar la asignación
    PA_tutor.asignar_tutor( :idEstudiante, :idTutor);
END;
-- Asignar un padre de familia a un estudiante
BEGIN
    -- Validar la asignación del padre de familia
    PA_padreDeFamilia.validar_asignacion_padre( :idEstudiante, :idPadre);
    
    -- Si la validación es exitosa, realizar la asignación
    PA_padreDeFamilia.asignar_padre( :idEstudiante, :idPadre);
END;


