import 'package:flutter/material.dart';
import 'package:smart_notes/presentation/core/resources/app_colors.dart';
import 'package:smart_notes/presentation/core/widgets/utilities/app_card.dart';
import 'package:smart_notes/presentation/features/upload_voice_note/ui/dashed_rect.dart';

class FilePickingWidget extends StatelessWidget {
  const FilePickingWidget({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      elevation: 4,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: context.foregroundOnPrimary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DashedRect(
            color: context.neutral,
            gap: 6,
            cornerRadius: 12 - 1,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.file_upload_outlined,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Upload an audio file",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          "Upload a Mp3, M4A, Or Mpeg file.",
                          softWrap: true,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
