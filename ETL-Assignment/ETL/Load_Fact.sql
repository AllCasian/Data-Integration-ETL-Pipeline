USE ETL_Assignment;
GO

TRUNCATE TABLE dwh.Fact_EmployeeActivity;
GO

-- 1. "Working" <- stg.Timesheets
INSERT INTO dwh.Fact_EmployeeActivity
    (employee_sk, date_sk, activity_type_sk, project_sk, training_sk, hours_worked)
SELECT
    de.employee_sk, dd.date_sk, dat.activity_type_sk, dp.project_sk, NULL, ts.hours_worked
FROM stg.Timesheets ts
JOIN dwh.Dim_Employee de ON de.employee_id = ts.employee_id
   AND ts.work_date BETWEEN de.valid_from AND de.valid_to
JOIN dwh.Dim_Date dd ON dd.full_date = ts.work_date
JOIN dwh.Dim_ActivityType dat ON dat.activity_type = 'Working'
LEFT JOIN dwh.Dim_Project dp ON dp.project_name = ts.project_name;
GO

-- 2. "Absence" <- stg.Absences
INSERT INTO dwh.Fact_EmployeeActivity
    (employee_sk, date_sk, activity_type_sk, project_sk, training_sk, hours_worked)
SELECT
    de.employee_sk, dd.date_sk, dat.activity_type_sk, NULL, NULL, NULL
FROM stg.Absences ab
JOIN dwh.Dim_Employee de ON de.employee_id = ab.employee_id
   AND ab.absence_date BETWEEN de.valid_from AND de.valid_to
JOIN dwh.Dim_Date dd ON dd.full_date = ab.absence_date
JOIN dwh.Dim_ActivityType dat ON dat.activity_type = 'Absence';
GO

-- 3. "Training" <- stg.TrainingAttendance
INSERT INTO dwh.Fact_EmployeeActivity
    (employee_sk, date_sk, activity_type_sk, project_sk, training_sk, hours_worked)
SELECT
    de.employee_sk, dd.date_sk, dat.activity_type_sk, NULL, dtr.training_sk, ta.attendance_hours
FROM stg.TrainingAttendance ta
JOIN dwh.Dim_Employee de ON de.employee_id = ta.employee_id
   AND ta.training_date BETWEEN de.valid_from AND de.valid_to
JOIN dwh.Dim_Date dd ON dd.full_date = ta.training_date
JOIN dwh.Dim_ActivityType dat ON dat.activity_type = 'Training'
LEFT JOIN dwh.Dim_Training dtr ON dtr.training_name = ta.training_name;
GO

-- 4. stg.DUExamSchedule
INSERT INTO dwh.Fact_EmployeeActivity
    (employee_sk, date_sk, activity_type_sk, project_sk, training_sk, hours_worked)
SELECT
    de.employee_sk, dd.date_sk, dat.activity_type_sk, NULL, NULL, NULL
FROM stg.DUExamSchedule des
JOIN dwh.Dim_Employee de ON de.employee_id = des.employee_id
   AND des.activity_date BETWEEN de.valid_from AND de.valid_to
JOIN dwh.Dim_Date dd ON dd.full_date = des.activity_date
JOIN dwh.Dim_ActivityType dat ON dat.activity_type =
    CASE des.activity_code
        WHEN 'Exam' THEN 'Exam'
        WHEN 'Absent' THEN 'Absence'
        WHEN 'Public Holiday' THEN 'Holiday'
        WHEN 'Training' THEN 'Training'
        WHEN 'Work From Home' THEN 'Working'
        ELSE NULL
    END
WHERE des.activity_code <> 'Available';
GO