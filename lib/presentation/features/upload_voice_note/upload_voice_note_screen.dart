import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_notes/injection/injector.dart';
import 'package:smart_notes/presentation/features/upload_voice_note/cubit/upload_note_cubit.dart';
import 'package:smart_notes/presentation/features/upload_voice_note/ui/upload_voice_note_body.dart';

@RoutePage()
class UploadVoiceNoteScreen extends StatelessWidget {
  const UploadVoiceNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UploadNoteCubit>(
      create: (_) => injector(),
      child: const UploadVoiceNoteBody(),
    );
  }
}
