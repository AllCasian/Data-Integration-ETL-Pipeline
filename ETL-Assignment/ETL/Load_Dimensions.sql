-- =========================================================
-- Load_Dimensions.sql
-- RESPONSABIL: Membrul 3 (Data Warehouse Developer)
-- =========================================================
USE ETL_Assignment;
GO

TRUNCATE TABLE dwh.Fact_EmployeeActivity;
GO

-- ---------------------------------------------------------
-- dwh.Dim_Date
-- ---------------------------------------------------------
DELETE FROM dwh.Dim_Date;
GO

WITH DateSequence AS (
    SELECT CAST('2026-01-01' AS DATE) AS full_date
    UNION ALL
    SELECT DATEADD(DAY, 1, full_date)
    FROM DateSequence
    WHERE full_date < '2026-12-31'
)
INSERT INTO dwh.Dim_Date (date_sk, full_date, day_of_week, month, month_name, year)
SELECT
    CONVERT(INT, FORMAT(full_date, 'yyyyMMdd')) AS date_sk,
    full_date,
    DATENAME(WEEKDAY, full_date) AS day_of_week,
    MONTH(full_date) AS month,
    DATENAME(MONTH, full_date) AS month_name,
    YEAR(full_date) AS year
FROM DateSequence
OPTION (MAXRECURSION 366);
GO

-- ---------------------------------------------------------
-- dwh.Dim_ActivityType
-- ---------------------------------------------------------
DELETE FROM dwh.Dim_ActivityType;
GO

INSERT INTO dwh.Dim_ActivityType (activity_type)
VALUES ('Working'), ('Absence'), ('Training'), ('Exam'), ('Holiday');
GO

-- ---------------------------------------------------------
-- dwh.Dim_Employee <- stg.EmployeeMaster
-- ---------------------------------------------------------
DELETE FROM dwh.Dim_Employee;
GO

INSERT INTO dwh.Dim_Employee
    (employee_id, full_name, grade, discipline, line_manager, delivery_unit, valid_from, valid_to, is_current)
SELECT
    employee_id, full_name, grade, discipline, line_manager, delivery_unit,
    valid_from,
    ISNULL(valid_to, '9999-12-31'),
    is_current
FROM stg.EmployeeMaster;
GO

-- ---------------------------------------------------------
-- dwh.Dim_Project <- stg.Timesheets
-- ---------------------------------------------------------
DELETE FROM dwh.Dim_Project;
GO

INSERT INTO dwh.Dim_Project (project_name)
SELECT DISTINCT project_name
FROM stg.Timesheets
WHERE project_name IS NOT NULL;
GO

-- ---------------------------------------------------------
-- dwh.Dim_Training <- stg.TrainingAttendance
-- ---------------------------------------------------------
DELETE FROM dwh.Dim_Training;
GO

INSERT INTO dwh.Dim_Training (training_name)
SELECT DISTINCT training_name
FROM stg.TrainingAttendance
WHERE training_name IS NOT NULL;
GO