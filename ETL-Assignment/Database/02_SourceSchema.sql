-- =========================================================
-- 02_SourceSchema.sql
-- RESPONSABIL: Membrul 1 (Database Architect)
-- SCOP: Tabele "src" - oglinda datelor brute asa cum vin din
--       cele 5 surse din cerinta temei. Aici NU se face nicio
--       transformare, doar se "primesc" datele ca atare.
--       Membrul 2 va importa efectiv fisierele aici (Load_Source.sql).
-- =========================================================
USE ETL_Assignment;
GO

CREATE TABLE src.Timesheets (
    employee_id     INT,
    work_date       DATE,
    project_name    VARCHAR(100),
    hours_worked    DECIMAL(4,2)
);

CREATE TABLE src.Absences (
    employee_id     INT,
    absence_date    DATE,
    absence_type    VARCHAR(50)  -- ex: 'Annual Leave', 'Sick Leave', 'Public Holiday'
);

CREATE TABLE src.TrainingAttendance (
    employee_id     INT,
    training_date   DATE,
    training_name   VARCHAR(150)
);

-- ATENTIE: aceasta este forma BRUTA a schedule-ului, ca o MATRICE
-- (angajati pe randuri, o coloana pentru fiecare data). Nu incercati
-- sa o folositi direct in rapoarte - se transforma in stg (UNPIVOT).
CREATE TABLE src.DUExamSchedule_Raw (
    employee_id     INT
    -- coloanele pentru fiecare data se adauga dinamic / manual,
    -- in functie de fisierul sursa primit (ex: [2026-07-01], [2026-07-02], ...)
);

CREATE TABLE src.EmployeeMaster (
    employee_id     INT,
    full_name       VARCHAR(150),
    grade           VARCHAR(50),
    discipline      VARCHAR(100),
    line_manager    VARCHAR(150),
    delivery_unit   VARCHAR(100)
);
