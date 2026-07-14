-- Creando nuestra Base de Datos
CREATE DATABASE BD_HR_ANALYTICS;

USE BD_HR_ANALYTICS;

--> DDL ---> Create
--> DML ---> Alter, insert into, ctas, etc
--> DQL ---> Select, Join, Group by, order by


---------------------------------
-- CARGA EMPLEADOS
---------------------------------
IF OBJECT_ID('Employee', 'U') IS NOT NULL
    DROP TABLE Employee;

CREATE TABLE Employee (
    -- Alfanum�rico por el formato '3012-1A41'
    EmployeeID              NVARCHAR(50) PRIMARY KEY, 
    FirstName               NVARCHAR(100),
    LastName                NVARCHAR(100),
    Gender                  NVARCHAR(50),
    Age                     INT,
    BusinessTravel          NVARCHAR(100),
    Department              NVARCHAR(100),
    [DistanceFromHome (KM)] INT, -- Entre corchetes por el espacio y par�ntesis
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
FROM 'D:\ArchivosJP\DataAcademy\ProyectoSQL_HR_JP\SQL-SERVER-HR-ANALYTICS\Data\Employee.csv' -- Reemplaza con la ruta real
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,           -- Ignora el encabezado del CSV
    FIELDTERMINATOR = ',',  -- Cambia por ';' si tu CSV usa punto y coma
    ROWTERMINATOR = '\n' -- Salto de l�nea est�ndar (LF) o '\n'
   -- ENCODING = 'UTF-8'      -- Importante si tienes acentos o tildes
 
);

SELECT *
FROM Employee
IF OBJECT_ID('Employee', 'U') IS NOT NULL
    DROP TABLE PerformanceRating;


CREATE TABLE PerformanceRating (
    PerformanceID                 NVARCHAR(20) PRIMARY KEY, -- Ej: 'PR01'
    EmployeeID                    NVARCHAR(50),             -- Debe coincidir con el formato de tu otra tabla
    ReviewDate                    DATE,                     -- SQL Server maneja formato YYYY-MM-DD
    EnvironmentSatisfaction       INT,
    JobSatisfaction               INT,
    RelationshipSatisfaction      INT,
    TrainingOpportunitiesWithinYear INT,
    TrainingOpportunitiesTaken    INT,
    WorkLifeBalance               INT,
    SelfRating                    INT,
    ManagerRating                 INT
);


BULK INSERT PerformanceRating
FROM 'D:\ArchivosJP\DataAcademy\ProyectoSQL_HR_JP\SQL-SERVER-HR-ANALYTICS\Data\PerformanceRating.csv' -- Reemplaza con la ruta real
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,           -- Ignora el encabezado del CSV
    FIELDTERMINATOR = ',',  -- Cambia por ';' si tu CSV usa punto y coma
    ROWTERMINATOR = '\n' -- Salto de l�nea est�ndar (LF) o '\n'
       -- Importante si tienes acentos o tildes
 
);

