import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_notes/injection/injector.dart';
import 'package:smart_notes/presentation/features/recording/cubit/audio_recorder_cubit.dart';
import 'package:smart_notes/presentation/features/recording/ui/audio_recorder_body.dart';

@RoutePage()
class AudioRecorderScreen extends StatelessWidget {
  const AudioRecorderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => injector<AudioRecorderCubit>()..init(),
      child: const AudioRecorderBody(),
    );
  }
}
