import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:smart_notes/gen/assets.gen.dart';
import 'package:smart_notes/presentation/core/resources/resources.dart';
import 'package:smart_notes/presentation/core/router/router.gr.dart';
import 'package:smart_notes/presentation/core/widgets/svg_picture/app_svg.dart';
import 'package:smart_notes/presentation/core/widgets/text/material_app_text.dart';

import 'bottom_sheet_option_widget.dart';

class AddNoteBottomSheet extends StatelessWidget {
  const AddNoteBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.only(bottom: context.w12),
          child: MaterialAppText.titleMedium(
            'Add New Notes',
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w700,
          ),
        ),
        context.mediumVerticalGap,
        BottomSheetOptionWidget(
          prefixWidget: Icon(Icons.mic_none_rounded, color: context.neutral),
          title: 'Record Audio',
          description: 'Record with your microphone',
          onPressed: () {
            //context.alerts.dismissDialog();
            context.pushRoute(const AudioRecorderRoute());
          },
        ),
        BottomSheetOptionWidget(
          prefixWidget: Icon(Icons.multitrack_audio, color: context.neutral),
          title: 'Upload Audio File',
          description: 'Upload Audio file',
        ),
        BottomSheetOptionWidget(
          prefixWidget: Icon(Icons.audio_file_outlined, color: context.neutral),
          title: 'Upload Document',
          description: 'Upload PDFs and other file types',
        ),
        BottomSheetOptionWidget(
          prefixWidget: AppSvg.fixedColor(
            Assets.icons.icTextFile.path,
            height: context.w20,
            width: context.w20,
            color: context.neutral,
          ),
          title: 'Create your own note',
          description: 'Manually enter or paste text',
        ),
      ],
    );
  }
}
