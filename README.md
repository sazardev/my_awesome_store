# My Awesome Store - Manage Your Products with Ease 🏪

![My Awesome Store Logo](https://example.com/logo.png)
![Flutter 3.35.2](https://img.shields.io/badge/Flutter-3.35.2-blue)
![Dart 3.2.6](https://img.shields.io/badge/Dart-3.2.6-blue)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![Clean Architecture](https://img.shields.io/badge/Architecture-Clean-green)
![BLoC](https://img.shields.io/badge/State-BLoC-orange)
![GitHub issues](https://img.shields.io/github/issues/sazardev/my_awesome_store)

My Awesome Store is a Flutter application designed to help you manage your products efficiently. Whether you're a small business owner or just someone who loves to keep track of their inventory, this app has got you covered!

If you have a local store, you can use this app to manage your products, track inventory, and even generate QR codes for easy product identification! Also support rack management, you can manage your products by rack.

You can add, edit, and delete products, as well as view detailed information about each product. The app also allows you to categorize your products for better organization.

And not only manage, you can also sell your products directly from the app! With a built-in sales feature, you can keep track of your sales and inventory in one place, you can only scan the product's QR code to add it to the sales list, making the checkout process quick and easy, and you can also view sales reports to see how your business is doing.

My Awesome Store is all-in-one solution for managing your products and sales to your store. Download it today and take control of your inventory!

> My Awesome Store is focused for Little Shops, Kiosks, and Small Businesses, not for large enterprises, please consider that before using it.

## Features

- **Product Management**: Add, edit, and delete products with ease.
- **Sales Management**: Track sales and generate sales reports.
- **Product Details**: View detailed information about each product, including name, description, price, and quantity.
- **Category Management**: Organize your products into categories for better management.
- **Sales Reports**: Generate reports to analyze your sales performance.
- **Inventory Tracking**: Keep track of stock levels and receive notifications for low inventory.
- **QR Code Generation**: Generate QR codes for your products for quick access and identification.
- **Rack Management**: Organize your products by racks for better inventory management.
- **User-Friendly Interface**: Intuitive design for easy navigation and use.
- **Cross-Platform**: Available on both Android and iOS devices.
- **Offline Support**: Manage your products even without an internet connection. (Data is stored locally on your device.)
- **Data Backup**: Backup your data to prevent loss.
- **Search Functionality**: Quickly find products using the search feature.
- **Categorization**: Organize products into categories for better management.
- **Export Data**: Export your product data to CSV for easy sharing and analysis.
- **Multi-language Support**: Available in multiple languages to cater to a global audience.
- **Dark Mode**: Enjoy a sleek dark mode for better usability in low-light conditions.
- **Barcode Scanning**: Quickly add products by scanning barcodes.

---

## 🏗️ Architecture & Technical Stack

This project follows **Clean Architecture** principles with the following tech stack:

### 📦 Core Technologies
- **Flutter** - UI Framework
- **Dart** - Programming Language
- **BLoC Pattern** - State Management (`flutter_bloc`)
- **Clean Architecture** - Layered Architecture

### 💾 Database & Persistence
- **Drift** - Modern SQLite ORM for Flutter
- **SQLite** - Local database

### 💉 Dependency Injection
- **GetIt** - Service Locator
- **Injectable** - Code generation for DI

### 🔧 Code Generation & Tools
- **Freezed** - Immutable data classes
- **JSON Serializable** - JSON serialization
- **Build Runner** - Code generation

### 🎯 Functional Programming
- **FPDart** - Either, Option, Result types for error handling

### 🎨 Design & Theming
- **Material Design 3** - Modern UI components
- **Google Fonts (Jost)** - Custom typography applied globally
- **Light & Dark Mode** - Adaptive themes that follow system preferences

### 📏 Code Quality
- **Very Good Analysis** - Strict lint rules
- **Logger** - Structured logging
- **Equatable** - Value equality

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.35.2 or higher)
- Dart SDK (3.9.0 or higher)

### Installation

1. Clone the repository
```bash
git clone https://github.com/sazardev/my_awesome_store.git
cd my_awesome_store
```

2. Install dependencies
```bash
flutter pub get
```

3. Generate code (Freezed, Injectable, Drift, JSON)
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Run the app
```bash
flutter run
```

---

## 📂 Project Structure

```
lib/
├── core/                    # Core functionality
│   ├── di/                 # Dependency Injection
│   ├── errors/             # Error handling
│   ├── database/           # Database configuration
│   └── utils/              # Utilities
│
├── features/               # Feature modules
│   ├── products/          # Product management
│   │   ├── data/          # Data layer
│   │   ├── domain/        # Business logic
│   │   └── presentation/  # UI layer
│   │
│   ├── sales/             # Sales management
│   └── categories/        # Category management
│
├── shared/                 # Shared widgets & theme
└── main.dart              # App entry point
```

### Layer Responsibilities

- **Domain Layer**: Business logic, entities, use cases, repository interfaces
- **Data Layer**: Repository implementations, data sources, models
- **Presentation Layer**: UI, BLoCs, pages, widgets

**See [CLEAN_ARCHITECTURE_GUIDE.md](CLEAN_ARCHITECTURE_GUIDE.md) for detailed architecture documentation.**

---

## 🛠️ Development Commands

```bash
# Install dependencies
flutter pub get

# Generate code
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (auto-regenerate on file changes)
flutter pub run build_runner watch --delete-conflicting-outputs

# Analyze code
flutter analyze

# Format code
dart format .

# Apply automated fixes
dart fix --apply

# Run tests
flutter test

# Run with coverage
flutter test --coverage
```

---

## 📖 Documentation

- **[CLEAN_ARCHITECTURE_GUIDE.md](CLEAN_ARCHITECTURE_GUIDE.md)** - Complete Clean Architecture guide with examples
- **[SETUP_EXAMPLES.md](SETUP_EXAMPLES.md)** - Setup examples and code templates

---

## 🏛️ Architecture Principles

This project follows **Clean Architecture** and **SOLID** principles:

- ✅ **Separation of Concerns** - Each layer has a specific responsibility
- ✅ **Dependency Inversion** - Dependencies point inward
- ✅ **Single Responsibility** - Each class does one thing well
- ✅ **Testability** - Easy to write unit tests for business logic
- ✅ **Scalability** - Easy to add new features
- ✅ **Maintainability** - Code is organized and self-documenting

---

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/features/products/domain/usecases/get_products_test.dart
```

---
