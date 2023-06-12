import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:superhero_demo/config/constants/constants.dart';
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
      title: SlideInDown(
        duration: animationDuration,
        child: const Text('Marvel Characters'),
      ),
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

    var description = characters[subPageIndex].description;
    if (description.isEmpty) description = 'No Description Available';

    return Padding(
      padding: const EdgeInsets.all(36.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title.
          Text(
            characters[subPageIndex].name,
            style: theme.textTheme.titleMedium?.copyWith(color: Colors.black),
            textAlign: TextAlign.start,
          ),
          // Description.
          Text(
            description,
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
            iconData: Icons.collections_bookmark_outlined,
            onPressed: seriesCount == 0
                ? null
                : () => _onPressed(context, ref, SeriesScreen.screenName),
          ),
          TonalButton(
            text: 'Comics ($comicsCount)',
            iconData: Icons.menu_book_outlined,
            onPressed: comicsCount == 0
                ? null
                : () => _onPressed(context, ref, ComicsScreen.screenName),
          ),
          TonalButton(
            text: 'Stories ($storiesCount)',
            iconData: Icons.bookmark_add_outlined,
            onPressed: storiesCount == 0
                ? null
                : () => _onPressed(context, ref, StoriesScreen.screenName),
          ),
          TonalButton(
            text: 'Events ($eventsCount)',
            iconData: Icons.playlist_add_check_circle_outlined,
            onPressed: eventsCount == 0
                ? null
                : () => _onPressed(context, ref, EventsScreen.screenName),
          ),
        ],
      ),
    );
  }

  _onPressed(BuildContext context, WidgetRef ref, String screenName) {
    ref
        .read(characterSelectedIdProvider.notifier)
        .update((state) => character.id);

    ref
        .read(characterSelectedNameProvider.notifier)
        .update((state) => character.name);

    context.pushNamed(screenName);
  }
}
