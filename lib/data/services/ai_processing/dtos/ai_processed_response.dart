import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_notes/data/services/ai_processing/dtos/note_segment_dto.dart';

part 'ai_processed_response.freezed.dart';
part 'ai_processed_response.g.dart';

@freezed
sealed class AiProcessedResponse  with _$AiProcessedResponse {
  factory AiProcessedResponse({required List<NoteSegmentDto> segments}) =_AiProcessedResponse;

  factory AiProcessedResponse.fromJson(Map<String, dynamic> json) =>
      _$AiProcessedResponseFromJson(json);
}