import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:bloc/bloc.dart';
import 'dart:async';

part 'audio_player_state.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  final PlayerController playerController;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _stateSubscription;

  AudioPlayerCubit(this.playerController) : super(const AudioPlayerState()) {
    _initializePlayer();
  }

  void _initializePlayer() {
    // Get initial duration if available
    _updateDuration();
    // Start position tracking
    _startPositionTracking();
    // Listen to player state changes
    _listenToPlayerStateChanges();
  }

  void _startPositionTracking() {
    // Cancel existing subscription if any
    _positionSubscription?.cancel();

    // For audio_waveforms, listen to the onCurrentDurationChanged stream
    _positionSubscription = playerController.onCurrentDurationChanged.listen((duration) {
      emit(
        state.copyWith(currentPosition: Duration(milliseconds: duration)),
      );
    });
  }

  void _listenToPlayerStateChanges() {
    // Cancel existing subscription if any
    _stateSubscription?.cancel();

    // Listen to player state changes if available
    _stateSubscription = playerController.onPlayerStateChanged?.listen((playerState) {
      AudioPlayerStates newState;
      switch (playerState) {
        case PlayerState.playing:
          newState = AudioPlayerStates.playing;
          break;
        case PlayerState.paused:
          newState = AudioPlayerStates.paused;
          break;
        case PlayerState.stopped:
          newState = AudioPlayerStates.stopped;
          break;
        default:
          newState = AudioPlayerStates.stopped;
      }

      emit(state.copyWith(
        playerState: newState,
        isLoading: false,
      ));
    });
  }

  Future<void> _updateDuration() async {
    try {
      final duration = await playerController.getDuration();
      emit(state.copyWith(totalDuration: Duration(milliseconds: duration)));
    } catch (e) {
      // Handle error if needed
    }
  }

  Future<void> playPause() async {
    try {
      if (state.playerState == AudioPlayerStates.playing) {
        await playerController.pausePlayer();
      } else {
        emit(state.copyWith(isLoading: true));
        await playerController.startPlayer();
        // Update duration after play starts
        await _updateDuration();
      }
    } catch (e) {
      emit(
        state.copyWith(playerState: AudioPlayerStates.stopped, isLoading: false),
      );
    }
  }

  Future<void> stop() async {
    try {
      await playerController.stopPlayer();
    } catch (e) {
      // Handle error if needed
    }
  }

  Future<void> seekForward() async {
    try {
      final newPosition = state.currentPosition + const Duration(seconds: 5);
      final maxPosition = state.totalDuration;
      final seekPosition =
      newPosition > maxPosition ? maxPosition : newPosition;
      await playerController.seekTo(seekPosition.inMilliseconds);
      emit(state.copyWith(currentPosition: seekPosition));
    } catch (e) {
      // Handle error if needed
    }
  }

  Future<void> seekBackward() async {
    try {
      final newPosition = state.currentPosition - const Duration(seconds: 5);
      final seekPosition =
      newPosition < Duration.zero ? Duration.zero : newPosition;
      await playerController.seekTo(seekPosition.inMilliseconds);
      emit(state.copyWith(currentPosition: seekPosition));
    } catch (e) {
      // Handle error if needed
    }
  }

  Future<void> seekTo(Duration position) async {
    try {
      await playerController.seekTo(position.inMilliseconds);
      emit(state.copyWith(currentPosition: position));
    } catch (e) {
      // Handle error if needed
    }
  }

  Future<void> changePlaybackSpeed(double speed) async {
    try {
      await playerController.setRate(speed);
      emit(state.copyWith(playbackSpeed: speed));
    } catch (e) {
      // Handle error if needed - some players might not support speed change
    }
  }

  @override
  Future<void> close() {
    // Cancel position tracking subscription
    _positionSubscription?.cancel();
    _stateSubscription?.cancel();
    playerController.dispose();
    return super.close();
  }
}