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
COPY --from=build /app/publish .

EXPOSE 8080
ENTRYPOINT ["dotnet", "InvoiceApp.Api.dll"]