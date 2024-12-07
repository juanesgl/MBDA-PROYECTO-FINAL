/*CREACIÓN DE PRUEBAS */
---------------------------HISTORIA DE ASTRID-------------------------

-- Astrid, una madre preocupada por el acceso de su hijo a contenidos inapropiados en internet, decide utilizar el sistema de gestión para supervisar y restringir el acceso a juegos y páginas web. A lo largo de esta historia, Astrid realizará varias acciones en el sistema, desde su registro inicial hasta la eliminación de su cuenta.

-- 1. Astrid se registra como madre en el sistema.
BEGIN
    PK_padresDeFamilia.adicionar(20, 'Astrid', 'Madre');
END;
/
-- Verificación de inserción: Astrid verifica que su registro se ha realizado correctamente.
DECLARE
    v_cursor SYS_REFCURSOR;
BEGIN
    v_cursor := PK_padresDeFamilia.consultar(20);
END;
/

-- 2. Astrid consulta la información de todos los padres de familia en el sistema para conocer la comunidad.
DECLARE
    v_cursor SYS_REFCURSOR;
BEGIN
    v_cursor := PK_padresDeFamilia.consultar;
END;
/

-- 3. Astrid consulta su propia información en el sistema para asegurarse de que todo esté correcto.
DECLARE
    v_cursor SYS_REFCURSOR;
BEGIN
    v_cursor := PK_padresDeFamilia.consultar(20);
END;
/

-- 4. Astrid decide actualizar su información personal en el sistema.
BEGIN
    PK_padresDeFamilia.modificar(20, 'Astrid María', 'Madre');
END;
/
-- Verificación de modificación: Astrid verifica que los cambios se han realizado correctamente.
DECLARE
    v_cursor SYS_REFCURSOR;
BEGIN
    v_cursor := PK_padresDeFamilia.consultar(20);
END;
/

-- 5. Astrid consulta de nuevo su información para verificar los cambios.
DECLARE
    v_cursor SYS_REFCURSOR;
BEGIN
    v_cursor := PK_padresDeFamilia.consultar(20);
END;
/

-- 6. Astrid configura restricciones para el contenido adecuado según la edad de su hijo.
DECLARE
    v_cursor SYS_REFCURSOR;
BEGIN
    v_cursor := PK_INFANTES.contenidoAdecuado(10); -- Suponiendo que su hijo tiene 10 años.
END;
/

-- 7. Astrid consulta los contenidos reportados por entidades gubernamentales para estar informada sobre posibles riesgos.
DECLARE
    v_cursor SYS_REFCURSOR;
BEGIN
    v_cursor := PK_entidadesGubernamentales.contenidoReportado;
END;
/

-- 8. Tras un tiempo, Astrid decide que ya no necesita estar registrada en el sistema y procede a eliminar su cuenta.
BEGIN
    PK_padresDeFamilia.eliminar(20);
END;
/
-- Verificación de eliminación: Astrid consulta de nuevo para asegurarse de que su registro ha sido eliminado.
DECLARE
    v_cursor SYS_REFCURSOR;
BEGIN
    v_cursor := PK_padresDeFamilia.consultar(20);
END;
/
--Prueba 2
--Luis, un padre preocupado por el tiempo que su hija pasa jugando videojuegos, decide usar el sistema de gestión para establecer límites en el tiempo de uso y verificar su cumplimiento. En esta historia, Luis realizará varias acciones en el sistema, desde su registro inicial hasta la eliminación de su cuenta.
--1. Luis se registra como padre en el sistema.
BEGIN  
    PK_padresDeFamilia.adicionar(30, 'Luis', 'Padre');  
END;  
/  
--Luis verifica que su registro se ha realizado correctamente.
DECLARE  
    v_cursor SYS_REFCURSOR;  
BEGIN  
    v_cursor := PK_padresDeFamilia.consultar(30);  
END;  
/  
--2. Luis consulta la información de todos los padres de familia en el sistema para conocer la comunidad.
DECLARE  
    v_cursor SYS_REFCURSOR;  
BEGIN  
    v_cursor := PK_padresDeFamilia.consultar;  
END;  
/  
--3. Luis consulta su propia información en el sistema para asegurarse de que todo esté correcto.
DECLARE  
    v_cursor SYS_REFCURSOR;  
BEGIN  
    v_cursor := PK_padresDeFamilia.consultar(30);  
END;  
/  
--4.  Luis decide actualizar su información personal en el sistema.
BEGIN  
    PK_padresDeFamilia.modificar(30, 'Luis Alberto', 'Padre');  
END;  
/  
--Luis verifica que los cambios se han realizado correctamente.
--5. Luis configura límites de tiempo de juego diario para su hija.
BEGIN  
    PK_INFANTES.limitarTiempoJuego(15, 2); -- Su hija tiene 15 años y puede jugar 2 horas al día.  
END;  
/  
--6. Luis consulta el cumplimiento de los límites establecidos para monitorear el tiempo de juego.
DECLARE  
    v_cursor SYS_REFCURSOR;  
BEGIN  
    v_cursor := PK_INFANTES.verCumplimientoLimites(15);  
END;  
/  
--7. Luis consulta los reportes de tiempo de uso para identificar si existen irregularidades.
DECLARE  
    v_cursor SYS_REFCURSOR;  
BEGIN  
    v_cursor := PK_entidadesGubernamentales.reportesTiempoUso;  
END;  
/  
--8.  Tras un tiempo, Luis decide que ya no necesita estar registrado en el sistema y procede a eliminar su cuenta.
BEGIN  
    PK_padresDeFamilia.eliminar(30);  
END;  
/  
-- Luis consulta de nuevo para asegurarse de que su registro ha sido eliminado.
DECLARE  
    v_cursor SYS_REFCURSOR;  
BEGIN  
    v_cursor := PK_padresDeFamilia.consultar(30);  
END;  
/  