import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_awesome_store/features/products/presentation/pages/product_form_page.dart';
import 'package:my_awesome_store/features/products/presentation/pages/products_page.dart';
import 'package:my_awesome_store/main.dart';

/// Configuración de rutas de la aplicación
class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      // Ruta principal (Home)
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),

      // Ruta de productos (lista)
      GoRoute(
        path: '/products',
        builder: (context, state) => const ProductsPage(),
      ),

      // Ruta para agregar producto
      GoRoute(
        path: '/products/add',
        builder: (context, state) => const ProductFormPage(),
      ),

      // Ruta para editar producto
      GoRoute(
        path: '/products/edit/:id',
        builder: (context, state) {
          final productId = state.pathParameters['id'];
          return ProductFormPage(productId: productId);
        },
      ),
    ],

    // Manejo de errores de navegación
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Página no encontrada',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              state.uri.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
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
