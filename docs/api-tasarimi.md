# API Tasarımı

## Amaç
Offline-first yaklaşım temel alınarak ileride eklenecek REST API yapısının taslak olarak belirlenmesi.

## Offline-First Stratejisi
- Lokal veritabanı ana kaynak.
- API eklendiğinde repository katmanı senkronize çalışacak.

## Endpoint Taslakları (İleride)
- /projects
- /employers
- /finance
- /debts
- /workers
- /reports

## JSON Kontrat Örnekleri
(JSON input/output yapıları burada tanımlanacak.)

## Senkronizasyon Stratejisi
- Lokal → Sunucu
- Sunucu → Lokal
- Çakışma çözme kuralları
