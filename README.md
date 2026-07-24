# ETL: Data Integration, Modelling & Reporting

A team project built as part of **Dava.X Academy** (Endava) — a complete ETL pipeline that integrates multiple employee activity data sources (timesheets, absences, training attendance, exam/absence schedules, employee master data) into an analytical **Star Schema** model, ready for querying and reporting.

## What this project includes

- **Database** (SQL Server) organized in 3 layers: `src` (raw sources) → `stg` (staging, cleaning/transformation) → `dwh` (Data Warehouse, Star Schema)
- **Complete ETL process**: import, transformation (including converting a matrix-style schedule into tabular format), dimension and fact table loading
- **SQL reports** and a **Power BI dashboard**
- **Automated validation** of data integrity (comparing staging vs. Data Warehouse)
- **Full documentation** (architecture, installation/run guide, ERD)

Full details: [`ETL-Assignment/Documentation/DOCUMENTATIE.pdf`](ETL-Assignment/Documentation) and [`ETL-Assignment/Documentation/README.md`](ETL-Assignment/Documentation/README.md).

## Team

| Role | Member |
|---|---|
| Database Architect | Buta Tudor |
| ETL Developer | Criste Casian Stelian |
| Data Warehouse Developer | Samboan Miruna |
| Reporting Developer | Puiu Stefan |
| QA & Documentation | Butuza Maria |

**Mentor:** Iulia Maria Alecu · **Buddy:** Ionuț Popescu
