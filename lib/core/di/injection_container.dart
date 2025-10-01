import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:my_awesome_store/core/di/injection_container.config.dart';

/// Instancia global de GetIt (Service Locator)
/// Usar getIt() para obtener dependencias en toda la app
final GetIt getIt = GetIt.instance;

/// Configura todas las dependencias de la aplicación
/// Debe ser llamado en main() antes de runApp()
@InjectableInit(
  initializerName: 'init', // Nombre del método generado
  preferRelativeImports: true, // Usar imports relativos
  asExtension: true, // Generar como extensión de GetIt
)
Future<void> configureDependencies() async {
  // Este método inicializa todas las dependencias registradas con @injectable
  // Injectable generará el código automáticamente
  getIt.init();
}
