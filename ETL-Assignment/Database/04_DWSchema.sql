-- =========================================================
-- 04_DWSchema.sql
-- RESPONSABIL: Membrul 1 (Database Architect), impreuna cu
--              Membrul 3 (Data Warehouse Developer) care va
--              popula si eventual ajusta aceste tabele.
-- SCOP: Star Schema final - dimensiuni + tabelul de fapte.
--       Aici ajung datele gata de raportare (Membrul 4).
-- =========================================================
USE ETL_Assignment;
GO

-- ---------- DIMENSIUNI ----------

-- SCD Type 2: pastreaza istoricul modificarilor pentru
-- Grade, Discipline, Line Manager, Delivery Unit.
CREATE TABLE dwh.Dim_Employee (
    employee_sk     INT IDENTITY PRIMARY KEY,   -- cheie surogat
    employee_id     INT NOT NULL,                -- cheie naturala (din sursa)
    full_name       VARCHAR(150),
    grade           VARCHAR(50),
    discipline      VARCHAR(100),
    line_manager    VARCHAR(150),
    delivery_unit   VARCHAR(100),
    valid_from      DATE DEFAULT '1900-01-01',
    valid_to        DATE DEFAULT '9999-12-31',
    is_current      BIT DEFAULT 1
);

CREATE TABLE dwh.Dim_Date (
    date_sk         INT PRIMARY KEY,   -- format YYYYMMDD, ex: 20260721
    full_date       DATE NOT NULL,
    day_of_week     VARCHAR(20),
    month           INT,
    month_name      VARCHAR(20),
    year            INT
);

CREATE TABLE dwh.Dim_ActivityType (
    activity_type_sk INT IDENTITY PRIMARY KEY,
    activity_type    VARCHAR(50)  -- 'Working', 'Absence', 'Training', 'Exam', 'Holiday'
);

CREATE TABLE dwh.Dim_Project (
    project_sk      INT IDENTITY PRIMARY KEY,
    project_name    VARCHAR(100)
);

CREATE TABLE dwh.Dim_Training (
    training_sk     INT IDENTITY PRIMARY KEY,
    training_name   VARCHAR(150)
);

-- ---------- FAPTA ----------
-- Grain: 1 rand = 1 angajat + 1 zi + 1 tip de activitate.
CREATE TABLE dwh.Fact_EmployeeActivity (
    fact_id          INT IDENTITY PRIMARY KEY,
    employee_sk      INT NOT NULL REFERENCES dwh.Dim_Employee(employee_sk),
    date_sk          INT NOT NULL REFERENCES dwh.Dim_Date(date_sk),
    activity_type_sk INT NOT NULL REFERENCES dwh.Dim_ActivityType(activity_type_sk),
    project_sk       INT NULL REFERENCES dwh.Dim_Project(project_sk),
    training_sk      INT NULL REFERENCES dwh.Dim_Training(training_sk),
    hours_worked     DECIMAL(4,2) NULL
);
