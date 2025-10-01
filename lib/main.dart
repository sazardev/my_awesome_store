import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_awesome_store/core/config/app_theme.dart';
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
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Usa el tema del sistema (light/dark)
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header con ícono
            Icon(
              Icons.store_rounded,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),

            // Título con fuente Jost
            Text(
              '¡Bienvenido!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 8),

            // Subtítulo
            Text(
              'My Awesome Store está lista para usar',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),

            // Card de configuración
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Theme.of(context).colorScheme.primary,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Configuración Completa',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureItem(context, '🏗️', 'Clean Architecture'),
                    _buildFeatureItem(context, '📦', 'BLoC Pattern'),
                    _buildFeatureItem(
                      context,
                      '💉',
                      'Dependency Injection (GetIt)',
                    ),
                    _buildFeatureItem(context, '🗄️', 'Base de Datos (SQLite)'),
                    _buildFeatureItem(context, '🔧', 'Manejo de Errores'),
                    _buildFeatureItem(context, '🎨', 'Tema con fuente Jost'),
                    _buildFeatureItem(context, '🌓', 'Light & Dark Mode'),
                    _buildFeatureItem(context, '📝', 'Logger configurado'),
                    _buildFeatureItem(context, '🌐', 'Variables de entorno'),
                    _buildFeatureItem(
                      context,
                      '🚀',
                      'CI/CD con GitHub Actions',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Card de información de entorno
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Información de Entorno',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow(context, 'Versión', EnvConfig.appVersion),
                    _buildInfoRow(
                      context,
                      'Entorno',
                      EnvConfig.environment.toUpperCase(),
                    ),
                    _buildInfoRow(
                      context,
                      'Debug Mode',
                      EnvConfig.debugMode ? 'Activo' : 'Inactivo',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Botones de acción
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Navegar a la primera feature
              },
              icon: const Icon(Icons.rocket_launch),
              label: const Text('Comenzar a Usar'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {
                // TODO: Mostrar documentación
              },
              icon: const Icon(Icons.menu_book),
              label: const Text('Ver Documentación'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
