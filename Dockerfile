FROM mcr.microsoft.com/dotnet/sdk:latest AS build-env
WORKDIR /app

# Copy everything
COPY . ./
# Restore as distinct layers
RUN dotnet restore
# Build and publish a release
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/sdk:latest
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "PlatfotmService.dll"]