import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_segment_entity.freezed.dart';
part 'note_segment_entity.g.dart';

@freezed
sealed class NoteSegmentEntity with _$NoteSegmentEntity {
  factory NoteSegmentEntity({
    required double startTime,
    required double endTime,
    required String content,
  }) = _NoteSegmentEntity;

  factory NoteSegmentEntity.fromJson(Map<String, dynamic> json) =>
      _$NoteSegmentEntityFromJson(json);
}
