
-- Función Escalar: La función CalcularEdad toma una fecha de nacimiento y devuelve la edad calculada.
CREATE  FUNCTION dbo.CalcularEdad (@fecha_nac DATETIME) RETURNS INT
AS
BEGIN
 DECLARE @edad INT;
SELECT @edad = YEAR(GETDATE()) - YEAR(@fecha_nac) - 
       CASE WHEN MONTH(GETDATE()) < MONTH(@fecha_nac)
       OR (MONTH(GETDATE()) = MONTH(@fecha_nac) AND DAY(GETDATE()) < DAY(@fecha_nac))
          THEN 1 
          ELSE 0 
END
RETURN @edad
END;


-- Función con Valores de Tabla: La función EmpleadosPorDepartamento toma un DepartamentoID y devuelve todos los empleados de ese departamento.
DROP FUNCTION dbo.EmpleadosPorDepartamento;
GO
CREATE  FUNCTION dbo.EmpleadosPorDepartamento(@departamento_ID INT) RETURNS TABLE 
AS
	RETURN(
	SELECT *
	FROM Empleados e
	WHERE e.departamentoid = @departamento_ID
);

-- Uso de las Funciones: Usar estas funciones en consultas para obtener la edad de los empleados y para listar empleados de un departamento específico.
  -- CalcularEdad 
SELECT 
    empleadoid,
    nombre,
    apellido,
    fecha_nac ,
    departamentoid,
    dbo.CalcularEdad(fecha_nac) AS Edad
FROM 
    Empleados;
    
  -- EmpleadosPorDepartamento
   
SELECT *
FROM dbo.EmpleadosPorDepartamento(1);


   