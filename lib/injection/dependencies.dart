// ignore_for_file: cascade_invocations, unnecessary_lambdas

import 'package:smart_notes/injection/injector.dart';
import 'package:smart_notes/presentation/core/router/router.dart';

class DependencyManager {
  static Future<void> inject() async {
    //injector.registerLazySingleton<AppFlavor>(() => flavor);
    injector.registerLazySingleton<AppRouter>(() => AppRouter());
    return configureDependencies();
  }
}
