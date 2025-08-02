import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_notes/presentation/core/resources/resources.dart';
import 'package:smart_notes/presentation/core/widgets/utilities/app_card.dart';

import 'cubit/audio_player_cubit.dart';

class NoteAudioPlayer extends StatefulWidget {
  final String audioUrl;
  final PlayerController? playerController;
  final Function(Duration)? onPositionChanged;

  const NoteAudioPlayer({
    super.key,
    this.audioUrl = '/data/user/0/com.arrahat.smart_notes/cache/file_picker/1754112719204/audio.mpeg',
    this.playerController,
    this.onPositionChanged,
  });

  @override
  State<NoteAudioPlayer> createState() => _NoteAudioPlayerState();
}

class _NoteAudioPlayerState extends State<NoteAudioPlayer> {
  late AudioPlayerCubit _audioPlayerCubit;

  @override
  void initState() {
    super.initState();
    final controller = widget.playerController ?? PlayerController();
    _audioPlayerCubit = AudioPlayerCubit(controller);
    // Initialize with audio URL
    _initializeAudio();
  }

  Future<void> _initializeAudio() async {
    try {
      await _audioPlayerCubit.playerController.preparePlayer(path: widget.audioUrl);
    } catch (e) {
      // Handle initialization error
    }
  }

  @override
  void dispose() {
    _audioPlayerCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _audioPlayerCubit,
      child: AppCard(
        elevation: 6,
        child: Container(
          decoration: BoxDecoration(
            color: context.foregroundOnPrimary,
            borderRadius: BorderRadius.circular(context.w12),
            border: Border.all(
              color: context.neutral
            )
          ),
          padding: EdgeInsets.all(context.w16),
          child: BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
            builder: (context, state) {

              WidgetsBinding.instance.addPostFrameCallback((_) {
                widget.onPositionChanged?.call(state.currentPosition);
              });

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Progress Indicator
                  _buildProgressIndicator(context, state),
                  SizedBox(height: context.w12),

                  // Control Buttons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSpeedButton(context, state),

                      _buildSeekButton(
                        context,
                        icon: Icons.replay_5,
                        onPressed: () => context.read<AudioPlayerCubit>().seekBackward(),
                      ),

                      _buildPlayPauseButton(context, state),

                      _buildSeekButton(
                        context,
                        icon: Icons.forward_5,
                        onPressed: () => context.read<AudioPlayerCubit>().seekForward(),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(BuildContext context, AudioPlayerState state) {
    final progress = state.totalDuration.inMilliseconds > 0
        ? state.currentPosition.inMilliseconds / state.totalDuration.inMilliseconds
        : 0.0;

    return Column(
      children: [
        // Progress Bar
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 4.0,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6.0),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 12.0),
          ),
          child: Slider(
            value: progress.clamp(0.0, 1.0),
            onChanged: (value) {
              final position = Duration(
                milliseconds: (value * state.totalDuration.inMilliseconds).round(),
              );
              context.read<AudioPlayerCubit>().seekTo(position);
            },
            activeColor: Theme.of(context).primaryColor,
            inactiveColor: Theme.of(context).primaryColor.withOpacity(0.3),
          ),
        ),

        // Time Labels
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.w16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDuration(state.currentPosition),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                _formatDuration(state.totalDuration),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlayPauseButton(BuildContext context, AudioPlayerState state) {
    IconData icon;
    switch (state.playerState) {
      case AudioPlayerStates.playing:
        icon = Icons.pause;
        break;
      case AudioPlayerStates.loading:
        return SizedBox(
          width: context.w48,
          height: context.w48,
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).primaryColor,
            ),
          ),
        );
      default:
        icon = Icons.play_arrow;
    }

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: state.isLoading
            ? null
            : () => context.read<AudioPlayerCubit>().playPause(),
        icon: Icon(
          icon,
          color: Colors.white,
          size: context.w24,
        ),
        iconSize: context.w48,
      ),
    );
  }

  Widget _buildSeekButton(BuildContext context, {required IconData icon, required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Theme.of(context).primaryColor,
          size: context.w20,
        ),
      ),
    );
  }

  Widget _buildSpeedButton(BuildContext context, AudioPlayerState state) {
    return GestureDetector(
      onTap: () => _showSpeedDialog(context, state.playbackSpeed),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.w12,
          vertical: context.w8,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(context.w8),
        ),
        child: Text(
          '${state.playbackSpeed}x',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: context.w12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _showSpeedDialog(BuildContext context, double currentSpeed) {
    final speeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Playback Speed'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: speeds.map((speed) {
            return ListTile(
              title: Text('${speed}x'),
              leading: Radio<double>(
                value: speed,
                groupValue: currentSpeed,
                onChanged: (value) {
                  if (value != null) {
                    context.read<AudioPlayerCubit>().changePlaybackSpeed(value);
                    Navigator.of(dialogContext).pop();
                  }
                },
              ),
              onTap: () {
                context.read<AudioPlayerCubit>().changePlaybackSpeed(speed);
                Navigator.of(dialogContext).pop();
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
