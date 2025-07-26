import 'dart:async';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_notes/domain/services/recorder/audio_recorder.dart';

@LazySingleton(as: AudioRecorder)
class AudioRecorderImpl implements AudioRecorder {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();

  @override
  Future<void> init() async {
    await _recorder.openRecorder();
  }

  @override
  Future<void> start(String path) async {
    await _recorder.startRecorder(toFile: path, codec: Codec.aacADTS);
  }

  @override
  Future<void> pause() async => await _recorder.pauseRecorder();

  @override
  Future<void> resume() async => await _recorder.resumeRecorder();

  @override
  Future<void> stop() async => await _recorder.stopRecorder();

  @override
  Future<void> dispose() async => await _recorder.closeRecorder();
}
