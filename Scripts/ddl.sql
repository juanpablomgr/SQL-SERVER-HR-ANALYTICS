-- Creando nuestra Base de Datos
CREATE DATABASE BD_HR_ANALYTICS;

USE BD_HR_ANALYTICS;

---------------------------------
-- CARGA EMPLEADOS
---------------------------------
IF OBJECT_ID('Employee', 'U') IS NOT NULL
    DROP TABLE Employee;

CREATE TABLE Employee (
    -- Alfanumérico por el formato '3012-1A41'
    EmployeeID              NVARCHAR(50) PRIMARY KEY, 
    FirstName               NVARCHAR(100),
    LastName                NVARCHAR(100),
    Gender                  NVARCHAR(50),
    Age                     INT,
    BusinessTravel          NVARCHAR(100),
    Department              NVARCHAR(100),
    [DistanceFromHome (KM)] INT, -- Entre corchetes por el espacio y paréntesis
    State                   NVARCHAR(10), 
    Ethnicity               NVARCHAR(100),
    Education               INT, -- Es un nivel (1-5)
    EducationField          NVARCHAR(100),
    JobRole                 NVARCHAR(100),
    MaritalStatus           NVARCHAR(50),
    Salary                  DECIMAL(18, 2), -- Para manejar montos grandes con decimales
    StockOptionLevel        INT,
    OverTime                NVARCHAR(10),
    HireDate                DATE, -- El formato YYYY-MM-DD es nativo de SQL
    Attrition               NVARCHAR(10),
    YearsAtCompany          INT,
    YearsInMostRecentRole   INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager    INT
);

BULK INSERT Employee
FROM 'G:\Mi unidad\HOME\CURSO\PROYECTOS\SQL-Project-HR-Analytics-Attrition-and-Performance-main\SQL-Project-HR-Analytics\Employee.csv' -- Reemplaza con la ruta real
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,           -- Ignora el encabezado del CSV
    FIELDTERMINATOR = ',',  -- Cambia por ';' si tu CSV usa punto y coma
    ROWTERMINATOR = '\n' -- Salto de línea estándar (LF) o '\n'
   -- ENCODING = 'UTF-8'      -- Importante si tienes acentos o tildes
 
);
