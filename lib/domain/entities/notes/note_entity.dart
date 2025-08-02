import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_notes/domain/entities/notes/note_segment_entity.dart';

part 'note_entity.freezed.dart';
part 'note_entity.g.dart';

@freezed
sealed class NoteEntity with _$NoteEntity {
  factory NoteEntity({
    required String noteTitle,
    String? audioPath,
    required List<NoteSegmentEntity> segments,
  }) = _NoteEntity;

  factory NoteEntity.fromJson(Map<String, dynamic> json) =>
      _$NoteEntityFromJson(json);
}
