# 🎯 Configuración Profesional Completa - My Awesome Store

Este documento detalla todas las configuraciones adicionales profesionales agregadas al proyecto.

---

## 📦 Nuevos Paquetes Instalados

### 🌐 Networking & Conectividad
- **connectivity_plus** (v6.1.5) - Detectar estado de conexión a internet
- **url_launcher** (v6.3.2) - Abrir URLs, emails, llamadas telefónicas

### 📱 Device & App Info
- **package_info_plus** (v8.3.1) - Información de la app (versión, build, etc.)
- **device_info_plus** (v12.1.0) - Información del dispositivo

### 💾 Almacenamiento Local
- **path_provider** (v2.1.5) - Rutas de directorios del sistema
- **shared_preferences** (v2.3.5) - Almacenamiento key-value simple

### 🧭 Navegación
- **go_router** (v14.8.1) - Routing declarativo profesional

### ⚙️ Configuración
- **flutter_dotenv** (v5.2.1) - Variables de entorno (.env files)

### 🎨 Branding
- **flutter_launcher_icons** (v0.14.1) - Generación de íconos personalizados
- **flutter_native_splash** (v2.4.4) - Pantalla de splash personalizada

---

## 🔐 Variables de Entorno (.env)

### Archivos Creados

```
📁 Proyecto/
├── .env              # Base (NO subir a Git)
├── .env.dev          # Desarrollo
└── .env.prod         # Producción
```

### Configuración Actual

#### `.env.dev` (Desarrollo)
```env
API_BASE_URL=http://localhost:3000/api
API_KEY=dev_api_key_12345
API_TIMEOUT=30000
DB_NAME=my_awesome_store_dev.db
ENABLE_ANALYTICS=false
DEBUG_MODE=true
ENVIRONMENT=development
```

#### `.env.prod` (Producción)
```env
API_BASE_URL=https://api.myawesomestore.com/v1
API_KEY=prod_api_key_xxxxx
API_TIMEOUT=15000
DB_NAME=my_awesome_store.db
ENABLE_ANALYTICS=true
DEBUG_MODE=false
ENVIRONMENT=production
```

### Uso en Código

#### Opción 1: Clase Helper (Recomendado)
```dart
import 'package:my_awesome_store/core/config/env_config.dart';

void example() {
  print(EnvConfig.apiBaseUrl);      // http://localhost:3000/api
  print(EnvConfig.debugMode);       // true
  print(EnvConfig.isDevelopment);   // true
  print(EnvConfig.environment);     // development
}
```

#### Opción 2: Inyección de Dependencias
```dart
@injectable
class ApiService {
  ApiService(@Named('apiBaseUrl') this.baseUrl);
  
  final String baseUrl;
}
```

### Cambiar Entorno

En `lib/main.dart`:
```dart
// Desarrollo
await dotenv.load(fileName: '.env.dev');

// Producción
await dotenv.load(fileName: '.env.prod');
```

---

## 🎨 Íconos y Splash Screen

### Configuración en pubspec.yaml

```yaml
flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/icons/app_icon.png"
  adaptive_icon_background: "#FFFFFF"
  adaptive_icon_foreground: "assets/icons/app_icon_foreground.png"
  
flutter_native_splash:
  color: "#FFFFFF"
  image: assets/images/splash_logo.png
  android_12:
    image: assets/images/splash_logo.png
    color: "#FFFFFF"
```

### Cómo Agregar tus Íconos

1. **Crear/Descargar íconos:**
   - `app_icon.png` → 1024x1024 px
   - `app_icon_foreground.png` → 1024x1024 px (transparente)
   - `splash_logo.png` → 512x512 px

2. **Colocar en carpetas:**
   ```
   assets/
   ├── icons/
   │   ├── app_icon.png
   │   └── app_icon_foreground.png
   └── images/
       └── splash_logo.png
   ```

3. **Generar:**
   ```bash
   # Generar íconos
   flutter pub run flutter_launcher_icons
   
   # Generar splash screen
   flutter pub run flutter_native_splash:create
   ```

### Herramientas Recomendadas
- **Flaticon**: https://www.flaticon.com/
- **Icons8**: https://icons8.com/
- **Canva**: https://www.canva.com/
- **App Icon Generator**: https://www.appicon.co/

**Ver `assets/ASSETS_GUIDE.md` para más detalles.**

---

## 🧭 Sistema de Navegación (GoRouter)

### Configuración Creada

Archivo: `lib/core/config/app_router.dart`

### Uso Básico

#### Definir Rutas
```dart
GoRoute(
  path: '/products',
  name: 'products',
  builder: (context, state) => const ProductsPage(),
  routes: [
    GoRoute(
      path: ':id',
      name: 'product-detail',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ProductDetailPage(productId: id);
      },
    ),
  ],
),
```

#### Navegar
```dart
// Por path
context.go('/products');

// Por nombre
context.goNamed('products');

// Con parámetros
context.goNamed('product-detail', pathParameters: {'id': '123'});

// Volver atrás
context.pop();
```

#### Usar MaterialApp.router
```dart
@override
Widget build(BuildContext context) {
  return MaterialApp.router(
    routerConfig: AppRouter.router,
    title: EnvConfig.appName,
  );
}
```

---

## 🚀 CI/CD con GitHub Actions

### Archivo Creado

`.github/workflows/ci.yml`

### Workflows Configurados

#### 1. 📊 Analyze & Lint
- Verifica formato de código
- Ejecuta `flutter analyze`
- Detecta warnings y errores

#### 2. 🧪 Run Tests
- Ejecuta tests unitarios
- Genera reporte de cobertura
- Sube a Codecov

#### 3. 🤖 Build Android (Debug)
- Compila APK debug
- Se ejecuta en todos los branches
- Sube artifact por 7 días

#### 4. 🤖 Build Android (Release)
- Compila APK release
- Solo en branch `main`
- Sube artifact por 30 días

#### 5. 🍎 Build iOS
- Compila para iOS
- Solo en branch `main`
- Requiere macOS runner

### Triggers

```yaml
on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]
  workflow_dispatch:  # Manual trigger
```

### Badges para README

```markdown
![CI](https://github.com/YOUR_USERNAME/my_awesome_store/workflows/Flutter%20CI%2FCD/badge.svg)
```

---

## 📂 Assets y .gitignore

### Assets Configurados

```yaml
flutter:
  assets:
    - assets/images/
    - assets/icons/
    - .env
    - .env.dev
    - .env.prod
```

### .gitignore Actualizado

```gitignore
# Environment files (NO SUBIR SECRETS)
.env
.env.local
.env.*.local

# Generated icons and splash
android/app/src/main/res/mipmap-*/
android/app/src/main/res/drawable/
ios/Runner/Assets.xcassets/AppIcon.appiconset/
```

---

## 🛠️ Paquetes de Utilidades

### 1. Connectivity Plus

**Detectar conexión a internet:**
```dart
import 'package:connectivity_plus/connectivity_plus.dart';

final connectivity = Connectivity();

// Verificar estado actual
final result = await connectivity.checkConnectivity();
if (result.contains(ConnectivityResult.none)) {
  print('Sin conexión');
}

// Escuchar cambios
connectivity.onConnectivityChanged.listen((result) {
  if (result.contains(ConnectivityResult.mobile)) {
    print('Conectado a datos móviles');
  } else if (result.contains(ConnectivityResult.wifi)) {
    print('Conectado a WiFi');
  }
});
```

### 2. URL Launcher

**Abrir URLs, llamadas, emails:**
```dart
import 'package:url_launcher/url_launcher.dart';

// Abrir URL
final url = Uri.parse('https://flutter.dev');
if (await canLaunchUrl(url)) {
  await launchUrl(url);
}

// Llamar teléfono
final tel = Uri.parse('tel:+1234567890');
await launchUrl(tel);

// Enviar email
final email = Uri.parse('mailto:support@example.com?subject=Help');
await launchUrl(email);

// Enviar SMS
final sms = Uri.parse('sms:+1234567890?body=Hello');
await launchUrl(sms);
```

### 3. Package Info Plus

**Obtener info de la app:**
```dart
import 'package:package_info_plus/package_info_plus.dart';

final info = await PackageInfo.fromPlatform();
print('App name: ${info.appName}');
print('Package: ${info.packageName}');
print('Version: ${info.version}');
print('Build: ${info.buildNumber}');
```

### 4. Path Provider

**Obtener rutas del sistema:**
```dart
import 'package:path_provider/path_provider.dart';

// Directorio de documentos
final docsDir = await getApplicationDocumentsDirectory();

// Directorio temporal
final tempDir = await getTemporaryDirectory();

// Directorio de soporte
final supportDir = await getApplicationSupportDirectory();

// Crear archivo
final file = File('${docsDir.path}/my_file.txt');
await file.writeAsString('Hello World');
```

### 5. Shared Preferences

**Almacenamiento simple:**
```dart
import 'package:shared_preferences/shared_preferences.dart';

final prefs = await SharedPreferences.getInstance();

// Guardar
await prefs.setString('username', 'john_doe');
await prefs.setInt('age', 25);
await prefs.setBool('isDarkMode', true);

// Leer
final username = prefs.getString('username');
final age = prefs.getInt('age');
final isDarkMode = prefs.getBool('isDarkMode') ?? false;

// Eliminar
await prefs.remove('username');

// Limpiar todo
await prefs.clear();
```

---

## 📝 Comandos Útiles

### Generación de Código
```bash
# Generar todo (Freezed, Injectable, Drift, etc.)
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (regenera automáticamente)
flutter pub run build_runner watch --delete-conflicting-outputs

# Limpiar archivos generados
flutter pub run build_runner clean
```

### Íconos y Splash
```bash
# Generar íconos de app
flutter pub run flutter_launcher_icons

# Generar splash screen
flutter pub run flutter_native_splash:create

# Eliminar splash screen
flutter pub run flutter_native_splash:remove
```

### Análisis y Testing
```bash
# Analizar código
flutter analyze

# Formatear código
dart format .

# Ejecutar tests
flutter test

# Tests con cobertura
flutter test --coverage

# Ver reporte de cobertura (Linux/Mac)
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Builds
```bash
# Android Debug
flutter build apk --debug

# Android Release
flutter build apk --release

# Android App Bundle (para Play Store)
flutter build appbundle --release

# iOS (macOS only)
flutter build ios --release
```

### Limpieza
```bash
# Limpiar build
flutter clean

# Reinstalar dependencias
flutter pub get

# Limpiar todo y regenerar
flutter clean && flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
```

---

## ✅ Checklist de Configuración Profesional

- [x] **Clean Architecture** - Estructura de capas (Domain, Data, Presentation)
- [x] **BLoC Pattern** - State management
- [x] **Dependency Injection** - GetIt + Injectable
- [x] **Database** - Drift + SQLite (4 tablas)
- [x] **Error Handling** - Freezed + FpDart Either
- [x] **Logging** - Logger configurado
- [x] **Linting** - very_good_analysis
- [x] **Environment Variables** - flutter_dotenv (.env files)
- [x] **Custom Icons** - flutter_launcher_icons configurado
- [x] **Splash Screen** - flutter_native_splash configurado
- [x] **Routing** - go_router implementado
- [x] **CI/CD** - GitHub Actions (analyze, test, build)
- [x] **Utilities** - connectivity_plus, url_launcher, package_info_plus, path_provider, shared_preferences
- [x] **Code Generation** - build_runner, freezed, json_serializable
- [x] **Documentation** - 6 guías completas
- [x] **.gitignore** - Actualizado para proteger secrets

---

## 🎯 Estado Final

### Paquetes Totales: 38
- **Dependencias principales:** 27
- **Dependencias de desarrollo:** 11

### Archivos de Configuración: 10+
- `pubspec.yaml` - Dependencias y assets
- `analysis_options.yaml` - Linting
- `.env`, `.env.dev`, `.env.prod` - Variables de entorno
- `.gitignore` - Exclusiones de Git
- `.github/workflows/ci.yml` - CI/CD
- `lib/core/config/env_config.dart` - Configuración de entorno
- `lib/core/config/app_router.dart` - Routing
- `assets/ASSETS_GUIDE.md` - Guía de assets

### Documentación: 6 Guías
1. `CLEAN_ARCHITECTURE_GUIDE.md` (600+ líneas)
2. `SETUP_EXAMPLES.md` (Ejemplos completos)
3. `INSTALLATION_SUMMARY.md` (Resumen de paquetes)
4. `SETUP_COMPLETE.md` (Estado final anterior)
5. `NEXT_STEPS_GUIDE.md` (Implementación de features)
6. `PROFESSIONAL_SETUP.md` (Este archivo)

---

## 🚀 Próximos Pasos

### 1. Agregar Íconos Personalizados
```bash
# 1. Colocar imágenes en assets/icons/ y assets/images/
# 2. Ejecutar:
flutter pub run flutter_launcher_icons
flutter pub run flutter_native_splash:create
```

### 2. Configurar CI/CD
```bash
# 1. Hacer push a GitHub
# 2. Ir a Actions tab
# 3. Verificar que los workflows se ejecuten
```

### 3. Implementar Features
```bash
# Ver NEXT_STEPS_GUIDE.md para implementar:
# - Feature de Productos
# - Feature de Ventas
# - Feature de Categorías
```

### 4. Agregar Tests
```dart
// test/features/products/domain/usecases/get_all_products_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('GetAllProducts', () {
    test('should return list of products', () async {
      // Arrange
      // Act
      // Assert
    });
  });
}
```

---

## 📖 Referencias

### Documentación Oficial
- [Flutter](https://flutter.dev/docs)
- [GoRouter](https://pub.dev/packages/go_router)
- [flutter_dotenv](https://pub.dev/packages/flutter_dotenv)
- [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons)
- [flutter_native_splash](https://pub.dev/packages/flutter_native_splash)
- [GitHub Actions](https://docs.github.com/en/actions)

### Recursos Adicionales
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [BLoC Pattern](https://bloclibrary.dev/)
- [Railway Oriented Programming](https://fsharpforfunandprofit.com/rop/)

---

## 🎊 ¡Felicitaciones!

Tu proyecto **My Awesome Store** ahora tiene:

✅ **Arquitectura profesional** (Clean Architecture + BLoC)  
✅ **Configuración completa** (DI, DB, Routing, CI/CD)  
✅ **Herramientas de desarrollo** (Linting, análisis, code gen)  
✅ **Infraestructura de producción** (.env, CI/CD, branding)  
✅ **Documentación exhaustiva** (6 guías completas)  

**¡Estás listo para desarrollar una aplicación de nivel profesional! 🚀**

---

**Fecha:** ${DateTime.now().toString().split('.')[0]}  
**Versión:** 2.0.0 - Professional Setup Complete
