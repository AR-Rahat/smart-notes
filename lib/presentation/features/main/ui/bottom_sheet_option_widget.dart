import 'package:flutter/material.dart';
import 'package:smart_notes/presentation/core/resources/resources.dart';
import 'package:smart_notes/presentation/core/widgets/text/material_app_text.dart';
import 'package:smart_notes/presentation/core/widgets/utilities/app_card.dart';

class BottomSheetOptionWidget extends StatelessWidget {
  const BottomSheetOptionWidget({
    super.key,
    this.onPressed,
    required this.title,
    required this.description,
    required this.prefixWidget,
  });

  final VoidCallback? onPressed;
  final String title;
  final String description;
  final Widget prefixWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.w16,
        right: context.w16,
        bottom: context.w12,
      ),
      child: GestureDetector(
        onTap: onPressed,
        child: AppCard(
          elevation: 4,
          child: Container(
            decoration: BoxDecoration(
              color: context.foregroundOnPrimary,
              borderRadius: BorderRadius.circular(context.w12),
              border: Border.all(
                color: context.dividerColor,
                width: context.customWidth(1),
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: context.w12,
              horizontal: context.w16,
            ),
            child: Row(
              children: [
                prefixWidget,
                context.mediumHorizontalGap,
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialAppText.titleSmall(title),
                    MaterialAppText.bodySmall(description),
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: context.neutral,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
