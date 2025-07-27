import 'package:flutter/material.dart';
import 'package:smart_notes/domain/entities/notes/note_entity.dart';
import 'package:smart_notes/presentation/core/resources/resources.dart';
import 'package:smart_notes/presentation/core/widgets/text/material_app_text.dart';
import 'package:smart_notes/presentation/core/widgets/utilities/app_card.dart';

class NoteCardWidget extends StatelessWidget {
  const NoteCardWidget({super.key, required this.note, this.onTap});

  final NoteEntity note;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      elevation: 5,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.foregroundOnPrimary,
            borderRadius: BorderRadius.circular(context.w12),
            border: Border.all(color: context.neutral),
          ),
          padding: EdgeInsets.all(context.w16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              MaterialAppText.titleMediumUppercase(
                note.noteTitle,
              ),
              context.smallVerticalGap,
              Container(
                decoration: BoxDecoration(
                  color: context.background,
                  borderRadius: BorderRadius.circular(
                    context.w8,
                  ),
                  border: Border.all(
                    color: context.dividerColor,
                  ),
                ),
                padding: EdgeInsets.all(context.w4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.multitrack_audio,
                      color: context.neutral,
                      size: context.w12,
                    ),
                    context.mediumHorizontalGap,
                    MaterialAppText.labelLarge(
                      'Audio File',
                      color: context.neutral,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
