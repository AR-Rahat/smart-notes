import 'package:injectable/injectable.dart';
import 'package:smart_notes/domain/entities/notes/note_entity.dart';
import 'package:smart_notes/domain/services/ai_processing/note_processing_service.dart';

@lazySingleton
final class FetchAllNoteUseCase {
  FetchAllNoteUseCase(this._noteProcessingService);

  final NoteProcessingService _noteProcessingService;

  Future<List<NoteEntity>> run() async {
    return _noteProcessingService.fetchAllNotes();
  }
}
