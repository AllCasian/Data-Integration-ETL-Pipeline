-- =========================================================
-- Load_Fact.sql
-- RESPONSABIL: Membrul 3 (Data Warehouse Developer)
-- SCOP: Populeaza dwh.Fact_EmployeeActivity, combinand toate
--       sursele de activitate (lucrat, absenta, training, exam)
--       intr-un singur tabel de fapte, la nivel de zi/angajat.
-- DEPENDENTA: dimensiunile trebuie populate (Load_Dimensions.sql rulat).
-- =========================================================
USE ETL_Assignment;
GO

-- Grain-ul tabelului: 1 rand = 1 angajat + 1 zi + 1 tip de activitate.
-- Pentru fiecare sursa de mai jos trebuie facut un INSERT separat
-- in dwh.Fact_EmployeeActivity, facand JOIN de la stg.* la
-- dimensiunile deja populate (Dim_Employee, Dim_Date, Dim_ActivityType,
-- si dupa caz Dim_Project / Dim_Training), ca sa aflati cheile surogat.

-- TODO: activitate "Working" <- stg.Timesheets

-- TODO: activitate "Absence" <- stg.Absences

-- TODO: activitate "Training" <- stg.TrainingAttendance

-- TODO: activitate din stg.DUExamSchedule
--   Discutati in echipa: 'Available' se incarca ca activitate,
--   sau doar 'Exam'/'Absent' conteaza?
