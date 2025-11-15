# Ekran Listesi

## Amaç
Usta Takip uygulamasındaki tüm ekranları, kullanıcı akışlarını ve genel bileşen yapısını tanımlamak.

## Modüller
- Dashboard
- İşveren Yönetimi
- Proje Yönetimi
- Çalışan Yönetimi
- Finans (Gelir/Gider)
- Borçlar (İşveren Borcu)
- Haftalık Raporlar

## Ekranlar
### Dashboard
- **Açıklama**: Uygulamanın ana kontrol ve özet ekranı. Tüm projelerin gelir, gider, işveren borcu ve yaklaşan vadelerinin görüldüğü ekran.
- **Kullanıcı Akışı**: Uygulama açılır → Dashboard yüklenir → kullanıcı kısa aksiyonlardan işlem ekler veya projeler listesine geçer → vade hatırlatmalarını inceler.
- **Bileşen Listesi**:
  - StatCard (gelir, gider, net bakiye)
  - DebtInfoCard (toplam işveren borcu)
  - HorizontalProjectList
  - ReminderTile (yaklaşan vadeler)
  - QuickActionButtons (Yeni Proje, Gelir Ekle, Gider Ekle)

### İşveren Listesi
- **Açıklama**: Tüm işverenlerin listelendiği ekran. İşverene özel borç ve proje sayısı burada görünür.
- **Kullanıcı Akışı**: İşveren modülü açılır → liste gösterilir → arama yapılır → işveren seçilerek detay ekranına gidilir.
- **Bileşen Listesi**:
  - SearchBar
  - EmployerTile (isim, proje sayısı, borç rozeti)
  - FloatingActionButton (yeni işveren ekle)

### İşveren Detay
- **Açıklama**: Seçilen işverene ait özet, projeleri ve borçların yönetildiği ekran.
- **Kullanıcı Akışı**: İşveren seçilir → detay açılır → Projeler / Borçlar / İletişim sekmeleri arasında geçiş yapılır → export aksiyonları tetiklenir.
- **Bileşen Listesi**:
  - EmployerHeaderCard
  - TabBar (Projeler / Borçlar / İletişim)
  - DebtList
  - ProjectListMini
  - ExportButtonBar (PDF/Excel)

### Proje Listesi
- **Açıklama**: Tüm projelerin durum ve özet bilgisiyle listelendiği ekran.
- **Kullanıcı Akışı**: Proje modülü açılır → proje kartları incelenir → filtre uygulanır → proje seçilerek detayına gidilir.
- **Bileşen Listesi**:
  - ProjectCard (başlık, tarih, bütçe ilerleme, durum chip)
  - FilterChips
  - FloatingActionButton (yeni proje)

### Proje Detay (Özet / Finans / Borçlar / Çalışan / Ödemeler)
- **Açıklama**: Seçilen proje için finans, borç, çalışan ve ödeme bilgilerini sekmeler halinde gösteren detay ekranı.
- **Kullanıcı Akışı**: Proje kartı seçilir → Proje Detay açılır → sekmeler arası geçiş yapılarak ilgili listeler görüntülenir veya yeni kayıt eklenir.
- **Bileşen Listesi**:
  - **Özet Sekmesi**
    - StatCard (gelir, gider, net bakiye)
    - ProgressBudgetCard
    - TimelineCard
  - **Finans Sekmesi**
    - TransactionList
    - CategoryFilterChips
    - AddIncomeButton
    - AddExpenseButton
  - **Borçlar Sekmesi (İşveren Borcu)**
    - BorrowedDebtList
    - DueDateAlert
    - AddDebtButton
  - **Çalışanlar Sekmesi**
    - WorkerCardList
    - AddWorkDayButton
    - WorkerSummaryCard
  - **Ödemeler Sekmesi**
    - PaymentList
    - AddPaymentButton

### Gelir/Gider Ekle
- **Açıklama**: Hızlı işlem ekleme popup’ı.
- **Kullanıcı Akışı**: Dashboard veya proje detayından açılır → kategori seçilir → tutar ve açıklama girilir → tarih ve proje seçilir → kaydedilir.
- **Bileşen Listesi**:
  - CategoryChipSelector
  - AmountInput
  - NoteInput
  - DatePicker
  - ProjectSelector

### Haftalık Rapor
- **Açıklama**: Haftalık gelir, gider, maaş ve borç dökümünü gösterir.
- **Kullanıcı Akışı**: Haftalık rapor ekranı açılır → tarih aralığı seçilir → rapor özetleri ve tablo güncellenir → PDF/Excel export alınır.
- **Bileşen Listesi**:
  - WeekPicker
  - ReportStatCards
  - ReportTable
  - ExportButtonBar
