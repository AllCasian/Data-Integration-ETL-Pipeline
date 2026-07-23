
USE ETL_Assignment;
GO

SELECT TOP (5) *
FROM dwh.Dim_Employee;

SELECT TOP (5) *
FROM dwh.Dim_Date;

SELECT TOP (10) * FROM src.EmployeeMaster;
GO
/*
1.Allow querying an employee's activity for a selected date
Să poți afla ce a făcut un angajat într-o anumită zi (a lucrat, a fost în concediu, la training etc.).
*/
SELECT
    Employee.full_name AS Employee,
    DateDim.full_date AS ActivityDate,
    ActivityType.activity_type AS ActivityType,
    Project.project_name AS Project,
    Training.training_name AS Training,
    Activity.hours_worked AS HoursWorked
FROM dwh.Fact_EmployeeActivity Activity
INNER JOIN dwh.Dim_Employee Employee
    ON Activity.employee_sk = Employee.employee_sk
INNER JOIN dwh.Dim_Date DateDim
    ON Activity.date_sk = DateDim.date_sk
INNER JOIN dwh.Dim_ActivityType ActivityType
    ON Activity.activity_type_sk = ActivityType.activity_type_sk
LEFT JOIN dwh.Dim_Project Project
    ON Activity.project_sk = Project.project_sk
LEFT JOIN dwh.Dim_Training Training
    ON Activity.training_sk = Training.training_sk
WHERE Employee.full_name = 'Mocanu Raluca'
  AND DateDim.full_date = '2026-07-01';

/*
2.Produce a monthly aggregated report showing activity types and training participation
Să generezi un raport lunar agregat cu activitățile și participarea la traininguri.
*/
SELECT
    DateDim.year,
    DateDim.month_name,
    ActivityType.activity_type,
    COUNT(*) AS TotalActivities,
    ISNULL(SUM(Activity.hours_worked), 0) AS TotalHours--daca nu folosim ISNULL atunci o sa ne afiseze valoarea NULL in loc de 0.00 de exemplu
FROM dwh.Fact_EmployeeActivity Activity
INNER JOIN dwh.Dim_Date DateDim
    ON Activity.date_sk = DateDim.date_sk
INNER JOIN dwh.Dim_ActivityType ActivityType
    ON Activity.activity_type_sk = ActivityType.activity_type_sk
GROUP BY
    DateDim.year,
    DateDim.month,
    DateDim.month_name,
    ActivityType.activity_type
ORDER BY
    DateDim.year,
    DateDim.month;

/*
Cati participanti am avut la training uri?
*/

SELECT
    DateDim.year,
    DateDim.month_name,
    Training.training_name,
    COUNT(DISTINCT Activity.employee_sk) AS Participants,
    SUM(ISNULL(Activity.hours_worked,0)) AS TotalTrainingHours
FROM dwh.Fact_EmployeeActivity Activity
INNER JOIN dwh.Dim_Date DateDim
    ON Activity.date_sk = DateDim.date_sk
INNER JOIN dwh.Dim_Training Training
    ON Activity.training_sk = Training.training_sk
GROUP BY
    DateDim.year,
    DateDim.month,
    DateDim.month_name,
    Training.training_name
ORDER BY
    DateDim.year,
    DateDim.month,
    Training.training_name;
/*
4.Ensure transformed data can be easily queried using SQL.
  Cate ore s-au lucrat pe proiecte?
*/
SELECT
    Project.project_name,
    SUM(Activity.hours_worked) AS TotalHours
FROM dwh.Fact_EmployeeActivity Activity
INNER JOIN dwh.Dim_Project Project
    ON Activity.project_sk = Project.project_sk
GROUP BY
    Project.project_name
ORDER BY
    TotalHours DESC;

--Cum sunt impartite task urile?
SELECT
    ActivityType.activity_type,
    COUNT(*) AS TotalActivities
FROM dwh.Fact_EmployeeActivity Activity
INNER JOIN dwh.Dim_ActivityType ActivityType
    ON Activity.activity_type_sk = ActivityType.activity_type_sk
GROUP BY
    ActivityType.activity_type
ORDER BY
    TotalActivities DESC;