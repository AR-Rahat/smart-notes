import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_notes/presentation/core/resources/app_ui_constants.dart';
import 'package:smart_notes/presentation/core/widgets/text/material_app_text.dart';
import 'package:smart_notes/presentation/features/recording/cubit/audio_recorder_cubit.dart';

class AudioRecorderBody extends StatefulWidget {
  const AudioRecorderBody({super.key});

  @override
  State<AudioRecorderBody> createState() => _AudioRecorderBodyState();
}

class _AudioRecorderBodyState extends State<AudioRecorderBody> {
  final RecorderController _recorderController = RecorderController();
  final PlayerController _playerController = PlayerController();

  @override
  void initState() {
    super.initState();
    _setupRecorderController();
    _setupPlayerController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize only once when the widget is fully built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<AudioRecorderCubit>().init();
      }
    });
  }

  void _setupRecorderController() {
    _recorderController
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.aac_adts
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100
      ..bitRate = 64000;
  }

  void _setupPlayerController() {
    // Listen to player state changes
    _playerController.onPlayerStateChanged.listen((state) {
      if (mounted) {
        switch (state) {
          case PlayerState.stopped:
            context.read<AudioRecorderCubit>().stopPlayback();
            break;
          case PlayerState.paused:
            context.read<AudioRecorderCubit>().pausePlayback();
            break;
          case PlayerState.initialized:
            break;
          case PlayerState.playing:
            break;
        }
      }
    });

    // Listen to playback position changes for progress tracking
    _playerController.onCurrentDurationChanged.listen((durationMS) {
      final currentPosition = Duration(milliseconds: durationMS);
      if (mounted) {
        context.read<AudioRecorderCubit>().updatePlaybackPosition(
          currentPosition,
        );
      }
    });
  }

  @override
  void dispose() {
    _recorderController.dispose();
    _playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MaterialAppText.headlineLarge("Note Recorder"),
        centerTitle: true,
        elevation: 0,
        actions: [
          BlocBuilder<AudioRecorderCubit, AudioRecorderState>(
            builder: (context, state) {
              if (state.hasRecording) {
                return IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed:
                      () => _showDeleteDialog(
                        context,
                        onCancel: () => Navigator.of(context).pop,
                        onDelete: () {
                          context.read<AudioRecorderCubit>().deleteRecording();
                          Navigator.of(context).pop();
                        },
                      ),
                  tooltip: "Delete Recording",
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocListener<AudioRecorderCubit, AudioRecorderState>(
        listener: (context, state) {
          // Show error messages
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16),
              ),
            );
          }
        },
        child: BlocBuilder<AudioRecorderCubit, AudioRecorderState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: AppUiConstants.defaultScreenHorizontalPadding,
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // Status Indicator
                  _buildStatusIndicator(state),

                  const SizedBox(height: 24),

                  // Duration Display
                  _buildDurationDisplay(state),

                  const SizedBox(height: 24),

                  // Waveform Display
                  _buildWaveformDisplay(context, state),

                  const SizedBox(height: 32),

                  // Control Buttons
                  _buildControlButtons(context, state),

                  const SizedBox(height: 24),

                  // Recording Information
                  if (state.hasRecording) _buildRecordingInfo(state),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(AudioRecorderState state) {
    String statusText = "";
    Color statusColor = Colors.grey;
    IconData statusIcon = Icons.circle;

    switch (state.status) {
      case RecorderStatus.idle:
        statusText = "Ready to Record";
        statusColor = Colors.blue;
        statusIcon = Icons.mic;
        break;
      case RecorderStatus.recording:
        statusText = "Recording...";
        statusColor = Colors.red;
        statusIcon = Icons.fiber_manual_record;
        break;
      case RecorderStatus.paused:
        statusText = "Recording Paused";
        statusColor = Colors.orange;
        statusIcon = Icons.pause;
        break;
      case RecorderStatus.stopped:
        statusText = state.hasRecording ? "Recording Complete" : "Stopped";
        statusColor = Colors.green;
        statusIcon = Icons.check_circle_outline;
        break;
      case RecorderStatus.playing:
        statusText = "Playing...";
        statusColor = Colors.green;
        statusIcon = Icons.play_arrow;
        break;
      case RecorderStatus.playbackPaused:
        statusText = "Playback Paused";
        statusColor = Colors.orange;
        statusIcon = Icons.pause;
        break;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: statusColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(statusIcon, color: statusColor, size: 20),
          const SizedBox(width: 8),
          Text(
            statusText,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          if (state.status == RecorderStatus.recording)
            Container(
              margin: const EdgeInsets.only(left: 8),
              child: _buildPulsingDot(),
            ),
        ],
      ),
    );
  }

  Widget _buildPulsingDot() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1000),
      builder: (context, value, child) {
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(value),
            shape: BoxShape.circle,
          ),
        );
      },
      onEnd: () {
        if (mounted) setState(() {});
      },
    );
  }

  Widget _buildDurationDisplay(AudioRecorderState state) {
    String formatDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "$twoDigitMinutes:$twoDigitSeconds";
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            if (state.status == RecorderStatus.recording ||
                state.status == RecorderStatus.paused)
              Column(
                children: [
                  Text(
                    formatDuration(state.duration),
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color:
                          state.status == RecorderStatus.recording
                              ? Colors.red
                              : Colors.orange,
                    ),
                  ),
                  Text(
                    "Recording Duration",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                  ),
                ],
              )
            else if (state.status == RecorderStatus.playing ||
                state.status == RecorderStatus.playbackPaused)
              Column(
                children: [
                  Text(
                    formatDuration(state.playbackPosition),
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    "/ ${formatDuration(state.totalDuration)}",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value:
                        state.totalDuration.inMilliseconds > 0
                            ? state.playbackPosition.inMilliseconds /
                                state.totalDuration.inMilliseconds
                            : 0.0,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ],
              )
            else if (state.hasRecording)
              Column(
                children: [
                  Text(
                    formatDuration(state.totalDuration),
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    "Total Duration",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                  ),
                ],
              )
            else
              Column(
                children: [
                  Text(
                    "00:00",
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "Ready to Record",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildWaveformDisplay(BuildContext context, AudioRecorderState state) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: 140,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: _getWaveformWidget(context, state),
      ),
    );
  }

  Widget _getWaveformWidget(BuildContext context, AudioRecorderState state) {
    switch (state.status) {
      case RecorderStatus.playing:
      case RecorderStatus.playbackPaused:
        if (state.hasRecording) {
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
              //extendWaveform: true,
              waveThickness: 3,
            ),
          );
        }
        break;
      case RecorderStatus.recording:
      case RecorderStatus.paused:
        return AudioWaveforms(
          recorderController: _recorderController,
          size: Size(MediaQuery.of(context).size.width - 64, 108),
          waveStyle: WaveStyle(
            waveColor:
                state.status == RecorderStatus.recording
                    ? Colors.red
                    : Colors.orange,
            showMiddleLine: true,
            middleLineColor: Colors.grey[400]!,
            extendWaveform: true,
            showBottom: true,
            waveThickness: 3,
          ),
        );
      default:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                state.hasRecording ? Icons.audiotrack : Icons.mic,
                size: 40,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 8),
              Text(
                state.hasRecording
                    ? "Tap Play to view waveform"
                    : "Start recording to see waveform",
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

  Widget _buildControlButtons(BuildContext context, AudioRecorderState state) {
    final cubit = context.read<AudioRecorderCubit>();

    switch (state.status) {
      case RecorderStatus.idle:
        return _buildRecordButton(cubit);

      case RecorderStatus.recording:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [_buildPauseButton(cubit), _buildStopButton(cubit)],
        );

      case RecorderStatus.paused:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [_buildResumeButton(cubit), _buildStopButton(cubit)],
        );

      case RecorderStatus.stopped:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildRecordAgainButton(cubit),
            if (state.hasRecording) _buildPlayButton(cubit),
          ],
        );

      case RecorderStatus.playing:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildPausePlaybackButton(),
            _buildStopPlaybackButton(cubit),
          ],
        );

      case RecorderStatus.playbackPaused:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildResumePlaybackButton(),
            _buildStopPlaybackButton(cubit),
          ],
        );
    }
  }

  // Control Button Builders
  Widget _buildRecordButton(AudioRecorderCubit cubit) {
    return ElevatedButton(
      onPressed: () {
        cubit.start();
        _recorderController.record(path: cubit.filePath);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        elevation: 4,
      ),
      child: const Icon(Icons.fiber_manual_record, size: 16),
    );
  }

  Widget _buildPauseButton(AudioRecorderCubit cubit) {
    return _buildCircularButton(
      onPressed: () {
        cubit.pause();
        _recorderController.pause();
      },
      icon: Icons.pause,
      color: Colors.orange,
    );
  }

  Widget _buildResumeButton(AudioRecorderCubit cubit) {
    return _buildCircularButton(
      onPressed: () {
        cubit.resume();
        _recorderController.record(path: cubit.filePath);
      },
      icon: Icons.play_arrow,
      color: Colors.green,
    );
  }

  Widget _buildStopButton(AudioRecorderCubit cubit) {
    return _buildCircularButton(
      onPressed: () {
        cubit.stop();
        _recorderController.stop();
      },
      icon: Icons.stop,
      color: Colors.red,
    );
  }

  Widget _buildRecordAgainButton(AudioRecorderCubit cubit) {
    return _buildCircularButton(
      onPressed: () {
        cubit.start();
        _recorderController.record(path: cubit.filePath);
      },
      icon: Icons.fiber_manual_record,
      color: Colors.red,
    );
  }

  Widget _buildPlayButton(AudioRecorderCubit cubit) {
    return _buildCircularButton(
      onPressed: () async {
        cubit.startPlayback();
        await _playerController.preparePlayer(path: cubit.filePath!);
        await _playerController.startPlayer();
      },
      icon: Icons.play_arrow,
      color: Colors.green,
    );
  }

  Widget _buildPausePlaybackButton() {
    return _buildCircularButton(
      onPressed: () => _playerController.pausePlayer(),
      icon: Icons.pause,
      color: Colors.orange,
    );
  }

  Widget _buildResumePlaybackButton() {
    return _buildCircularButton(
      onPressed: () => _playerController.startPlayer(),
      icon: Icons.play_arrow,
      color: Colors.green,
    );
  }

  Widget _buildStopPlaybackButton(AudioRecorderCubit cubit) {
    return _buildCircularButton(
      onPressed: () {
        _playerController.stopPlayer();
        cubit.stopPlayback();
      },
      icon: Icons.stop,
      color: Colors.red,
    );
  }

  Widget _buildCircularButton({
    required VoidCallback onPressed,
    required IconData icon,
    required Color color,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        elevation: 4,
      ),
      child: Icon(icon, size: 16),
    );
  }

  Widget _buildRecordingInfo(AudioRecorderState state) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue[600], size: 20),
                const SizedBox(width: 8),
                Text(
                  "Recording Information",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.blue[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildInfoRow("Duration", _formatDuration(state.totalDuration)),
            _buildInfoRow("Status", "Ready for playback"),
            _buildInfoRow("Quality", "44.1 kHz, AAC"),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  void _showDeleteDialog(
    BuildContext context, {
    VoidCallback? onCancel,
    VoidCallback? onDelete,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.delete_outline, color: Colors.red),
              SizedBox(width: 8),
              Text('Delete Recording'),
            ],
          ),
          content: const Text(
            'Are you sure you want to delete this recording? This action cannot be undone.',
          ),
          actions: [
            TextButton(onPressed: onCancel, child: const Text('Cancel')),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: onDelete,
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
