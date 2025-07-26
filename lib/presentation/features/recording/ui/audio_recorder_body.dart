import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_notes/presentation/core/resources/app_colors.dart';
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
    _recorderController
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.aac_adts
      ..sampleRate = 44100;

    // Listen to player state changes
    _playerController.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.stopped) {
        if(mounted){
          context.read<AudioRecorderCubit>().stopPlayback();
        }
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
      ),
      body: BlocBuilder<AudioRecorderCubit, AudioRecorderState>(
        builder: (context, state) {
          return Padding(
            padding: AppUiConstants.defaultScreenHorizontalPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Divider(color: context.secondaryVariant),
                if (state.status == RecorderStatus.playing && state.hasRecording)
                  AudioFileWaveforms(
                    playerController: _playerController,
                    size: Size(MediaQuery.of(context).size.width, 100),
                    playerWaveStyle: PlayerWaveStyle(
                      fixedWaveColor: context.dividerColor,
                      liveWaveColor: context.primary,
                      showSeekLine: true,
                    ),
                  )
                else
                  AudioWaveforms(
                    recorderController: _recorderController,
                    size: Size(MediaQuery.of(context).size.width, 100),
                    waveStyle: WaveStyle(
                      waveColor: context.secondary,
                      showMiddleLine: true,
                      middleLineColor: context.primaryVariant,
                    ),
                  ),
                Divider(color: context.secondaryVariant),
                const SizedBox(height: 20),
                _buildControlButtons(context, state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildControlButtons(BuildContext context, AudioRecorderState state) {
    final cubit = context.read<AudioRecorderCubit>();

    switch (state.status) {
      case RecorderStatus.idle:
        return ElevatedButton(
          onPressed: () {
            cubit.start();
            _recorderController.record(path: cubit.filePath);
          },
          child: const Text("Start Recording"),
        );

      case RecorderStatus.recording:
        return Wrap(
          spacing: 10,
          children: [
            ElevatedButton(
              onPressed: () {
                cubit.pause();
                _recorderController.pause();
              },
              child: const Text("Pause"),
            ),
            ElevatedButton(
              onPressed: () {
                cubit.stop();
                _recorderController.stop();
              },
              child: const Text("Stop"),
            ),
          ],
        );

      case RecorderStatus.paused:
        return Wrap(
          spacing: 10,
          children: [
            ElevatedButton(
              onPressed: () {
                cubit.resume();
                _recorderController.record(path: cubit.filePath);
              },
              child: const Text("Resume"),
            ),
            ElevatedButton(
              onPressed: () {
                cubit.stop();
                _recorderController.stop();
              },
              child: const Text("Stop"),
            ),
          ],
        );

      case RecorderStatus.stopped:
        return Wrap(
          spacing: 10,
          children: [
            ElevatedButton(
              onPressed: () {
                cubit.start();
                _recorderController.record(path: cubit.filePath);
              },
              child: const Text("Record Again"),
            ),
            if (state.hasRecording)
              ElevatedButton(
                onPressed: () async {
                  cubit.startPlayback();
                  await _playerController.preparePlayer(
                    path: cubit.filePath!,
                  );
                  await _playerController.startPlayer();
                },
                child: const Text("Play Recording"),
              ),
          ],
        );

      case RecorderStatus.playing:
        return Wrap(
          spacing: 10,
          children: [
            ElevatedButton(
              onPressed: () {
                _playerController.pausePlayer();
              },
              child: const Text("Pause Playback"),
            ),
            ElevatedButton(
              onPressed: () {
                _playerController.stopPlayer();
                cubit.stopPlayback();
              },
              child: const Text("Stop Playback"),
            ),
          ],
        );
    }
  }
}