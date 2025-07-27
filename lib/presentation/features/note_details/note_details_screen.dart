import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:smart_notes/domain/entities/notes/note_entity.dart';
import 'package:smart_notes/gen/assets.gen.dart';
import 'package:smart_notes/presentation/core/resources/resources.dart';
import 'package:smart_notes/presentation/core/widgets/svg_picture/app_svg.dart';
import 'package:smart_notes/presentation/core/widgets/text/material_app_text.dart';

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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MaterialAppText.headlineLarge(widget.noteEntity.noteTitle),
            context.mediumVerticalGap,
            Container(
              height: context.customWidth(32),
              // decoration: BoxDecoration(
              //     color: context.neutral,
              //   borderRadius: BorderRadius.circular(8)
              // ),
              child: TabBar(
                isScrollable: false,
                controller: _tabController,
                dividerHeight: 0,
                indicatorWeight: 1,
                splashFactory: NoSplash.splashFactory,
                overlayColor: WidgetStatePropertyAll(Colors.transparent),
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
                    child: Column(
                      children: [
                        ...widget.noteEntity.segments.map(
                          (item) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(color: context.dividerColor),
                              Row(
                                children: [
                                  MaterialAppText.titleLarge(
                                    'Smart Noter',
                                    fontSize: 22,
                                  ),
                                  context.mediumHorizontalGap,
                                  MaterialAppText.titleMedium(
                                    item.startTime.toString(),
                                    color: context.neutral,
                                  ),
                                ],
                              ),
                              context.mediumVerticalGap,
                              MaterialAppText.bodyLarge(
                                fontSize: 18,
                                item.content,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
