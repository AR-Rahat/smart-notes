import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_notes/presentation/core/resources/resources.dart';
import 'package:smart_notes/presentation/core/widgets/button/app_button.dart';
import 'package:smart_notes/presentation/core/widgets/text/material_app_text.dart';
import 'package:smart_notes/presentation/core/widgets/utilities/app_alerts.dart';
import 'package:smart_notes/presentation/core/widgets/utilities/app_card.dart';
import 'package:smart_notes/presentation/features/recording/cubit/audio_recorder_cubit.dart';
import 'package:smart_notes/presentation/features/upload_voice_note/cubit/upload_note_cubit.dart';

import 'file_picking_widget.dart';

class UploadVoiceNoteBody extends StatefulWidget {
  const UploadVoiceNoteBody({super.key});

  @override
  State<UploadVoiceNoteBody> createState() => _UploadVoiceNoteBodyState();
}

class _UploadVoiceNoteBodyState extends State<UploadVoiceNoteBody> {
  final PlayerController _playerController = PlayerController();

  @override
  void initState() {
    super.initState();
    _setupPlayerController();
  }

  void _setupPlayerController() {
    // Listen to player state changes
    _playerController.onPlayerStateChanged.listen((playerState) {
      if (mounted) {
        switch (playerState) {
          case PlayerState.stopped:
            context.read<UploadNoteCubit>().stopPlayback();
            break;
          case PlayerState.paused:
            context.read<UploadNoteCubit>().pausePlayback();
            break;
          default:
            break;
        }
      }
    });

    // Listen to playback position changes
    _playerController.onCurrentDurationChanged.listen((positionMs) {
      if (mounted) {
        final position = Duration(milliseconds: positionMs);
        context.read<UploadNoteCubit>().updatePlaybackPosition(position);
      }
    });
  }

  @override
  void dispose() {
    _playerController.dispose();
    super.dispose();
  }

  Future<void> _pickFiles(Function(PlatformFile) result) async {
    FilePickerResult? results = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['mp3', 'mpeg', 'm4a', 'wav', 'aac'],
    );
    if (results != null) {
      PlatformFile selectedFile = results.files.first;
      result(selectedFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: MaterialAppText.headlineLarge('Upload Audio File'),
      ),
      body: BlocListener<UploadNoteCubit, UploadNoteState>(
        listener: (context, state) {
          // Show error messages
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else {
            if (state.fileStatus.isLoading) {
              context.alerts.showLoadingDialog(title: "Processing");
            } else {
              if (state.fileStatus.isSuccess || state.fileStatus.isSuccess) {
                context.pop();
                if (state.fileStatus.isSuccess) {
                  context.alerts.snackBar(
                    massage: 'File Processed Successfully',
                    isSuccess: true,
                  );
                } else {
                  context.alerts.snackBar(
                    massage: 'Something went wrong',
                    isSuccess: false,
                  );
                }
              }
            }
          }
        },
        child: BlocBuilder<UploadNoteCubit, UploadNoteState>(
          builder: (context, state) {
            PlatformFile? file = state.pickedFile;
            bool isPlaying = state.status == RecorderStatus.playing;
            bool isPaused = state.status == RecorderStatus.playbackPaused;

            return Padding(
              padding: AppUiConstants.defaultScreenHorizontalPadding,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // File picker section
                    if (file == null)
                      FilePickingWidget(
                        onTap: () {
                          _pickFiles((file) {
                            context.read<UploadNoteCubit>().filePicked(file);
                          });
                        },
                      ),

                    // File info section
                    if (file != null)
                      AppCard(
                        elevation: 4,
                        child: Container(
                          decoration: BoxDecoration(
                            color: context.foregroundOnPrimary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Icon(
                                Icons.audio_file_outlined,
                                color: context.neutral,
                              ),
                              context.smallHorizontalGap,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MaterialAppText.bodyLarge(file.name),
                                    if (state.totalDuration > Duration.zero)
                                      MaterialAppText.bodySmall(
                                        _formatDuration(state.totalDuration),
                                      ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  context.read<UploadNoteCubit>().clearFile();
                                  _playerController.stopAllPlayers();
                                },
                                child: Icon(
                                  Icons.delete_outline,
                                  color: context.danger,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    // Duration display
                    if (file != null && (isPlaying || isPaused))
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: context.w16),
                        child: _buildDurationDisplay(state),
                      ),

                    // Waveform display
                    if (file != null)
                      Padding(
                        padding: EdgeInsets.only(top: context.w16),
                        child: _buildWaveformDisplay(context, state),
                      ),

                    // Control buttons
                    if (file != null)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: context.w16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (isPlaying)
                              _buildCircularButton(
                                onPressed: () {
                                  _playerController.pausePlayer();
                                },
                                icon: Icons.pause,
                                color: Colors.orange,
                              ),
                            if (isPaused)
                              _buildCircularButton(
                                onPressed: () {
                                  _playerController.startPlayer();
                                },
                                icon: Icons.play_arrow,
                                color: Colors.green,
                              ),
                            if (!isPlaying && !isPaused)
                              _buildCircularButton(
                                onPressed: () async {
                                  if (file.path != null) {
                                    context
                                        .read<UploadNoteCubit>()
                                        .startPlayback();
                                    await _playerController.preparePlayer(
                                      path: file.path!,
                                    );
                                    await _playerController.startPlayer();
                                  }
                                },
                                icon: Icons.play_arrow,
                                color: Colors.green,
                              ),

                            // Stop button (show only when playing or paused)
                            if (isPlaying || isPaused) ...[
                              const SizedBox(width: 20),
                              _buildCircularButton(
                                onPressed: () {
                                  _playerController.stopPlayer();
                                  context
                                      .read<UploadNoteCubit>()
                                      .stopPlayback();
                                },
                                icon: Icons.stop,
                                color: Colors.red,
                              ),
                            ],
                          ],
                        ),
                      ),

                    // Mock Ai processing button
                    if (file != null)
                      AppButton.primary(
                        label: 'Process with Smart Note AI',
                        onPressed: () {
                          context.read<UploadNoteCubit>().processFileWithAi();
                        },
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDurationDisplay(UploadNoteState state) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.foregroundOnPrimary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialAppText.bodyMedium(
                _formatDuration(state.playbackPosition),
              ),
              MaterialAppText.bodyMedium(_formatDuration(state.totalDuration)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value:
                state.totalDuration.inMilliseconds > 0
                    ? state.playbackPosition.inMilliseconds /
                        state.totalDuration.inMilliseconds
                    : 0.0,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularButton({
    required VoidCallback onPressed,
    required IconData icon,
    required Color color,
  }) {
    return SizedBox(
      width: 60,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: const CircleBorder(),
          elevation: 4,
          padding: EdgeInsets.zero,
        ),
        child: Icon(icon, size: 24),
      ),
    );
  }

  Widget _buildWaveformDisplay(BuildContext context, UploadNoteState state) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: context.foregroundOnPrimary,
      child: Container(
        height: 140,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: _getWaveformWidget(context, state),
      ),
    );
  }

  Widget _getWaveformWidget(BuildContext context, UploadNoteState state) {
    switch (state.status) {
      case RecorderStatus.playing:
      case RecorderStatus.playbackPaused:
        if (state.pickedFile != null) {
          return AudioFileWaveforms(
            playerController: _playerController,
            size: Size(MediaQuery.of(context).size.width - 64, 108),
            playerWaveStyle: PlayerWaveStyle(
              fixedWaveColor: Colors.grey[300]!,
              liveWaveColor: Colors.green,
              showSeekLine: true,
              seekLineColor: Colors.green,
              seekLineThickness: 2,
              showBottom: true,
              waveThickness: 3,
            ),
          );
        }
        break;
      default:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.audiotrack, size: 40, color: Colors.grey[400]),
              const SizedBox(height: 8),
              Text(
                "Tap Play to view waveform",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
    }
    return const SizedBox.shrink();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
