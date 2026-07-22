-- =========================================================
-- Load_Dimensions.sql
-- RESPONSABIL: Membrul 3 (Data Warehouse Developer)
-- SCOP: Populeaza toate tabelele de dimensiune din dwh,
--       pornind de la datele deja curatate din "stg".
-- DEPENDENTA: stg.* trebuie sa fie populat (Load_Staging.sql rulat).
-- =========================================================
USE ETL_Assignment;
GO

-- ---------------------------------------------------------
-- dwh.Dim_Date
-- Generam toate datele pentru anul 2026, folosind un CTE recursiv.
-- ---------------------------------------------------------
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
-- Lista fixa de tipuri de activitate posibile.
-- ---------------------------------------------------------
INSERT INTO dwh.Dim_ActivityType (activity_type)
VALUES ('Working'), ('Absence'), ('Training'), ('Exam'), ('Holiday');
GO

-- TODO: dwh.Dim_Employee <- stg.EmployeeMaster
--   Discutati in echipa: implementati SCD Type 2 complet
--   (verificati schimbari fata de versiunea curenta si inchideti
--   randul vechi), sau pentru inceput toti intra ca is_current = 1?
--   -> ASTEAPTA finalizarea Load_Staging.sql (Membrul 2)

-- TODO: dwh.Dim_Project <- stg.Timesheets (valori distincte de proiect)
--   -> ASTEAPTA finalizarea Load_Staging.sql (Membrul 2)

-- TODO: dwh.Dim_Training <- stg.TrainingAttendance (valori distincte de training)
--   -> ASTEAPTA finalizarea Load_Staging.sql (Membrul 2)