import 'package:injectable/injectable.dart';
import 'package:smart_notes/data/services/ai_processing/dtos/ai_processed_response.dart';
import 'package:smart_notes/data/services/ai_processing/dtos/note_segment_dto.dart';
import 'package:smart_notes/domain/entities/notes/note_entity.dart';
import 'package:smart_notes/domain/entities/notes/note_segment_entity.dart';

@lazySingleton
class AiProcessingRemapper {
  NoteEntity fromResponse({
    required AiProcessedResponse response,
    required String title,
    String? path,
  }) {
    return NoteEntity(
      noteTitle: title,
      audioPath: path,
      segments: response.segments
          .map(_mapSegment)
          .toList(),
    );
  }

  NoteSegmentEntity _mapSegment(NoteSegmentDto segment) {
    return NoteSegmentEntity(
      startTime: segment.startTime,
      endTime: segment.endTime,
      content: segment.content,
    );
  }
}
