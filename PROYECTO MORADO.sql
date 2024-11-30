/*Eliminar todas las claves para poder crear los indices */
/* Eliminar claves foraneas */

ALTER TABLE tutores DROP CONSTRAINT FK_Tutores_ResponsablesLegales;
ALTER TABLE tutores DROP CONSTRAINT FK_Tutores_Perfil;
ALTER TABLE perfiles DROP CONSTRAINT FK_Perfiles_Verificaciones;
ALTER TABLE bienestarDigitales DROP CONSTRAINT FK_BienestarDigitales_ContenidosVisuales;
ALTER TABLE bloqueos DROP CONSTRAINT FK_Bloqueos_BienestarDigitales;
ALTER TABLE videojuegos DROP CONSTRAINT FK_Videojuegos_ContenidosInteractivos;
ALTER TABLE videojuegos DROP CONSTRAINT FK_Videojuegos_Clasificaciones;
ALTER TABLE paginasWeb DROP CONSTRAINT FK_PaginasWeb_ContenidosInteractivos;
ALTER TABLE paginasWeb DROP CONSTRAINT FK_PaginasWeb_Clasificaciones;
ALTER TABLE normas DROP CONSTRAINT FK_Normas_Leyes;

/* Eliminar claves primarias */
ALTER TABLE responsablesLegales DROP CONSTRAINT PK_ResponsablesLegales;
ALTER TABLE tutores DROP CONSTRAINT PK_Tutores;
ALTER TABLE perfiles DROP CONSTRAINT PK_Perfiles;
ALTER TABLE verificaciones DROP CONSTRAINT PK_Verificaciones;
ALTER TABLE contenidosVisuales DROP CONSTRAINT PK_ContenidosVisuales;
ALTER TABLE categorias DROP CONSTRAINT PK_Categorias;
ALTER TABLE streamings DROP CONSTRAINT PK_Streamings;
ALTER TABLE canalesTelevisivos DROP CONSTRAINT PK_CanalesTelevisivos;
ALTER TABLE bienestarDigitales DROP CONSTRAINT PK_BienestarDigitales;
ALTER TABLE bloqueos DROP CONSTRAINT PK_Bloqueos;
ALTER TABLE contenidosInteractivos DROP CONSTRAINT PK_ContenidosInteractivos;
ALTER TABLE videojuegos DROP CONSTRAINT PK_Videojuegos;
ALTER TABLE paginasWeb DROP CONSTRAINT PK_PaginasWeb;
ALTER TABLE clasificaciones DROP CONSTRAINT PK_Clasificaciones;
ALTER TABLE leyes DROP CONSTRAINT PK_Leyes;
ALTER TABLE normas DROP CONSTRAINT PK_Normas;

--indices
CREATE INDEX id_responsablesLegales
ON responsablesLegales(
    id
);
CREATE INDEX id_tutores
ON tutores(
    id
);
CREATE INDEX id_perfiles
ON perfiles(
    id
);
CREATE INDEX id_verificaciones
ON verificaciones(
    id
);
CREATE INDEX id_contenidosVisuales
ON contenidosVisuales(
    id
);
CREATE INDEX id_categorias
ON categorias(
    idContenidosVisuales
);
CREATE INDEX categorias
ON categorias(
    categoria
);
CREATE INDEX id_streamings
ON streamings(
    idContenidosVisuales
);
CREATE INDEX id_canalesTelevisivos
ON canalesTelevisivos(
    idContenidosVisuales
);
CREATE INDEX id_bienestarDigitales
ON bienestarDigitales(
    id
);
CREATE INDEX id_bloqueos
ON bloqueos(
    id
);
CREATE INDEX id_contenidosInteractivos
ON contenidosInteractivos(
    id
);
CREATE INDEX id_videojuegos
ON videojuegos(
    idContenidosInteractivos
);
CREATE INDEX id_paginasWeb
ON paginasWeb(
    idContenidosInteractivos
);
CREATE INDEX id_clasificaciones
ON clasificaciones(
    id
);
CREATE INDEX id_leyes
ON leyes(
    id
);
CREATE INDEX id_normas
ON normas(
    id
);
--vistas

CREATE VIEW vLeyesVigentes AS
SELECT 
    id,
    nombre,
    fechaPublicacion,
    autoridadFiscal,
    entidades,
    sancion
FROM leyes
WHERE sancion = 1; -- Supongo que "sancion = 1" indica que la ley está vigente.

CREATE VIEW vNormasVigentes AS
SELECT 
    n.id,
    n.descripcion,
    n.fechaModificacion,
    n.vigencia,
    n.alcance
FROM normas n
INNER JOIN leyes l ON n.idLeyes = l.id
WHERE n.vigencia = 'Vigente'; -- Condición basada en el atributo de vigencia.

CREATE VIEW vContenidoInfantil AS
SELECT 
    cv.audienciaObjetiva,
    s.plataforma,
    cv.generoCanal
FROM canalesTelevisivos cv
LEFT JOIN streamings s ON cv.idContenidosVisuales = s.idContenidosVisuales
WHERE cv.generoCanal = 'Infantil'; -- Filtro para contenido educativo.



CREATE VIEW vContenidoEducativo AS
SELECT 
    cv.audienciaObjetiva,
    s.plataforma,
    cv.generoCanal
FROM canalesTelevisivos cv
LEFT JOIN streamings s ON cv.idContenidosVisuales = s.idContenidosVisuales
WHERE cv.generoCanal = 'Educativo'; -- Filtro para contenido educativo.

CREATE VIEW vContenidoAdecuado AS
SELECT 
    cv.id AS idContenidosVisuales,
    ci.id AS idContenidosInteractivos
FROM contenidosVisuales cv
JOIN contenidosInteractivos ci ON cv.id = ci.id
WHERE 
    cv.subtitulos = 1 -- Contenido visual con subtítulos.
    AND ci.accesibilidad = 1; -- Contenido interactivo accesible.

CREATE VIEW vContenidoReportado AS
SELECT 
    b.id,
    b.metodo,
    b.fechaBloqueo,
    b.duracionDias
FROM bloqueos b
WHERE b.duracionDias > 0; -- Filtra contenido con duración válida en el bloqueo.


CREATE VIEW vClasificacionContenido AS
SELECT 
    id,
    nombreClasificacion,
    criterios,
    organizacionReguladora,
    fechaEmision
FROM Clasificaciones
WHERE organizacionReguladora = 'EjemploOrg'; -- Filtra por una organización reguladora específica.

CREATE VIEW vPerfilesVigentes AS
SELECT 
    id,
    fechaEdad,
    nombreUsuario,
    fechaRegistro,
    nivelAcceso,
    paisOrigen,
    rol
FROM Perfiles
WHERE fechaEdad IS NULL OR fechaEdad >= CURRENT_DATE;

CREATE VIEW vResponsablesLegalesVigentes AS
SELECT 
    id,
    nombre,
    relacion
FROM ResponsablesLegales
WHERE relacion = 'Activo'; -- Filtra responsables legales con relación activa.
--XindicesVistas
--indices 
DROP INDEX id_responsablesLegales;
DROP INDEX id_tutores;
DROP INDEX id_perfiles;
DROP INDEX id_verificaciones;
DROP INDEX id_contenidosVisuales;
DROP INDEX id_categorias;
DROP INDEX categorias;
DROP INDEX id_streamings;
DROP INDEX id_canalesTelevisivos;
DROP INDEX id_bienestarDigitales;
DROP INDEX id_bloqueos;
DROP INDEX id_contenidosInteractivos;
DROP INDEX id_videojuegos;
DROP INDEX id_paginasWeb;
DROP INDEX id_clasificaciones;
DROP INDEX id_leyes;
DROP INDEX id_normas;
--vistas
DROP VIEW vLeyesVigentes;
DROP VIEW vNormasVigentes;
DROP VIEW vContenidoInfantil;
DROP VIEW vContenidoEducativo;
DROP VIEW vContenidoAdecuado;
DROP VIEW vContenidoReportado;
DROP VIEW vClasificacionContenido;
DROP VIEW vPerfilesVigentes;
DROP VIEW vResponsablesLegalesVigentes;
--indicesVistasOk
-- Consulta 1: Selecciona los campos de la tabla 'ResponsablesLegales' para el 'id' igual a 10
-- Utiliza el índice 'id_responsablesLegales' para optimizar la búsqueda por 'id'
SELECT id, nombre, relacion
FROM ResponsablesLegales
WHERE id = 10; -- Utiliza el índice 'id_responsablesLegales'


-- Consulta 2: Selecciona los campos de la tabla 'Perfiles' para el 'id' igual a 5
-- Utiliza el índice 'id_perfiles' para optimizar la búsqueda por 'id'
SELECT id, nombreUsuario, nivelAcceso
FROM Perfiles
WHERE id = 5; -- Utiliza el índice 'id_perfiles'


-- Consulta 3: Selecciona los campos de la vista 'vLeyesVigentes', que ya está filtrada por 'sancion = 1'
-- No requiere índices, ya que la vista ya aplica el filtro para leyes vigentes
SELECT id, nombre, fechaPublicacion, autoridadFiscal
FROM vLeyesVigentes;


-- Consulta 4: Selecciona los campos de la tabla 'Categorias' donde la categoría es 'Educativo'
-- Utiliza el índice 'categorias' para optimizar la búsqueda por 'categoria'
SELECT idContenidosVisuales, categoria
FROM Categorias
WHERE categoria = 'Educativo'; -- Utiliza el índice 'categorias'


-- Consulta 5: Realiza una unión entre 'canalesTelevisivos' y 'streamings' con filtro por 'generoCanal' igual a 'Infantil'
-- Utiliza el índice 'id_canalesTelevisivos' y 'id_streamings' para optimizar la búsqueda y la unión de tablas
SELECT cv.audienciaObjetiva, s.plataforma
FROM canalesTelevisivos cv
LEFT JOIN streamings s ON cv.idContenidosVisuales = s.idContenidosVisuales
WHERE cv.generoCanal = 'Infantil'; -- Utiliza los índices 'id_canalesTelevisivos' e 'id_streamings'


-- Consulta 6: Selecciona los campos de la vista 'vContenidoAdecuado', que ya filtra contenido con subtítulos y accesible
-- No requiere índices adicionales, ya que la vista ya realiza los filtros necesarios
SELECT idContenidosVisuales, idContenidosInteractivos
FROM vContenidoAdecuado;


-- Consulta 7: Selecciona los campos de la tabla 'bloqueos' para un 'id' igual a 100
-- Utiliza el índice 'id_bloqueos' para optimizar la búsqueda por 'id'
SELECT id, metodo, fechaBloqueo, duracionDias
FROM bloqueos
WHERE id = 100; -- Utiliza el índice 'id_bloqueos'


-- Consulta 8: Realiza una unión entre las vistas 'vLeyesVigentes' y 'vNormasVigentes' por el 'id' de la ley
-- Utiliza las vistas predefinidas, no requiere índices adicionales, ya que las vistas ya están filtradas
SELECT 
    l.id AS ley_id,
    l.nombre AS ley_nombre,
    n.id AS norma_id,
    n.descripcion AS norma_descripcion
FROM vLeyesVigentes l
INNER JOIN vNormasVigentes n ON l.id = n.idLeyes;
