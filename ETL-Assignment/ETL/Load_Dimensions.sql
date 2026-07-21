-- =========================================================
-- Load_Dimensions.sql
-- RESPONSABIL: Membrul 3 (Data Warehouse Developer)
-- SCOP: Populeaza toate tabelele de dimensiune din dwh,
--       pornind de la datele deja curatate din "stg".
-- DEPENDENTA: stg.* trebuie sa fie populat (Load_Staging.sql rulat).
-- =========================================================
USE ETL_Assignment;
GO

-- TODO: dwh.Dim_Employee <- stg.EmployeeMaster
--   Discutati in echipa: implementati SCD Type 2 complet
--   (verificati schimbari fata de versiunea curenta si inchideti
--   randul vechi), sau pentru inceput toti intra ca is_current = 1?

-- TODO: dwh.Dim_Date
--   Genereaza toate datele dintr-un interval relevant temei
--   (cautati despre "recursive CTE" pentru serii de date in SQL Server).

-- TODO: dwh.Dim_ActivityType
--   Ce tipuri de activitate exista? (Working, Absence, Training, ...)

-- TODO: dwh.Dim_Project <- stg.Timesheets (valori distincte de proiect)

-- TODO: dwh.Dim_Training <- stg.TrainingAttendance (valori distincte de training)
