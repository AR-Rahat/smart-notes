import 'package:auto_route/auto_route.dart';
import 'package:smart_notes/presentation/core/router/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: MainRoute.page,
          path: '/main',
          initial: true,
          children: [

          ],
        ),
      ];
}
