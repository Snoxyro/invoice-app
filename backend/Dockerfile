# --- Build ---
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

COPY *.slnx .
COPY InvoiceApp.Api/*.csproj ./InvoiceApp.Api/
COPY InvoiceApp.Service/*.csproj ./InvoiceApp.Service/
COPY InvoiceApp.Repository/*.csproj ./InvoiceApp.Repository/
COPY InvoiceApp.Common/*.csproj ./InvoiceApp.Common/
RUN dotnet restore InvoiceApp.slnx

COPY . .
RUN dotnet publish InvoiceApp.Api/InvoiceApp.Api.csproj -c Release -o /app/publish --no-restore

# --- Runtime ---
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final
WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends python3 python3-pip \
    && pip3 install --no-cache-dir --break-system-packages saxonche \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build /app/publish .
COPY --from=build /src/InvoiceApp.Service/EInvoice/Resources/gib-e-fatura.xslt ./EInvoice/gib-e-fatura.xslt
COPY --from=build /src/InvoiceApp.Service/EInvoice/Resources/transform.py ./EInvoice/transform.py

EXPOSE 8080
ENTRYPOINT ["dotnet", "InvoiceApp.Api.dll"]
