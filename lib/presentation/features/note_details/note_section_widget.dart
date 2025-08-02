import 'package:flutter/material.dart';
import 'package:smart_notes/domain/entities/notes/note_segment_entity.dart';
import 'package:smart_notes/presentation/core/resources/resources.dart';

import '../../core/widgets/text/material_app_text.dart';

class NoteSectionWidget extends StatelessWidget {
  const NoteSectionWidget({
    super.key,
    required this.segment,
    this.isCurrentSegment = false,
  });

  final NoteSegmentEntity segment;
  final bool isCurrentSegment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            MaterialAppText.titleLarge(
              'Smart Noter',
              fontSize: 22,
              color: isCurrentSegment ? context.foregroundOnBackground : context.neutral,
            ),
            context.mediumHorizontalGap,
            MaterialAppText.titleMedium(
              segment.startTime.toString(),
              color: context.neutral,
            ),
          ],
        ),
        context.mediumVerticalGap,
        MaterialAppText.bodyLarge(
          fontSize: 18,
          segment.content,
          overflow: TextOverflow.visible,
          textAlign: TextAlign.justify,
          color: isCurrentSegment ? context.foregroundOnBackground : context.neutral,
        ),
        Divider(color: context.dividerColor),
      ],
    );
  }
}
