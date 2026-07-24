# ETL: Data Integration, Modelling & Reporting

Proiect de echipă realizat în cadrul **Dava.X Academy** (Endava) — un pipeline ETL complet care integrează mai multe surse de date despre activitatea angajaților (timesheets, absențe, traininguri, programări de examen, date administrative) într-un model analitic de tip **Star Schema**, gata pentru interogare și raportare.

## Ce conține proiectul

- **Bază de date** (SQL Server) organizată pe 3 niveluri: `src` (surse brute) → `stg` (staging, curățare/transformare) → `dwh` (Data Warehouse, Star Schema)
- **Proces ETL** complet: import, transformare (inclusiv transformarea unui calendar tip matrice în format tabelar), populare dimensiuni și tabelă de fapte
- **Rapoarte SQL** și **dashboard Power BI**
- **Validare** automată a integrității datelor (comparare staging vs. Data Warehouse)
- **Documentație completă** (arhitectură, ghid de instalare/rulare, ERD)

Detalii complete: [`ETL-Assignment/Documentation/DOCUMENTATIE.pdf`](ETL-Assignment/Documentation) și [`ETL-Assignment/Documentation/README.md`](ETL-Assignment/Documentation/README.md).

## Echipa

| Rol | Membru |
|---|---|
| Database Architect | Buta Tudor |
| ETL Developer | Criste Casian Stelian |
| Data Warehouse Developer | Samboan Miruna |
| Reporting Developer | Puiu Stefan |
| QA & Documentation | Butuza Maria |

**Mentor:** Iulia Maria Alecu · **Buddy:** Ionuț Popescu
