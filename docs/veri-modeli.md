# Veri Modeli

## 1) Varlıklar (Entities)
### Employer (İşveren)
- **Alanlar ve Türler**
  - `id`: INTEGER (PK)
  - `name`: TEXT
  - `contact`: TEXT (opsiyonel)
  - `note`: TEXT (opsiyonel)
  - `totalDebt`: INTEGER (hesaplanan alan; `debts` - `debt_payments`)
- **Açıklama**: İşveren kartı; temel iletişim ve not bilgisi tutulur, borç toplamı hesaplanır.
- **İlişkiler**: Employer 1..n Project (`projects.employerId`), Employer 1..n Debt (`debts.employerId`).

### Project (Proje)
- **Alanlar ve Türler**
  - `id`: INTEGER (PK)
  - `employerId`: INTEGER (FK → employers.id)
  - `title`: TEXT
  - `startDate`: DATE
  - `endDate`: DATE (opsiyonel)
  - `status`: TEXT (enum: new/active/done/archived)
  - `budget`: INTEGER (kuruş)
  - `description`: TEXT (opsiyonel)
- **Açıklama**: Proje meta verisi; bütçe ve durum izleme.
- **İlişkiler**: Project 1..n IncomeExpense, Project 1..n Debt, Project 1..n WorkerAssignment, Project 1..n Payment (opsiyonel bağ), Project → Employer (n..1).

### IncomeExpense (Gelir/Gider)
- **Alanlar ve Türler**
  - `id`: INTEGER (PK)
  - `projectId`: INTEGER (FK → projects.id)
  - `employerId`: INTEGER (FK → employers.id)
  - `type`: TEXT (`income` / `expense`)
  - `category`: TEXT (enum mantığında; ör. işveren ödemesi, borç, yemek vb.)
  - `amount`: INTEGER
  - `description`: TEXT (opsiyonel)
  - `txDate`: DATE
- **Açıklama**: Projeye bağlı tüm finans hareketleri.
- **İlişkiler**: IncomeExpense → Project (n..1), → Employer (n..1).

### Debt (İşveren Borcu)
- **Alanlar ve Türler**
  - `id`: INTEGER (PK)
  - `employerId`: INTEGER (FK → employers.id)
  - `projectId`: INTEGER (FK → projects.id, opsiyonel)
  - `amount`: INTEGER
  - `borrowDate`: DATE
  - `dueDate`: DATE
  - `status`: TEXT (`pending` / `partial` / `paid`)
  - `description`: TEXT (opsiyonel)
- **Açıklama**: İşverenden alınan borç kayıtları; proje ile eşlenebilir.
- **İlişkiler**: Debt → Employer (n..1), Debt → Project (n..1, opsiyonel), Debt 1..n DebtPayment.

### DebtPayment
- **Alanlar ve Türler**
  - `id`: INTEGER (PK)
  - `debtId`: INTEGER (FK → debts.id)
  - `amount`: INTEGER
  - `paymentDate`: DATE
  - `note`: TEXT (opsiyonel)
- **Açıklama**: Borç üzerindeki parça/parça ödemeler.
- **İlişkiler**: DebtPayment → Debt (n..1).

### Worker (Çalışan)
- **Alanlar ve Türler**
  - `id`: INTEGER (PK)
  - `fullName`: TEXT
  - `dailyRate`: INTEGER
  - `phone`: TEXT (opsiyonel)
  - `note`: TEXT (opsiyonel)
  - `active`: INTEGER/BOOLEAN (default 1)
- **Açıklama**: Çalışan temel bilgisi ve günlük ücret.
- **İlişkiler**: Worker 1..n WorkerAssignment, Worker 1..n Payment.

### WorkerAssignment (Çalışma Günleri)
- **Alanlar ve Türler**
  - `id`: INTEGER (PK)
  - `workerId`: INTEGER (FK → workers.id)
  - `projectId`: INTEGER (FK → projects.id)
  - `workDate`: DATE
  - `hours`: REAL (opsiyonel; saat bazlı)
  - `overtimeHours`: REAL (opsiyonel)
- **Açıklama**: Proje-çalışan bazlı günlük çalışma kaydı.
- **İlişkiler**: WorkerAssignment → Worker (n..1), → Project (n..1).

### Payment (Hakediş Ödemesi)
- **Alanlar ve Türler**
  - `id`: INTEGER (PK)
  - `workerId`: INTEGER (FK → workers.id)
  - `projectId`: INTEGER (FK → projects.id, opsiyonel)
  - `amount`: INTEGER
  - `paymentDate`: DATE
  - `note`: TEXT (opsiyonel)
- **Açıklama**: Çalışanlara yapılan hakediş ödemeleri.
- **İlişkiler**: Payment → Worker (n..1), → Project (n..1, opsiyonel).

### WeeklySnapshot (Haftalık Rapor Cache)
- **Alanlar ve Türler**
  - `id`: INTEGER (PK)
  - `weekStart`: DATE
  - `incomeTotal`: INTEGER
  - `expenseTotal`: INTEGER
  - `debtTotal`: INTEGER
  - `payrollTotal`: INTEGER
  - `generatedAt`: DATETIME
- **Açıklama**: Haftalık özetlerin cache tablosu.
- **İlişkiler**: Doğrudan FK yok; rapor hesapları için kaynak veriden türetilir.

## 2) Tablo Şemaları
### employers
| Kolon | Tür | Açıklama | Constraint/Varsayılan |
| --- | --- | --- | --- |
| id | INTEGER | Birincil anahtar | PK AUTOINCREMENT |
| name | TEXT | İşveren adı | NOT NULL |
| contact | TEXT | Telefon/e-posta | NULL |
| note | TEXT | Not | NULL |
| totalDebt | INTEGER | Hesaplanan alan için cache (opsiyonel) | DEFAULT 0 |
| createdAt | DATETIME | Oluşturulma | DEFAULT CURRENT_TIMESTAMP |

### projects
| Kolon | Tür | Açıklama | Constraint/Varsayılan |
| --- | --- | --- | --- |
| id | INTEGER | PK | PK AUTOINCREMENT |
| employerId | INTEGER | İşveren FK | NOT NULL, FK → employers(id) ON DELETE CASCADE |
| title | TEXT | Proje başlığı | NOT NULL |
| startDate | DATE | Başlangıç | NOT NULL |
| endDate | DATE | Bitiş | NULL |
| status | TEXT | new/active/done/archived | NOT NULL, CHECK(status IN ('new','active','done','archived')) |
| budget | INTEGER | Bütçe (kuruş) | NOT NULL, CHECK(budget >= 0) |
| description | TEXT | Açıklama | NULL |
| createdAt | DATETIME | Oluşturulma | DEFAULT CURRENT_TIMESTAMP |

### income_expense
| Kolon | Tür | Açıklama | Constraint/Varsayılan |
| --- | --- | --- | --- |
| id | INTEGER | PK | PK AUTOINCREMENT |
| projectId | INTEGER | Proje FK | NOT NULL, FK → projects(id) ON DELETE CASCADE |
| employerId | INTEGER | İşveren FK | NOT NULL, FK → employers(id) ON DELETE CASCADE |
| type | TEXT | income/expense | NOT NULL, CHECK(type IN ('income','expense')) |
| category | TEXT | Kategori | NOT NULL |
| amount | INTEGER | Tutar (kuruş) | NOT NULL, CHECK(amount > 0) |
| description | TEXT | Açıklama | NULL |
| txDate | DATE | İşlem tarihi | NOT NULL |
| createdAt | DATETIME | Oluşturulma | DEFAULT CURRENT_TIMESTAMP |

### debts
| Kolon | Tür | Açıklama | Constraint/Varsayılan |
| --- | --- | --- | --- |
| id | INTEGER | PK | PK AUTOINCREMENT |
| employerId | INTEGER | İşveren FK | NOT NULL, FK → employers(id) ON DELETE CASCADE |
| projectId | INTEGER | Proje FK (opsiyonel) | NULL, FK → projects(id) ON DELETE SET NULL |
| amount | INTEGER | Tutar | NOT NULL, CHECK(amount > 0) |
| borrowDate | DATE | Alınan tarih | NOT NULL |
| dueDate | DATE | Vade | NOT NULL |
| status | TEXT | pending/partial/paid | NOT NULL, CHECK(status IN ('pending','partial','paid')) |
| description | TEXT | Not | NULL |
| createdAt | DATETIME | Oluşturulma | DEFAULT CURRENT_TIMESTAMP |

### debt_payments
| Kolon | Tür | Açıklama | Constraint/Varsayılan |
| --- | --- | --- | --- |
| id | INTEGER | PK | PK AUTOINCREMENT |
| debtId | INTEGER | Borç FK | NOT NULL, FK → debts(id) ON DELETE CASCADE |
| amount | INTEGER | Ödenen tutar | NOT NULL, CHECK(amount > 0) |
| paymentDate | DATE | Ödeme tarihi | NOT NULL |
| note | TEXT | Not | NULL |
| createdAt | DATETIME | Oluşturulma | DEFAULT CURRENT_TIMESTAMP |

### workers
| Kolon | Tür | Açıklama | Constraint/Varsayılan |
| --- | --- | --- | --- |
| id | INTEGER | PK | PK AUTOINCREMENT |
| fullName | TEXT | Ad Soyad | NOT NULL |
| dailyRate | INTEGER | Günlük ücret (kuruş) | NOT NULL, CHECK(dailyRate > 0) |
| phone | TEXT | Telefon | NULL |
| note | TEXT | Not | NULL |
| active | INTEGER | 1 aktif / 0 pasif | NOT NULL, DEFAULT 1 |
| hireDate | DATE | Başlangıç | NULL |
| createdAt | DATETIME | Oluşturulma | DEFAULT CURRENT_TIMESTAMP |

### worker_assignments
| Kolon | Tür | Açıklama | Constraint/Varsayılan |
| --- | --- | --- | --- |
| id | INTEGER | PK | PK AUTOINCREMENT |
| workerId | INTEGER | Çalışan FK | NOT NULL, FK → workers(id) ON DELETE CASCADE |
| projectId | INTEGER | Proje FK | NOT NULL, FK → projects(id) ON DELETE CASCADE |
| workDate | DATE | Çalışma tarihi | NOT NULL |
| hours | REAL | Çalışılan saat | NULL, CHECK(hours >= 0) |
| overtimeHours | REAL | Mesai saati | NULL, CHECK(overtimeHours >= 0) |
| createdAt | DATETIME | Oluşturulma | DEFAULT CURRENT_TIMESTAMP |

### payments
| Kolon | Tür | Açıklama | Constraint/Varsayılan |
| --- | --- | --- | --- |
| id | INTEGER | PK | PK AUTOINCREMENT |
| workerId | INTEGER | Çalışan FK | NOT NULL, FK → workers(id) ON DELETE CASCADE |
| projectId | INTEGER | Proje FK (opsiyonel) | NULL, FK → projects(id) ON DELETE SET NULL |
| amount | INTEGER | Ödenen tutar | NOT NULL, CHECK(amount > 0) |
| paymentDate | DATE | Ödeme tarihi | NOT NULL |
| note | TEXT | Not | NULL |
| createdAt | DATETIME | Oluşturulma | DEFAULT CURRENT_TIMESTAMP |

### weekly_snapshots
| Kolon | Tür | Açıklama | Constraint/Varsayılan |
| --- | --- | --- | --- |
| id | INTEGER | PK | PK AUTOINCREMENT |
| weekStart | DATE | Hafta başlangıç | NOT NULL |
| incomeTotal | INTEGER | Haftalık gelir toplamı | NOT NULL, DEFAULT 0 |
| expenseTotal | INTEGER | Haftalık gider toplamı | NOT NULL, DEFAULT 0 |
| debtTotal | INTEGER | Haftalık borç toplamı | NOT NULL, DEFAULT 0 |
| payrollTotal | INTEGER | Haftalık maaş toplamı | NOT NULL, DEFAULT 0 |
| generatedAt | DATETIME | Hesaplanma tarihi | DEFAULT CURRENT_TIMESTAMP |

## 3) İlişkiler
- **Employer 1..n Project**: `projects.employerId` FK; işveren silindiğinde bağlı projeler CASCADE ile temizlenir. İşveren bazlı takip ve raporlama için.
- **Project 1..n IncomeExpense**: `income_expense.projectId` FK; proje silinince finans hareketleri CASCADE. Bütçe takibi için.
- **Project 1..n Debt**: `debts.projectId` opsiyonel FK SET NULL; proje silinse borç kaydı korunur ama proje bağlamı kaldırılır. Borç geçmişi kaybını önlemek için.
- **Employer 1..n Debt**: `debts.employerId` FK CASCADE; işveren silinince ilgili borçlar da silinir.
- **Debt 1..n DebtPayment**: `debt_payments.debtId` FK CASCADE; borç kapatıldığında ödemeler de kaldırılır.
- **Project 1..n WorkerAssignment**: `worker_assignments.projectId` FK CASCADE; proje silinince çalışma günleri temizlenir.
- **Worker 1..n WorkerAssignment**: `worker_assignments.workerId` FK CASCADE; çalışan silinince çalışma kayıtları da silinir.
- **Worker 1..n Payment**: `payments.workerId` FK CASCADE; çalışan silinince ödeme kayıtları da silinir. Proje FK SET NULL (opsiyonel bağ) olduğundan ödeme kaydı çalışan silinince gider.

## 4) Index ve Constraint Kuralları
- **Indexler**
  - `projects(employerId)`
  - `income_expense(projectId, type, category)`
  - `debts(dueDate)`
  - `workers(active)`
  - `worker_assignments(projectId, workDate)`
  - `payments(workerId, projectId)`
- **CHECK Kuralları**
  - `income_expense.type IN ('income','expense')`
  - `debts.status IN ('pending','partial','paid')`
  - `amount > 0` (income_expense.amount, debts.amount, debt_payments.amount, payments.amount, workers.dailyRate)
  - `status` için proje: `status IN ('new','active','done','archived')`
  - Saat alanları için `hours >= 0`, `overtimeHours >= 0`

## 5) Haftalık Rapor Mantığı
- **Snapshot Oluşumu**: Haftalık cron/background job, `weekStart` Pazartesi olacak şekilde veriyi tarar ve `weekly_snapshots` tablosuna yazar.
- **Veri Kaynakları**: `income_expense` (income/expense toplam), `debts` (hafta içinde alınan veya vadesi gelen tutarları dahil), `debt_payments` (ödenen kısmı düşmek için), `payments` (maaş/hakediş), `worker_assignments` (çalışılan gün/saatten maaş tahmini opsiyonel).
- **Örnek Hesap**: `incomeTotal = SUM(amount WHERE type='income' AND txDate within week)`, `expenseTotal = SUM(amount WHERE type='expense' …)`, `debtTotal = SUM(debts.amount within week) - SUM(debt_payments.amount within week)`, `payrollTotal = SUM(payments.amount within week)`.
- **Cache Kullanım Nedeni**: Haftalık raporun hızlı yüklenmesi ve offline görünüm için hesap sonucu saklanır; yoğun sorguları her açılışta tekrar etmeyi önler.
- **Yeniden Hesaplama Koşulları**: İlgili tablolarda (income_expense, debts, debt_payments, payments) hafta aralığına düşen yeni/UPDATE/DELETE işlemi olduğunda snapshot invalid edilir veya yeniden üretilir. Manuel “yenile” aksiyonu da tetikleyebilir.
