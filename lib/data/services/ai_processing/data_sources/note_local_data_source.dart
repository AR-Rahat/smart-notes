import 'package:injectable/injectable.dart';
import 'package:smart_notes/core/hive/hive_service.dart';

@lazySingleton
class NoteLocalDataSource {
  final HiveService _hiveService = HiveService.instance;

  static const noteKey = 'Notes';

  dynamic fetchLocalNotes() {
    return _hiveService.retrieveData(noteKey);
  }

  Future<void> saveLocalNotes({required String notes}) async {
    await _hiveService.storeData(noteKey, notes);
    return;
  }
}
