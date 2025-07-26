part of 'audio_recorder_cubit.dart';

enum RecorderStatus {
  idle,
  recording,
  paused,
  stopped,
  playing,
  playbackPaused
}

class AudioRecorderState {
  final RecorderStatus status;
  final bool hasRecording;
  final String? errorMessage;
  final Duration duration;
  final Duration totalDuration;
  final Duration playbackPosition;

  const AudioRecorderState({
    required this.status,
    this.hasRecording = false,
    this.errorMessage,
    this.duration = Duration.zero,
    this.totalDuration = Duration.zero,
    this.playbackPosition = Duration.zero,
  });

  factory AudioRecorderState.initial() => const AudioRecorderState(
    status: RecorderStatus.idle,
    hasRecording: false,
  );

  AudioRecorderState copyWith({
    RecorderStatus? status,
    bool? hasRecording,
    String? errorMessage,
    Duration? duration,
    Duration? totalDuration,
    Duration? playbackPosition,
  }) {
    return AudioRecorderState(
      status: status ?? this.status,
      hasRecording: hasRecording ?? this.hasRecording,
      errorMessage: errorMessage,
      duration: duration ?? this.duration,
      totalDuration: totalDuration ?? this.totalDuration,
      playbackPosition: playbackPosition ?? this.playbackPosition,
    );
  }
}