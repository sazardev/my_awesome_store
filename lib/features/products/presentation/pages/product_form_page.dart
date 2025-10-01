import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_awesome_store/core/di/injection_container.dart';
import 'package:my_awesome_store/core/utils/extensions.dart';
import 'package:my_awesome_store/core/utils/validators.dart';
import 'package:my_awesome_store/features/products/domain/entities/product.dart';
import 'package:my_awesome_store/features/products/presentation/bloc/product_bloc.dart';
import 'package:my_awesome_store/shared/widgets/common_widgets.dart';
import 'package:uuid/uuid.dart';

/// Página de formulario para agregar/editar productos
class ProductFormPage extends StatelessWidget {
  const ProductFormPage({
    this.productId,
    super.key,
  });
  final String? productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProductBloc>(),
      child: _ProductFormView(productId: productId),
    );
  }
}

class _ProductFormView extends StatefulWidget {
  const _ProductFormView({this.productId});
  final String? productId;

  @override
  State<_ProductFormView> createState() => _ProductFormViewState();
}

class _ProductFormViewState extends State<_ProductFormView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _barcodeController = TextEditingController();
  final _categoryController = TextEditingController();
  final _rackLocationController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _descriptionController.dispose();
    _barcodeController.dispose();
    _categoryController.dispose();
    _rackLocationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.productId != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Producto' : 'Nuevo Producto'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Nombre *
            AppTextField(
              controller: _nameController,
              label: 'Nombre del Producto *',
              hint: 'Ej: Laptop Dell Inspiron',
              prefixIcon: Icons.shopping_bag_outlined,
              validator: Validators.productName,
            ),
            const SizedBox(height: 16),

            // Precio *
            AppTextField(
              controller: _priceController,
              label: 'Precio *',
              hint: r'$0.00',
              prefixIcon: Icons.attach_money,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              validator: Validators.price,
            ),
            const SizedBox(height: 16),

            // Stock *
            AppTextField(
              controller: _stockController,
              label: 'Stock *',
              hint: '0',
              prefixIcon: Icons.inventory_2_outlined,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: Validators.stock,
            ),
            const SizedBox(height: 16),

            // Descripción (opcional)
            AppTextField(
              controller: _descriptionController,
              label: 'Descripción (Opcional)',
              hint: 'Detalles del producto...',
              prefixIcon: Icons.description_outlined,
              maxLines: 3,
              validator: (value) {
                if (value != null && value.length > 500) {
                  return 'La descripción no puede exceder los 500 caracteres';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Código de Barras (opcional)
            AppTextField(
              controller: _barcodeController,
              label: 'Código de Barras (Opcional)',
              hint: '123456789',
              prefixIcon: Icons.qr_code_scanner,
            ),
            const SizedBox(height: 16),

            // Categoría (opcional)
            AppTextField(
              controller: _categoryController,
              label: 'Categoría (Opcional)',
              hint: 'Ej: Electrónica',
              prefixIcon: Icons.category_outlined,
            ),
            const SizedBox(height: 16),

            // Ubicación/Rack (opcional)
            AppTextField(
              controller: _rackLocationController,
              label: 'Ubicación/Rack (Opcional)',
              hint: 'Ej: Pasillo A - Estante 3',
              prefixIcon: Icons.location_on_outlined,
            ),
            const SizedBox(height: 24),

            // Nota informativa
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.colorScheme.primaryContainer.withValues(
                  alpha: 0.3,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: context.colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Los campos marcados con * son obligatorios',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurface.withValues(
                          alpha: 0.7,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Botón Guardar
            LoadingButton(
              icon: Icons.save,
              isLoading: _isLoading,
              onPressed: _saveProduct,
              child: Text(
                isEditing ? 'Actualizar Producto' : 'Guardar Producto',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveProduct() async {
    // Quitar el teclado
    context.dismissKeyboard();

    // Validar formulario
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    final isEditing = widget.productId != null;
    final productId = widget.productId ?? const Uuid().v4();

    final product = Product(
      id: productId,
      name: _nameController.text.trim(),
      price: double.parse(_priceController.text.trim()),
      stock: int.parse(_stockController.text.trim()),
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      barcode: _barcodeController.text.trim().isEmpty
          ? null
          : _barcodeController.text.trim(),
      categoryId: _categoryController.text.trim().isEmpty
          ? null
          : _categoryController.text.trim(),
      rackLocation: _rackLocationController.text.trim().isEmpty
          ? null
          : _rackLocationController.text.trim(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // Guardar producto
    if (isEditing) {
      context.read<ProductBloc>().add(ProductEvent.updateProduct(product));
    } else {
      context.read<ProductBloc>().add(ProductEvent.addProduct(product));
    }

    // Esperar un poco para la animación
    await Future<void>.delayed(const Duration(milliseconds: 300));

    setState(() => _isLoading = false);

    // Mostrar mensaje de éxito y volver atrás
    if (mounted) {
      context.showSuccessSnackBar(
        isEditing
            ? 'Producto actualizado correctamente'
            : 'Producto creado correctamente',
      );
      context.pop();
    }
  }
}
