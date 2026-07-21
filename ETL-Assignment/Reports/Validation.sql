-- =========================================================
-- Validation.sql
-- RESPONSABIL: Membrul 4 (Reporting Developer), verificat de
--              Membrul 5 (QA & Documentation)
-- SCOP: Compara datele procesate (dwh) cu sursele originale
--       (stg), ca sa confirmam ca nu s-a pierdut nimic la ETL.
--       Cerinta explicita din tema: "mecanism de validare".
-- =========================================================
USE ETL_Assignment;
GO

-- TODO: comparati numarul de randuri intre stg.* si dwh.Fact_EmployeeActivity
--   (grupat pe tip de activitate)

-- TODO: comparati o suma relevanta (ex: total ore lucrate)
--   intre stg.Timesheets si dwh.Fact_EmployeeActivity

-- TODO: verificati daca exista angajati in stg.EmployeeMaster
--   fara corespondent in dwh.Dim_Employee (ar insemna eroare de load)

-- TODO: orice alta verificare utila (duplicate, valori NULL neasteptate)
