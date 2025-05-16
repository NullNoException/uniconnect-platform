FROM mcr.microsoft.com/dotnet/sdk:9.0 AS dev
WORKDIR /app

# Copy solution and restore as distinct layers
COPY UniConnect.sln ./
COPY src/ ./src/
COPY tests/ ./tests/
RUN dotnet restore UniConnect.sln

WORKDIR /app/src/UniConnect.API

# Expose HTTP, HTTPS, and VS Code debug port
EXPOSE 80
EXPOSE 443
EXPOSE 5678

ENV ASPNETCORE_ENVIRONMENT=Development
ENV DOTNET_USE_POLLING_FILE_WATCHER=1
ENV DOTNET_RUNNING_IN_CONTAINER=true

# Use dotnet watch for hot reload and debugging
ENTRYPOINT ["dotnet", "watch", "--project", ".", "run", "--urls", "http://0.0.0.0:80"]
