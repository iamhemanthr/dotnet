# Use the latest version of the ASP.NET Core SDK as build image
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# Copy the project file and restore dependencies
COPY ["YourDotNetModule/YourDotNetModule.csproj", "YourDotNetModule/"]
RUN dotnet restore "YourDotNetModule/YourDotNetModule.csproj"

# Copy the entire project and build
COPY . .
WORKDIR "/src/YourDotNetModule"
RUN dotnet build "YourDotNetModule.csproj" -c Release -o /app/build

# Publish the application
FROM build AS publish
RUN dotnet publish "YourDotNetModule.csproj" -c Release -o /app/publish

# Use the ASP.NET Core Runtime as base image for the final stage
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS final
WORKDIR /app

# Copy the published app from the 'publish' stage
COPY --from=publish /app/publish .

# Expose port 80
EXPOSE 80

# Set the entry point for the application
ENTRYPOINT ["dotnet", "YourDotNetModule.dll"]

