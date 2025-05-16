FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copy the solution file and project files first for better layer caching
COPY ["UniConnect.sln", "./"]
COPY ["src/", "src/"]
COPY ["tests/", "tests/"]

# Restore dependencies
RUN dotnet restore "UniConnect.sln"

# Copy everything else
COPY . .

# Build the API project
WORKDIR "/src/src/UniConnect.API"
RUN dotnet build "UniConnect.API.csproj" -c Release -o /app/build

FROM build AS publish
# Publish the API project
RUN dotnet publish "UniConnect.API.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "UniConnect.API.dll"]
