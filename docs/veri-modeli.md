# Veri Modeli

## Amaç
Uygulamanın ihtiyaç duyduğu veri varlıklarını, ilişkileri ve tablo yapısını tanımlamak.

## Temel Varlıklar
- Employer (İşveren)
- Project (Proje)
- Worker (Çalışan)
- IncomeExpense (Gelir/Gider)
- Debt (İşveren Borcu)
- DebtPayment
- WorkerAssignment
- Payment
- WeeklySnapshot

## Tablo Şemaları
(Tablolar burada detaylandırılacak.)

## İlişkiler
- Employer 1..n Project
- Project 1..n IncomeExpense
- Project 1..n Debt
- Worker 1..n WorkerAssignment
- Worker 1..n Payment
- Debt 1..n DebtPayment

## Index / Constraint Kuralları
(Indexler ve check kuralları burada yazılacak.)

## Haftalık Rapor Mantığı
(Snapshot yaklaşımı burada açıklanacak.)
