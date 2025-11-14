# Usta Takip - Teknik Taslak

## Mimari Yaklaşım
- **Katmanlı Clean Architecture**: Presentation (Flutter UI) → Application (State & UseCase) → Data (Repository) → Infrastructure (SQLite/Services). Her katmanda bağımlılıklar yalnızca bir alt katmana akar.
- **Modüler Paketleme**: `core`, `features/dashboard`, `features/projects`, `features/employers`, `features/workers`, `features/finance`, `features/debts`, `features/reports`. Ortak widget ve servisler `core` içinde tutulur.
- **Tema / UI Dili**: Koyu tema, kart tabanlı düzen, Material 3 + özelleştirilmiş tonlar. Atomik bileşenler (badge, stat card, chip) ile hızlı prototip.
- **Veri Erişimi**: Lokal SQLite + `drift` veya `floor`. Export işlemleri için arka planda PDF/Excel servisleri.
- **Senkronizasyon**: İlk fazda offline-first. İleride API eklendiğinde repository ara katmanı sayesinde web servislerine geçiş kolay.

## Ekran Taslakları
### 1. Dashboard
- Hero üst kartı: Toplam gelir, gider, net bakiye donut chart.
- "Toplam İşveren Borcu" için vurgulu info card + ödeme çağrısı.
- Aktif projeler yatay kaydırılabilir kart listesi (durum, kalan tutar, sorumlu usta).
- Yaklaşan vadeler liste elemanı (borç kartı + kalan gün).
- Kısa aksiyon butonları: `Yeni Proje`, `Gelir Ekle`, `Gider Ekle`.

### 2. İşveren Yönetimi
- Liste ekranı: Arama barı, alfabetik section header, borç rozeti.
- Detay: Üstte işveren bilgisi, alt sekmeler **Projeler**, **Borçlar**, **İletişim**.
- Borç listesinde PDF/Excel indirme ikonları.

### 3. Proje Yönetimi
- Proje kartı: Başlık, tarih, durum chip, ilerleme çubuğu (harcanan/kalan bütçe).
- Detay sekmeleri:
  - **Özet**: Gelir-gider karşılaştırması, net bakiye, durum timeline.
  - **Çalışanlar**: Tablo kartları; isim, günlük ücret, toplam gün.
  - **Finans**: Transaction list (gelir/gider). Filtre chipleri.
  - **Borçlar**: İşveren borçlarına bağlanan kayıtlar.
  - **Ödemeler**: Hakediş takibi, ödeme aksiyonları.

### 4. Gelir & Gider
- Modal form: kategori seçim chipleri, tutar, açıklama, ilişkilendirilecek proje ve işveren.
- Liste: segment control ile Gelir/Gider ayrımı, renk kodlu satırlar.

### 5. Çalışan Yönetimi
- Liste: avatar + günlük ücret, aktif projeler badge'i.
- Detay: Ücret bilgisi, çalışma günleri timeline, hakediş grafiği.
- "Gün ekle" butonu ile proje-gün bağlama.

### 6. Borç Modülü
- Filtrelenebilir tablo: tutar, işveren, alınan tarih, vade, durum.
- Yaklaşan vadeler için üstte alert banner.
- Kart detayında ödeme planı, kısmi ödeme ekleme.

### 7. Haftalık Raporlar
- Tarih seçici + kartta özet (gelir, gider, borç, maaş).
- "PDF oluştur" ve "Excel indir" butonları; işlem tamamlandığında paylaşım sayfası açılır.

## Widget / Component Breakdown
- `StatCard`: ikon + başlık + değer. Dashboard ve raporlar.
- `ProgressBudgetCard`: Proje bütçe ilerleme göstergesi.
- `DebtBadge`: İşveren veya borç listelerinde durum vurgusu.
- `TransactionTile`: Gelir/Gider satırı, kategori ikonları.
- `WorkerChip` & `WorkerCostCard`: çalışan detayları.
- `SectionScaffold`: Sekmeli içeriklerde ortak çerçeve.
- `ReminderTile`: vade bildirimleri.
- `ExportButtonBar`: PDF/Excel aksiyonları.

## Veri Modeli
### Varlıklar & İlişkiler
- **Employer (İşveren)** 1..n **Project**
- **Project** 1..n **IncomeExpense** (finans), 1..n **WorkerAssignment**, 1..n **Debt**
- **Worker** 1..n **WorkerAssignment**, 1..n **Payment**
- **Debt** 1..n **DebtPayment**
- Haftalık raporlar `WeeklySnapshot` tablosundan veya dinamik sorgu.

### Tablo Şemaları
| Tablo | Alanlar | Açıklama |
| --- | --- | --- |
| `employers` | `id`, `name`, `contact`, `note`, `totalCreditLimit`, `createdAt`, `updatedAt` | İşveren temel bilgileri. |
| `projects` | `id`, `employerId`, `title`, `startDate`, `endDate`, `status`, `budget`, `description`, `createdAt` | Proje meta verisi. |
| `income_expense` | `id`, `projectId`, `employerId`, `type` (income/expense), `category`, `amount`, `description`, `txDate`, `createdAt` | Gelir/gider hareketleri. `category` enum değerleri (işveren ödemesi, borç vb.). |
| `workers` | `id`, `fullName`, `dailyRate`, `phone`, `note`, `hireDate`, `active` | Çalışan kayıtları. |
| `worker_assignments` | `id`, `workerId`, `projectId`, `workDate`, `hours`, `overtimeHours` | Gün bazlı çalışma kayıtları. |
| `payments` | `id`, `workerId`, `projectId`, `amount`, `paymentDate`, `method`, `note` | Hakediş ödemeleri. |
| `debts` | `id`, `employerId`, `projectId`, `amount`, `borrowDate`, `dueDate`, `description`, `status` (pending/partial/paid) | İşverenden alınan borç. |
| `debt_payments` | `id`, `debtId`, `amount`, `paymentDate`, `note` | Borcun ödenen kısımları. |
| `reminders` | `id`, `debtId`, `type`, `scheduledAt`, `sentAt` | Vade bildirimleri. |
| `weekly_snapshots` | `id`, `weekStart`, `incomeTotal`, `expenseTotal`, `debtTotal`, `payrollTotal`, `generatedAt` | Rapor cache tablosu. |
| `exports` | `id`, `type` (pdf/excel), `payload`, `status`, `filePath`, `createdAt`, `completedAt` | Oluşturulan dosyalar ve durumları. |

### Ek Kurallar
- Tüm parasal alanlar `INTEGER` (kuruş bazlı) saklanır.
- `status` alanları için `CHECK` constraint (örneğin `status IN ('new','active','done','archived')`).
- Sık kullanılan sorgular için indexler: `projects(employerId)`, `income_expense(projectId, type)`, `worker_assignments(projectId, workDate)`, `debts(dueDate)`.
- Haftalık rapor `worker_assignments` + `payments` + `income_expense` üzerinden hesaplanıp `weekly_snapshots` tablosuna yazılır (cron benzeri background task).

## Repository + Service Yapısı
```
lib/
  core/
    database/app_database.dart
    error/failure.dart
    theme/
  features/
    dashboard/
      data/dashboard_repository.dart
      application/dashboard_notifier.dart
      presentation/dashboard_page.dart
    employers/
      data/employer_repository.dart
      domain/employer.dart
      application/employer_notifier.dart
    projects/
      data/project_repository.dart
      ...
    finance/
      data/finance_repository.dart
      domain/income_expense.dart
    workers/
      data/worker_repository.dart
      domain/worker.dart
    debts/
      data/debt_repository.dart
      domain/debt.dart
    reports/
      data/report_repository.dart
      services/export_service.dart
```
- **Repository** katmanı: SQLite DAO'larıyla çalışır, entity ↔ DTO dönüşümü yapar.
- **Service** katmanı: PDF/Excel üretimi, bildirim planlama, hatırlatma scheduler. Ör: `ExportService`, `ReminderService`.
- **UseCase/Application**: State yönetimini besleyen `Notifier`/`Bloc`. İş kuralları (örneğin borç kapatma) burada tutulur.
- **Dependency Injection**: `riverpod` `ProviderScope` veya `get_it` + `riverpod` kombinasyonu.

## State Management Önerisi
- **Riverpod + StateNotifier**: Modüler yapı, test edilebilirlik ve bağımlılık enjeksiyonu kolaylığı nedeniyle seçildi.
- Her feature için `StateNotifier` veya `AsyncNotifier`:
  - `DashboardNotifier`: repo verilerine abone, özetleri hesaplar.
  - `ProjectDetailNotifier`: sekme bazlı state (summary, workers, finance) lazy load.
  - `DebtNotifier`: due date filtrasyonu + reminder trigger.
- Formlar için `Formz` veya `riverpod` `StateProvider` ile hafif state.
- Arka plan işlemleri (export, reminder) için `riverpod` `FutureProvider` + `ProviderListener` ile snackbar/toast.

## Kod Başlangıç Template'i
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await AppDatabase.init();
  runApp(ProviderScope(
    overrides: [appDatabaseProvider.overrideWithValue(db)],
    child: const UstaTakipApp(),
  ));
}

class UstaTakipApp extends StatelessWidget {
  const UstaTakipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Usta Takip',
      theme: AppTheme.dark(),
      home: const DashboardPage(),
    );
  }
}
```

Örnek repository iskeleti:
```dart
class ProjectRepository {
  ProjectRepository(this._db);
  final AppDatabase _db;

  Future<List<Project>> fetchActive() async {
    final rows = await _db.projectDao.fetchActive();
    return rows.map(ProjectMapper.fromRow).toList();
  }

  Future<void> save(Project project) async {
    await _db.projectDao.upsert(ProjectMapper.toCompanion(project));
  }
}
```

StateNotifier örneği:
```dart
final dashboardProvider = AsyncNotifierProvider<DashboardNotifier, DashboardState>(
  DashboardNotifier.new,
);

class DashboardNotifier extends AsyncNotifier<DashboardState> {
  @override
  Future<DashboardState> build() async {
    final repo = ref.read(dashboardRepositoryProvider);
    final summary = await repo.fetchSummary();
    return DashboardState.fromSummary(summary);
  }
}
```

## Export ve Bildirim Servisleri
- **ExportService**: `income_expense`, `payments`, `debts` tablolarından veri çekip `pdf`/`xlsx` üretir, dosya yolunu `exports` tablosuna yazar.
- **ReminderService**: `debts.dueDate` yaklaşan kayıtları tarar, lokal notifikasyon veya push tetikler. Scheduler `Workmanager` ile.

## Test ve Doğrulama Notları
- Repository birimleri için `sqflite_common_ffi` ile in-memory test.
- StateNotifier testleri `riverpod_test`.
- Export servisleri için fixture veri ile PDF/Excel çıktısı hash kontrolü.
