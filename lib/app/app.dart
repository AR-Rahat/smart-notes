import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:smart_notes/injection/injector.dart';
import 'package:smart_notes/presentation/core/resources/app_theme.dart';
import 'package:smart_notes/presentation/core/router/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = injector.get<AppRouter>();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.fromBrightness(Brightness.light),
      darkTheme: AppTheme.fromBrightness(Brightness.dark),
      themeMode: ThemeMode.light,
      routerDelegate: AutoRouterDelegate(appRouter),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }
}
