# Fatura Yönetim Sistemi (Invoice App)

Staj projesi kapsamında geliştirilen, çok kiracılı (multi-tenant) bir fatura yönetim uygulaması. Firmalar kendi şubelerini, müşteri ve fatura kayıtlarını yönetir, her firma içinde esnek bir yetki/profil sistemiyle çalışan bazında ayrıntılı erişim kontrolü sağlanır. Backend ASP.NET Core, frontend Next.js, veritabanı MSSQL Server olarak tasarlandı; tüm sistem Docker Compose ile tek komutla ayağa kalkar.

## Özellikler

- **Çok kiracılı (multi-tenant) yapı**: Sistem admini firmalar oluşturur; her firmanın müşteri, fatura, kullanıcı ve profil kayıtları diğer firmalardan tamamen izole çalışır.
- **Profil/yetki (RBAC) sistemi**: Her firma kendi içinde sınırsız sayıda yetki profili tanımlayabilir (örn. "Müşteri Düzenleyici", "Fatura Düzenleyici"). Yetkiler Kaynak × İşlem (Kullanıcılar/Müşteriler/Faturalar/Profiller/Şubeler × Oluştur/Görüntüle/Düzenle/Sil) matrisi üzerinden atanır.
  - **Alt küme kuralı**: Kimse sahip olmadığı bir yetkiyi başkasına veremez; bir kullanıcı yalnızca kendi yetki kümesinin alt kümesi olan profiller oluşturabilir/atayabilir/düzenleyebilir.
  - **Kilitlenme korumaları**: Kimse kendi hesabını veya kendine atanmış profili düzenleyemez/silemez; sistem profili ("admin") değiştirilemez; bir firmanın tam yetkili son kullanıcısı silinemez veya yetkisi düşürülemez.
- **Şube (Branch) yapısı**: Her firma birden fazla şubeye sahip olabilir; firma oluşturulduğunda otomatik bir "Merkez" şubesi seed edilir (silinemez, düzenlenebilir). Şubeler arası veri izolasyonu sağlanır — bir şube kullanıcısı başka bir şubenin müşteri/fatura kayıtlarını göremez; `CanAccessAllBranches` yetkisine sahip kullanıcılar tüm şubeleri görüp yönetebilir.
- **Fatura numaralandırma**: Her şube için birden fazla fatura serisi (ön ek/birim kodu) tanımlanabilir. Gerçek fatura numarası, taslak aşamasında değil yalnızca **gönderim anında**, eşzamanlılığa karşı korumalı şekilde ilgili seriden tahsis edilir (`{ÖnEk}{Yıl}{9 haneli sıra no}` formatında, her yıl 1'den yeniden başlar).
- **Taslak / Gönderim yaşam döngüsü**: Faturalar önce taslak olarak kaydedilir, serbestçe düzenlenebilir/silinebilir. "Gönder" ile fatura kesinleşir: numara atanır, tam validasyon (KDV oranı izinleri, tutar limitleri) çalışır, durum "Gönderildi"ye döner ve bir daha düzenlenemez.
- **e-Fatura XML + XSLT önizleme**: Fatura verisinden UBL-TR benzeri bir XML üretilir ve GİB'in resmi XSLT şablonuyla (SaxonC-HE, Python `saxonche` üzerinden) HTML'e dönüştürülüp tarayıcıda önizlenir. Gönderim öncesi bu önizlemeyi gösteren zorunlu bir onay adımı vardır. Gönderim, GİB'in "1300 Başarıyla Tamamlandı" durumunu simüle eder — gerçek bir devlet/entegratör bağlantısı kurulmaz, mali mühür imzalanmaz.
- **Fatura listesi toplamları**: Fatura listesinin altında, o an aktif filtreye (tarih, arama, şube, durum) uyan **tüm** kayıtların toplam KDV matrahı/tutarı/genel toplamını gösteren sabit bir satır.
- **Fatura yönetimi**: Oluşturma, düzenleme, soft-delete, kalem bazlı KDV hesaplaması, profile özel izinli KDV oranı kısıtı, fatura tutarı için profile özel alt/üst limit doğrulaması, tarih aralığı filtresi.
- **Müşteri yönetimi**: Firma ve şube bazlı müşteri CRUD işlemleri.
- **Dashboard**: Rol ve yetkiye duyarlı özet ekranı — sistem admini toplam/yeni firma sayısını ve son eklenen firmaları görür; firma kullanıcıları yalnızca kendi yetkilerinin kapsadığı özet kartlarını (fatura, ciro, müşteri, kullanıcı, profil sayısı) ve son faturaları görür.
- **JWT tabanlı kimlik doğrulama**, BCrypt ile şifre hashleme.
- **Türkçe/İngilizce dil desteği (i18n)**, kullanıcı bazlı ve anlık dil değişimi.
- **Aydınlık/koyu tema** ve birkaç hazır renk teması (varsayılan/mavi/yeşil/mor), tercihler tarayıcıda saklanır.
- Tüm liste ekranlarında ortak bir bileşen üzerinden **sayfalama, arama ve sıralama**.
- **Docker Compose** ile tek komutla ayağa kalkan tam sistem (backend, frontend, MSSQL).

## Teknoloji Yığını

- **Backend**: ASP.NET Core 10 (.NET 10), Entity Framework Core, JWT Bearer kimlik doğrulama, BCrypt.Net
- **Frontend**: Next.js 16 (React 19), shadcn/ui, Tailwind CSS v4, next-intl (i18n), next-themes (tema)
- **Veritabanı**: MSSQL Server 2022 (Docker container)
- **e-Fatura dönüştürme**: Python 3 + SaxonC-HE (`saxonche`) — GİB XSLT şablonunun sunucu tarafında HTML'e dönüştürülmesi için (Docker imajına gömülü, ekstra kurulum gerekmez)
- **Konteynerleştirme**: Docker & Docker Compose

## Mimari

Backend katmanlı mimariyle organize edilmiştir:

```
Controller  → API uç noktaları, kimlik/yetki doğrulama
Service     → İş kuralları (izin kontrolü, alt küme kuralı, KDV hesaplama, e-Fatura üretimi vb.)
Repository  → Veri erişimi (generic repository + EF Core)
Common      → Entity'ler, DTO'lar, hata kodları, paylaşılan yardımcılar
```

Yetkilendirme, dinamik bir `Permission:{Kaynak}:{İşlem}` policy mekanizmasıyla çalışır; her isteğin izin kontrolü kullanıcının profiline göre sunucu tarafında yapılır (JWT yalnızca kimliği taşır, yetkiler her istekte veritabanından çözülür).

e-Fatura önizleme akışı: fatura + müşteri + firma + şube verisinden bellek içinde bir UBL-TR benzeri XML üretilir (`System.Xml.Linq`), ardından bu XML bir Python alt süreci (`saxonche`) aracılığıyla GİB'in resmi XSLT şablonuyla HTML'e dönüştürülür ve `/api/Invoices/{id}/preview` uç noktasından döner.

Frontend App Router yapısındadır; sayfa erişimi Server Component katman koruyucularıyla (layout guard) sağlanır, izin bazlı arayüz öğeleri (menü, buton, sayfa erişimi) `/api/Me/permissions` uç noktasından gelen veriyle anlık olarak filtrelenir.

## Kurulum ve Çalıştırma

### Gereksinimler

Yalnızca Docker ve Docker Compose. Başka hiçbir şeyin (.NET SDK, Node.js, Python vb.) yerel makinede kurulu olmasına gerek yoktur; her şey container içinde çalışır.

### Adımlar

1. Repoyu klonlayın:
   ```bash
   git clone <repo-url>
   cd invoice-app
   ```

2. `.env.example` dosyasını `.env` olarak kopyalayıp içindeki değerleri (özellikle şifreleri) güncelleyin:
   ```bash
   cp .env.example .env
   ```

3. Tüm servisleri ayağa kaldırın:
   ```bash
   docker compose up --build
   ```

4. Veritabanı şemasını oluşturun (yalnızca ilk çalıştırmada gerekir):
   ```bash
   docker compose exec backend dotnet ef database update
   ```

5. Servisler hazır olduğunda:
   - Frontend: http://localhost:3000
   - Backend API (Swagger): http://localhost:5000/swagger
   - MSSQL: `localhost,1433` (kullanıcı: `sa`, şifre: `.env` dosyasındaki değer)

6. İlk girişte, `.env` dosyasındaki `SEED_ADMIN_USERNAME` / `SEED_ADMIN_PASSWORD` değerleriyle sistem admini olarak giriş yapıp ilk firmanızı oluşturabilirsiniz (Firmalar ekranından firma adı + ilk kullanıcı bilgileriyle). Firma oluşturulduğunda otomatik olarak bir "Merkez" şubesi ve ilk fatura serisi de birlikte oluşturulur.

## Klasör Yapısı

```
invoice-app/
├── docker-compose.yml
├── .env.example
├── backend/                  # ASP.NET Core Web API
│   ├── InvoiceApp.Api/
│   ├── InvoiceApp.Service/
│   │   └── EInvoice/          # UBL-TR XML üretimi + XSLT/Python dönüştürme
│   ├── InvoiceApp.Repository/
│   └── InvoiceApp.Common/
└── frontend/                 # Next.js
```

## Docker Olmadan (Geliştirme Ortamında) Çalıştırma

Backend:
```bash
cd backend
dotnet run --project InvoiceApp.Api
```

Frontend:
```bash
cd frontend
npm install
npm run dev
```

Not: e-Fatura önizleme özelliği için yerel ortamda `python3` ve `saxonche` paketinin kurulu olması gerekir (`pip3 install --break-system-packages saxonche`); aksi halde yalnızca önizleme uç noktası çalışmaz, diğer tüm özellikler etkilenmez.

## API Dokümantasyonu

Backend ayaktayken Swagger arayüzü üzerinden tüm uç noktalar incelenebilir: http://localhost:5000/swagger

---

Bu proje bir yazılım mühendisliği stajı kapsamında geliştirilmiştir.
