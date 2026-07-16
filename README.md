# Fatura Yönetim Sistemi (Invoice App)

Staj projesi kapsamında geliştirdiğim fatura yönetim uygulaması. Backend ASP.NET Core, frontend Next.js, veritabanı MSSQL Server olarak tasarlandı. Tüm servisler Docker Compose ile tek komutla çalıştırılabilir.

## Mimari

- **Backend**: ASP.NET Core Web API, katmanlı mimari (Controller / Service / Repository / Common)
- **Frontend**: Next.js + shadcn/ui + Tailwind CSS
- **Veritabanı**: MSSQL Server 2022 (Docker container)

## Gereksinimler

- Docker ve Docker Compose

Başka hiçbir şeyin (SDK, Node.js vb.) yerel makinede kurulu olmasına gerek yoktur; her şey container içinde çalışır.

## Kurulum ve çalıştırma

1. Repoyu klonlayın:
   ```bash
   git clone <repo-url>
   cd invoice-app
   ```

2. `.env.example` dosyasını `.env` olarak kopyalayıp içindeki şifreyi güncelleyin:
   ```bash
   cp .env.example .env
   ```

3. Tüm servisleri ayağa kaldırın:
   ```bash
   docker compose up --build
   ```

4. Servisler hazır olduğunda:
   - Frontend: http://localhost:3000
   - Backend API (Swagger): http://localhost:5000/swagger
   - MSSQL: `localhost,1433` (kullanıcı: `sa`, şifre: `.env` dosyasındaki değer)

## Veritabanı migration'ları

İlk çalıştırmada veritabanı şemasının oluşturulması gerekir. Backend container'ı içinde:
```bash
docker compose exec backend dotnet ef database update
```

## Klasör yapısı

```
invoice-app/
├── docker-compose.yml
├── .env.example
├── backend/          # ASP.NET Core Web API
│   ├── InvoiceApp.Api/
│   ├── InvoiceApp.Service/
│   ├── InvoiceApp.Repository/
│   └── InvoiceApp.Common/
└── frontend/         # Next.js
```

## Geliştirme ortamında (Docker olmadan) çalıştırma

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