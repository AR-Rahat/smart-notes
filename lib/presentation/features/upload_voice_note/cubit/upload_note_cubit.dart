import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_notes/core/base/base_status/base_status.dart';
import 'package:smart_notes/core/logger/log.dart';
import 'package:smart_notes/core/response_error/response_error.dart';
import 'package:smart_notes/domain/use_cases/ai_processing/process_with_ai_use_case.dart';
import 'package:smart_notes/domain/use_cases/notes/fetch_all_note_use_case.dart';

import '../../recording/cubit/audio_recorder_cubit.dart';

part 'upload_note_cubit.freezed.dart';
part 'upload_note_state.dart';

@injectable
class UploadNoteCubit extends Cubit<UploadNoteState> {
  UploadNoteCubit(this._processWithAiUseCase, this._fetchAllNoteUseCase)
    : super(const UploadNoteState());

  final ProcessWithAiUseCase _processWithAiUseCase;
  final FetchAllNoteUseCase _fetchAllNoteUseCase;

  Future<void> filePicked(PlatformFile file) async {
    try {
      // Validate file
      if (file.path == null || !File(file.path!).existsSync()) {
        emit(
          state.copyWith(
            status: RecorderStatus.idle,
            errorMessage: 'Selected file does not exist',
          ),
        );
        return;
      }

      // Get file duration (placeholder for now)
      // In a real app, you'd use a package to get actual audio duration
      final fileDuration = await _getAudioDuration(file.path!);

      emit(
        state.copyWith(
          pickedFile: file,
          status: RecorderStatus.stopped,
          totalDuration: fileDuration,
          playbackPosition: Duration.zero,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RecorderStatus.idle,
          errorMessage: 'Error loading file: $e',
        ),
      );
    }
  }

  void startPlayback() {
    if (state.pickedFile?.path != null) {
      emit(
        state.copyWith(
          status: RecorderStatus.playing,
          playbackPosition: Duration.zero,
          errorMessage: null,
        ),
      );
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
    emit(
      state.copyWith(
        status: RecorderStatus.stopped,
        playbackPosition: Duration.zero,
      ),
    );
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

  Future<void> processFileWithAi() async {
    if (state.pickedFile == null || state.fileStatus.isLoading) {
      return;
    }

    emit(state.copyWith(fileStatus: const BaseStatus.loading()));

    try {
      final processedNote = await _processWithAiUseCase.run(
        file: state.pickedFile!,
      );

      Log.info(processedNote.toString());

      if (isClosed) {
        return;
      }

      final allNotes = await _fetchAllNoteUseCase.run();

      Log.info(allNotes.length.toString());

      return emit(state.copyWith(fileStatus: const BaseStatus.success()));
    } catch (e) {
      final error = ResponseError.from(e);
      return emit(state.copyWith(fileStatus: BaseStatus.failure(error)));
    }
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
