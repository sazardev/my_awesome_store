/// Constantes globales de la aplicación
/// Centraliza todos los valores constantes para facilitar su mantenimiento
class AppConstants {
  AppConstants._();

  // ==================== App Info ====================
  static const String appName = 'My Awesome Store';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Gestiona tu tienda de forma eficiente';

  // ==================== Database ====================
  static const String databaseName = 'my_awesome_store.db';
  static const int databaseVersion = 1;

  // ==================== API ====================
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration apiConnectionTimeout = Duration(seconds: 30);
  static const Duration apiReceiveTimeout = Duration(seconds: 30);

  // ==================== Pagination ====================
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // ==================== Validation ====================
  /// Longitud mínima de nombres de productos
  static const int minProductNameLength = 1;

  /// Longitud máxima de nombres de productos
  static const int maxProductNameLength = 100;

  /// Longitud máxima de descripciones
  static const int maxDescriptionLength = 500;

  /// Precio mínimo permitido
  static const double minPrice = 0.01;

  /// Stock mínimo para alerta de bajo inventario
  static const int lowStockThreshold = 5;

  // ==================== UI/UX ====================
  /// Duración de animaciones rápidas
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);

  /// Duración de animaciones normales
  static const Duration normalAnimationDuration = Duration(milliseconds: 300);

  /// Duración de animaciones lentas
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  /// Duración de mensajes (SnackBar, Toast)
  static const Duration snackBarDuration = Duration(seconds: 3);

  /// Duración de mensajes de error
  static const Duration errorSnackBarDuration = Duration(seconds: 5);

  // ==================== Storage Keys ====================
  /// Key para el idioma guardado
  static const String languageKey = 'app_language';

  /// Key para el tema guardado
  static const String themeKey = 'app_theme';

  /// Key para el usuario actual
  static const String currentUserKey = 'current_user';

  /// Key para el token de autenticación
  static const String authTokenKey = 'auth_token';

  /// Key para datos offline
  static const String offlineDataKey = 'offline_data';

  // ==================== Formats ====================
  /// Formato de fecha para mostrar (dd/MM/yyyy)
  static const String dateFormat = 'dd/MM/yyyy';

  /// Formato de fecha y hora (dd/MM/yyyy HH:mm)
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';

  /// Formato de hora (HH:mm)
  static const String timeFormat = 'HH:mm';

  /// Formato de moneda (símbolo)
  static const String currencySymbol = r'$';

  /// Formato de precio con 2 decimales
  static const String priceFormat = '#,##0.00';

  // ==================== Regex Patterns ====================
  /// Validación de email
  static const String emailPattern =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

  /// Validación de teléfono (10 dígitos)
  static const String phonePattern = r'^\d{10}$';

  /// Validación de código postal
  static const String postalCodePattern = r'^\d{5}$';

  /// Validación de números decimales positivos
  static const String positiveDecimalPattern = r'^\d+\.?\d{0,2}$';

  // ==================== Error Messages ====================
  static const String networkError = 'Error de conexión. Verifica tu internet.';
  static const String serverError = 'Error del servidor. Intenta más tarde.';
  static const String unexpectedError = 'Ocurrió un error inesperado.';
  static const String noDataFound = 'No se encontraron datos.';
  static const String invalidInput = 'Entrada inválida.';
  static const String requiredField = 'Este campo es requerido.';

  // ==================== Success Messages ====================
  static const String savedSuccessfully = 'Guardado exitosamente.';
  static const String updatedSuccessfully = 'Actualizado exitosamente.';
  static const String deletedSuccessfully = 'Eliminado exitosamente.';
  static const String operationCompleted = 'Operación completada.';

  // ==================== Asset Paths ====================
  static const String imagesPath = 'assets/images/';
  static const String iconsPath = 'assets/icons/';
  static const String logoPath = '${imagesPath}logo.png';
  static const String placeholderImage = '${imagesPath}placeholder.png';

  // ==================== Routes (si no usas go_router) ====================
  static const String homeRoute = '/';
  static const String productsRoute = '/products';
  static const String productDetailsRoute = '/products/details';
  static const String categoriesRoute = '/categories';
  static const String salesRoute = '/sales';
  static const String settingsRoute = '/settings';

  // ==================== Limits ====================
  /// Máximo de items en el carrito de ventas
  static const int maxCartItems = 100;

  /// Máximo de imágenes por producto
  static const int maxImagesPerProduct = 5;

  /// Tamaño máximo de archivo de imagen (en MB)
  static const int maxImageSizeMB = 5;
}
