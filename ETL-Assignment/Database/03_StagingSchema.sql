-- =========================================================
-- 03_StagingSchema.sql
-- RESPONSABIL: Membrul 1 (Database Architect)
-- SCOP: Tabele "stg" - versiunea curatata/transformata a datelor,
--       cu metadate de ingestie (dataset_name, process_timestamp).
--       Membrul 2 va popula aceste tabele (Load_Staging.sql).
-- =========================================================
USE ETL_Assignment;
GO

CREATE TABLE stg.Timesheets (
    staging_id          INT IDENTITY PRIMARY KEY,
    employee_id         INT NOT NULL,
    work_date           DATE NOT NULL,
    project_name        VARCHAR(100),
    hours_worked        DECIMAL(4,2),
    dataset_name        VARCHAR(50) DEFAULT 'timesheets',
    process_timestamp   DATETIME DEFAULT GETDATE()
);

CREATE TABLE stg.Absences (
    staging_id          INT IDENTITY PRIMARY KEY,
    employee_id         INT NOT NULL,
    absence_date        DATE NOT NULL,
    absence_type        VARCHAR(50),
    dataset_name        VARCHAR(50) DEFAULT 'absences',
    process_timestamp   DATETIME DEFAULT GETDATE()
);

CREATE TABLE stg.TrainingAttendance (
    staging_id          INT IDENTITY PRIMARY KEY,
    employee_id         INT NOT NULL,
    training_date       DATE NOT NULL,
    training_name       VARCHAR(150),
    dataset_name        VARCHAR(50) DEFAULT 'training_attendance',
    process_timestamp   DATETIME DEFAULT GETDATE()
);

-- Aici ajunge rezultatul UNPIVOT-ului din src.DUExamSchedule_Raw:
-- fiecare (angajat, data) devine un rand separat, nu o coloana.
CREATE TABLE stg.DUExamSchedule (
    staging_id          INT IDENTITY PRIMARY KEY,
    employee_id         INT NOT NULL,
    activity_date       DATE NOT NULL,
    activity_code       VARCHAR(50),  -- ex: 'Exam', 'Absent', 'Available'
    dataset_name        VARCHAR(50) DEFAULT 'du_exam_schedule',
    process_timestamp   DATETIME DEFAULT GETDATE()
);

CREATE TABLE stg.EmployeeMaster (
    staging_id          INT IDENTITY PRIMARY KEY,
    employee_id         INT NOT NULL,
    full_name           VARCHAR(150),
    grade               VARCHAR(50),
    discipline          VARCHAR(100),
    line_manager        VARCHAR(150),
    delivery_unit       VARCHAR(100),
    dataset_name        VARCHAR(50) DEFAULT 'employee_master',
    process_timestamp   DATETIME DEFAULT GETDATE()
);
