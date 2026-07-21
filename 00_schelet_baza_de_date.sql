-- =========================================================
-- SCHELET DE PORNIRE - Tema ETL (DavaX)
-- SQL Server / SSMS
-- Rulați acest fișier primul, apoi fiecare completează
-- tabelul lui cu date reale în fișierul propriu.
-- =========================================================

CREATE DATABASE DavaX_ETL;
GO
USE DavaX_ETL;
GO

-- Schema-uri (doar ca să separăm staging de rezultatul final)
CREATE SCHEMA stg;  -- staging: date brute, aproape cum vin din surse
GO
CREATE SCHEMA dwh;  -- target: star schema, gata de raportare
GO

-- =========================================================
-- STAGING (Persoana 1: Timesheets + Absences)
-- =========================================================

CREATE TABLE stg.Timesheets (
    timesheet_id     INT IDENTITY PRIMARY KEY,
    employee_id      INT NOT NULL,
    work_date        DATE NOT NULL,
    project_name     VARCHAR(100),
    hours_worked     DECIMAL(4,2),
    dataset_name     VARCHAR(50) DEFAULT 'timesheets',
    process_timestamp DATETIME DEFAULT GETDATE()
);

CREATE TABLE stg.Absences (
    absence_id       INT IDENTITY PRIMARY KEY,
    employee_id      INT NOT NULL,
    absence_date     DATE NOT NULL,
    absence_type     VARCHAR(50), -- ex: 'Annual Leave', 'Sick Leave', 'Public Holiday'
    dataset_name     VARCHAR(50) DEFAULT 'absences',
    process_timestamp DATETIME DEFAULT GETDATE()
);

-- =========================================================
-- STAGING (Persoana 2: Training + DU Exam Schedule)
-- =========================================================

CREATE TABLE stg.TrainingAttendance (
    training_id      INT IDENTITY PRIMARY KEY,
    employee_id      INT NOT NULL,
    training_date    DATE NOT NULL,
    training_name    VARCHAR(150),
    dataset_name     VARCHAR(50) DEFAULT 'training_attendance',
    process_timestamp DATETIME DEFAULT GETDATE()
);

-- Aici ajunge rezultatul transformarii DIN MATRICE (angajati x date)
-- IN format tabelar, folosind UNPIVOT sau CROSS APPLY (VALUES ...)
CREATE TABLE stg.DUExamSchedule (
    schedule_id      INT IDENTITY PRIMARY KEY,
    employee_id      INT NOT NULL,
    activity_date    DATE NOT NULL,
    activity_code    VARCHAR(50), -- ex: 'Exam', 'Absent', 'Available'
    dataset_name     VARCHAR(50) DEFAULT 'du_exam_schedule',
    process_timestamp DATETIME DEFAULT GETDATE()
);

-- =========================================================
-- STAGING (Persoana 3: Employee Master)
-- =========================================================

CREATE TABLE stg.EmployeeMaster (
    employee_id      INT NOT NULL,
    full_name        VARCHAR(150),
    grade            VARCHAR(50),
    discipline       VARCHAR(100),
    line_manager     VARCHAR(150),
    delivery_unit    VARCHAR(100),
    dataset_name     VARCHAR(50) DEFAULT 'employee_master',
    process_timestamp DATETIME DEFAULT GETDATE()
);

-- =========================================================
-- STAR SCHEMA (Persoana 4)
-- =========================================================

CREATE TABLE dwh.Dim_Employee (
    employee_sk      INT IDENTITY PRIMARY KEY,  -- cheie surogat
    employee_id      INT NOT NULL,               -- cheie naturala
    full_name        VARCHAR(150),
    grade            VARCHAR(50),
    discipline       VARCHAR(100),
    line_manager     VARCHAR(150),
    delivery_unit    VARCHAR(100),
    valid_from       DATE DEFAULT '1900-01-01',
    valid_to         DATE DEFAULT '9999-12-31',
    is_current       BIT DEFAULT 1
);

CREATE TABLE dwh.Dim_Date (
    date_sk          INT PRIMARY KEY,  -- ex: 20260720
    full_date        DATE NOT NULL,
    day_of_week      VARCHAR(20),
    month            INT,
    month_name       VARCHAR(20),
    year             INT
);

CREATE TABLE dwh.Dim_ActivityType (
    activity_type_sk INT IDENTITY PRIMARY KEY,
    activity_type    VARCHAR(50)  -- 'Working', 'Absence', 'Training', 'Holiday'
);

CREATE TABLE dwh.Dim_Project (
    project_sk       INT IDENTITY PRIMARY KEY,
    project_name     VARCHAR(100)
);

CREATE TABLE dwh.Dim_Training (
    training_sk      INT IDENTITY PRIMARY KEY,
    training_name    VARCHAR(150)
);

CREATE TABLE dwh.Fact_EmployeeActivity (
    fact_id          INT IDENTITY PRIMARY KEY,
    employee_sk      INT NOT NULL REFERENCES dwh.Dim_Employee(employee_sk),
    date_sk          INT NOT NULL REFERENCES dwh.Dim_Date(date_sk),
    activity_type_sk INT NOT NULL REFERENCES dwh.Dim_ActivityType(activity_type_sk),
    project_sk       INT NULL REFERENCES dwh.Dim_Project(project_sk),
    training_sk      INT NULL REFERENCES dwh.Dim_Training(training_sk),
    hours_worked     DECIMAL(4,2) NULL
);

-- =========================================================
-- Gata. De aici fiecare completeaza tabelul lui cu date +
-- INSERT INTO ... SELECT din stg in dwh (Persoana 4).
-- =========================================================
