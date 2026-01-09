# FROM mcr.microsoft.com/dotnet/sdk:10.0
# WORKDIR /app
# COPY/bin/Debug/net10.0/ .
# CMD ["dotnet", "dso25dockerintro.dll"]

# Steg 1
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build

WORKDIR /src

COPY *.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o /app/publish

# Steg 2
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "dso25dockerintro.dll"]