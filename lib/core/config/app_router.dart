import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_awesome_store/main.dart';

/// Configuración de rutas de la aplicación usando GoRouter
class AppRouter {
  AppRouter._();

  /// Router instance
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      // Ruta principal (Home)
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),

      // Ejemplo: Ruta de productos
      // GoRoute(
      //   path: '/products',
      //   name: 'products',
      //   builder: (context, state) => const ProductsPage(),
      //   routes: [
      //     // Detalle de producto
      //     GoRoute(
      //       path: ':id',
      //       name: 'product-detail',
      //       builder: (context, state) {
      //         final id = state.pathParameters['id']!;
      //         return ProductDetailPage(productId: id);
      //       },
      //     ),
      //   ],
      // ),

      // Ejemplo: Ruta de ventas
      // GoRoute(
      //   path: '/sales',
      //   name: 'sales',
      //   builder: (context, state) => const SalesPage(),
      // ),

      // Ejemplo: Ruta de configuración
      // GoRoute(
      //   path: '/settings',
      //   name: 'settings',
      //   builder: (context, state) => const SettingsPage(),
      // ),
    ],
    // Manejo de errores 404
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(
        title: const Text('Página no encontrada'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 100,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            const Text(
              '404 - Página no encontrada',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Ruta: ${state.uri}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Volver al inicio'),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Extension para facilitar la navegación
extension GoRouterExtension on BuildContext {
  /// Navega a una ruta por nombre
  void goNamed(String name, {Map<String, String>? pathParameters}) {
    if (pathParameters != null) {
      GoRouter.of(this).goNamed(name, pathParameters: pathParameters);
    } else {
      GoRouter.of(this).goNamed(name);
    }
  }

  /// Navega a una ruta por path
  void goPath(String path) {
    GoRouter.of(this).go(path);
  }

  /// Navega hacia atrás
  void goBack() {
    GoRouter.of(this).pop();
  }
}
