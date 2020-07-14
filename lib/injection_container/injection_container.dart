import 'package:get_it/get_it.dart';
import 'package:together/theme/app_theme.dart';

final sl = GetIt.instance;

Future<void> injectDependencies() async {
  sl.registerLazySingleton<AppTheme>(() => AppTheme());
}
