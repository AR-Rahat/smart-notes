import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_notes/domain/services/recorder/audio_recorder.dart';

part 'audio_recorder_state.dart';

@injectable
class AudioRecorderCubit extends Cubit<AudioRecorderState> {
  final AudioRecorder recorder;
  String? filePath;
  Timer? _durationTimer;
  DateTime? _recordingStartTime;
  Duration _currentDuration = Duration.zero;

  AudioRecorderCubit(this.recorder) : super(AudioRecorderState.initial());

  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;

    try {
      await recorder.init();
      final dir = await getTemporaryDirectory();
      filePath = "${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.aac";
      _isInitialized = true;
      emit(state.copyWith(status: RecorderStatus.idle));
    } catch (e) {
      emit(state.copyWith(status: RecorderStatus.idle, errorMessage: 'Failed to initialize recorder: $e'));
    }
  }

  Future<void> start() async {
    try {
      if (filePath != null) {
        await recorder.start(filePath!);
        _recordingStartTime = DateTime.now();
        _startDurationTimer();
        emit(state.copyWith(
          status: RecorderStatus.recording,
          errorMessage: null,
          duration: Duration.zero,
        ));
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to start recording: $e'));
    }
  }

  Future<void> pause() async {
    try {
      await recorder.pause();
      _stopDurationTimer();
      emit(state.copyWith(status: RecorderStatus.paused));
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to pause recording: $e'));
    }
  }

  Future<void> resume() async {
    try {
      await recorder.resume();
      _recordingStartTime = DateTime.now().subtract(_currentDuration);
      _startDurationTimer();
      emit(state.copyWith(status: RecorderStatus.recording, errorMessage: null));
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to resume recording: $e'));
    }
  }

  Future<void> stop() async {
    try {
      await recorder.stop();
      _stopDurationTimer();

      // Check if file exists and has content
      if (filePath != null && File(filePath!).existsSync()) {
        final fileSize = File(filePath!).lengthSync();
        if (fileSize > 0) {
          emit(state.copyWith(
            status: RecorderStatus.stopped,
            hasRecording: true,
            errorMessage: null,
            totalDuration: _currentDuration,
          ));
        } else {
          emit(state.copyWith(
            status: RecorderStatus.idle,
            hasRecording: false,
            errorMessage: 'Recording failed - no audio data',
          ));
        }
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to stop recording: $e'));
    }
  }

  void startPlayback() {
    if (state.hasRecording && filePath != null && File(filePath!).existsSync()) {
      emit(state.copyWith(status: RecorderStatus.playing, playbackPosition: Duration.zero));
    }
  }

  void updatePlaybackPosition(Duration position) {
    if (state.status == RecorderStatus.playing) {
      emit(state.copyWith(playbackPosition: position));
    }
  }

  void stopPlayback() {
    emit(state.copyWith(
      status: RecorderStatus.stopped,
      playbackPosition: Duration.zero,
    ));
  }

  void pausePlayback() {
    emit(state.copyWith(status: RecorderStatus.playbackPaused));
  }

  void resumePlayback() {
    emit(state.copyWith(status: RecorderStatus.playing));
  }

  Future<void> deleteRecording() async {
    if (filePath != null && File(filePath!).existsSync()) {
      try {
        await File(filePath!).delete();
        emit(AudioRecorderState.initial());
        // Generate new file path for next recording
        final dir = await getTemporaryDirectory();
        filePath = "${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.aac";
      } catch (e) {
        emit(state.copyWith(errorMessage: 'Failed to delete recording: $e'));
      }
    }
  }

  void setUploadedFile(String uploadedFilePath) {
    filePath = uploadedFilePath;

    // Get file duration if possible
    final file = File(uploadedFilePath);
    if (file.existsSync()) {
      // For now, we'll set a placeholder duration
      // In a real app, you'd use a package like flutter_ffmpeg or just_audio to get actual duration
      emit(state.copyWith(
        status: RecorderStatus.stopped,
        hasRecording: true,
        totalDuration: const Duration(seconds: 60), // Placeholder
        errorMessage: null,
      ));
    }
  }

  void _startDurationTimer() {
    _durationTimer?.cancel();
    _durationTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_recordingStartTime != null) {
        _currentDuration = DateTime.now().difference(_recordingStartTime!);
        emit(state.copyWith(duration: _currentDuration));
      }
    });
  }

  void _stopDurationTimer() {
    _durationTimer?.cancel();
  }

  @override
  Future<void> close() async {
    _stopDurationTimer();
    await recorder.dispose();
    return super.close();
  }
}