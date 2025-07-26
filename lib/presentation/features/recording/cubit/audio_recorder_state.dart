part of 'audio_recorder_cubit.dart';

enum RecorderStatus { idle, recording, paused, stopped, playing }

class AudioRecorderState {
  final RecorderStatus status;
  final bool hasRecording;

  const AudioRecorderState({
    required this.status,
    this.hasRecording = false,
  });

  factory AudioRecorderState.initial() => const AudioRecorderState(
    status: RecorderStatus.idle,
    hasRecording: false,
  );

  AudioRecorderState copyWith({
    RecorderStatus? status,
    bool? hasRecording,
  }) {
    return AudioRecorderState(
      status: status ?? this.status,
      hasRecording: hasRecording ?? this.hasRecording,
    );
  }
}