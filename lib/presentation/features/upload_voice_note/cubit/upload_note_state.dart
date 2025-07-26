part of 'upload_note_cubit.dart';

@freezed
sealed class UploadNoteState with _$UploadNoteState {
  const factory UploadNoteState({
    PlatformFile? pickedFile,
    @Default(BaseStatus.initial()) fileStatus,
    @Default(RecorderStatus.idle) status,
    @Default(Duration.zero) duration,
    @Default(Duration.zero) totalDuration,
    @Default(Duration.zero) playbackPosition,
    String? errorMessage,
  }) = _UploadNoteState;
}
