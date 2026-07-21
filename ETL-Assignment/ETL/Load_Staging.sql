-- =========================================================
-- Load_Staging.sql
-- RESPONSABIL: Membrul 2 (ETL Developer)
-- SCOP: Muta datele din "src" in "stg", cu curatare minima
--       si adaugarea metadatelor de ingestie (dataset_name,
--       process_timestamp - deja au valori DEFAULT in tabel).
--
--       Aici se face si transformarea DU Exam Schedule din
--       MATRICE (o coloana per data) in format TABELAR
--       (un rand per angajat+data) - partea cea mai tehnica
--       a temei. Cautati despre UNPIVOT sau CROSS APPLY (VALUES ...).
--
-- DEPENDENTA: src.* trebuie sa aiba date (Load_Source.sql rulat).
-- =========================================================
USE ETL_Assignment;
GO

-- TODO: stg.Timesheets <- src.Timesheets

-- TODO: stg.Absences <- src.Absences

-- TODO: stg.TrainingAttendance <- src.TrainingAttendance

-- TODO: stg.EmployeeMaster <- src.EmployeeMaster

-- TODO: stg.DUExamSchedule <- src.DUExamSchedule_Raw
--   Aici trebuie transformarea matrice -> tabelar.
--   Intrebari de pus in echipa inainte sa incepeti:
--     - ce coduri de activitate exista (Exam / Absent / Available / altele)?
--     - cum se numesc coloanele de data in fisierul primit?
