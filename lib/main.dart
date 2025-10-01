import 'package:flutter/material.dart';
import 'package:my_awesome_store/core/di/injection_container.dart';

Future<void> main() async {
  // Asegurar que los bindings de Flutter estén inicializados
  WidgetsFlutterBinding.ensureInitialized();

  // Configurar la inyección de dependencias
  await configureDependencies();

  // Inicializar la base de datos (se crea automáticamente al primer acceso)
  // El AppDatabase se puede inyectar cuando se necesite en los repositorios

  runApp(const MyAwesomeStoreApp());
}

/// Aplicación principal de My Awesome Store
class MyAwesomeStoreApp extends StatelessWidget {
  const MyAwesomeStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Awesome Store',
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
