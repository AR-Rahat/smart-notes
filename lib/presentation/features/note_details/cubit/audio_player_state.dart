part of 'audio_player_cubit.dart';

enum AudioPlayerStates { playing, paused, stopped, loading }

// Audio Player Cubit State
class AudioPlayerState {
  final AudioPlayerStates playerState;
  final Duration currentPosition;
  final Duration totalDuration;
  final double playbackSpeed;
  final bool isLoading;

  const AudioPlayerState({
    this.playerState = AudioPlayerStates.stopped,
    this.currentPosition = Duration.zero,
    this.totalDuration = Duration.zero,
    this.playbackSpeed = 1.0,
    this.isLoading = false,
  });

  AudioPlayerState copyWith({
    AudioPlayerStates? playerState,
    Duration? currentPosition,
    Duration? totalDuration,
    double? playbackSpeed,
    bool? isLoading,
  }) {
    return AudioPlayerState(
      playerState: playerState ?? this.playerState,
      currentPosition: currentPosition ?? this.currentPosition,
      totalDuration: totalDuration ?? this.totalDuration,
      playbackSpeed: playbackSpeed ?? this.playbackSpeed,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
