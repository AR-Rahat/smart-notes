import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_notes/domain/services/recorder/audio_recorder.dart';

part 'audio_recorder_state.dart';

@injectable
class AudioRecorderCubit extends Cubit<AudioRecorderState> {
  final AudioRecorder recorder;
  String? filePath;

  AudioRecorderCubit(this.recorder) : super(AudioRecorderState.initial());

  Future<void> init() async {
    await recorder.init();
    final dir = await getTemporaryDirectory();
    filePath = "${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.aac";
  }

  Future<void> start() async {
    if (filePath != null) {
      await recorder.start(filePath!);
      emit(state.copyWith(status: RecorderStatus.recording));
    }
  }

  Future<void> pause() async {
    await recorder.pause();
    emit(state.copyWith(status: RecorderStatus.paused));
  }

  Future<void> resume() async {
    await recorder.resume();
    emit(state.copyWith(status: RecorderStatus.recording));
  }

  Future<void> stop() async {
    await recorder.stop();
    emit(state.copyWith(status: RecorderStatus.stopped, hasRecording: true));
  }

  void startPlayback() {
    emit(state.copyWith(status: RecorderStatus.playing));
  }

  void stopPlayback() {
    emit(state.copyWith(status: RecorderStatus.stopped));
  }

  @override
  Future<void> close() async {
    await recorder.dispose();
    return super.close();
  }
}