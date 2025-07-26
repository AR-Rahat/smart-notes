import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_segment_dto.freezed.dart';
part 'note_segment_dto.g.dart';

@freezed
sealed class NoteSegmentDto with _$NoteSegmentDto {
  factory NoteSegmentDto({
    @JsonKey(name: 'start_time') required double startTime,
    @JsonKey(name: 'end_time') required double endTime,
    required String content,
  }) = _NoteSegmentDto;

  factory NoteSegmentDto.fromJson(Map<String, dynamic> json) =>
      _$NoteSegmentDtoFromJson(json);
}
