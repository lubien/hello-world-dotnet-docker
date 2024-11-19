FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.csproj ./dotnetapp/
WORKDIR /app/dotnetapp
RUN dotnet restore

# copy and build everything else
WORKDIR /app/
COPY . ./dotnetapp/
WORKDIR /app/dotnetapp
RUN dotnet publish -c Release -o out


FROM mcr.microsoft.com/dotnet/runtime:9.0 AS runtime
WORKDIR /app
COPY --from=build /app/dotnetapp/out ./
ENTRYPOINT ["dotnet", "hello-world-dotnet.dll"]
