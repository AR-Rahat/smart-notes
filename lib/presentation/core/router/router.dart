import 'package:auto_route/auto_route.dart';
import 'package:smart_notes/presentation/core/router/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: MainRoute.page, path: '/main', initial: true),
    AutoRoute(page: AudioRecorderRoute.page, path: '/recorder_screen'),
    AutoRoute(page: UploadVoiceNoteRoute.page, path: '/upload_voice_note'),
  ];
}
