# 🎨 Guía del Tema - My Awesome Store

## 📌 Resumen

Este proyecto utiliza un sistema de temas personalizado con la fuente **Jost** de Google Fonts aplicada globalmente en toda la aplicación.

---

## 🎯 Características del Tema

### ✅ Implementado

- ✅ **Fuente Global**: Jost (Google Fonts) en toda la aplicación
- ✅ **Tema Claro (Light Mode)**: Colores profesionales y modernos
- ✅ **Tema Oscuro (Dark Mode)**: Colores optimizados para baja luminosidad
- ✅ **Material Design 3**: Uso de `useMaterial3: true`
- ✅ **Componentes Estilizados**: Botones, Cards, TextFields, AppBar, etc.
- ✅ **Sistema Adaptativo**: Sigue el tema del sistema operativo automáticamente

---

## 📦 Configuración

### Archivo de Tema

**Ubicación:** `lib/core/config/app_theme.dart`

```dart
import 'package:my_awesome_store/core/config/app_theme.dart';

// Usar en MaterialApp
MaterialApp(
  theme: AppTheme.lightTheme,        // Tema claro
  darkTheme: AppTheme.darkTheme,     // Tema oscuro
  themeMode: ThemeMode.system,       // Automático según sistema
  // ...
)
```

### Integración en `main.dart`

```dart
import 'package:my_awesome_store/core/config/app_theme.dart';

class MyAwesomeStoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}
```

---

## 🎨 Paleta de Colores

### Colores Principales

```dart
primaryColor:     #2196F3  // Azul principal
secondaryColor:   #03DAC6  // Turquesa/Cyan
errorColor:       #B00020  // Rojo para errores
successColor:     #4CAF50  // Verde para éxitos
warningColor:     #FF9800  // Naranja para advertencias
infoColor:        #2196F3  // Azul para información
```

### Colores de Fondo (Light Mode)

```dart
backgroundColor:  #F5F5F5  // Fondo general
surfaceColor:     #FFFFFF  // Superficies (cards, bottom sheets)
cardColor:        #FFFFFF  // Color de tarjetas
```

### Colores de Texto (Light Mode)

```dart
textPrimary:      #212121  // Texto principal
textSecondary:    #757575  // Texto secundario
textDisabled:     #BDBDBD  // Texto deshabilitado
```

---

## 🔤 Tipografía con Jost

La fuente **Jost** se aplica globalmente en toda la aplicación con diferentes variantes:

### Display (Textos muy grandes)

```dart
displayLarge:   57sp, weight: 400
displayMedium:  45sp, weight: 400
displaySmall:   36sp, weight: 400
```

### Headline (Títulos principales)

```dart
headlineLarge:  32sp, weight: 600
headlineMedium: 28sp, weight: 600
headlineSmall:  24sp, weight: 600
```

### Title (Títulos de secciones)

```dart
titleLarge:     22sp, weight: 500
titleMedium:    16sp, weight: 500
titleSmall:     14sp, weight: 500
```

### Body (Texto del cuerpo)

```dart
bodyLarge:      16sp, weight: 400  // Texto principal
bodyMedium:     14sp, weight: 400  // Texto normal
bodySmall:      12sp, weight: 400  // Texto pequeño
```

### Label (Etiquetas y botones)

```dart
labelLarge:     14sp, weight: 500
labelMedium:    12sp, weight: 500
labelSmall:     11sp, weight: 500
```

---

## 📚 Cómo Usar el Tema

### 1. Usar Estilos de Texto

```dart
// En cualquier widget
Text(
  'Título Grande',
  style: Theme.of(context).textTheme.headlineLarge,
)

Text(
  'Texto normal',
  style: Theme.of(context).textTheme.bodyMedium,
)

Text(
  'Etiqueta',
  style: Theme.of(context).textTheme.labelSmall,
)
```

### 2. Usar Colores del Tema

```dart
// Colores primarios
Container(
  color: Theme.of(context).colorScheme.primary,
  child: Text(
    'Texto',
    style: TextStyle(
      color: Theme.of(context).colorScheme.onPrimary,
    ),
  ),
)

// Color de fondo
Container(
  color: Theme.of(context).scaffoldBackgroundColor,
)

// Color de superficie (card)
Container(
  color: Theme.of(context).colorScheme.surface,
)
```

### 3. Botones con Tema

```dart
// Elevated Button (ya estilizado)
ElevatedButton(
  onPressed: () {},
  child: const Text('Botón Elevado'),
)

// Text Button (ya estilizado)
TextButton(
  onPressed: () {},
  child: const Text('Botón de Texto'),
)

// Outlined Button (ya estilizado)
OutlinedButton(
  onPressed: () {},
  child: const Text('Botón con Borde'),
)
```

### 4. TextFields con Tema

```dart
// Ya viene estilizado automáticamente
TextField(
  decoration: InputDecoration(
    labelText: 'Nombre',
    hintText: 'Ingresa tu nombre',
  ),
)
```

### 5. Cards con Tema

```dart
// Ya viene estilizado automáticamente
Card(
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Text('Contenido de la tarjeta'),
  ),
)
```

---

## 🌓 Cambiar entre Light y Dark Mode

### Opción 1: Automático (Recomendado)

```dart
// Ya está configurado en main.dart
MaterialApp(
  themeMode: ThemeMode.system, // Sigue el tema del sistema
)
```

### Opción 2: Manual

```dart
// Forzar tema claro
MaterialApp(
  themeMode: ThemeMode.light,
)

// Forzar tema oscuro
MaterialApp(
  themeMode: ThemeMode.dark,
)
```

### Opción 3: Con State Management

```dart
// Usando un ValueNotifier
class ThemeNotifier extends ValueNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system);

  void toggleTheme() {
    value = value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}

// En tu widget
ValueListenableBuilder<ThemeMode>(
  valueListenable: themeNotifier,
  builder: (context, themeMode, child) {
    return MaterialApp(
      themeMode: themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
    );
  },
)
```

---

## 🎨 Personalización

### Cambiar Color Primario

Edita `lib/core/config/app_theme.dart`:

```dart
static const Color primaryColor = Color(0xFF2196F3); // Tu color aquí
```

### Cambiar Fuente

Si quieres usar otra fuente de Google Fonts:

```dart
// Reemplaza todas las referencias de GoogleFonts.jost por:
GoogleFonts.roboto(...)    // Roboto
GoogleFonts.openSans(...)  // Open Sans
GoogleFonts.lato(...)      // Lato
```

### Agregar Colores Personalizados

```dart
class AppTheme {
  // Agregar nuevos colores
  static const Color customColor1 = Color(0xFFAABBCC);
  static const Color customColor2 = Color(0xFFDDEEFF);
}

// Usar en widgets
Container(
  color: AppTheme.customColor1,
)
```

---

## 📱 Componentes Estilizados

### ✅ Componentes con Tema Personalizado

- ✅ AppBar
- ✅ Cards
- ✅ Elevated Button
- ✅ Text Button
- ✅ Outlined Button
- ✅ TextField / TextFormField
- ✅ FloatingActionButton
- ✅ Chip
- ✅ Dialog
- ✅ BottomNavigationBar
- ✅ ListTile
- ✅ Divider
- ✅ SnackBar

---

## 🚀 Testing del Tema

### Probar Light/Dark Mode

1. **En iOS Simulator:**
   - Settings → Developer → Dark Appearance

2. **En Android Emulator:**
   - Settings → Display → Dark theme

3. **En VS Code (Flutter Inspector):**
   - Debug → Toggle Brightness

### Visualizar Todos los Estilos de Texto

Crea una página de prueba:

```dart
class ThemeTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Theme Test')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text('Display Large', style: Theme.of(context).textTheme.displayLarge),
          Text('Headline Large', style: Theme.of(context).textTheme.headlineLarge),
          Text('Title Large', style: Theme.of(context).textTheme.titleLarge),
          Text('Body Large', style: Theme.of(context).textTheme.bodyLarge),
          Text('Body Medium', style: Theme.of(context).textTheme.bodyMedium),
          Text('Label Large', style: Theme.of(context).textTheme.labelLarge),
          SizedBox(height: 20),
          ElevatedButton(onPressed: () {}, child: Text('Elevated Button')),
          TextButton(onPressed: () {}, child: Text('Text Button')),
          OutlinedButton(onPressed: () {}, child: Text('Outlined Button')),
          Card(child: Padding(padding: EdgeInsets.all(16), child: Text('Card'))),
        ],
      ),
    );
  }
}
```

---

## 📖 Referencias

- **Google Fonts Package**: https://pub.dev/packages/google_fonts
- **Material Design 3**: https://m3.material.io/
- **Flutter Theming**: https://docs.flutter.dev/cookbook/design/themes
- **Jost Font**: https://fonts.google.com/specimen/Jost

---

## ✅ Checklist de Implementación

- ✅ Tema claro (Light Mode)
- ✅ Tema oscuro (Dark Mode)
- ✅ Fuente Jost aplicada globalmente
- ✅ Colores personalizados definidos
- ✅ Componentes estilizados (botones, cards, inputs)
- ✅ Integrado en `main.dart`
- ✅ Modo automático según sistema

---

## 🎯 Próximos Pasos

1. **Personalizar colores** según tu marca en `app_theme.dart`
2. **Crear páginas de prueba** para visualizar todos los estilos
3. **Agregar más variantes** si necesitas colores adicionales
4. **Implementar cambio manual** de tema si lo requieres (con BLoC o Provider)

---

¡Tema configurado exitosamente! 🎉
