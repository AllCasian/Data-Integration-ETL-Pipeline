-- =========================================================
-- Validation.sql
-- RESPONSABIL: Membrul 5 (QA & Documentation)
-- SCOP: Compara datele procesate (dwh) cu sursele originale
--       (stg), pentru a confirma ca procesul ETL nu a pierdut
--       sau dublat date pe parcurs.
-- =========================================================
USE ETL_Assignment;
GO

-- ---------------------------------------------------------
-- Validation 1 - Timesheets (Working)
-- ---------------------------------------------------------
SELECT
    'Timesheets -> Working' AS Verificare,
    (SELECT COUNT(*) FROM stg.Timesheets) AS StagingRows,
    (SELECT COUNT(*)
     FROM dwh.Fact_EmployeeActivity Activity
     INNER JOIN dwh.Dim_ActivityType ActivityType
        ON Activity.activity_type_sk = ActivityType.activity_type_sk
     WHERE ActivityType.activity_type = 'Working') AS WarehouseRows;

-- ---------------------------------------------------------
-- Validation 2 - Training Attendance
-- ---------------------------------------------------------
SELECT
    'TrainingAttendance -> Training' AS Verificare,
    (SELECT COUNT(*) FROM stg.TrainingAttendance) AS StagingRows,
    (SELECT COUNT(*)
     FROM dwh.Fact_EmployeeActivity Activity
     INNER JOIN dwh.Dim_ActivityType ActivityType
        ON Activity.activity_type_sk = ActivityType.activity_type_sk
     WHERE ActivityType.activity_type = 'Training') AS WarehouseRows;

-- ---------------------------------------------------------
-- Validation 3 - Absences (stg.Absences + DUExamSchedule 'Absent')
-- ---------------------------------------------------------
SELECT
    'Absences + DUExamSchedule(Absent) -> Absence' AS Verificare,
    (
        (SELECT COUNT(*) FROM stg.Absences) +
        (SELECT COUNT(*) FROM stg.DUExamSchedule WHERE activity_code = 'Absent')
    ) AS StagingRows,
    (SELECT COUNT(*)
     FROM dwh.Fact_EmployeeActivity Activity
     INNER JOIN dwh.Dim_ActivityType ActivityType
        ON Activity.activity_type_sk = ActivityType.activity_type_sk
     WHERE ActivityType.activity_type = 'Absence') AS WarehouseRows;

-- ---------------------------------------------------------
-- Validation 4 - DU Exam Schedule -> Exam
-- ---------------------------------------------------------
SELECT
    'DUExamSchedule (Exam) -> Exam' AS Verificare,
    (SELECT COUNT(*) FROM stg.DUExamSchedule WHERE activity_code = 'Exam') AS StagingRows,
    (SELECT COUNT(*)
     FROM dwh.Fact_EmployeeActivity Activity
     INNER JOIN dwh.Dim_ActivityType ActivityType
        ON Activity.activity_type_sk = ActivityType.activity_type_sk
     WHERE ActivityType.activity_type = 'Exam') AS WarehouseRows;

-- ---------------------------------------------------------
-- Validation 5 - DU Exam Schedule -> Holiday
-- ---------------------------------------------------------
SELECT
    'DUExamSchedule (Public Holiday) -> Holiday' AS Verificare,
    (SELECT COUNT(*) FROM stg.DUExamSchedule WHERE activity_code = 'Public Holiday') AS StagingRows,
    (SELECT COUNT(*)
     FROM dwh.Fact_EmployeeActivity Activity
     INNER JOIN dwh.Dim_ActivityType ActivityType
        ON Activity.activity_type_sk = ActivityType.activity_type_sk
     WHERE ActivityType.activity_type = 'Holiday') AS WarehouseRows;

-- ---------------------------------------------------------
-- Validation 6 - Angajati activi (SCD2 - is_current)
-- ---------------------------------------------------------
SELECT
    'EmployeeMaster -> Dim_Employee (activi)' AS Verificare,
    (SELECT COUNT(*) FROM stg.EmployeeMaster WHERE is_current = 1) AS CurrentEmployees,
    (SELECT COUNT(*) FROM dwh.Dim_Employee WHERE is_current = 1) AS WarehouseEmployees;

-- ---------------------------------------------------------
-- Validation 7 - Total general Fact_EmployeeActivity
-- ---------------------------------------------------------
-- Suma tuturor tipurilor de activitate ar trebui sa fie egala
-- cu numarul total de randuri din tabela de fapte.
SELECT
    'Total Fact_EmployeeActivity' AS Verificare,
    (SELECT COUNT(*) FROM dwh.Fact_EmployeeActivity) AS TotalWarehouseRows,
    (
        (SELECT COUNT(*) FROM dwh.Fact_EmployeeActivity Activity
            INNER JOIN dwh.Dim_ActivityType at ON Activity.activity_type_sk = at.activity_type_sk
            WHERE at.activity_type = 'Working') +
        (SELECT COUNT(*) FROM dwh.Fact_EmployeeActivity Activity
            INNER JOIN dwh.Dim_ActivityType at ON Activity.activity_type_sk = at.activity_type_sk
            WHERE at.activity_type = 'Absence') +
        (SELECT COUNT(*) FROM dwh.Fact_EmployeeActivity Activity
            INNER JOIN dwh.Dim_ActivityType at ON Activity.activity_type_sk = at.activity_type_sk
            WHERE at.activity_type = 'Training') +
        (SELECT COUNT(*) FROM dwh.Fact_EmployeeActivity Activity
            INNER JOIN dwh.Dim_ActivityType at ON Activity.activity_type_sk = at.activity_type_sk
            WHERE at.activity_type = 'Holiday') +
        (SELECT COUNT(*) FROM dwh.Fact_EmployeeActivity Activity
            INNER JOIN dwh.Dim_ActivityType at ON Activity.activity_type_sk = at.activity_type_sk
            WHERE at.activity_type = 'Exam')
    ) AS SumaPeTipuriActivitate;

-- ---------------------------------------------------------
-- Validation 8 - Angajati "orfani"
-- ---------------------------------------------------------
-- Daca acest query returneaza randuri, inseamna ca exista
-- angajati in stg.EmployeeMaster care nu au ajuns in Dim_Employee
-- (posibila eroare la Load_Dimensions.sql).
SELECT
    s.employee_id,
    s.full_name
FROM stg.EmployeeMaster s
LEFT JOIN dwh.Dim_Employee d
    ON d.employee_id = s.employee_id
WHERE d.employee_id IS NULL;