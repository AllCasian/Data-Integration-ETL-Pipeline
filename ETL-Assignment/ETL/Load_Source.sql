-- =========================================================
-- Load_Source.sql
-- RESPONSABIL: Membrul 2 (ETL Developer)
-- SCOP: Importa fisierele/datele brute in tabelele "src".
--       Aici NU se transforma nimic, doar se aduc datele
--       exact cum sunt in sursa originala.
-- DEPENDENTA: baza de date + schema "src" trebuie sa existe deja
--             (Membrul 1 - 01_CreateDatabase.sql, 02_SourceSchema.sql)
-- =========================================================
USE ETL_Assignment;
GO

-- OPTIUNEA A: daca aveti fisiere CSV/Excel, folositi Import Wizard
-- din SSMS (click-dreapta pe baza de date -> Tasks -> Import Data)
-- si mapati direct pe tabelele src.*

-- OPTIUNEA B: daca introduceti manual date de test, exemplu:
-- INSERT INTO src.Timesheets (employee_id, work_date, project_name, hours_worked)
-- VALUES (101, '2026-07-01', 'Project Alpha', 8.0);

-- INSERT INTO src.Absences (employee_id, absence_date, absence_type)
-- VALUES (101, '2026-07-02', 'Sick Leave');

-- INSERT INTO src.TrainingAttendance (employee_id, training_date, training_name)
-- VALUES (101, '2026-07-03', 'SQL Fundamentals');

-- INSERT INTO src.EmployeeMaster (employee_id, full_name, grade, discipline, line_manager, delivery_unit)
-- VALUES (101, 'Popescu Ion', 'Junior', 'Data Engineering', 'Andreea Bilboreanu', 'CLD - Data & AI');

-- TODO Membrul 2: inlocuiti exemplele de mai sus cu datele reale
-- (sau date de test consistente) pentru toate cele 5 surse.

-- ATENTIE la src.DUExamSchedule_Raw: daca fisierul sursa are
-- o coloana per data (matrice), aici doar il importati asa cum e.
-- Transformarea in format tabelar se face in Load_Staging.sql.
