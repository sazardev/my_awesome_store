# Assets Guide - My Awesome Store

## 📁 Estructura de Assets

```
assets/
├── icons/
│   ├── app_icon.png                    # Ícono principal (1024x1024)
│   └── app_icon_foreground.png         # Ícono adaptativo Android (1024x1024)
└── images/
    └── splash_logo.png                 # Logo para splash screen (512x512)
```

---

## 🎨 Cómo Agregar Íconos Personalizados

### 1. Ícono de la Aplicación (`app_icon.png`)

**Requisitos:**
- Tamaño: **1024x1024 px**
- Formato: PNG con fondo transparente o sólido
- Ubicación: `assets/icons/app_icon.png`

**Recomendaciones:**
- Usa colores de tu marca
- Diseño simple y reconocible
- Evita texto muy pequeño
- Prueba cómo se ve en diferentes tamaños

### 2. Ícono Adaptativo Android (`app_icon_foreground.png`)

**Requisitos:**
- Tamaño: **1024x1024 px**
- Formato: PNG con **fondo transparente**
- Ubicación: `assets/icons/app_icon_foreground.png`
- El contenido debe estar centrado en una área segura de 800x800px

**Nota:** Android recortará el ícono en diferentes formas (círculo, cuadrado, etc.)

### 3. Logo de Splash Screen (`splash_logo.png`)

**Requisitos:**
- Tamaño recomendado: **512x512 px** o **1024x1024 px**
- Formato: PNG con fondo transparente
- Ubicación: `assets/images/splash_logo.png`

---

## 🚀 Generar Íconos

Una vez que tengas tus imágenes, ejecuta:

```bash
# Generar íconos de la app
flutter pub run flutter_launcher_icons

# Generar splash screen
flutter pub run flutter_native_splash:create
```

---

## 🛠️ Herramientas Recomendadas

### Crear Íconos Online (Gratis)
- **Flaticon**: https://www.flaticon.com/
- **Icons8**: https://icons8.com/
- **Canva**: https://www.canva.com/ (plantillas de íconos)
- **Figma**: https://www.figma.com/ (diseño personalizado)

### Generadores de Íconos
- **App Icon Generator**: https://www.appicon.co/
- **Icon Kitchen**: https://icon.kitchen/
- **Adaptive Icon Generator**: https://adapticon.tooo.io/

### Optimizar PNG
- **TinyPNG**: https://tinypng.com/
- **ImageOptim**: https://imageoptim.com/

---

## 📝 Ejemplo Rápido

### Opción 1: Usar un Ícono de Material Icons

1. Descarga un ícono de Material Design:
   https://fonts.google.com/icons

2. Guárdalo como PNG de 1024x1024 en:
   - `assets/icons/app_icon.png`
   - `assets/icons/app_icon_foreground.png`

3. Para el splash, crea un logo simple con:
   - Ícono de tienda (store)
   - Nombre de la app
   - Guárdalo en `assets/images/splash_logo.png`

### Opción 2: Usar IA para Generar

Usa herramientas como:
- **DALL-E**: https://openai.com/dall-e
- **Midjourney**: https://www.midjourney.com/
- **Stable Diffusion**: https://stablediffusionweb.com/

Prompt ejemplo:
```
"Simple flat design app icon for a store management app, 
blue and white colors, minimalist, modern, professional"
```

---

## 🎯 Configuración Actual

El proyecto ya está configurado en `pubspec.yaml`:

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

**Solo necesitas:**
1. Agregar tus imágenes PNG en las carpetas correctas
2. Ejecutar los comandos de generación
3. ¡Listo!

---

## ⚠️ Importante

- **NO** subas archivos `.env` a Git (ya están en `.gitignore`)
- Los íconos generados se crean automáticamente en `android/` y `ios/`
- Después de generar, haz un `flutter clean` y recompila

---

## 🔄 Actualizar Íconos

Si cambias los íconos más adelante:

```bash
# Limpiar caché
flutter clean

# Regenerar íconos
flutter pub run flutter_launcher_icons

# Regenerar splash
flutter pub run flutter_native_splash:create

# Recompilar
flutter pub get
flutter run
```

---

## 📱 Vista Previa

Después de instalar, verás:

- **Android**: Tu ícono en el drawer de apps
- **iOS**: Tu ícono en la pantalla de inicio
- **Splash**: Logo centrado con fondo blanco al abrir la app

---

## 💡 Tips

1. **Mantén el diseño simple**: Los íconos pequeños necesitan claridad
2. **Usa colores de marca**: Consistencia visual
3. **Prueba en dispositivos reales**: Los emuladores no siempre muestran bien los íconos
4. **Versión Alternativa**: Crea íconos diferentes para dev/prod

---

**¿Necesitas ayuda?** Consulta la documentación:
- flutter_launcher_icons: https://pub.dev/packages/flutter_launcher_icons
- flutter_native_splash: https://pub.dev/packages/flutter_native_splash
