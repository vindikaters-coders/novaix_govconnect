# Novaix GovConnect

A comprehensive government services platform consisting of a Spring Boot backend API and a Flutter mobile/web application that enables citizens to connect with government services efficiently.

## 📋 Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Quick Start with Docker](#quick-start-with-docker)
- [Backend Setup](#backend-setup)
- [Frontend Setup](#frontend-setup)
- [API Documentation](#api-documentation)
- [Development](#development)
- [Contributing](#contributing)
- [License](#license)

## 🔍 Overview

Novaix GovConnect is a modern digital platform designed to bridge the gap between citizens and government services. The platform provides:

- **Backend**: RESTful API built with Spring Boot 3.5.4, featuring JWT authentication, email services, and comprehensive data management
- **Frontend**: Cross-platform Flutter application supporting mobile (Android/iOS) and web platforms
- **Database**: MySQL 8.0 for reliable data persistence
- **Security**: JWT-based authentication with Spring Security
- **Deployment**: Docker containerization for easy deployment and scaling

## 🏗️ Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Flutter App   │    │  Spring Boot    │    │     MySQL       │
│   (Frontend)    │◄──►│    Backend      │◄──►│   Database      │
│                 │    │                 │    │                 │
│ • Mobile (iOS)  │    │ • REST APIs     │    │ • User Data     │
│ • Mobile (And.) │    │ • JWT Auth      │    │ • Services      │
│ • Web           │    │ • Email Service │    │ • Requests      │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## ✨ Features

### Backend Features
- **Authentication & Authorization**: JWT-based secure authentication
- **Email Services**: Automated email notifications using Spring Mail
- **Data Validation**: Comprehensive input validation
- **Security**: Spring Security integration with role-based access control
- **Database**: JPA/Hibernate with MySQL integration
- **API Documentation**: RESTful API endpoints
- **Modular Architecture**: Clean separation of concerns

### Frontend Features
- **Cross-Platform**: Runs on Android, iOS, and Web
- **Modern UI**: Material Design components
- **Secure Storage**: Flutter Secure Storage for sensitive data
- **Navigation**: Go Router for efficient routing
- **HTTP Client**: Dio for API communication
- **Responsive Design**: Adaptive layouts for different screen sizes

## 📋 Prerequisites

### For Backend Development
- **Java**: JDK 24 or higher
- **Maven**: 3.6+ for dependency management
- **MySQL**: 8.0 or higher
- **IDE**: IntelliJ IDEA, Eclipse, or VS Code

### For Frontend Development
- **Flutter**: 3.7.0 or higher
- **Dart**: Latest stable version
- **IDE**: Android Studio, VS Code, or IntelliJ IDEA
- **Platform SDKs**:
  - Android SDK (for Android development)
  - Xcode (for iOS development on macOS)

### For Docker Deployment
- **Docker**: 20.10+
- **Docker Compose**: 2.0+

## 🚀 Quick Start with Docker

The fastest way to get the entire application running:

```bash
# Clone the repository
git clone https://github.com/vindikaters-coders/novaix_govconnect.git
cd novaix_govconnect

# Start all services with Docker Compose
docker-compose up -d

# Wait for services to start, then access:
# - Frontend: http://localhost:3000
# - Backend API: http://localhost:8080
# - MySQL: localhost:3306
```

## 🔧 Backend Setup

### 1. Clone and Navigate
```bash
git clone https://github.com/vindikaters-coders/novaix_govconnect.git
cd novaix_govconnect/govconnect-server
```

### 2. Database Configuration
Create a MySQL database and update `src/main/resources/application.yml`:

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/gov_connect?createDatabaseIfNotExist=true
    username: your_username
    password: your_password
    driver-class-name: com.mysql.cj.jdbc.Driver

  jpa:
    hibernate:
      ddl-auto: update
    show-sql: true
    properties:
      hibernate:
        dialect: org.hibernate.dialect.MySQLDialect

  mail:
    host: smtp.gmail.com
    port: 587
    username: your_email@gmail.com
    password: your_app_password
    properties:
      mail:
        smtp:
          auth: true
          starttls:
            enable: true

jwt:
  secret: your_jwt_secret_key
  expiration: 86400000  # 24 hours
```

### 3. Install Dependencies
```bash
# Using Maven wrapper (recommended)
./mvnw clean install

# Or using system Maven
mvn clean install
```

### 4. Run the Application
```bash
# Using Maven wrapper
./mvnw spring-boot:run

# Or using system Maven
mvn spring-boot:run

# Or run the JAR directly
java -jar target/govconnect-server-0.0.1-SNAPSHOT.jar
```

The backend will start on `http://localhost:8080`

### 5. Verify Installation
```bash
# Health check
curl http://localhost:8080/actuator/health

# API endpoints (if available)
curl http://localhost:8080/api/v1/health
```

## 📱 Frontend Setup

### 1. Navigate to Flutter App
```bash
cd ../govconnect_app
```

### 2. Install Flutter Dependencies
```bash
# Get Flutter packages
flutter pub get

# Verify Flutter installation
flutter doctor
```

### 3. Configure API Endpoints
Update the API base URL in your Flutter app configuration files to point to your backend:

```dart
// lib/config/api_config.dart (create if doesn't exist)
class ApiConfig {
  static const String baseUrl = 'http://localhost:8080/api/v1';
  // For Android emulator use: 'http://10.0.2.2:8080/api/v1'
  // For iOS simulator use: 'http://localhost:8080/api/v1'
  // For physical device use your computer's IP: 'http://192.168.1.xxx:8080/api/v1'
}
```

### 4. Run the Application

#### For Web Development
```bash
flutter run -d chrome
```

#### For Mobile Development
```bash
# List available devices
flutter devices

# Run on Android
flutter run -d android

# Run on iOS (macOS only)
flutter run -d ios
```

#### For Production Build
```bash
# Web build
flutter build web

# Android APK
flutter build apk

# Android App Bundle
flutter build appbundle

# iOS (macOS only)
flutter build ios
```

### 5. Platform-Specific Setup

#### Android Setup
1. Ensure Android SDK is installed
2. Create/update `android/app/src/main/AndroidManifest.xml` for permissions
3. Configure signing for release builds

#### iOS Setup (macOS only)
1. Install Xcode from App Store
2. Configure iOS development certificates
3. Update `ios/Runner/Info.plist` for permissions

#### Web Setup
1. Configure `web/index.html` for production
2. Set up proper CORS headers on backend for web deployment

## 📚 API Documentation

### Authentication Endpoints
```
POST /api/v1/auth/login          # User login
POST /api/v1/auth/register       # User registration
POST /api/v1/auth/refresh        # Refresh JWT token
POST /api/v1/auth/logout         # User logout
POST /api/v1/auth/forgot-password # Password reset
```

### User Management
```
GET    /api/v1/users             # Get all users (admin)
GET    /api/v1/users/{id}        # Get user by ID
PUT    /api/v1/users/{id}        # Update user
DELETE /api/v1/users/{id}        # Delete user
```

### Government Services
```
GET    /api/v1/services          # Get available services
POST   /api/v1/services/request  # Submit service request
GET    /api/v1/services/requests # Get user's requests
PUT    /api/v1/services/requests/{id} # Update request status
```

### Request Headers
```
Authorization: Bearer <jwt_token>
Content-Type: application/json
```

### Response Format
```json
{
  "success": true,
  "message": "Operation successful",
  "data": {},
  "timestamp": "2024-01-01T00:00:00Z"
}
```

## 🛠️ Development

### Backend Development

#### Project Structure
```
govconnect-server/
├── src/main/java/com/novaix/govconnect_server/
│   ├── GovConnectServerApplication.java    # Main application class
│   ├── config/                             # Configuration classes
│   ├── controller/                         # REST controllers
│   ├── service/                           # Business logic
│   ├── repository/                        # Data access layer
│   ├── dao/                               # Data access objects
│   ├── dto/                               # Data transfer objects
│   ├── request/                           # Request models
│   ├── response/                          # Response models
│   ├── exception/                         # Custom exceptions
│   ├── filter/                            # Security filters
│   ├── validator/                         # Custom validators
│   ├── enums/                             # Enumerations
│   └── seeder/                            # Database seeders
├── src/main/resources/
│   ├── application.yml                    # Application configuration
│   └── templates/                         # Email templates
└── pom.xml                                # Maven dependencies
```

#### Key Dependencies
- **Spring Boot Starter Web**: REST API development
- **Spring Boot Starter Data JPA**: Database operations
- **Spring Boot Starter Security**: Authentication & authorization
- **Spring Boot Starter Mail**: Email services
- **MySQL Connector**: Database connectivity
- **JWT (jjwt)**: JSON Web Token implementation
- **Lombok**: Reduce boilerplate code
- **ModelMapper**: Object mapping
- **Thymeleaf**: Template engine for emails

#### Development Commands
```bash
# Run in development mode with auto-reload
./mvnw spring-boot:run -Dspring-boot.run.profiles=dev

# Run tests
./mvnw test

# Package application
./mvnw clean package

# Skip tests during build
./mvnw clean package -DskipTests
```
