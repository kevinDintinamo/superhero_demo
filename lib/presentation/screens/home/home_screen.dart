import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:superhero_demo/utils/utils.dart';

import '../../../models/characters/characters.dart';
import '../../providers/providers.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class HomeScreen extends ConsumerWidget {
  static const screenName = 'home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appBar = AppBar(
      centerTitle: true,
      title: const Text('Marvel Characters'),
    );

    return Scaffold(
      appBar: appBar,
      body: const SafeArea(child: _HomeView()),
      bottomNavigationBar: BottomPageNavigationBar(
        dataProvider: characterDataProvider,
        offsetProvider: charactersOffsetProvider,
      ),
    );
  }
}

class _HomeView extends ConsumerWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context, ref) {
    final characterData = ref.watch(characterDataProvider);

    final theme = Theme.of(context);

    final subPageIndex = ref.watch(characterSubPageIndexProvider);

    return characterData.when(
      loading: () => const LoadingWidget(),
      error: (e, s) => Text('$e'),
      data: (data) {
        final characters = data.characters;
        return ListView(
          children: [
            // Photo Views.
            SizedBox(
                height: 380,
                width: double.infinity,
                child: SinglePageView(
                  objectListWithThumbnails: characters,
                  subPageProvider: characterSubPageIndexProvider,
                )),

            _DetailedInfoWidget(
                characters: characters,
                subPageIndex: subPageIndex,
                theme: theme),
          ],
        );
      },
    );
  }
}

class _DetailedInfoWidget extends StatelessWidget {
  const _DetailedInfoWidget({
    required this.characters,
    required this.subPageIndex,
    required this.theme,
  });

  final List<Character> characters;
  final int subPageIndex;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    if (characters.isEmpty) {
      return const Center(child: Text('No Characters to Show'));
    }

    final modifiedDate =
        Utils.getDateFormatted(characters[subPageIndex].modifiedDate);

    return Padding(
      padding: const EdgeInsets.all(36.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title.
          Text(
            characters[subPageIndex].name,
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.start,
          ),
          // Description.
          Text(
            characters[subPageIndex].description,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 8.0),
          Text(
            'Modified Date: $modifiedDate',
            style: theme.textTheme.bodySmall,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 24.0),
          _MoreInfoActionWidgets(characters[subPageIndex]),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}

class _MoreInfoActionWidgets extends ConsumerWidget {
  final Character character;
  const _MoreInfoActionWidgets(this.character);

  @override
  Widget build(BuildContext context, ref) {
    final seriesCount = character.seriesAvailableCount;
    final comicsCount = character.comicsAvailableCount;
    final storiesCount = character.storiesAvailableCount;
    final eventsCount = character.eventsAvailableCount;

    // Center Here to improve design consistents on web.
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8.0,
        runSpacing: 8.0,
        runAlignment: WrapAlignment.center,
        children: [
          TonalButton(
            text: 'Series ($seriesCount)',
            iconData: Icons.ac_unit,
            onPressed: seriesCount == 0
                ? null
                : () {
                    ref
                        .read(characterSelectedIdProvider.notifier)
                        .update((state) => character.id);
                    context.pushNamed(SeriesScreen.screenName);
                  },
          ),
          TonalButton(
            text: 'Comics ($comicsCount)',
            iconData: Icons.book,
            onPressed: comicsCount == 0
                ? null
                : () {
                    ref
                        .read(characterSelectedIdProvider.notifier)
                        .update((state) => character.id);
                    context.pushNamed(ComicsScreen.screenName);
                  },
          ),
          TonalButton(
              text: 'Stories ($storiesCount)',
              iconData: Icons.battery_6_bar_sharp,
              onPressed: storiesCount == 0
                  ? null
                  : () {
                      ref
                          .read(characterSelectedIdProvider.notifier)
                          .update((state) => character.id);
                      context.pushNamed(StoriesScreen.screenName);
                    }),
          TonalButton(
            text: 'Events ($eventsCount)',
            iconData: Icons.event,
            onPressed: eventsCount == 0
                ? null
                : () {
                    ref
                        .read(characterSelectedIdProvider.notifier)
                        .update((state) => character.id);
                    context.pushNamed(EventsScreen.screenName);
                  },
          ),
        ],
      ),
    );
  }
}
