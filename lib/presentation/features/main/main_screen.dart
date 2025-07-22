import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:smart_notes/presentation/core/resources/resources.dart';
import 'package:smart_notes/presentation/core/widgets/button/app_button.dart';
import 'package:smart_notes/presentation/core/widgets/text/material_app_text.dart';
import 'package:smart_notes/presentation/core/widgets/text_field/app_text_field.dart';
import 'package:smart_notes/presentation/core/widgets/utilities/app_alerts.dart';
import 'package:smart_notes/presentation/core/widgets/utilities/app_card.dart';
import 'package:smart_notes/presentation/features/main/ui/add_note_bottom_sheet.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: MaterialAppText.headlineLarge(
          'My Notes',
          fontWeight: FontWeight.w700,
        ),
        actions: [
          AppCard(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [context.primary, context.secondary],
                ),
                borderRadius: BorderRadius.circular(context.w64),
              ),
              padding: EdgeInsets.symmetric(
                vertical: context.w6,
                horizontal: context.w12,
              ),
              child: MaterialAppText.titleMediumUppercase(
                'PRO',
                color: context.foregroundOnPrimary,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: AppUiConstants.defaultScreenHorizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            context.smallVerticalGap,
            Row(
              children: [
                Flexible(
                  child: AppTextField.optional(
                    prefixWidget: Icon(
                      Icons.search_rounded,
                      color: context.neutral,
                      size: context.w20,
                    ),
                    filled: true,
                    fillColor: context.foregroundOnPrimary,
                    hintText: 'Search notes and transcripts',
                  ),
                ),
                context.mediumHorizontalGap,
                RotatedBox(
                  quarterTurns: 1,
                  child: AppCard(
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.foregroundOnPrimary,
                        borderRadius: BorderRadius.circular(context.w16),
                        border: Border.all(
                          color: context.dividerColor,
                          width: context.customWidth(1.5),
                        ),
                      ),
                      padding: EdgeInsets.all(context.w12),
                      child: Icon(
                        Symbols.discover_tune_rounded,
                        color: context.neutral,
                        size: context.customWidth(22),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            context.mediumVerticalGap,
            Row(
              children: [
                AppCard(
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.neutral.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(
                        context.customWidth(10),
                      ),
                      border: Border.all(color: context.neutral),
                    ),
                    padding: EdgeInsets.all(context.customWidth(10)),
                    child: Icon(
                      Icons.folder_outlined,
                      color: context.foregroundOnBackground.withValues(
                        alpha: .4,
                      ),
                    ),
                  ),
                ),
                context.mediumHorizontalGap,
                AppCard(
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.primary,
                      borderRadius: BorderRadius.circular(
                        context.customWidth(10),
                      ),
                      border: Border.all(color: context.neutral),
                    ),
                    padding: EdgeInsets.all(context.customWidth(11)),
                    child: MaterialAppText.titleLarge(
                      'All Notes',
                      color: context.foregroundOnPrimary,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            AppButton.primary(
              label: '\uFF0B New Note',
              borderRadius: 50,
              onPressed: () {
                context.alerts.openBottomSheet(
                  child: const AddNoteBottomSheet(),
                );
              },
            ),
            context.customVerticalGap(24),
          ],
        ),
      ),
    );
  }
}
