# API Tasarımı

## 1) Offline-First Mimari Açıklaması
- **Local-first, server-later**: Ana veri kaynağı lokal SQLite. API geldiğinde repository katmanı aynı interface ile uzak veri kaynağını ekler.
- **Repository katmanı**: `LocalDataSource` (SQLite/DAO) ve `RemoteDataSource` (HTTP) soyutlanır; senkronizasyon servisleri repository üzerinden delta üretir.
- **Önbellek ve delta sync**: Tüm CRUD işlemleri önce lokalde yazılır → “pending queue” kuşağına alınır → ağ geldiğinde kuyruğa göre PATCH/POST yapılır → sunucudan dönen id/versiyon ile lokal güncellenir.
- **Senkron kuralları**: `updatedAt` tabanlı artımlı çekme; son senkron zamanına göre değişen kayıtlar alınır. Silinen kayıtlar için `deletedAt` veya “tombstone” satırı tutulur.
- **Çakışma çözümü**: Varsayılan “server-wins”; saha için kritik alanlar (tutar, tarih) için merge stratejisi kullanılabilir. İsteğe bağlı “client-wins” politikası üzerinden zorlama yapılabilir.
- **Offline işlemler**: UI her zaman lokaldeki snapshot’ı gösterir. Export/paylaşım işlemleri dahi lokalde üretilir; yalnızca paylaşımda ağa ihtiyaç duyar.

## 2) Endpoint Taslakları
Not: Backend henüz yok, taslak olarak hazırlanmıştır; tüm endpointler HTTPS zorunludur ve `Authorization: Bearer <token>` bekler.

### Employers
- **GET /employers**  
  - Amaç: İşveren listesini ve güncel versiyonlarını getirir.  
  - Örnek response:  
    ```json
    {
      "data": [
        {"id":1,"name":"Acme","contact":"+90...","note":null,"updatedAt":"2024-02-10T12:00:00Z"}
      ],
      "lastSync":"2024-02-10T12:00:00Z"
    }
    ```  
  - Senkron rolü: Artımlı çekme için `updatedAt` filtrelenir.
- **POST /employers**  
  - Amaç: Yeni işveren oluşturur.  
  - Örnek request:  
    ```json
    {"name":"Yeni İşveren","contact":"+90","note":""}
    ```  
  - Örnek response: `201 Created` + oluşturulan kayıt.  
  - Senkron rolü: Lokal pending kaydı sunucu id’siyle eşler.
- **PUT /employers/:id**: Kayıt güncelleme; `updatedAt` döner.  
- **DELETE /employers/:id**: Yumuşak silme (tombstone) önerilir; `deletedAt` set edilir.

### Projects
- **GET /projects** / **GET /projects/:id**: Listeleme ve detay; `updatedAt`/`deletedAt` desteği.  
- **POST /projects**  
  - Request: `{"employerId":1,"title":"Bahçe Düzenleme","startDate":"2024-02-01","status":"active","budget":500000}`  
  - Response: `201 Created` + proje.  
- **PUT /projects/:id**: Güncelleme, versiyon artırımı.  
- **DELETE /projects/:id**: Yumuşak silme; bağlı finans/assignment kayıtlarına CASCADE yerine tombstone referansı.
- Senkron rolü: Proje id’leri diğer uçlar için referans teşkil eder; delta çekme zorunlu.

### Finance (IncomeExpense)
- **GET /transactions**: `?updatedAfter=` ve `?projectId=` filtreleriyle gelir/gider kayıtlarını getirir.  
- **POST /transactions**:  
  ```json
  {"projectId":5,"employerId":1,"type":"expense","category":"malzeme","amount":120000,"txDate":"2024-02-02","description":"Toprak"}
  ```  
  Response `201 Created` + `id`, `updatedAt`.  
- **PUT /transactions/:id**: Güncelleme; tutar ve kategori değişiklikleri.  
- **DELETE /transactions/:id**: Yumuşak silme veya sert silme parametreli.  
- Senkron rolü: Finansal delta; offline eklenen kayıtlar kuyruğa alınır.

### Debts (İşveren Borcu)
- **GET /debts**: Liste; `status`, `dueBefore`, `updatedAfter` filtreleri.  
- **POST /debts**:  
  ```json
  {"employerId":1,"projectId":5,"amount":300000,"borrowDate":"2024-02-03","dueDate":"2024-03-01","status":"pending","description":"Avans"}
  ```  
- **PUT /debts/:id**: Durum ve tutar düzeltmeleri.  
- **GET /debts/:id/payments**: Borç altındaki ödemeler.  
- **POST /debts/:id/payments**:  
  ```json
  {"amount":50000,"paymentDate":"2024-02-10","note":"Kısmi ödeme"}
  ```  
- Senkron rolü: Vade bazlı hatırlatmalar için dueDate delta çekilir; ödemeler borçla beraber versiyonlanır.

### Workers
- **GET /workers**: Aktif/pasif filtreleri; `updatedAfter` desteği.  
- **POST /workers**:  
  ```json
  {"fullName":"Ali Usta","dailyRate":75000,"phone":"+90","active":true}
  ```  
- **PUT /workers/:id**: Ücret veya aktiflik güncelleme.  
- **DELETE /workers/:id**: Yumuşak silme; assignments/payments bağı korunur.

### Reports
- **GET /reports/weekly**: Parametre: `weekStart`. Response cachelenmiş özet.  
- **GET /reports/project/:id**: Proje bazlı özet; gelir/gider/borç/maaş toplamları.  
- Senkron rolü: Raporlar hesaplanmış veri döner; lokaldeki snapshot ile kıyaslanıp gerekirse güncellenir.

## 3) JSON Kontratları
### Employer JSON
- Zorunlu: `id` (int), `name` (string), `updatedAt` (datetime)
- Opsiyonel: `contact` (string), `note` (string), `deletedAt` (datetime)

### Project JSON
- Zorunlu: `id`, `employerId`, `title`, `startDate`, `status`, `budget`, `updatedAt`
- Opsiyonel: `endDate`, `description`, `deletedAt`

### IncomeExpense JSON
- Zorunlu: `id`, `projectId`, `employerId`, `type` (`income`/`expense`), `category`, `amount` (int), `txDate`, `updatedAt`
- Opsiyonel: `description`, `deletedAt`

### Debt JSON
- Zorunlu: `id`, `employerId`, `amount`, `borrowDate`, `dueDate`, `status`, `updatedAt`
- Opsiyonel: `projectId`, `description`, `deletedAt`

### DebtPayment JSON
- Zorunlu: `id`, `debtId`, `amount`, `paymentDate`, `updatedAt`
- Opsiyonel: `note`, `deletedAt`

### Worker JSON
- Zorunlu: `id`, `fullName`, `dailyRate`, `active`, `updatedAt`
- Opsiyonel: `phone`, `note`, `deletedAt`

### Payment JSON
- Zorunlu: `id`, `workerId`, `amount`, `paymentDate`, `updatedAt`
- Opsiyonel: `projectId`, `note`, `deletedAt`

### WeeklyReport JSON
- Zorunlu: `weekStart`, `incomeTotal`, `expenseTotal`, `debtTotal`, `payrollTotal`, `generatedAt`
- Opsiyonel: `projectId` (proje özel rapor), `notes`

## 4) Senkronizasyon Modeli
- **İlk senkron**: Uygulama ilk açılışta tüm tabloları çekip lokal SQLite’a yazar, `lastSync` tutulur.
- **Artımlı senkron**: `updatedAfter=lastSync` parametresiyle yalnız değişen kayıtlar alınır; tombstone satırlarıyla silinenler lokalde işaretlenir.
- **Kirli kayıt/pending queue**: Lokal insert/update/delete işlemleri `pending` kuyruğuna yazılır; durumları `pending → syncing → synced/failed` olarak izlenir. Başarısız istek tekrar denenir.
- **Versiyonlama**: Her kayıt `updatedAt` ve opsiyonel `version` taşır; sunucu her değişimde artırır. İstemci pending kayıt için geçici uuid kullanır.
- **Çakışma çözme**:
  - Varsayılan: **server wins**; istemci kendi değişimini sunucu versiyonuna uygular veya kullanıcıya fark bildirir.
  - Opsiyonel: **client wins**; saha önceliği gereken alanlarda (örn. hızlı gider girişi) sunucuya zorla yazılır, sunucu audit için eski değeri saklar.
  - Merge kuralı: Tutar ve tarih gibi alanlarda son güncelleme zaman damgası erken olan kaybeder; not alanları birleştirilebilir.
- **Zaman damgası kullanımı**: Tüm endpoint responses `updatedAt` içerir; istemci `lastSync` + kayıt bazlı `updatedAt` ile delta üretir.

## 5) Güvenlik Taslağı
- **Token yapısı**: JWT (HS256/RS256) taslak; payload örneği: `{"sub":"userId","iat":..., "exp":..., "scope":["read","write"]}`.
- **Authorization header**: `Authorization: Bearer <jwt>` zorunlu; refresh token akışı önerilir.
- **SSL zorunluluğu**: Tüm trafik HTTPS; HSTS önerilir.
- **Rate limiting**: IP + user bazlı limit (örn. 1000 request/15dk). Senkron isteklerine öncelik tanıyacak burst-kuşak uygulanabilir.
- **Payload imzalama**: İsteğe bağlı olarak body hash’i header’da (`X-Payload-Signature`) tutulur; tamlık kontrolü için sunucu-side doğrulama yapılır; replay’e karşı nonce/timestamp eklenir.
