import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_notes/domain/entities/notes/note_entity.dart';
import 'package:smart_notes/domain/services/ai_processing/note_processing_service.dart';

@lazySingleton
final class ProcessWithAiUseCase {
  ProcessWithAiUseCase(this._noteProcessingService);

  final NoteProcessingService _noteProcessingService;

  Future<NoteEntity> run({required PlatformFile file}) {
    return _noteProcessingService.processWithAi(file: file);
  }
}
