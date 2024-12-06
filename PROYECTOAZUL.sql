/* CREACION DE TABLAS*/
CREATE TABLE responsablesLegales(
    id NUMBER(20) NOT NULL, --PK
    nombre VARCHAR2(100) NOT NULL,
    relacion VARCHAR2(20) NOT NULL
);

CREATE TABLE tutores(
    id NUMBER(20) NOT NULL, --Pk 
    idResponsablesLegales NUMBER(20) NOT NULL, --PK y K
    idPerfil NUMBER(20) NOT NULL, --PK y Fk
    nombre VARCHAR2(100) NOT NULL,
    responsabilidad VARCHAR2(50) NOT NULL,
    correo VARCHAR2(50) NOT NULL,
    numeroTelefono NUMBER(15) NOT NULL,
    documentoIdentidad NUMBER(20) NOT NULL,
    direccion VARCHAR2(50) NOT NULL
);

CREATE TABLE perfiles(
    id NUMBER(20) NOT NULL, --PK
    idVerificaciones NUMBER(20) NOT NULL, --PK y FK
    nombreUsuario VARCHAR2(100) NOT NULL, --UK
    fechaEdad DATE NOT NULL,
    fechaRegistro DATE NOT NULL,
    nivelAcceso VARCHAR2(20) NOT NULL,
    paisOrigen VARCHAR2(50) NOT NULL,
    rol VARCHAR2(50) NOT NULL
);

CREATE TABLE verificaciones(
    id NUMBER(20) NOT NULL, --PK
    metodo VARCHAR2(50) NOT NULL,
    fechaVerificacion DATE NOT NULL,
    estadoVerificacion VARCHAR2(20) NOT NULL
);

CREATE TABLE contenidosVisuales(
    id NUMBER(20) NOT NULL, --PK
    subtitulos NUMBER(1) NOT NULL CHECK (subtitulos IN (0, 1)), -- 0 para FALSE y 1 para TRUE
    productora VARCHAR2(20) NOT NULL
);

CREATE TABLE categorias(
    idContenidosVisuales NUMBER(20) NOT NULL, --PK
    categoria VARCHAR2(20)NOT NULL--Pk
);

CREATE TABLE streamings(
    idContenidosVisuales NUMBER(20) NOT NULL, --PK y FK
    id NUMBER(20) NOT NULL, --PK y FK
    plataforma VARCHAR2(50) NOT NULL,
    requiereRegistro NUMBER(1) NOT NULL,
    calidad VARCHAR2(20) NOT NULL,
    duracionHoras NUMBER(20) NOT NULL
);

CREATE TABLE canalesTelevisivos(
    idContenidosVisuales NUMBER(20) NOT NULL, --PK y Fk
    nombreCanal VARCHAR2(50) NOT NULL,
    generoCanal VARCHAR2(50) NOT NULL,
    audienciaObjetivo VARCHAR2(20) NOT NULL,
    frecuencia VARCHAR2(20) NOT NULL    
);

CREATE TABLE bienestarDigitales(
    id NUMBER(20) NOT NULL, --PK
    idContenidosVisuales NUMBER(20) NOT NULL, --PK y Fk
    plataformas VARCHAR2(50) NOT NULL,
    politicasAsociadas VARCHAR2(50) NOT NULL,
    fechaImplementacio DATE NOT NULL
);

CREATE TABLE bloqueos(
    id NUMBER(20) NOT NULL, --PK
    idBienestarDigitales NUMBER(20) NOT NULL, --PK y FK
    metodo VARCHAR2(50),
    fechaBloqueo DATE,
    motivo VARCHAR2(100),
    duracionDias NUMBER(20)
);

CREATE TABLE contenidosInteractivos(
    id NUMBER(20) NOT NULL, --PK
    nivelInteraccion VARCHAR2(10) NOT NULL,
    accesibilidad NUMBER(1) NOT NULL CHECK (accesibilidad IN (0, 1)), -- 0 para FALSE y 1 para TRUE
    plataformasCompatibles VARCHAR2(100) NOT NULL,
    popularidad NUMBER(20) NOT NULL
);



CREATE TABLE videojuegos(
    idContenidosInteractivos NUMBER(20) NOT NULL, --Pk y Fk
    idClasificaciones NUMBER(20) NOT NULL, --PK y Fk
    nombre VARCHAR2(100) NOT NULL,
    desarrollador VARCHAR2(50) NOT NULL,
    requisitos VARCHAR2(50) NOT NULL,
    modoJuego VARCHAR2(50) NOT NULL
);

CREATE TABLE paginasWeb(
    idContenidosInteractivos NUMBER(20) NOT NULL,  --PK y  FK
    idClasificaciones NUMBER(20) NOT NULL, --PK y Fk
    url VARCHAR2(100) NOT NULL, --UK
    visitasMensuales NUMBER(20) NOT NULL,
    fechaCreacion DATE NOT NULL,
    descripcion VARCHAR2(100) NOT NULL,
    politicasPrivacidad VARCHAR2(100) NOT NULL,
    protocolo VARCHAR2(20) NOT NULL
);

CREATE TABLE clasificaciones(
    id NUMBER(20) NOT NULL,
    nombreClasificacion VARCHAR2(20) NOT NULL,
    criterios VARCHAR2(50) NOT NULL,
    organizacionReguladora VARCHAR2(50) NOT NULL,
    fechaEmision DATE NOT NULL
);

CREATE TABLE leyes(
    id NUMBER(20) NOT NULL, --PK
    nombre VARCHAR2(100) NOT NULL,
    fechaPublicacion DATE NOT NULL,
    autoridadFiscal VARCHAR2(50) NOT NULL,
    entidades VARCHAR2(100) NOT NULL,
    sancion NUMBER(1) NOT NULL
);






BEGIN 
    PK_Leyes.adicionarLey(27, 'Ley de Proteccion Infantil', TO_DATE('2018-05-20', 'YYYY-MM-DD'), 'Gobierno', 'Colegios, Plataformas Digitales', 1);
END;

SELECT * FROM leyes WHERE id = 26;


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

BEGIN 
    PK_Leyes.modificarLey(27, 'Ley de Proteccion de Datos', TO_DATE('2018-05-25', 'YYYY-MM-DD'), 'Gobierno', 'Usuarios, Empresas', 2);
END;
SELECT * FROM leyes WHERE id = 27;


BEGIN 
    PK_Leyes.eliminarLey(27);
END;

SELECT * FROM leyes WHERE id = 27;

SELECT * FROM leyes;
DROP PACKAGE PK_Leyes;




CREATE TABLE normas(
    id NUMBER(20) NOT NULL, --PK
    idLeyes NUMBER(20) NOT NULL, --PK y FK
    descripcion VARCHAR2(100) NOT NULL,
    fechaModificacion DATE NOT NULL,
    vigencia VARCHAR2(100) NOT NULL,
    alcance VARCHAR2(100) NOT NULL
);

/*Atributos */
ALTER TABLE perfiles
ADD CONSTRAINT CK_nivel_acceso CHECK (nivelAcceso IN ('admin', 'user', 'guest'));

ALTER TABLE streamings
ADD CONSTRAINT CK_calidad_video CHECK (calidad IN ('SD', 'HD', '4K'));

ALTER TABLE verificaciones
ADD CONSTRAINT CK_estado_verificacion CHECK (estadoVerificacion IN ('Pendiente', 'Completado', 'Rechazado'));

ALTER TABLE tutores 
ADD CONSTRAINT CK_Tutores_Correo 
CHECK (correo LIKE '%@%.%');

ALTER TABLE contenidosVisuales 
ADD CONSTRAINT CK_ContenidosVisuales_Subtitulos 
CHECK (subtitulos IN (0, 1));

ALTER TABLE paginasWeb 
ADD CONSTRAINT CK_PaginasWeb_Protocolo 
CHECK (protocolo IN ('HTTP', 'HTTPS'));

ALTER TABLE normas 
ADD CONSTRAINT CK_alcanceDefinido
CHECK (alcance IN ('Nacional', 'Internacional'));

/* Claves Primarias */
ALTER TABLE responsablesLegales
ADD CONSTRAINT PK_ResponsablesLegales PRIMARY KEY (id);

ALTER TABLE tutores
ADD CONSTRAINT PK_Tutores PRIMARY KEY (id);

ALTER TABLE perfiles
ADD CONSTRAINT PK_Perfiles PRIMARY KEY (id);

ALTER TABLE verificaciones
ADD CONSTRAINT PK_Verificaciones PRIMARY KEY (id);

ALTER TABLE contenidosVisuales
ADD CONSTRAINT PK_ContenidosVisuales PRIMARY KEY (id);

ALTER TABLE categorias
ADD CONSTRAINT PK_Categorias PRIMARY KEY (idContenidosVisuales, categoria);

ALTER TABLE streamings
ADD CONSTRAINT PK_Streamings PRIMARY KEY (id);

ALTER TABLE canalesTelevisivos
ADD CONSTRAINT PK_CanalesTelevisivos PRIMARY KEY (idContenidosVisuales, nombreCanal);

ALTER TABLE bienestarDigitales
ADD CONSTRAINT PK_BienestarDigitales PRIMARY KEY (id);

ALTER TABLE bloqueos
ADD CONSTRAINT PK_Bloqueos PRIMARY KEY (id);

ALTER TABLE contenidosInteractivos
ADD CONSTRAINT PK_ContenidosInteractivos PRIMARY KEY (id);

ALTER TABLE videojuegos
ADD CONSTRAINT PK_Videojuegos PRIMARY KEY (idContenidosInteractivos, idClasificaciones);

ALTER TABLE paginasWeb
ADD CONSTRAINT PK_PaginasWeb PRIMARY KEY (idContenidosInteractivos, idClasificaciones);

ALTER TABLE clasificaciones
ADD CONSTRAINT PK_Clasificaciones PRIMARY KEY (id);

ALTER TABLE leyes
ADD CONSTRAINT PK_Leyes PRIMARY KEY (id);

ALTER TABLE normas
ADD CONSTRAINT PK_Normas PRIMARY KEY (id);

/*Claves For�neas */

ALTER TABLE tutores
ADD CONSTRAINT FK_Tutores_ResponsablesLegales 
FOREIGN KEY (idResponsablesLegales) REFERENCES responsablesLegales(id);

ALTER TABLE tutores
ADD CONSTRAINT FK_Tutores_Perfil 
FOREIGN KEY (idPerfil) REFERENCES perfiles(id);

ALTER TABLE perfiles
ADD CONSTRAINT FK_Perfiles_Verificaciones 
FOREIGN KEY (idVerificaciones) REFERENCES verificaciones(id);

ALTER TABLE bienestarDigitales
ADD CONSTRAINT FK_BienestarDigitales_ContenidosVisuales 
FOREIGN KEY (idContenidosVisuales) REFERENCES contenidosVisuales(id);

ALTER TABLE bloqueos
ADD CONSTRAINT FK_Bloqueos_BienestarDigitales 
FOREIGN KEY (idBienestarDigitales) REFERENCES bienestarDigitales(id);

ALTER TABLE videojuegos
ADD CONSTRAINT FK_Videojuegos_ContenidosInteractivos 
FOREIGN KEY (idContenidosInteractivos) REFERENCES contenidosInteractivos(id);

ALTER TABLE videojuegos
ADD CONSTRAINT FK_Videojuegos_Clasificaciones 
FOREIGN KEY (idClasificaciones) REFERENCES clasificaciones(id);

ALTER TABLE paginasWeb
ADD CONSTRAINT FK_PaginasWeb_ContenidosInteractivos 
FOREIGN KEY (idContenidosInteractivos) REFERENCES contenidosInteractivos(id);

ALTER TABLE paginasWeb
ADD CONSTRAINT FK_PaginasWeb_Clasificaciones 
FOREIGN KEY (idClasificaciones) REFERENCES clasificaciones(id);

ALTER TABLE normas
ADD CONSTRAINT FK_Normas_Leyes 
FOREIGN KEY (idLeyes) REFERENCES leyes(id);

/* Claves �nicas */
ALTER TABLE perfiles
ADD CONSTRAINT UK_Perfiles_NombreUsuario UNIQUE (nombreUsuario);

ALTER TABLE paginasWeb
ADD CONSTRAINT UK_PaginasWeb_Url UNIQUE (url);


/*XTablas*/
DROP TABLE responsablesLegales;
DROP TABLE tutores;
DROP TABLE perfiles;
DROP TABLE verificaciones;
DROP TABLE contenidosVisuales;
DROP TABLE categorias;
DROP TABLE streamings;
DROP TABLE canalesTelevisivos;
DROP TABLE bienestarDigitales;
DROP TABLE bloqueos;
DROP TABLE contenidosInteractivos;
DROP TABLE videojuegos;
DROP TABLE paginasWeb;
DROP TABLE clasificaciones;
DROP TABLE leyes;
DROP TABLE normas;

/*XTablas
DROP TABLE responsablesLegales  CASCADE CONSTRAINTS;
DROP TABLE tutores  CASCADE CONSTRAINTS;
DROP TABLE perfiles  CASCADE CONSTRAINTS;
DROP TABLE verificaciones  CASCADE CONSTRAINTS;
DROP TABLE contenidosVisuales  CASCADE CONSTRAINTS;
DROP TABLE categorias  CASCADE CONSTRAINTS;
DROP TABLE streamings  CASCADE CONSTRAINTS;
DROP TABLE canalesTelevisivos  CASCADE CONSTRAINTS;
DROP TABLE bienestarDigitales  CASCADE CONSTRAINTS;
DROP TABLE bloqueos  CASCADE CONSTRAINTS;
DROP TABLE contenidosInteractivos  CASCADE CONSTRAINTS;
DROP TABLE videojuegos  CASCADE CONSTRAINTS;
DROP TABLE paginasWeb  CASCADE CONSTRAINTS;
DROP TABLE clasificaciones  CASCADE CONSTRAINTS;
DROP TABLE leyes  CASCADE CONSTRAINTS;
DROP TABLE normas  CASCADE CONSTRAINTS;
*/

/*Consultas SQL con identificador */

/*Consulta 1: Seleccionar todos los responsables legales*/
SELECT id, nombre, relacion 
FROM responsablesLegales;

/*Consulta 2: Seleccionar tutores y sus responsables legales*/

SELECT t.id AS tutor_id, t.nombre AS tutor_nombre, t.idResponsablesLegales AS responsable_id, r.nombre AS responsable_nombre
FROM tutores t
JOIN responsablesLegales r ON t.idResponsablesLegales = r.id;

/*Consulta 3: Contar el número de verificaciones por método incluyendo*/
SELECT v.metodo, COUNT(*) AS total_verificaciones
FROM verificaciones v
GROUP BY v.metodo;

/*Consulta 4: Insertar un nuevo registro en contenidosVisuales */
INSERT INTO contenidosVisuales (id, subtitulos, productora)
VALUES (11, 1, 'Productora Y');

/*Consulta 5: Actualizar la dirección de un tutor*/
UPDATE tutores
SET direccion = 'Nueva Dirección'
WHERE id = 1;

/*Consulta 6: Seleccionar todos los contenidos interactivos*/
SELECT id, nivelInteraccion, accesibilidad
FROM contenidosInteractivos;

/*Consulta 7: Seleccionar videojuegos con popularidad superior a un cierto valor*/
SELECT idContenidosInteractivos, idClasificaciones, nombre
FROM videojuegos
WHERE idClasificaciones = 1;

/*Consulta 8: Contar el número de contenidos visuales por productora*/
SELECT id, productora, COUNT(*) AS total_contenidos
FROM contenidosVisuales
GROUP BY id, productora;

/*Consulta 9:  Listar las páginas web, su número de visitas mensuales*/
SELECT idContenidosInteractivos, idClasificaciones, url, visitasMensuales
FROM paginasWeb;

/*Consulta 10: Seleccionar leyes con sanción*/
SELECT id, nombre, fechaPublicacion
FROM leyes
WHERE sancion = 1;

/*Consulta 11: Unir normas y leyes para obtener descripciones de normas*/
SELECT n.id, n.descripcion, l.id AS ley_id, l.nombre
FROM normas n
JOIN leyes l ON n.idLeyes = l.id;

/*Consulta 12: Seleccionar perfiles y sus verificaciones*/
SELECT p.id AS perfil_id, p.nombreUsuario, p.idVerificaciones AS verificacion_id, v.metodo, v.estadoVerificacion
FROM perfiles p
JOIN verificaciones v ON p.idVerificaciones = v.id;

/*Consulta 13: Obtener todos los contenidos interactivos*/
SELECT id, nivelInteraccion, accesibilidad
FROM contenidosInteractivos;

/*Consulta 14: Listar todas las plataformas de streaming y sus calidades*/
SELECT idContenidosVisuales, id, plataforma, calidad
FROM streamings;

/*Consulta 15: Contar bloqueos por método*/
SELECT id, idBienestarDigitales, metodo, COUNT(*) AS total_bloqueos
FROM bloqueos
GROUP BY id, metodo, idBienestarDigitales;

/*Consulta 16: Seleccionar todas las categorías de contenidos visuales*/
SELECT idContenidosVisuales, categoria
FROM categorias;

/*PoblarOK */

-- Poblaci�n de la tabla leyes
INSERT INTO leyes (id, nombre, fechaPublicacion, autoridadFiscal, entidades, sancion)
VALUES (1, 'Ley de Proteccion Infantil', TO_DATE('2018-05-20', 'YYYY-MM-DD'), 'Gobierno', 'Colegios, Plataformas Digitales', 1);

INSERT INTO leyes (id, nombre, fechaPublicacion, autoridadFiscal, entidades, sancion)
VALUES (2, 'Ley de Protección de Datos', TO_DATE('2018-05-25', 'YYYY-MM-DD'), 'Gobierno', 'Usuarios, Empresas', 2);

INSERT INTO leyes (id, nombre, fechaPublicacion, autoridadFiscal, entidades, sancion)
VALUES (3, 'Ley de Comercio Electrónico', TO_DATE('2019-07-01', 'YYYY-MM-DD'), 'Gobierno', 'Comerciantes, Consumidores', 3);

INSERT INTO leyes (id, nombre, fechaPublicacion, autoridadFiscal, entidades, sancion)
VALUES (4, 'Ley de Derechos de Autor', TO_DATE('2020-01-15', 'YYYY-MM-DD'), 'Gobierno', 'Autores, Editores', 4);

INSERT INTO leyes (id, nombre, fechaPublicacion, autoridadFiscal, entidades, sancion)
VALUES (5, 'Ley de Transparencia', TO_DATE('2021-09-10', 'YYYY-MM-DD'), 'Gobierno', 'Instituciones Públicas, Ciudadanos', 5);

INSERT INTO leyes (id, nombre, fechaPublicacion, autoridadFiscal, entidades, sancion)
VALUES (6, 'Ley de Protección Ambiental', TO_DATE('2022-11-20', 'YYYY-MM-DD'), 'Gobierno', 'Empresas, Ciudadanos', 6);

INSERT INTO leyes (id, nombre, fechaPublicacion, autoridadFiscal, entidades, sancion)
VALUES (7, 'Ley de Seguridad en Línea', TO_DATE('2017-03-10', 'YYYY-MM-DD'), 'Gobierno', 'Usuarios, Plataformas Digitales', 1);

INSERT INTO leyes (id, nombre, fechaPublicacion, autoridadFiscal, entidades, sancion)
VALUES (8, 'Ley de Contenido Digital', TO_DATE('2020-12-05', 'YYYY-MM-DD'), 'Ministerio de Cultura', 'Plataformas de Streaming, Productoras', 0);

INSERT INTO leyes (id, nombre, fechaPublicacion, autoridadFiscal, entidades, sancion)
VALUES (9, 'Ley de Protección Infantil', TO_DATE('2018-05-20', 'YYYY-MM-DD'), 'Gobierno', 'Colegios, Plataformas Digitales', 1);

INSERT INTO leyes (id, nombre, fechaPublicacion, autoridadFiscal, entidades, sancion)
VALUES (10, 'Ley de Protección de Datos Personales', TO_DATE('2019-08-15', 'YYYY-MM-DD'), 'Gobierno', 'Usuarios, Empresas', 2);

-- Poblaci�n de la tabla contenidosVisuales
INSERT INTO contenidosVisuales (id, subtitulos, productora)
VALUES (1, 1, 'Productora A'); 

INSERT INTO contenidosVisuales (id, subtitulos, productora)
VALUES (2, 1, 'Productora B');

INSERT INTO contenidosVisuales (id, subtitulos, productora)
VALUES (3, 0, 'Productora C');

INSERT INTO contenidosVisuales (id, subtitulos, productora)
VALUES (4, 1, 'Productora D');

INSERT INTO contenidosVisuales (id, subtitulos, productora)
VALUES (5, 0, 'Productora E');

INSERT INTO contenidosVisuales (id, subtitulos, productora)
VALUES (6, 1, 'Productora F');

INSERT INTO contenidosVisuales (id, subtitulos, productora)
VALUES (7, 0, 'Productora G');

INSERT INTO contenidosVisuales (id, subtitulos, productora)
VALUES (8, 1, 'Productora H');

INSERT INTO contenidosVisuales (id, subtitulos, productora)
VALUES (9, 0, 'Productora I');

INSERT INTO contenidosVisuales (id, subtitulos, productora)
VALUES (10, 1, 'Productora J');

-- Poblaci�n de la tabla contenidosInteractivos
INSERT INTO contenidosInteractivos (id, nivelInteraccion, accesibilidad, plataformasCompatibles, popularidad)
VALUES (1, 'Alta', 1, 'Windows, Mac, Linux', 85);

INSERT INTO contenidosInteractivos (id, nivelInteraccion, accesibilidad, plataformasCompatibles, popularidad)
VALUES (2, 'Media', 1, 'Windows, Mac', 75);

INSERT INTO contenidosInteractivos (id, nivelInteraccion, accesibilidad, plataformasCompatibles, popularidad)
VALUES (3, 'Baja', 0, 'Windows, Linux', 65);

INSERT INTO contenidosInteractivos (id, nivelInteraccion, accesibilidad, plataformasCompatibles, popularidad)
VALUES (4, 'Alta', 1, 'Mac, Linux', 90);

INSERT INTO contenidosInteractivos (id, nivelInteraccion, accesibilidad, plataformasCompatibles, popularidad)
VALUES (5, 'Media', 1, 'Windows, Mac, Linux', 80);

INSERT INTO contenidosInteractivos (id, nivelInteraccion, accesibilidad, plataformasCompatibles, popularidad)
VALUES (6, 'Baja', 0, 'Windows', 60);

INSERT INTO contenidosInteractivos (id, nivelInteraccion, accesibilidad, plataformasCompatibles, popularidad)
VALUES (7, 'Alta', 1, 'Mac', 85);

INSERT INTO contenidosInteractivos (id, nivelInteraccion, accesibilidad, plataformasCompatibles, popularidad)
VALUES (8, 'Media', 1, 'Linux', 70);

INSERT INTO contenidosInteractivos (id, nivelInteraccion, accesibilidad, plataformasCompatibles, popularidad)
VALUES (9, 'Baja', 0, 'Windows, Mac', 55);

INSERT INTO contenidosInteractivos (id, nivelInteraccion, accesibilidad, plataformasCompatibles, popularidad)
VALUES (10, 'Alta', 1, 'Windows, Linux', 95);

-- Poblaci�n de la tabla responsablesLegales
INSERT INTO responsablesLegales (id, nombre, relacion)
VALUES (1, 'Carlos Garc�a', 'Padre');

INSERT INTO responsablesLegales (id, nombre, relacion)
VALUES (2, 'Astrid Rivera', 'Madre');

INSERT INTO responsablesLegales (id, nombre, relacion)
VALUES (3, 'Juan Pérez', 'Tutor');

INSERT INTO responsablesLegales (id, nombre, relacion)
VALUES (4, 'Ana Martínez', 'Madre');

INSERT INTO responsablesLegales (id, nombre, relacion)
VALUES (5, 'Luis Fernández', 'Padre');

INSERT INTO responsablesLegales (id, nombre, relacion)
VALUES (6, 'Laura Sánchez', 'Tutor');

INSERT INTO responsablesLegales (id, nombre, relacion)
VALUES (7, 'Pedro Gómez', 'Padre');

INSERT INTO responsablesLegales (id, nombre, relacion)
VALUES (8, 'Elena Rodríguez', 'Madre');

INSERT INTO responsablesLegales (id, nombre, relacion)
VALUES (9, 'Miguel Torres', 'Tutor');

INSERT INTO responsablesLegales (id, nombre, relacion)
VALUES (10, 'Carmen Díaz', 'Madre');

-- Poblaci�n de la tabla clasificaciones
INSERT INTO clasificaciones (id, nombreClasificacion, criterios, organizacionReguladora, fechaEmision)
VALUES (1, 'Todo P�blico', 'Sin contenido violento', 'Regulador Nacional', TO_DATE('2022-03-15', 'YYYY-MM-DD'));

INSERT INTO clasificaciones (id, nombreClasificacion, criterios, organizacionReguladora, fechaEmision)
VALUES (2, 'Adolescentes', 'Violencia moderada', 'Regulador Nacional', TO_DATE('2021-05-10', 'YYYY-MM-DD'));

INSERT INTO clasificaciones (id, nombreClasificacion, criterios, organizacionReguladora, fechaEmision)
VALUES (3, 'Adultos', 'Contenido explícito', 'Regulador Nacional', TO_DATE('2020-08-20', 'YYYY-MM-DD'));

INSERT INTO clasificaciones (id, nombreClasificacion, criterios, organizacionReguladora, fechaEmision)
VALUES (4, 'Infantil', 'Apto para niños', 'Regulador Nacional', TO_DATE('2019-11-25', 'YYYY-MM-DD'));

INSERT INTO clasificaciones (id, nombreClasificacion, criterios, organizacionReguladora, fechaEmision)
VALUES (5, 'Mayores de 13', 'Violencia leve', 'Regulador Nacional', TO_DATE('2018-02-14', 'YYYY-MM-DD'));

INSERT INTO clasificaciones (id, nombreClasificacion, criterios, organizacionReguladora, fechaEmision)
VALUES (6, 'Mayores de 16', 'Lenguaje fuerte', 'Regulador Nacional', TO_DATE('2017-07-30', 'YYYY-MM-DD'));

INSERT INTO clasificaciones (id, nombreClasificacion, criterios, organizacionReguladora, fechaEmision)
VALUES (7, 'Mayores de 18', 'Contenido sexual', 'Regulador Nacional', TO_DATE('2016-12-05', 'YYYY-MM-DD'));

INSERT INTO clasificaciones (id, nombreClasificacion, criterios, organizacionReguladora, fechaEmision)
VALUES (8, 'Educativo', 'Contenido educativo', 'Regulador Nacional', TO_DATE('2015-09-10', 'YYYY-MM-DD'));

INSERT INTO clasificaciones (id, nombreClasificacion, criterios, organizacionReguladora, fechaEmision)
VALUES (9, 'Documental', 'Contenido informativo', 'Regulador Nacional', TO_DATE('2014-04-22', 'YYYY-MM-DD'));

INSERT INTO clasificaciones (id, nombreClasificacion, criterios, organizacionReguladora, fechaEmision)
VALUES (10, 'Cultural', 'Contenido cultural', 'Regulador Nacional', TO_DATE('2013-01-18', 'YYYY-MM-DD'));


-- Poblaci�n de la tabla videojuegos
INSERT INTO videojuegos (idContenidosInteractivos, idClasificaciones, nombre, desarrollador, requisitos, modoJuego)
VALUES (1, 1, 'Aventura Espacial', 'Desarrolladora XYZ', 'Windows 10, 8GB RAM', 'Un jugador');

INSERT INTO videojuegos (idContenidosInteractivos, idClasificaciones, nombre, desarrollador, requisitos, modoJuego)
VALUES (2, 2, 'Carreras Extremas', 'Desarrolladora ABC', 'Windows 10, 4GB RAM', 'Multijugador');

INSERT INTO videojuegos (idContenidosInteractivos, idClasificaciones, nombre, desarrollador, requisitos, modoJuego)
VALUES (3, 3, 'Mundo Fantástico', 'Desarrolladora DEF', 'Windows 10, 16GB RAM', 'Un jugador');

INSERT INTO videojuegos (idContenidosInteractivos, idClasificaciones, nombre, desarrollador, requisitos, modoJuego)
VALUES (4, 4, 'Puzzle Master', 'Desarrolladora GHI', 'Windows 7, 2GB RAM', 'Un jugador');

INSERT INTO videojuegos (idContenidosInteractivos, idClasificaciones, nombre, desarrollador, requisitos, modoJuego)
VALUES (5, 5, 'Estrategia Total', 'Desarrolladora JKL', 'Windows 10, 8GB RAM', 'Multijugador');

INSERT INTO videojuegos (idContenidosInteractivos, idClasificaciones, nombre, desarrollador, requisitos, modoJuego)
VALUES (6, 6, 'Simulación de Vida', 'Desarrolladora MNO', 'Windows 8, 4GB RAM', 'Un jugador');

INSERT INTO videojuegos (idContenidosInteractivos, idClasificaciones, nombre, desarrollador, requisitos, modoJuego)
VALUES (7, 7, 'Horror Nocturno', 'Desarrolladora PQR', 'Windows 10, 8GB RAM', 'Un jugador');

INSERT INTO videojuegos (idContenidosInteractivos, idClasificaciones, nombre, desarrollador, requisitos, modoJuego)
VALUES (8, 8, 'Educación Interactiva', 'Desarrolladora STU', 'Windows 7, 2GB RAM', 'Un jugador');

INSERT INTO videojuegos (idContenidosInteractivos, idClasificaciones, nombre, desarrollador, requisitos, modoJuego)
VALUES (9, 9, 'Historia Documental', 'Desarrolladora VWX', 'Windows 10, 4GB RAM', 'Un jugador');

INSERT INTO videojuegos (idContenidosInteractivos, idClasificaciones, nombre, desarrollador, requisitos, modoJuego)
VALUES (10, 10, 'Cultura Virtual', 'Desarrolladora YZ', 'Windows 10, 8GB RAM', 'Un jugador');

-- Poblaci�n de la tabla paginasWeb
INSERT INTO paginasWeb (idContenidosInteractivos, idClasificaciones, url, visitasMensuales, fechaCreacion, descripcion, politicasPrivacidad, protocolo)
VALUES (1, 1, 'https://www.ejemplo.com', 50000, TO_DATE('2020-10-10', 'YYYY-MM-DD'), 'P�gina de educaci�n infantil', 'Pol�tica de privacidad 2023', 'HTTPS');

INSERT INTO paginasWeb (idContenidosInteractivos, idClasificaciones, url, visitasMensuales, fechaCreacion, descripcion, politicasPrivacidad, protocolo)
VALUES (2, 2, 'https://www.carrerasextremas.com', 75000, TO_DATE('2019-05-15', 'YYYY-MM-DD'), 'Página de carreras de autos', 'Política de privacidad 2022', 'HTTPS');

INSERT INTO paginasWeb (idContenidosInteractivos, idClasificaciones, url, visitasMensuales, fechaCreacion, descripcion, politicasPrivacidad, protocolo)
VALUES (3, 3, 'https://www.mundofantastico.com', 120000, TO_DATE('2018-07-20', 'YYYY-MM-DD'), 'Página de fantasía y aventuras', 'Política de privacidad 2021', 'HTTP');

INSERT INTO paginasWeb (idContenidosInteractivos, idClasificaciones, url, visitasMensuales, fechaCreacion, descripcion, politicasPrivacidad, protocolo)
VALUES (4, 4, 'https://www.puzzlemaster.com', 30000, TO_DATE('2021-03-10', 'YYYY-MM-DD'), 'Página de juegos de puzzle', 'Política de privacidad 2023', 'HTTP');

INSERT INTO paginasWeb (idContenidosInteractivos, idClasificaciones, url, visitasMensuales, fechaCreacion, descripcion, politicasPrivacidad, protocolo)
VALUES (5, 5, 'https://www.estrategiatotal.com', 85000, TO_DATE('2020-11-25', 'YYYY-MM-DD'), 'Página de juegos de estrategia', 'Política de privacidad 2022', 'HTTPS');

INSERT INTO paginasWeb (idContenidosInteractivos, idClasificaciones, url, visitasMensuales, fechaCreacion, descripcion, politicasPrivacidad, protocolo)
VALUES (6, 6, 'https://www.simulaciondevida.com', 60000, TO_DATE('2019-09-30', 'YYYY-MM-DD'), 'Página de simulación de vida', 'Política de privacidad 2021', 'HTTP');

INSERT INTO paginasWeb (idContenidosInteractivos, idClasificaciones, url, visitasMensuales, fechaCreacion, descripcion, politicasPrivacidad, protocolo)
VALUES (7, 7, 'https://www.horrornocturno.com', 95000, TO_DATE('2018-12-15', 'YYYY-MM-DD'), 'Página de juegos de horror', 'Política de privacidad 2020', 'HTTPS');

INSERT INTO paginasWeb (idContenidosInteractivos, idClasificaciones, url, visitasMensuales, fechaCreacion, descripcion, politicasPrivacidad, protocolo)
VALUES (8, 8, 'https://www.educacioninteractiva.com', 40000, TO_DATE('2021-06-05', 'YYYY-MM-DD'), 'Página de educación interactiva', 'Política de privacidad 2023', 'HTTPS');

INSERT INTO paginasWeb (idContenidosInteractivos, idClasificaciones, url, visitasMensuales, fechaCreacion, descripcion, politicasPrivacidad, protocolo)
VALUES (9, 9, 'https://www.historiadocumental.com', 70000, TO_DATE('2020-01-20', 'YYYY-MM-DD'), 'Página de documentales históricos', 'Política de privacidad 2022', 'HTTPS');

INSERT INTO paginasWeb (idContenidosInteractivos, idClasificaciones, url, visitasMensuales, fechaCreacion, descripcion, politicasPrivacidad, protocolo)
VALUES (10, 10, 'https://www.culturavirtual.com', 55000, TO_DATE('2019-04-10', 'YYYY-MM-DD'), 'Página de contenido cultural', 'Política de privacidad 2021', 'HTTP');


-- Poblaci�n de la tabla normas
INSERT INTO normas (id, idLeyes, descripcion, fechaModificacion, vigencia, alcance)
VALUES (1, 1, 'Regulaci�n de contenido infantil', TO_DATE('2023-02-25', 'YYYY-MM-DD'), 'Indefinida', 'Nacional');

INSERT INTO normas (id, idLeyes, descripcion, fechaModificacion, vigencia, alcance)
VALUES (2, 2, 'Protección de datos personales', TO_DATE('2022-05-15', 'YYYY-MM-DD'), 'Indefinida', 'Internacional');

INSERT INTO normas (id, idLeyes, descripcion, fechaModificacion, vigencia, alcance)
VALUES (3, 3, 'Regulación de comercio electrónico', TO_DATE('2021-08-10', 'YYYY-MM-DD'), 'Indefinida', 'Nacional');

INSERT INTO normas (id, idLeyes, descripcion, fechaModificacion, vigencia, alcance)
VALUES (4, 4, 'Derechos de autor en medios digitales', TO_DATE('2020-11-20', 'YYYY-MM-DD'), 'Indefinida', 'Internacional');

INSERT INTO normas (id, idLeyes, descripcion, fechaModificacion, vigencia, alcance)
VALUES (5, 5, 'Transparencia en instituciones públicas', TO_DATE('2019-03-05', 'YYYY-MM-DD'), 'Indefinida', 'Nacional');

INSERT INTO normas (id, idLeyes, descripcion, fechaModificacion, vigencia, alcance)
VALUES (6, 6, 'Protección ambiental en empresas', TO_DATE('2018-07-25', 'YYYY-MM-DD'), 'Indefinida', 'Nacional');

INSERT INTO normas (id, idLeyes, descripcion, fechaModificacion, vigencia, alcance)
VALUES (7, 7, 'Seguridad en línea para usuarios', TO_DATE('2017-10-15', 'YYYY-MM-DD'), 'Indefinida', 'Internacional');

INSERT INTO normas (id, idLeyes, descripcion, fechaModificacion, vigencia, alcance)
VALUES (8, 8, 'Regulación de contenido digital', TO_DATE('2016-12-30', 'YYYY-MM-DD'), 'Indefinida', 'Nacional');

INSERT INTO normas (id, idLeyes, descripcion, fechaModificacion, vigencia, alcance)
VALUES (9, 9, 'Protección infantil en plataformas digitales', TO_DATE('2015-05-10', 'YYYY-MM-DD'), 'Indefinida', 'Internacional');

INSERT INTO normas (id, idLeyes, descripcion, fechaModificacion, vigencia, alcance)
VALUES (10, 10, 'Protección de datos personales', TO_DATE('2014-09-20', 'YYYY-MM-DD'), 'Indefinida', 'Nacional');

-- Poblaci�n de la tabla verificaciones
INSERT INTO verificaciones (id, metodo, fechaVerificacion, estadoVerificacion)
VALUES (1, 'Documento Identidad', TO_DATE('2023-05-10', 'YYYY-MM-DD'), 'Completado');

INSERT INTO verificaciones (id, metodo, fechaVerificacion, estadoVerificacion)
VALUES (2, 'Correo Electrónico', TO_DATE('2023-04-15', 'YYYY-MM-DD'), 'Completado');

INSERT INTO verificaciones (id, metodo, fechaVerificacion, estadoVerificacion)
VALUES (3, 'Teléfono', TO_DATE('2023-03-20', 'YYYY-MM-DD'), 'Pendiente');

INSERT INTO verificaciones (id, metodo, fechaVerificacion, estadoVerificacion)
VALUES (4, 'Dirección', TO_DATE('2023-02-25', 'YYYY-MM-DD'), 'Completado');

INSERT INTO verificaciones (id, metodo, fechaVerificacion, estadoVerificacion)
VALUES (5, 'Documento Identidad', TO_DATE('2023-01-30', 'YYYY-MM-DD'), 'Pendiente');

INSERT INTO verificaciones (id, metodo, fechaVerificacion, estadoVerificacion)
VALUES (6, 'Correo Electrónico', TO_DATE('2022-12-15', 'YYYY-MM-DD'), 'Completado');

INSERT INTO verificaciones (id, metodo, fechaVerificacion, estadoVerificacion)
VALUES (7, 'Teléfono', TO_DATE('2022-11-10', 'YYYY-MM-DD'), 'Completado');

INSERT INTO verificaciones (id, metodo, fechaVerificacion, estadoVerificacion)
VALUES (8, 'Dirección', TO_DATE('2022-10-05', 'YYYY-MM-DD'), 'Pendiente');

INSERT INTO verificaciones (id, metodo, fechaVerificacion, estadoVerificacion)
VALUES (9, 'Documento Identidad', TO_DATE('2022-09-20', 'YYYY-MM-DD'), 'Completado');

INSERT INTO verificaciones (id, metodo, fechaVerificacion, estadoVerificacion)
VALUES (10, 'Correo Electrónico', TO_DATE('2022-08-15', 'YYYY-MM-DD'), 'Pendiente');

-- Poblaci�n de la tabla perfiles
INSERT INTO perfiles (id, idVerificaciones, nombreUsuario, fechaEdad, fechaRegistro, nivelAcceso, paisOrigen, rol)
VALUES (1, 1, 'usuario123', TO_DATE('2005-08-15', 'YYYY-MM-DD'), TO_DATE('2023-01-10', 'YYYY-MM-DD'), 'user', 'Espa�a', 'Acudiente');

INSERT INTO perfiles (id, idVerificaciones, nombreUsuario, fechaEdad, fechaRegistro, nivelAcceso, paisOrigen, rol)
VALUES (2, 2, 'usuario456', TO_DATE('1998-12-05', 'YYYY-MM-DD'), TO_DATE('2023-02-15', 'YYYY-MM-DD'), 'admin', 'México', 'Profesor');

INSERT INTO perfiles (id, idVerificaciones, nombreUsuario, fechaEdad, fechaRegistro, nivelAcceso, paisOrigen, rol)
VALUES (3, 3, 'usuario789', TO_DATE('2000-07-20', 'YYYY-MM-DD'), TO_DATE('2023-03-20', 'YYYY-MM-DD'), 'user', 'Argentina', 'Acudiente');

INSERT INTO perfiles (id, idVerificaciones, nombreUsuario, fechaEdad, fechaRegistro, nivelAcceso, paisOrigen, rol)
VALUES (4, 4, 'usuario101', TO_DATE('1995-05-10', 'YYYY-MM-DD'), TO_DATE('2023-04-25', 'YYYY-MM-DD'), 'guest', 'Chile', 'Profesor');

INSERT INTO perfiles (id, idVerificaciones, nombreUsuario, fechaEdad, fechaRegistro, nivelAcceso, paisOrigen, rol)
VALUES (5, 5, 'usuario202', TO_DATE('2003-11-30', 'YYYY-MM-DD'), TO_DATE('2023-05-05', 'YYYY-MM-DD'), 'user', 'Colombia', 'Acudiente');

INSERT INTO perfiles (id, idVerificaciones, nombreUsuario, fechaEdad, fechaRegistro, nivelAcceso, paisOrigen, rol)
VALUES (6, 6, 'usuario303', TO_DATE('1992-03-15', 'YYYY-MM-DD'), TO_DATE('2023-06-10', 'YYYY-MM-DD'), 'admin', 'Perú', 'Profesor');

INSERT INTO perfiles (id, idVerificaciones, nombreUsuario, fechaEdad, fechaRegistro, nivelAcceso, paisOrigen, rol)
VALUES (7, 7, 'usuario404', TO_DATE('2001-09-25', 'YYYY-MM-DD'), TO_DATE('2023-07-15', 'YYYY-MM-DD'), 'user', 'Uruguay', 'Acudiente');

INSERT INTO perfiles (id, idVerificaciones, nombreUsuario, fechaEdad, fechaRegistro, nivelAcceso, paisOrigen, rol)
VALUES (8, 8, 'usuario505', TO_DATE('1990-01-10', 'YYYY-MM-DD'), TO_DATE('2023-08-20', 'YYYY-MM-DD'), 'guest', 'Paraguay', 'Profesor');

INSERT INTO perfiles (id, idVerificaciones, nombreUsuario, fechaEdad, fechaRegistro, nivelAcceso, paisOrigen, rol)
VALUES (9, 9, 'usuario606', TO_DATE('2004-06-05', 'YYYY-MM-DD'), TO_DATE('2023-09-25', 'YYYY-MM-DD'), 'user', 'Bolivia', 'Acudiente');

INSERT INTO perfiles (id, idVerificaciones, nombreUsuario, fechaEdad, fechaRegistro, nivelAcceso, paisOrigen, rol)
VALUES (10, 10, 'usuario707', TO_DATE('1997-04-20', 'YYYY-MM-DD'), TO_DATE('2023-10-30', 'YYYY-MM-DD'), 'admin', 'Venezuela', 'Profesor');



-- Poblaci�n de la tabla tutores
INSERT INTO tutores (id, idResponsablesLegales, idPerfil, nombre, responsabilidad, correo, numeroTelefono, documentoIdentidad, direccion)
VALUES (1, 1, 1, 'Marta P�rez', 'Tutora Legal', 'marta.perez@email.com', 123456789, 987654321, 'Calle Principal 123');

INSERT INTO tutores (id, idResponsablesLegales, idPerfil, nombre, responsabilidad, correo, numeroTelefono, documentoIdentidad, direccion)
VALUES (2, 2, 2, 'Juan López', 'Tutor Legal', 'juan.lopez@email.com', 234567890, 876543210, 'Avenida Secundaria 456');

INSERT INTO tutores (id, idResponsablesLegales, idPerfil, nombre, responsabilidad, correo, numeroTelefono, documentoIdentidad, direccion)
VALUES (3, 3, 3, 'Ana García', 'Tutora Legal', 'ana.garcia@email.com', 345678901, 765432109, 'Calle Tercera 789');

INSERT INTO tutores (id, idResponsablesLegales, idPerfil, nombre, responsabilidad, correo, numeroTelefono, documentoIdentidad, direccion)
VALUES (4, 4, 1, 'Luis Martínez', 'Tutor Legal', 'luis.martinez@email.com', 456789012, 654321098, 'Avenida Cuarta 101');

INSERT INTO tutores (id, idResponsablesLegales, idPerfil, nombre, responsabilidad, correo, numeroTelefono, documentoIdentidad, direccion)
VALUES (5, 5, 5, 'Elena Fernández', 'Tutora Legal', 'elena.fernandez@email.com', 567890123, 543210987, 'Calle Quinta 202');

INSERT INTO tutores (id, idResponsablesLegales, idPerfil, nombre, responsabilidad, correo, numeroTelefono, documentoIdentidad, direccion)
VALUES (6, 6, 6, 'Carlos Sánchez', 'Tutor Legal', 'carlos.sanchez@email.com', 678901234, 432109876, 'Avenida Sexta 303');

INSERT INTO tutores (id, idResponsablesLegales, idPerfil, nombre, responsabilidad, correo, numeroTelefono, documentoIdentidad, direccion)
VALUES (7, 7, 7, 'Laura Gómez', 'Tutora Legal', 'laura.gomez@email.com', 789012345, 321098765, 'Calle Séptima 404');

INSERT INTO tutores (id, idResponsablesLegales, idPerfil, nombre, responsabilidad, correo, numeroTelefono, documentoIdentidad, direccion)
VALUES (8, 8, 8, 'Pedro Rodríguez', 'Tutor Legal', 'pedro.rodriguez@email.com', 890123456, 210987654, 'Avenida Octava 505');

INSERT INTO tutores (id, idResponsablesLegales, idPerfil, nombre, responsabilidad, correo, numeroTelefono, documentoIdentidad, direccion)
VALUES (9, 9, 9, 'Sofía Torres', 'Tutora Legal', 'sofia.torres@email.com', 901234567, 109876543, 'Calle Novena 606');

INSERT INTO tutores (id, idResponsablesLegales, idPerfil, nombre, responsabilidad, correo, numeroTelefono, documentoIdentidad, direccion)
VALUES (10, 10, 10, 'Miguel Díaz', 'Tutor Legal', 'miguel.diaz@email.com', 123456789, 987654321, 'Avenida Décima 707');

-- Poblaci�n de la tabla streamings
INSERT INTO streamings (idContenidosVisuales, id, plataforma, requiereRegistro, calidad, duracionHoras)
VALUES (1, 1, 'PlataformaX', 1, 'HD', 2);

INSERT INTO streamings (idContenidosVisuales, id, plataforma, requiereRegistro, calidad, duracionHoras)
VALUES (1, 2, 'PlataformaY', 0, 'HD', 1.5);

INSERT INTO streamings (idContenidosVisuales, id, plataforma, requiereRegistro, calidad, duracionHoras)
VALUES (1, 3, 'PlataformaZ', 1, '4K', 3);

INSERT INTO streamings (idContenidosVisuales, id, plataforma, requiereRegistro, calidad, duracionHoras)
VALUES (1, 4, 'PlataformaA', 0, 'HD', 2.5);

INSERT INTO streamings (idContenidosVisuales, id, plataforma, requiereRegistro, calidad, duracionHoras)
VALUES (1, 5, 'PlataformaB', 1, 'HD', 1);

INSERT INTO streamings (idContenidosVisuales, id, plataforma, requiereRegistro, calidad, duracionHoras)
VALUES (1, 6, 'PlataformaC', 0, '4K', 2);

INSERT INTO streamings (idContenidosVisuales, id, plataforma, requiereRegistro, calidad, duracionHoras)
VALUES (1, 7, 'PlataformaD', 1, 'HD', 1.5);

INSERT INTO streamings (idContenidosVisuales, id, plataforma, requiereRegistro, calidad, duracionHoras)
VALUES (1, 8, 'PlataformaE', 0, 'HD', 2);

INSERT INTO streamings (idContenidosVisuales, id, plataforma, requiereRegistro, calidad, duracionHoras)
VALUES (1, 9, 'PlataformaF', 1, '4K', 3.5);

INSERT INTO streamings (idContenidosVisuales, id, plataforma, requiereRegistro, calidad, duracionHoras)
VALUES (1, 10, 'PlataformaG', 0, 'HD', 1);

-- Poblaci�n de la tabla canalesTelevisivos
INSERT INTO canalesTelevisivos (idContenidosVisuales, nombreCanal, generoCanal, audienciaObjetivo, frecuencia)
VALUES (1, 'Canal Educativo', 'Educaci�n', 'Ni�os', 'Diaria');

INSERT INTO canalesTelevisivos (idContenidosVisuales, nombreCanal, generoCanal, audienciaObjetivo, frecuencia)
VALUES (2, 'Canal de Deportes', 'Deportes', 'Adultos', 'Semanal');

INSERT INTO canalesTelevisivos (idContenidosVisuales, nombreCanal, generoCanal, audienciaObjetivo, frecuencia)
VALUES (3, 'Canal de Noticias', 'Noticias', 'General', 'Diaria');

INSERT INTO canalesTelevisivos (idContenidosVisuales, nombreCanal, generoCanal, audienciaObjetivo, frecuencia)
VALUES (4, 'Canal de Música', 'Música', 'Jóvenes', 'Diaria');

INSERT INTO canalesTelevisivos (idContenidosVisuales, nombreCanal, generoCanal, audienciaObjetivo, frecuencia)
VALUES (5, 'Canal de Cine', 'Cine', 'General', 'Semanal');

INSERT INTO canalesTelevisivos (idContenidosVisuales, nombreCanal, generoCanal, audienciaObjetivo, frecuencia)
VALUES (6, 'Canal de Documentales', 'Documentales', 'Adultos', 'Diaria');

INSERT INTO canalesTelevisivos (idContenidosVisuales, nombreCanal, generoCanal, audienciaObjetivo, frecuencia)
VALUES (7, 'Canal Infantil', 'Infantil', 'Niños', 'Diaria');

INSERT INTO canalesTelevisivos (idContenidosVisuales, nombreCanal, generoCanal, audienciaObjetivo, frecuencia)
VALUES (8, 'Canal de Cocina', 'Cocina', 'General', 'Semanal');

INSERT INTO canalesTelevisivos (idContenidosVisuales, nombreCanal, generoCanal, audienciaObjetivo, frecuencia)
VALUES (9, 'Canal de Viajes', 'Viajes', 'Adultos', 'Diaria');

INSERT INTO canalesTelevisivos (idContenidosVisuales, nombreCanal, generoCanal, audienciaObjetivo, frecuencia)
VALUES (10, 'Canal de Tecnología', 'Tecnología', 'Jóvenes', 'Semanal');

-- Poblaci�n de la tabla bienestarDigitales
INSERT INTO bienestarDigitales (id, idContenidosVisuales, plataformas, politicasAsociadas, fechaImplementacio)
VALUES (1, 1, 'PlataformaX', 'Pol�tica de Bienestar 2023', TO_DATE('2023-06-01', 'YYYY-MM-DD'));

INSERT INTO bienestarDigitales (id, idContenidosVisuales, plataformas, politicasAsociadas, fechaImplementacio)
VALUES (2, 2, 'PlataformaY', 'Política de Bienestar 2022', TO_DATE('2022-05-15', 'YYYY-MM-DD'));

INSERT INTO bienestarDigitales (id, idContenidosVisuales, plataformas, politicasAsociadas, fechaImplementacio)
VALUES (3, 3, 'PlataformaZ', 'Política de Bienestar 2021', TO_DATE('2021-04-10', 'YYYY-MM-DD'));

INSERT INTO bienestarDigitales (id, idContenidosVisuales, plataformas, politicasAsociadas, fechaImplementacio)
VALUES (4, 4, 'PlataformaA', 'Política de Bienestar 2020', TO_DATE('2020-03-05', 'YYYY-MM-DD'));

INSERT INTO bienestarDigitales (id, idContenidosVisuales, plataformas, politicasAsociadas, fechaImplementacio)
VALUES (5, 5, 'PlataformaB', 'Política de Bienestar 2019', TO_DATE('2019-02-20', 'YYYY-MM-DD'));

INSERT INTO bienestarDigitales (id, idContenidosVisuales, plataformas, politicasAsociadas, fechaImplementacio)
VALUES (6, 6, 'PlataformaC', 'Política de Bienestar 2018', TO_DATE('2018-01-15', 'YYYY-MM-DD'));

INSERT INTO bienestarDigitales (id, idContenidosVisuales, plataformas, politicasAsociadas, fechaImplementacio)
VALUES (7, 7, 'PlataformaD', 'Política de Bienestar 2017', TO_DATE('2017-12-10', 'YYYY-MM-DD'));

INSERT INTO bienestarDigitales (id, idContenidosVisuales, plataformas, politicasAsociadas, fechaImplementacio)
VALUES (8, 8, 'PlataformaE', 'Política de Bienestar 2016', TO_DATE('2016-11-05', 'YYYY-MM-DD'));

INSERT INTO bienestarDigitales (id, idContenidosVisuales, plataformas, politicasAsociadas, fechaImplementacio)
VALUES (9, 9, 'PlataformaF', 'Política de Bienestar 2015', TO_DATE('2015-10-01', 'YYYY-MM-DD'));

INSERT INTO bienestarDigitales (id, idContenidosVisuales, plataformas, politicasAsociadas, fechaImplementacio)
VALUES (10, 10, 'PlataformaG', 'Política de Bienestar 2014', TO_DATE('2014-09-15', 'YYYY-MM-DD'));

-- Poblaci�n de la tabla bloqueos
INSERT INTO bloqueos (id, idBienestarDigitales, metodo, fechaBloqueo, motivo, duracionDias)
VALUES (1, 1, 'Control Parental', TO_DATE('2023-07-20', 'YYYY-MM-DD'), 'Uso excesivo', 7);

INSERT INTO bloqueos (id, idBienestarDigitales, metodo, fechaBloqueo, motivo, duracionDias)
VALUES (2, 2, 'Control Parental', TO_DATE('2023-06-15', 'YYYY-MM-DD'), 'Contenido inapropiado', 14);

INSERT INTO bloqueos (id, idBienestarDigitales, metodo, fechaBloqueo, motivo, duracionDias)
VALUES (3, 3, 'Control Parental', TO_DATE('2023-05-10', 'YYYY-MM-DD'), 'Violación de políticas', 30);

INSERT INTO bloqueos (id, idBienestarDigitales, metodo, fechaBloqueo, motivo, duracionDias)
VALUES (4, 4, 'Control Parental', TO_DATE('2023-04-05', 'YYYY-MM-DD'), 'Uso excesivo', 7);

INSERT INTO bloqueos (id, idBienestarDigitales, metodo, fechaBloqueo, motivo, duracionDias)
VALUES (5, 5, 'Control Parental', TO_DATE('2023-03-01', 'YYYY-MM-DD'), 'Contenido inapropiado', 14);

INSERT INTO bloqueos (id, idBienestarDigitales, metodo, fechaBloqueo, motivo, duracionDias)
VALUES (6, 6, 'Control Parental', TO_DATE('2023-02-20', 'YYYY-MM-DD'), 'Violación de políticas', 30);

INSERT INTO bloqueos (id, idBienestarDigitales, metodo, fechaBloqueo, motivo, duracionDias)
VALUES (7, 7, 'Control Parental', TO_DATE('2023-01-15', 'YYYY-MM-DD'), 'Uso excesivo', 7);

INSERT INTO bloqueos (id, idBienestarDigitales, metodo, fechaBloqueo, motivo, duracionDias)
VALUES (8, 8, 'Control Parental', TO_DATE('2022-12-10', 'YYYY-MM-DD'), 'Contenido inapropiado', 14);

INSERT INTO bloqueos (id, idBienestarDigitales, metodo, fechaBloqueo, motivo, duracionDias)
VALUES (9, 9, 'Control Parental', TO_DATE('2022-11-05', 'YYYY-MM-DD'), 'Violación de políticas', 30);

INSERT INTO bloqueos (id, idBienestarDigitales, metodo, fechaBloqueo, motivo, duracionDias)
VALUES (10, 10, 'Control Parental', TO_DATE('2022-10-01', 'YYYY-MM-DD'), 'Uso excesivo', 7);

-- Poblaci�n de la tabla categorias
INSERT INTO categorias (idContenidosVisuales, categoria)
VALUES (1, 'Educativo');

INSERT INTO categorias (idContenidosVisuales, categoria)
VALUES (2, 'Deportes');

INSERT INTO categorias (idContenidosVisuales, categoria)
VALUES (3, 'Noticias');

INSERT INTO categorias (idContenidosVisuales, categoria)
VALUES (4, 'Música');

INSERT INTO categorias (idContenidosVisuales, categoria)
VALUES (5, 'Cine');

INSERT INTO categorias (idContenidosVisuales, categoria)
VALUES (6, 'Documentales');

INSERT INTO categorias (idContenidosVisuales, categoria)
VALUES (7, 'Infantil');

INSERT INTO categorias (idContenidosVisuales, categoria)
VALUES (8, 'Cocina');

INSERT INTO categorias (idContenidosVisuales, categoria)
VALUES (9, 'Viajes');

INSERT INTO categorias (idContenidosVisuales, categoria)
VALUES (10, 'Tecnología');

/* PoblarNoOK */

-- Intento de ingreso de datos erróneos
/*
-- 1. Clave primaria duplicada
INSERT INTO responsablesLegales (id, idContenidosVisuales, idContenidosInteractivos, idLeyes, nombre, relacion) 
VALUES (1, 1, 1, 1, 'Juan Pérez', 'Padre'); -- Esto fallará porque la combinación (1, 1, 1, 1) ya existe.

-- 2. Violación de clave foránea
INSERT INTO tutores (id, idResponsablesLegales, idPerfil, nombre, responsabilidad, correo, numeroTelefono, documentoIdentidad, direccion) 
VALUES (1, 999, 1, 'Tutor A', 'Responsable', 'tutor@example.com', 123456789, 12345678, 'Dirección A'); -- idResponsablesLegales=999 no existe.

-- 3. Violación de restricción UNIQUE
INSERT INTO perfiles (id, idVerificaciones, nombreUsuario, fechaEdad, fechaRegistro, nivelAcceso, paisOrigen, rol) 
VALUES (2, 1, 'usuario1', TO_DATE('2000-01-01', 'YYYY-MM-DD'), TO_DATE('2024-01-01', 'YYYY-MM-DD'), 'User', 'Chile', 'Usuario'); -- nombreUsuario ya existe.

-- 4. Inserción de NULL en una columna que no permite valores NULL
INSERT INTO contenidosVisuales (id, idResponsablesLegales, idContenidosInteractivos, idLeyes, subtitulos, productora) 
VALUES (2, NULL, 1, 1, 1, 'Productora XYZ'); -- idResponsablesLegales es NULL pero no puede serlo.

-- 5. Clave foránea faltante
INSERT INTO bloqueos (id, idBienestarDigitales, metodo, fechaBloqueo, motivo, duracionDias) 
VALUES (2, 999, 'Bloqueo Permanente', TO_DATE('2024-01-01', 'YYYY-MM-DD'), 'Razón del bloqueo', 10); -- idBienestarDigitales=999 no existe.

-- 6. Violación de restricción CHECK
INSERT INTO contenidosInteractivos (id, nivelInteraccion, accesibilidad, plataformasCompatibles, popularidad)
VALUES (3, 'Muy Alta', 1, 'Windows, Mac, Linux', 85); -- 'Muy Alta' no es un valor permitido por la restricción CHECK en nivelInteraccion.

-- 7. Violación de restricción NOT NULL
INSERT INTO paginasWeb (idContenidosInteractivos, idClasificaciones, url, visitasMensuales, fechaCreacion, descripcion, politicasPrivacidad, protocolo)
VALUES (1, 1, NULL, 50000, TO_DATE('2020-10-10', 'YYYY-MM-DD'), 'Página de educación infantil', 'Política de privacidad 2023', 'HTTPS'); -- url es NULL pero no puede serlo.

-- 8. Violación de restricción de longitud de cadena
INSERT INTO perfiles (id, idVerificaciones, nombreUsuario, fechaEdad, fechaRegistro, nivelAcceso, paisOrigen, rol)
VALUES (3, 1, 'usuario_con_un_nombre_demasiado_largo_para_la_columna', TO_DATE('2000-01-01', 'YYYY-MM-DD'), TO_DATE('2024-01-01', 'YYYY-MM-DD'), 'User', 'Chile', 'Usuario'); -- nombreUsuario excede la longitud permitida.

-- 9. Violación de restricción de tipo de datos
INSERT INTO verificaciones (id, metodo, fechaVerificacion, estadoVerificacion)
VALUES (1, 'Documento Identidad', 'Fecha Incorrecta', 'Completado'); -- 'Fecha Incorrecta' no es un valor válido para la columna fechaVerificacion que espera un tipo de dato DATE.

-- 10. Violación de restricción de valor único
INSERT INTO leyes (id, nombre, fechaPublicacion, autoridadFiscal, entidades, sancion)
VALUES (1, 'Ley de Protección de Datos', TO_DATE('2018-05-25', 'YYYY-MM-DD'), 'Gobierno', 'Usuarios, Empresas', 2); -- id=1 ya existe.

*/

/* XPoblar */
/*
DELETE FROM bloqueos;

DELETE FROM bienestarDigitales;

DELETE FROM canalesTelevisivos;

DELETE FROM streamings;

DELETE FROM categorias;

DELETE FROM paginasWeb;

DELETE FROM videojuegos;

DELETE FROM contenidosInteractivos;

DELETE FROM contenidosVisuales;

DELETE FROM tutores; 

DELETE FROM responsablesLegales;

DELETE FROM perfiles;

DELETE FROM verificaciones;

DELETE FROM normas;

DELETE FROM clasificaciones;

DELETE FROM leyes;
*/

/* CONSULTAS SELECT 
No aparecen en lo definido en el proyecto, sin embargo sirve para verificar si los datos fueron bien ingresados 

SELECT * FROM bienestarDigitales;
SELECT * FROM bloqueos;
SELECT * FROM canalesTelevisivos;
SELECT * FROM categorias;
SELECT * FROM clasificaciones;
SELECT * FROM contenidosInteractivos;
SELECT * FROM contenidosVisuales;
SELECT * FROM leyes;
SELECT * FROM normas;
SELECT * FROM paginasWeb;
SELECT * FROM perfiles;
SELECT * FROM responsablesLegales;
SELECT * FROM streamings;
SELECT * FROM tutores;
SELECT * FROM videojuegos;
SELECT * FROM verificaciones;
*/

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



