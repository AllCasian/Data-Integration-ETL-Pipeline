# ETL Assignment — DavaX

Proiect de echipă (5 membri) — construirea unui pipeline ETL complet: surse → staging → star schema, plus rapoarte SQL.

## Stack
SQL Server + SSMS

## Structura proiectului

```
ETL-Assignment/
├── Database/
│   ├── 01_CreateDatabase.sql     # Membrul 1 - baza de date + schema-uri
│   ├── 02_SourceSchema.sql       # Membrul 1 - tabele "src"
│   ├── 03_StagingSchema.sql      # Membrul 1 - tabele "stg"
│   └── 04_DWSchema.sql           # Membrul 1 (+3) - star schema "dwh"
├── ETL/
│   ├── Load_Source.sql           # Membrul 2 - import date brute
│   ├── Load_Staging.sql          # Membrul 2 - src -> stg (+ UNPIVOT schedule)
│   ├── Load_Dimensions.sql       # Membrul 3 - populare dimensiuni
│   └── Load_Fact.sql             # Membrul 3 - populare tabel de fapte
├── Reports/
│   ├── Queries.sql               # Membrul 4 - interogarile cerute
│   └── Validation.sql            # Membrul 4/5 - validare stg vs dwh
├── PowerBI/
│   └── Dashboard.pbix            # Membrul 4 - bonus, opțional
├── Documentation/
│   ├── README.md                 # acest fișier
│   ├── ERD.drawio                # Membrul 5 - diagrama star schema
│   └── Assumptions.md            # Membrul 5 - asumții și decizii
└── SampleData/                   # fișiere sursă (CSV/Excel), dacă există
```

## Ordinea de rulare

Rulați fișierele **în ordine**, pe aceeași bază de date:

1. `Database/01_CreateDatabase.sql`
2. `Database/02_SourceSchema.sql`
3. `Database/03_StagingSchema.sql`
4. `Database/04_DWSchema.sql`
5. `ETL/Load_Source.sql`
6. `ETL/Load_Staging.sql`
7. `ETL/Load_Dimensions.sql`
8. `ETL/Load_Fact.sql`
9. `Reports/Queries.sql` și `Reports/Validation.sql`

## Distribuirea echipei

| Membru    | Rol                        | Fișiere principale                                  | Depinde de              |
|-----------|-----------------------------|------------------------------------------------------|--------------------------|
| Membru 1  | Database Architect          | `Database/*.sql`                                     | —                        |
| Membru 2  | ETL Developer                | `ETL/Load_Source.sql`, `ETL/Load_Staging.sql`        | Database creată          |
| Membru 3  | Data Warehouse Developer     | `ETL/Load_Dimensions.sql`, `ETL/Load_Fact.sql`        | Staging finalizat        |
| Membru 4  | Reporting Developer          | `Reports/Queries.sql`, `PowerBI/Dashboard.pbix`      | Star Schema finalizat    |
| Membru 5  | QA & Documentation            | `Documentation/*`, verificare `Reports/Validation.sql`| Toate modulele           |

> Notă: pentru a evita blocajele, Membrul 1 creează structura completă (goală) a tuturor tabelelor cât mai devreme, astfel încât Membrii 2-4 pot lucra în paralel pe logica lor, chiar dacă rezultatele finale depind unele de altele.

## Assumptions

Vezi `Assumptions.md` pentru lista completă de decizii/presupuneri luate acolo unde cerința a fost ambiguă.
