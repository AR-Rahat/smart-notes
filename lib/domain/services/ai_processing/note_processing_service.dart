import 'package:file_picker/file_picker.dart';
import 'package:smart_notes/domain/entities/notes/note_entity.dart';

abstract interface class NoteProcessingService {
  Future<NoteEntity> processWithAi({required PlatformFile file});
  List<NoteEntity> fetchAllNotes();
  Future<void> saveAllNotes({required List<NoteEntity> notes});
}