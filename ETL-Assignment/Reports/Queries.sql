-- =========================================================
-- Queries.sql
-- RESPONSABIL: Membrul 4 (Reporting Developer)
-- SCOP: Interogarile cerute explicit in tema, plus rapoartele
--       lunare, pe baza star schema-ului finalizat.
-- DEPENDENTA: dwh.* trebuie sa fie complet populat.
-- =========================================================
USE ETL_Assignment;
GO

-- ---------- Query 1: Activitatea unui angajat la o data data ----------
-- Cerinta: "poti sa interoghezi activitatea unui angajat pentru
-- o data aleasa (lucrat / absent / training)"
-- TODO: JOIN intre Fact_EmployeeActivity si dimensiuni,
-- filtrat pe employee_id si pe o data specifica.


-- ---------- Query 2: Raport lunar agregat ----------
-- Cerinta: "raport lunar cu tipurile de activitate si
-- participarea la traininguri"
-- TODO: GROUP BY pe angajat + luna + tip de activitate,
-- cu COUNT sau SUM dupa caz.


-- TODO: orice alt raport pe care il considerati util/cerut de tema
