-- -- -- -- -- -- -- -- -- -- -- --
-- EXPLORATORY DATA ANALYSIS AND INSIGHTS --
-- -- -- -- -- -- -- -- -- -- -- --

--Pregunta #1: 
--¿Cuál es la antigüedad promedio de los empleados en cada departamento?}
-- Antigüedad promedio por departamento  --

SELECT 
	Department, 
	CAST(AVG(YearsAtCompany*1.0) AS NUMERIC(10,2))  Anios_Promedio_Compania
FROM Employee
group by Department


-- Pregunta #2: 
--¿Cuántos empleados en cada departamento siguen trabajando en la empresa?

SELECT Department, Attrition as Abandono,
		count(1) as ActiveEmployees, 
		ROUND( COUNT(1) * 100 /
				(SELECT count(1)
				FROM Employee
				WHERE Attrition = 'No'), 0 
				) as PctofActive
FROM Employee
WHERE Attrition = 'No'
Group by Department, Attrition
ORDER BY ActiveEmployees DESC;

-- Pregunta #3: ¿Cómo se compara la satisfacción laboral de los empleados según los diferentes niveles de antigüedad?
-- Promedio de satisfaccion por categoria de antiguedad
with employee_antiguedad as( 
	select 
	CASE 
		WHEN YearsAtCompany < 3  THEN 'i. 3 o más'
		WHEN YearsAtCompany BETWEEN 3 AND 5 THEN 'i. 3-5 años'
		ELSE 'iii. 5 o más'
	END AS GrupoAntiguedad, 
	EmployeeID,
	FirstName,
	Age,
	Department
	FROM Employee
)
SELECT 
	ea.GrupoAntiguedad,
	AVG(pr.JobSatisfaction*1.0) as RatingSatisfaccion
FROM employee_antiguedad ea
INNER JOIN dbo.PerformanceRating pr on ea.EmployeeID = pr.EmployeeID --Solo los que tienen encuesta
GROUP BY  ea.GrupoAntiguedad
ORDER BY 
	RatingSatisfaccion desc, 
	ea.GrupoAntiguedad desc	;


-- Pregunta #4: Examinar cuántos empleados que trabajaron horas extras han dejado la empresa frente a los que no trabajaron