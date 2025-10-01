import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_awesome_store/core/config/env_config.dart';
import 'package:my_awesome_store/core/di/injection_container.dart';

Future<void> main() async {
  // Asegurar que los bindings de Flutter estén inicializados
  WidgetsFlutterBinding.ensureInitialized();

  // Cargar variables de entorno (.env, .env.dev, o .env.prod)
  // Por defecto carga .env, puedes cambiar según el entorno
  try {
    await dotenv.load(
      fileName: '.env.dev',
    ); // Cambiar a .env.prod en producción
  } on Exception catch (e) {
    debugPrint('⚠️  Warning: No se pudo cargar .env file: $e');
    debugPrint('⚠️  La app continuará con valores por defecto');
  }

  // Configurar la inyección de dependencias
  await configureDependencies();

  // Log del entorno actual
  if (EnvConfig.debugMode) {
    debugPrint('🚀 Iniciando ${EnvConfig.appName} v${EnvConfig.appVersion}');
    debugPrint('📦 Entorno: ${EnvConfig.environment}');
    debugPrint('🌐 API Base URL: ${EnvConfig.apiBaseUrl}');
    debugPrint('💾 Database: ${EnvConfig.dbName}');
  }

  runApp(const MyAwesomeStoreApp());
}

/// Aplicación principal de My Awesome Store
class MyAwesomeStoreApp extends StatelessWidget {
  const MyAwesomeStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: EnvConfig.appName,
      debugShowCheckedModeBanner: EnvConfig.debugMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

/// Página de inicio temporal
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Awesome Store'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.store,
              size: 100,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              '¡Bienvenido!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            const Text(
              'Configuración completada:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('✅ Inyección de Dependencias (GetIt + Injectable)'),
            const Text('✅ Base de Datos (Drift + SQLite)'),
            const Text('✅ Clean Architecture'),
            const Text('✅ Manejo de Errores (Freezed + FpDart)'),
            const Text('✅ Logger Configurado'),
            const Text('✅ Variables de Entorno (.env)'),
            const Text('✅ Routing (go_router)'),
            const Text('✅ Íconos y Splash personalizables'),
            const SizedBox(height: 16),
            Text(
              'Entorno: ${EnvConfig.environment}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              'Versión: ${EnvConfig.appVersion}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            const Text(
              'Próximos pasos: Implementar features (Productos, Ventas, etc.)',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
