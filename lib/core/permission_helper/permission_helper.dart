import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<void> requestMicrophone() async {
    final status = await Permission.microphone.request();
    if (!status.isGranted) throw Exception("Microphone permission denied");
  }
}
