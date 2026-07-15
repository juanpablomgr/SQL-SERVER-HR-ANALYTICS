!['IMAGEN PREGUNTA 1'](/picture/baneer_vertical.png)
!['ada'](/picture/pregunta1.png)
# SQL-SERVER-HR-ANALYTICS
## Resumen
El presente proyecto de HR Analytics emplea técnicas avanzadas de procesamiento de datos en SQL Server para resolver uno de los mayores desafíos organizacionales: la rotación de personal. Mediante el análisis riguroso de métricas históricas de Recursos Humanos, el estudio identifica los factores críticos y patrones subyacentes que impulsan la fuga de talento, transformando datos crudos en conocimiento estratégico. Esto permitirá a la dirección tomar decisiones informadas, diseñar estrategias de retención altamente efectivas, mitigar costos operativos y asegurar la continuidad de equipos de alto rendimiento.
## Estructura
- [Sobre los datos](#sobre-los-datos)
- [Analisis exploratorio de Datos e Insights](#Análisis-exploratorio-de-Datos-e-Insights)

## sobre los datos
Los datos originales, junto con una explicación de cada columna, se pueden encontrar [aquí](https://www.kaggle.com/datasets/mahmoudemadabdallah/hr-analytics-employee-attrition-and-performance/data?select=Employee.csv).

## Analisis exploratorio de Datos e Insights
### 1. Cuál es la antigüedad promedio de los empleados en cada departamento?

````sql
--- Antiguedad por departamento
SELECT 
	Department, 
	CAST(AVG(YearsAtCompany*1.0) AS NUMERIC(10,2))  Anios_Promedio_Compania
FROM Employee
group by Department
````
Insight: Se encontró que el departamento de Tecnología tiene un mayor tiempo de permanencia, se asume que se produce debido a los ingresos de esta área específica.

!['pregunta1'](/picture/pregunta1.png)

### 2. ¿Cuántos empleados en cada departamento siguen trabajando en la empresa?

````sql
--- Empleados Activos en la Empresa
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
````
Insight: BALBLABLABLA

!['pregunta1'](/picture/pregunta2.png)

### 3. ¿Cómo se compara la satisfacción laboral de los empleados según los diferentes niveles de antigüedad?

````sql
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
````


