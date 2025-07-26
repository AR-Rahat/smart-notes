import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_notes/injection/injector.dart';
import 'package:smart_notes/presentation/features/main/cubit/main_cubit.dart';
import 'package:smart_notes/presentation/features/main/ui/main_body.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainCubit>(
      create: (_) => injector()..fetchAllSavedNotes(),
      child: const MainBody(),
    );
  }
}
