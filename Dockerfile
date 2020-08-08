FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /src
COPY ["MyFirstAspNetApi.csproj", "./"]
RUN dotnet restore "./MyFirstAspNetApi.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "MyFirstAspNetApi.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "MyFirstAspNetApi.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "MyFirstAspNetApi.dll"]
