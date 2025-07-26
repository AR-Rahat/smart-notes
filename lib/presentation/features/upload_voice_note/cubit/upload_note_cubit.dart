import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_notes/core/base/base_status/base_status.dart';

import '../../recording/cubit/audio_recorder_cubit.dart';

part 'upload_note_cubit.freezed.dart';
part 'upload_note_state.dart';

@injectable
class UploadNoteCubit extends Cubit<UploadNoteState> {
  UploadNoteCubit() : super(const UploadNoteState());

  Future<void> filePicked(PlatformFile file) async {
    try {
      // Validate file
      if (file.path == null || !File(file.path!).existsSync()) {
        emit(state.copyWith(
          status: RecorderStatus.idle,
          errorMessage: 'Selected file does not exist',
        ));
        return;
      }

      // Get file duration (placeholder for now)
      // In a real app, you'd use a package to get actual audio duration
      final fileDuration = await _getAudioDuration(file.path!);

      emit(state.copyWith(
        pickedFile: file,
        status: RecorderStatus.stopped,
        totalDuration: fileDuration,
        playbackPosition: Duration.zero,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: RecorderStatus.idle,
        errorMessage: 'Error loading file: $e',
      ));
    }
  }

  void startPlayback() {
    if (state.pickedFile?.path != null) {
      emit(state.copyWith(
        status: RecorderStatus.playing,
        playbackPosition: Duration.zero,
        errorMessage: null,
      ));
    }
  }

  void pausePlayback() {
    if (state.status == RecorderStatus.playing) {
      emit(state.copyWith(status: RecorderStatus.playbackPaused));
    }
  }

  void resumePlayback() {
    if (state.status == RecorderStatus.playbackPaused) {
      emit(state.copyWith(status: RecorderStatus.playing));
    }
  }

  void stopPlayback() {
    emit(state.copyWith(
      status: RecorderStatus.stopped,
      playbackPosition: Duration.zero,
    ));
  }

  void updatePlaybackPosition(Duration position) {
    if (state.status == RecorderStatus.playing) {
      emit(state.copyWith(playbackPosition: position));
    }
  }

  void seekTo(Duration position) {
    if (state.pickedFile != null && position <= state.totalDuration) {
      emit(state.copyWith(playbackPosition: position));
    }
  }

  void clearFile() {
    emit(const UploadNoteState());
  }

  // Helper method to get audio duration
  // This is a placeholder - in a real app you'd use just_audio or similar
  Future<Duration> _getAudioDuration(String filePath) async {
    try {
      // For now, return a placeholder duration
      // You can implement actual duration detection using packages like:
      // - just_audio: final duration = await AudioPlayer().setFilePath(filePath);
      // - flutter_ffmpeg: to get metadata

      final file = File(filePath);
      final sizeInBytes = await file.length();

      // Rough estimation: 1MB ≈ 1 minute for compressed audio
      final estimatedMinutes = (sizeInBytes / (1024 * 1024)).round();
      return Duration(minutes: estimatedMinutes.clamp(1, 60));

    } catch (e) {
      return const Duration(minutes: 3); // Default fallback
    }
  }

  bool get hasFile => state.pickedFile != null;
  bool get canPlay => hasFile && state.status != RecorderStatus.playing;
  bool get isPlaying => state.status == RecorderStatus.playing;
  bool get isPaused => state.status == RecorderStatus.playbackPaused;
}