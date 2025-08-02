import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:smart_notes/domain/entities/notes/note_entity.dart';
import 'package:smart_notes/gen/assets.gen.dart';
import 'package:smart_notes/presentation/core/resources/resources.dart';
import 'package:smart_notes/presentation/core/widgets/svg_picture/app_svg.dart';
import 'package:smart_notes/presentation/core/widgets/text/material_app_text.dart';
import 'package:smart_notes/presentation/features/note_details/note_audio_player.dart';
import 'package:smart_notes/presentation/features/note_details/note_section_widget.dart';

@RoutePage()
class NoteDetailsScreen extends StatefulWidget {
  const NoteDetailsScreen({super.key, required this.noteEntity});

  final NoteEntity noteEntity;

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ValueNotifier<double> currentPlaybackTime = ValueNotifier(0.0);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    currentPlaybackTime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: MaterialAppText.headlineLarge('Smart Note Details'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: AppUiConstants.defaultScreenHorizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(context.w12),
                border: Border.all(color: context.dividerColor),
              ),
              padding: EdgeInsets.symmetric(
                vertical: context.customWidth(3),
                horizontal: context.w12,
              ),
              child: MaterialAppText.headlineLarge(widget.noteEntity.noteTitle),
            ),
            context.mediumVerticalGap,
            SizedBox(
              height: context.customWidth(32),
              child: TabBar(
                isScrollable: false,
                controller: _tabController,
                dividerHeight: 0,
                indicatorWeight: 1,
                splashFactory: NoSplash.splashFactory,
                overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                indicator: BoxDecoration(
                  color: context.secondary,
                  borderRadius: BorderRadius.circular(context.w4),
                ),
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.multitrack_audio, size: context.w12),
                        context.smallHorizontalGap,
                        MaterialAppText.titleLarge('Summary'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppSvg.fixedColor(
                          Assets.icons.icTextFile.path,
                          height: context.w12,
                          width: context.w12,
                          color: context.foregroundOnBackground,
                        ),
                        context.smallHorizontalGap,
                        MaterialAppText.titleLarge('Transcript'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            context.largeVerticalGap,
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  MaterialAppText.headlineSmall('Summery'),
                  SingleChildScrollView(
                    child: ValueListenableBuilder(
                      valueListenable: currentPlaybackTime,
                      builder: (context, time, __) {
                        return Column(
                          children: [
                            ...widget.noteEntity.segments.map(
                              (item) => NoteSectionWidget(
                                segment: item,
                                isCurrentSegment:
                                    (time >= item.startTime &&
                                        time <= item.endTime),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            context.largeVerticalGap,
            NoteAudioPlayer(
              audioUrl: widget.noteEntity.audioPath ?? '',
              onPositionChanged: (currentPosition) {
                currentPlaybackTime.value =
                    currentPosition.inSeconds.toDouble();
              },
            ),
          ],
        ),
      ),
    );
  }
}
