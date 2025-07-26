import 'dart:async';
import 'dart:io';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_notes/domain/services/recorder/audio_recorder.dart';

@LazySingleton(as: AudioRecorder)
class AudioRecorderImpl implements AudioRecorder {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isInitialized = false;

  @override
  Future<void> init() async {
    if (!_isInitialized) {
      try {
        await _recorder.openRecorder();
        _isInitialized = true;
      } catch (e) {
        // If already initialized, just mark as initialized
        if (e.toString().contains('_openRecorderCompleter')) {
          _isInitialized = true;
        } else {
          rethrow;
        }
      }
    }
  }

  @override
  Future<void> start(String path) async {
    if (!_isInitialized) {
      await init();
    }
    await _recorder.startRecorder(toFile: path, codec: Codec.aacADTS);
  }

  @override
  Future<void> pause() async {
    if (_recorder.isRecording) {
      await _recorder.pauseRecorder();
    }
  }

  @override
  Future<void> resume() async {
    if (_recorder.isPaused) {
      await _recorder.resumeRecorder();
    }
  }

  @override
  Future<void> stop() async {
    if (_recorder.isRecording || _recorder.isPaused) {
      await _recorder.stopRecorder();
    }
  }

  @override
  Future<void> dispose() async {
    if (_isInitialized) {
      try {
        await _recorder.closeRecorder();
        _isInitialized = false;
      } catch (e) {
        // Ignore errors during disposal
        _isInitialized = false;
      }
    }
  }

  @override
  Future<Directory> getTempDirectory() async {
    return await getTemporaryDirectory();
  }
}