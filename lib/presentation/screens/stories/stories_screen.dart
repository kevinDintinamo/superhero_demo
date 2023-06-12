import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/stories/story.dart';
import '../../../utils/utils.dart';
import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class StoriesScreen extends ConsumerWidget {
  static const screenName = 'stories_screen';

  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appBar = customAppBar('Stories', ref);

    return Scaffold(
      appBar: appBar,
      body: const SafeArea(child: _StoriesView()),
      bottomNavigationBar: BottomPageNavigationBar(
        dataProvider: storyDataProvider,
        offsetProvider: storiesOffsetProvider,
      ),
    );
  }
}

class _StoriesView extends ConsumerWidget {
  const _StoriesView();

  @override
  Widget build(BuildContext context, ref) {
    final storyData = ref.watch(storyDataProvider);

    final theme = Theme.of(context);

    return storyData.when(
      loading: () => const LoadingWidget(),
      error: (e, s) => Text('$e'),
      data: (data) {
        final stories = data.stories;
        return ListView(
          children: [
            // Photo Views.
            SizedBox(
                height: 240,
                width: double.infinity,
                child: SinglePageView(
                  objectListWithThumbnails: stories,
                  subPageProvider: storySubPageIndexProvider,
                )),

            _DetailedInfoWidget(stories: stories, theme: theme),
          ],
        );
      },
    );
  }
}

class _DetailedInfoWidget extends ConsumerWidget {
  const _DetailedInfoWidget({
    required this.stories,
    required this.theme,
  });

  final List<Story> stories;
  final ThemeData theme;

  @override
  Widget build(BuildContext context, ref) {
    final subPageIndex = ref.watch(storySubPageIndexProvider);
    if (stories.isEmpty) {
      return const Center(child: Text('No Stories to Show'));
    }

    final modifiedDate =
        Utils.getDateFormatted(stories[subPageIndex].modifiedDate);

    var description = stories[subPageIndex].description;
    if (description.isEmpty) description = 'No Description Available';

    return DetailsContainer(
      children: [
        // Title.
        Text(
          stories[subPageIndex].title,
          style: theme.textTheme.titleMedium,
          textAlign: TextAlign.start,
        ),

        const SizedBox(height: 4.0),

        // Page Count.
        Text(
          'Type: ${stories[subPageIndex].type}',
          style:
              theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 8.0),

        // Description.
        Text(
          description,
          style: theme.textTheme.bodyMedium,
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 8.0),

        // Modified Date.
        Text(
          'Modified Date: $modifiedDate',
          style: theme.textTheme.bodySmall,
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }
}
