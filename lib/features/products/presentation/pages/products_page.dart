import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_awesome_store/core/di/injection_container.dart';
import 'package:my_awesome_store/features/products/presentation/bloc/product_bloc.dart';
import 'package:my_awesome_store/features/products/presentation/widgets/product_list_item.dart';
import 'package:my_awesome_store/shared/widgets/common_widgets.dart';

/// Página principal de productos
class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProductBloc>()..add(const LoadProducts()),
      child: const _ProductsView(),
    );
  }
}

class _ProductsView extends StatelessWidget {
  const _ProductsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implementar búsqueda
            },
            tooltip: 'Buscar',
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductInitial) {
            return const Center(
              child: Text('Inicializando...'),
            );
          } else if (state is ProductLoading) {
            return const LoadingWidget(
              message: 'Cargando productos...',
            );
          } else if (state is ProductLoaded) {
            final products = state.products;
            if (products.isEmpty) {
              return EmptyStateWidget(
                message: 'No hay productos registrados',
                icon: Icons.inventory_2_outlined,
                action: () => context.push('/products/add'),
                actionLabel: 'Agregar Producto',
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<ProductBloc>().add(
                  const RefreshProducts(),
                );
                // Esperar un poco para el efecto visual
                await Future<void>.delayed(const Duration(milliseconds: 500));
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductListItem(
                    product: product,
                    onTap: () => context.push('/products/edit/${product.id}'),
                    onDelete: () => _showDeleteDialog(context, product.id),
                  );
                },
              ),
            );
          } else if (state is ProductError) {
            return ErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<ProductBloc>().add(
                  const LoadProducts(),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/products/add'),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Producto'),
      ),
    );
  }

  Future<void> _showDeleteDialog(BuildContext context, String productId) async {
    final confirmed = await ConfirmDialog.show(
      context,
      title: 'Eliminar Producto',
      content: '¿Estás seguro de que deseas eliminar este producto?',
      confirmText: 'Eliminar',
      isDangerous: true,
    );

    if (confirmed && context.mounted) {
      context.read<ProductBloc>().add(DeleteProduct(productId));
    }
  }
}
