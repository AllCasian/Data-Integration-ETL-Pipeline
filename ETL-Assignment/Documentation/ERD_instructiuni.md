# ERD — instrucțiuni

**RESPONSABIL:** Membrul 5 (QA & Documentation)

Fișierul `.drawio` nu poate fi generat automat de un asistent AI (e format vizual, desenat manual) — desenați-l în https://app.diagrams.net (gratuit, online, se poate salva direct ca `ERD.drawio`).

## Ce trebuie desenat (star schema)

**Centru — tabelul de fapte:**
- `Fact_EmployeeActivity` (employee_sk, date_sk, activity_type_sk, project_sk, training_sk, hours_worked)

**În jur — dimensiunile, fiecare legată de fapt printr-o linie (relație 1-la-multe):**
- `Dim_Employee` (SCD2: valid_from, valid_to, is_current)
- `Dim_Date`
- `Dim_ActivityType`
- `Dim_Project`
- `Dim_Training`

Forma vizuală clasică: un dreptunghi central (fapta) cu linii către 5 dreptunghiuri în jur (dimensiunile) — de unde vine și numele "star schema".
