# --- Aşama 1: Build ---
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

# Önce sadece proje dosyalarını kopyala (Docker layer cache'ten faydalanmak için)
COPY *.slnx .
COPY InvoiceApp.Api/*.csproj ./InvoiceApp.Api/
COPY InvoiceApp.Service/*.csproj ./InvoiceApp.Service/
COPY InvoiceApp.Repository/*.csproj ./InvoiceApp.Repository/
COPY InvoiceApp.Common/*.csproj ./InvoiceApp.Common/
RUN dotnet restore InvoiceApp.slnx

# Şimdi tüm kaynak kodu kopyala ve yayınla (publish)
COPY . .
RUN dotnet publish InvoiceApp.Api/InvoiceApp.Api.csproj -c Release -o /app/publish --no-restore

# --- Aşama 2: Runtime ---
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

# .NET 8+ container imajlarında varsayılan port 8080'dir
EXPOSE 8080
ENTRYPOINT ["dotnet", "InvoiceApp.Api.dll"]