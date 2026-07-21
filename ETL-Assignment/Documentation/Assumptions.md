# Assumptions & decizii de design

**RESPONSABIL: Membrul 5 (QA & Documentation)** — completați/ajustați pe măsură ce echipa ia decizii reale.

- Grain-ul tabelului de fapte (`Fact_EmployeeActivity`) este **1 rând per angajat, per zi, per tip de activitate** — dacă un angajat are și absență și training în aceeași zi, apar 2 rânduri separate.
- `Dim_Employee` este implementat ca **SCD Type 2** pentru a păstra istoricul schimbărilor de Grade/Discipline/Line Manager/Delivery Unit.
- Pentru `DU Exam Schedule`, codul `'Available'` (zi fără activitate specială) **nu este încărcat** ca rând separat în tabelul de fapte — doar `'Exam'`/`'Absent'` sunt considerate activități relevante. *(De confirmat cu echipa dacă e corect.)*
- Datele de test folosite acolo unde nu există fișiere sursă reale sunt inventate, doar pentru a demonstra funcționarea pipeline-ului.

## Template pentru orice decizie nouă
```
Decizie: ...
Motiv: ...
Alternativă respinsă: ...
```
