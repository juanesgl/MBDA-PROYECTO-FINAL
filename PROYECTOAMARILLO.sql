---CREACIÓN DE PAQUETES ---
/*CRUDE*/
-------------------------------------------------------------------------------------------------------------
----------------------------------------- RESPONSABLES LEGALES ----------------------------------------------
-------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE PK_ResponsablesLegales IS
    PROCEDURE adicionarResponsableLegal(
        xIdResponsable IN NUMBER, 
        xNombre IN VARCHAR2, 
        xRelacion IN VARCHAR2
    );

    FUNCTION consultarResponsableLegal(xIdResponsable IN NUMBER) 
    RETURN SYS_REFCURSOR;

    PROCEDURE modificarResponsableLegal(
        xIdResponsable IN NUMBER, 
        xNombre IN VARCHAR2, 
        xRelacion IN VARCHAR2
    );

    PROCEDURE eliminarResponsableLegal(xIdResponsable IN NUMBER);

END PK_ResponsablesLegales;
/
-------------------------------------------------------------------------------------------------------------
----------------------------------------- CONTENIDO INTERACTIVO ---------------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE PK_ContenidosInteractivo 
IS 
    PROCEDURE adicionarContenidoInteractivo(
        xidContenido IN NUMBER,
        xNivelInteraccion IN VARCHAR2,
        xAccesibilidad IN NUMBER, -- Solo puede ser 0 ó 1
        xPlataformasCompatibles IN VARCHAR,
        xPopularidad IN NUMBER
    );

    FUNCTION consultarContenidoInteractivo(xidContenido IN NUMBER) 
    RETURN SYS_REFCURSOR;

    PROCEDURE eliminarContenidoInteractivo(xidContenido IN NUMBER);

END PK_ContenidosInteractivo;
/
-------------------------------------------------------------------------------------------------------------
----------------------------------------- LEYES -------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE PK_Leyes IS

    PROCEDURE adicionarLey(
        xId NUMBER,
        xNombre VARCHAR2,
        xFechaPublicacion DATE,
        xAutoridadFiscal VARCHAR2,
        xEntidades VARCHAR2,
        xSancion NUMBER
    );

    FUNCTION consultarLey(xId IN NUMBER) 
    RETURN SYS_REFCURSOR;


    PROCEDURE modificarLey(
        xId NUMBER,
        xNombre VARCHAR2,
        xFechaPublicacion DATE,
        xAutoridadFiscal VARCHAR2,
        xEntidades VARCHAR2,
        xSancion NUMBER
    );

    PROCEDURE eliminarLey(xId IN NUMBER);

END PK_Leyes;
/




/*CRUDI */
-------------------------------------------------------------------------------------------------------------
----------------------------------------- RESPONSABLES LEGALES ----------------------------------------------
-------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY PK_ResponsablesLegales IS

    -- ADICIONAR RESPONSABLE LEGAL
    PROCEDURE adicionarResponsableLegal(
        xIdResponsable IN NUMBER,
        xNombre        IN VARCHAR2,
        xRelacion      IN VARCHAR2
    ) IS
    BEGIN 
        INSERT INTO responsablesLegales(id, nombre, relacion)
        VALUES(xIdResponsable, xNombre, xRelacion);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001, 'Error al adicionar un responsable legal');
    END adicionarResponsableLegal;

    -- CONSULTAR RESPONSABLE LEGAL POR ID
    FUNCTION consultarResponsableLegal(
        xIdResponsable IN NUMBER
    ) RETURN SYS_REFCURSOR IS
        vCursor SYS_REFCURSOR;
    BEGIN
        OPEN vCursor FOR
        SELECT id, nombre, relacion
        FROM responsablesLegales
        WHERE id = xIdResponsable;
        RETURN vCursor;
    END consultarResponsableLegal;

    -- MODIFICAR RESPONSABLE LEGAL
    PROCEDURE modificarResponsableLegal(
        xIdResponsable IN NUMBER,
        xNombre        IN VARCHAR2,
        xRelacion      IN VARCHAR2
    ) IS
    BEGIN
        UPDATE responsablesLegales
        SET nombre = xNombre, 
            relacion = xRelacion
        WHERE id = xIdResponsable;

        IF SQL % ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'No se encontró un responsable legal con el ID especificado.');
        END IF;

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003, 'Error al modificar el responsable legal');
    END modificarResponsableLegal;

    -- ELIMINAR RESPONSABLE LEGAL
    PROCEDURE eliminarResponsableLegal(
        xIdResponsable IN NUMBER
    ) IS
    BEGIN
        DELETE FROM responsablesLegales
        WHERE id = xIdResponsable;

        IF SQL % ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20004, 'No se encontró un responsable legal con el ID especificado para eliminar.');
        END IF;

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20005, 'Error al eliminar el responsable legal');
    END eliminarResponsableLegal;

END PK_ResponsablesLegales;
/

-------------------------------------------------------------------------------------------------------------
----------------------------------------- CONTENIDO INTERACTIVO ---------------------------------------------
-------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY PK_ContenidosInteractivo  IS

    PROCEDURE adicionarContenidoInteractivo(
        xidContenido IN NUMBER,
        xNivelInteraccion IN VARCHAR2,
        xAccesibilidad IN NUMBER, -- Solo puede ser 0 ó 1
        xPlataformasCompatibles IN VARCHAR,
        xPopularidad IN NUMBER
    ) IS
    BEGIN 
        INSERT INTO contenidosInteractivos (id, nivelInteraccion, accesibilidad, plataformasCompatibles, popularidad)
        VALUES(xidContenido, xNivelInteraccion, xAccesibilidad, xPlataformasCompatibles, xPopularidad);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001, 'Error al adicionar contenido interactivo');
    END adicionarContenidoInteractivo;

    FUNCTION consultarContenidoInteractivo(
        xidContenido IN NUMBER
    ) RETURN SYS_REFCURSOR IS
        vCursor SYS_REFCURSOR;
    BEGIN
        OPEN vCursor FOR
        SELECT id, nivelInteraccion, accesibilidad, plataformasCompatibles, popularidad
        FROM contenidosInteractivos
        WHERE id = xidContenido;
        RETURN vCursor;
    END consultarContenidoInteractivo;

    PROCEDURE eliminarContenidoInteractivo(
        xidContenido IN NUMBER
    ) IS
    BEGIN
        DELETE FROM contenidosInteractivos
        WHERE id = xidContenido;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20004, 'No se encontró contenido interactivo con el ID especificado para eliminar.');
        END IF;

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20005, 'Error al eliminar contenido interactivo');
    END eliminarContenidoInteractivo;

END PK_ContenidosInteractivo;
/

-------------------------------------------------------------------------------------------------------------
----------------------------------------- LEYES -------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY PK_Leyes IS

    PROCEDURE adicionarLey(
        xId NUMBER,
        xNombre VARCHAR2,
        xFechaPublicacion DATE,
        xAutoridadFiscal VARCHAR2,
        xEntidades VARCHAR2,
        xSancion NUMBER
    ) IS 

    BEGIN
        INSERT INTO leyes(id, nombre, fechaPublicacion, autoridadFiscal, entidades, sancion)
        VALUES(xId, xNombre, xFechaPublicacion, xAutoridadFiscal, xEntidades, xSancion);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001, 'Error al adicionar una ley');
    END adicionarLey;

    FUNCTION consultarLey(
         xId IN NUMBER
    ) RETURN SYS_REFCURSOR IS
        vCursor SYS_REFCURSOR;
    BEGIN
        OPEN vCursor FOR
        SELECT id, nombre, fechaPublicacion, autoridadFiscal, entidades, sancion
        FROM leyes
        WHERE id = xId;
        RETURN vCursor;
    END consultarLey;

    PROCEDURE modificarLey(
        xId NUMBER,
        xNombre VARCHAR2,
        xFechaPublicacion DATE,
        xAutoridadFiscal VARCHAR2,
        xEntidades VARCHAR2,
        xSancion NUMBER
    ) IS
    BEGIN
        UPDATE leyes
        SET nombre = xNombre, 
            fechaPublicacion = xFechaPublicacion,
            autoridadFiscal = xAutoridadFiscal,
            entidades = xEntidades,
            sancion = xSancion
        WHERE id = xId;
        
        IF SQL % ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'No se encontró la ley a modificar');
        END IF;

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003, 'Error al modificar la ley');
    END modificarLey;


    PROCEDURE eliminarLey(
        xId IN NUMBER
    ) IS
    BEGIN
        DELETE FROM leyes
        WHERE id = xId;
        IF SQL % ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20004, 'No se encontró la ley a eliminar');
        END IF;

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20005, 'Error al eliminar la ley');
    END eliminarLey;
    
END PK_Leyes;
/



/*CRUDOK */
---#######################################################################################################---
----------------------------------------- RESPONSABLES LEGALES ----------------------------------------------
---#######################################################################################################---

-------------------------------------------------------------------------------------------------------------
----------------------------------------- ADICIONAR ---------------------------------------------------------
-------------------------------------------------------------------------------------------------------------

--DELETE FROM responsablesLegales; 

--EL DELETE SOLO EN CASO DE QUE LA BD ESTE LLENA

BEGIN
    PK_ResponsablesLegales.adicionarResponsableLegal(16, 'Astryyyyy', 'Madre');
END;

BEGIN
    PK_ResponsablesLegales.adicionarResponsableLegal(17, 'Armando Casas', 'Padre');
END;

BEGIN
    PK_ResponsablesLegales.adicionarResponsableLegal(18, 'Pedro Puas', 'Padre');
END;
-------------------------------------------------------------------------------------------------------------
----------------------------------------- CONSULTAR ---------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
DECLARE
    vCursor SYS_REFCURSOR;
    vId NUMBER;
    vNombre VARCHAR2(100);
    vRelacion VARCHAR2(20);
BEGIN
    
    vCursor := PK_ResponsablesLegales.consultarResponsableLegal(16);
    
   
    FETCH vCursor INTO vId, vNombre, vRelacion;

   
    DBMS_OUTPUT.PUT_LINE('ID: ' || vId || ', Nombre: ' || vNombre || ', Relación: ' || vRelacion);

   
    CLOSE vCursor;
END;
/

DECLARE
    vCursor SYS_REFCURSOR;
    vId NUMBER;
    vNombre VARCHAR2(100);
    vRelacion VARCHAR2(20);
BEGIN
   
    vCursor := PK_ResponsablesLegales.consultarResponsableLegal(17);
    
   
    FETCH vCursor INTO vId, vNombre, vRelacion;

  
    DBMS_OUTPUT.PUT_LINE('ID: ' || vId || ', Nombre: ' || vNombre || ', Relación: ' || vRelacion);

   
    CLOSE vCursor;
END;
/

DECLARE
    vCursor SYS_REFCURSOR;
    vId NUMBER;
    vNombre VARCHAR2(100);
    vRelacion VARCHAR2(20);

BEGIN
    
    vCursor := PK_ResponsablesLegales.consultarResponsableLegal(18);
    
   
    FETCH vCursor INTO vId, vNombre, vRelacion;

    
    DBMS_OUTPUT.PUT_LINE('ID: ' || vId || ', Nombre: ' || vNombre || ', Relación: ' || vRelacion);

    CLOSE vCursor;
END;
/
-------------------------------------------------------------------------------------------------------------
----------------------------------------- MODIFICAR ---------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
BEGIN
    PK_ResponsablesLegales.modificarResponsableLegal(16, 'Juan', 'Padre');
END;
/

SELECT * FROM responsablesLegales WHERE id = 16; -- Para probar que la modificación fue exitosa


BEGIN
    PK_ResponsablesLegales.modificarResponsableLegal(17, 'Luna', 'Madre');
END;
/


SELECT * FROM responsablesLegales WHERE id = 17; -- Para probar que la modificación fue exitosa

BEGIN
    PK_ResponsablesLegales.modificarResponsableLegal(18, 'Diego', 'Padre');
END;
/

SELECT * FROM responsablesLegales WHERE id = 18; -- Para probar que la modificación fue exitosa

-------------------------------------------------------------------------------------------------------------
----------------------------------------- ELIMINAR ----------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
BEGIN
    PK_ResponsablesLegales.eliminarResponsableLegal(16);
END;
/

SELECT * FROM responsablesLegales WHERE id = 16; -- Para probar que la eliminación fue exitosa

BEGIN
    PK_ResponsablesLegales.eliminarResponsableLegal(17);
END;
/

SELECT * FROM responsablesLegales WHERE id = 17; -- Para probar que la eliminación fue exitosa

BEGIN
    PK_ResponsablesLegales.eliminarResponsableLegal(18);
END;
/
SELECT * FROM responsablesLegales WHERE id = 18; -- Para probar que la eliminación fue exitosa

---#######################################################################################################---
----------------------------------------- CONTENIDO INTERACTIVO ---------------------------------------------
---#######################################################################################################---
-------------------------------------------------------------------------------------------------------------
----------------------------------------- ADICIONAR ---------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
BEGIN
    PK_ContenidosInteractivo.adicionarContenidoInteractivo(11, 'Media', '1', 'Windows',96 );
END;

BEGIN
    PK_ContenidosInteractivo.adicionarContenidoInteractivo(12, 'Alta', '1', 'Mac',36);
END;

BEGIN
    PK_ContenidosInteractivo.adicionarContenidoInteractivo(13, 'Baja', '0', 'Linux',56 );
END;

-------------------------------------------------------------------------------------------------------------
----------------------------------------- CONSULTAR ---------------------------------------------------------
-------------------------------------------------------------------------------------------------------------

DECLARE
    vCursor SYS_REFCURSOR;
    vId NUMBER;
    vnivelInteraccion VARCHAR2(10);
    vaccesibilidad NUMBER(1);
    vplataformasCompatibles VARCHAR2(100);
    vpopularidad NUMBER(20);
BEGIN
    
    vCursor := PK_ContenidosInteractivo.consultarContenidoInteractivo(11);
    
    FETCH vCursor INTO vId, vnivelInteraccion, vaccesibilidad, vplataformasCompatibles, vpopularidad;

    DBMS_OUTPUT.PUT_LINE('Nivel de Interacción: ' || vnivelInteraccion || ', Accesibilidad: ' || vaccesibilidad || ', Plataformas Compatibles: ' || vplataformasCompatibles || ', Popularidad: ' || vpopularidad);
   
    CLOSE vCursor;
END;
/

DECLARE
    vCursor SYS_REFCURSOR;
    vId NUMBER;
    vnivelInteraccion VARCHAR2(10);
    vaccesibilidad NUMBER(1);
    vplataformasCompatibles VARCHAR2(100);
    vpopularidad NUMBER(20);
BEGIN
    
    vCursor := PK_ContenidosInteractivo.consultarContenidoInteractivo(12);
    
    FETCH vCursor INTO vId, vnivelInteraccion, vaccesibilidad, vplataformasCompatibles, vpopularidad;

    DBMS_OUTPUT.PUT_LINE('Nivel de Interacción: ' || vnivelInteraccion || ', Accesibilidad: ' || vaccesibilidad || ', Plataformas Compatibles: ' || vplataformasCompatibles || ', Popularidad: ' || vpopularidad);
   
    CLOSE vCursor;
END;
/

DECLARE
    vCursor SYS_REFCURSOR;
    vId NUMBER;
    vnivelInteraccion VARCHAR2(10);
    vaccesibilidad NUMBER(1);
    vplataformasCompatibles VARCHAR2(100);
    vpopularidad NUMBER(20);
BEGIN
    
    vCursor := PK_ContenidosInteractivo.consultarContenidoInteractivo(13);
    
    FETCH vCursor INTO vId, vnivelInteraccion, vaccesibilidad, vplataformasCompatibles, vpopularidad;

    DBMS_OUTPUT.PUT_LINE('Nivel de Interacción: ' || vnivelInteraccion || ', Accesibilidad: ' || vaccesibilidad || ', Plataformas Compatibles: ' || vplataformasCompatibles || ', Popularidad: ' || vpopularidad);
   
    CLOSE vCursor;
END;
/
-------------------------------------------------------------------------------------------------------------
----------------------------------------- ELIMINAR ----------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
BEGIN
    PK_ContenidosInteractivo.eliminarContenidoInteractivo(11);
END;
/
SELECT * FROM responsablesLegales WHERE id = 11;

BEGIN
    PK_ContenidosInteractivo.eliminarContenidoInteractivo(12);
END;
/
SELECT * FROM responsablesLegales WHERE id = 12;

BEGIN
    PK_ContenidosInteractivo.eliminarContenidoInteractivo(12);
END;
/
SELECT * FROM responsablesLegales WHERE id = 12;

---#######################################################################################################---
----------------------------------------- LEYES ----------------------------------------------
---#######################################################################################################---

-------------------------------------------------------------------------------------------------------------
----------------------------------------- ADICIONAR ---------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
BEGIN 
    PK_Leyes.adicionarLey(26, 'Ley de Proteccion Infantil', TO_DATE('2018-05-20', 'YYYY-MM-DD'), 'Gobierno', 'Colegios, Plataformas Digitales', 1);
END;

BEGIN 
    PK_Leyes.adicionarLey(27, 'Ley de Proteccion de Datos', TO_DATE('2018-05-25', 'YYYY-MM-DD'), 'Gobierno', 'Usuarios, Empresas', 2);
END;

BEGIN 
    PK_Leyes.adicionarLey(28, 'Ley de Protección de Datos Personales', TO_DATE('1996-05-25', 'YYYY-MM-DD'), 'Gobierno', 'Usuarios, Empresas', 2);
END;
-------------------------------------------------------------------------------------------------------------
----------------------------------------- CONSULTAR ---------------------------------------------------------
-------------------------------------------------------------------------------------------------------------

DECLARE
    vCursor SYS_REFCURSOR;
    vId NUMBER(20);
    vNombre VARCHAR2(100);
    vFechaPublicacion  DATE;
    vAutoridadFiscal VARCHAR2(50);
    vEntidades VARCHAR2(100);
    vSancion NUMBER(1);
BEGIN
    
    vCursor := PK_Leyes.consultarLey(26);
    
   
    FETCH vCursor INTO vId, vNombre, vFechaPublicacion, vAutoridadFiscal, vEntidades, vSancion;

   
    DBMS_OUTPUT.PUT_LINE('ID: ' || vId || ' Nombre: ' || vNombre || ' Fecha de Publicacion: ' || vFechaPublicacion || ' Autoridad Fiscal: ' || vAutoridadFiscal || ' Entidades: ' || vEntidades || ' Sancion: ' || vSancion);

   
    CLOSE vCursor;
END;
/


DECLARE
    vCursor SYS_REFCURSOR;
    vId NUMBER(20);
    vNombre VARCHAR2(100);
    vFechaPublicacion  DATE;
    vAutoridadFiscal VARCHAR2(50);
    vEntidades VARCHAR2(100);
    vSancion NUMBER(1);
BEGIN
    
    vCursor := PK_Leyes.consultarLey(27);
    
   
    FETCH vCursor INTO vId, vNombre, vFechaPublicacion, vAutoridadFiscal, vEntidades, vSancion;

   
    DBMS_OUTPUT.PUT_LINE('ID: ' || vId || ' Nombre: ' || vNombre || ' Fecha de Publicacion: ' || vFechaPublicacion || ' Autoridad Fiscal: ' || vAutoridadFiscal || ' Entidades: ' || vEntidades || ' Sancion: ' || vSancion);

   
    CLOSE vCursor;
END;
/


DECLARE
    vCursor SYS_REFCURSOR;
    vId NUMBER(20);
    vNombre VARCHAR2(100);
    vFechaPublicacion  DATE;
    vAutoridadFiscal VARCHAR2(50);
    vEntidades VARCHAR2(100);
    vSancion NUMBER(1);
BEGIN
    
    vCursor := PK_Leyes.consultarLey(28);
    
   
    FETCH vCursor INTO vId, vNombre, vFechaPublicacion, vAutoridadFiscal, vEntidades, vSancion;

   
    DBMS_OUTPUT.PUT_LINE('ID: ' || vId || ' Nombre: ' || vNombre || ' Fecha de Publicacion: ' || vFechaPublicacion || ' Autoridad Fiscal: ' || vAutoridadFiscal || ' Entidades: ' || vEntidades || ' Sancion: ' || vSancion);

   
    CLOSE vCursor;
END;
/
-------------------------------------------------------------------------------------------------------------
----------------------------------------- MODIFICAR ---------------------------------------------------------
-------------------------------------------------------------------------------------------------------------


BEGIN 
    PK_Leyes.modificarLey(26 , 'Ley de Proteccion de Datos', TO_DATE('2024-05-25', 'YYYY-MM-DD'), 'Gobierno', 'Usuarios, Empresas', 2);
END;


BEGIN 
    PK_Leyes.modificarLey(27, 'Ley de Proteccion de Datos', TO_DATE('2013-05-25', 'YYYY-MM-DD'), 'Gobierno', 'Usuarios, Empresas', 2);
END;


BEGIN 
    PK_Leyes.modificarLey(28, 'Ley de Proteccion de Datos', TO_DATE('2012-05-29', 'YYYY-MM-DD'), 'Gobierno', 'Usuarios, Empresas', 2);
END;
-------------------------------------------------------------------------------------------------------------
----------------------------------------- ELIMINAR ----------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
BEGIN 
    PK_Leyes.eliminarLey(26);
END;

BEGIN 
    PK_Leyes.eliminarLey(27);
END;

BEGIN 
    PK_Leyes.eliminarLey(28);
END;

/*XCRUD - NO EJECUTAR SI NO SE ENCUENTRA ENTRE ASTERISCO Y SLASH */
DROP PACKAGE PK_ResponsablesLegales;
DROP PACKAGE PK_ContenidosInteractivo ;
DROP PACKAGE PK_Leyes;