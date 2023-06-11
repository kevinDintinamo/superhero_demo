import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../data/data_sources/character_data_source.dart';
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
      loading: () => const Center(child: Text('Loading...')),
      error: (e, s) => Text('$e'),
      data: (data) {
        final characters = data.characters;
        return ListView(
          children: [
            const SizedBox(height: 20),

            // Photo Views.
            SizedBox(
                height: 300,
                width: double.infinity,
                child: SinglePageView(
                  objectListWithThumbnails: characters,
                )),

            const SizedBox(height: 4.0),
            Text(
              '${subPageIndex + 1}/${characters.length}',
              style: theme.textTheme.labelSmall,
              textAlign: TextAlign.center,
            ),

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
    final dateTime = DateTime.parse(characters[subPageIndex].modifiedDate);
    final modifiedDate = DateFormat('dd/MM/yyyy').format(dateTime);

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

class _MoreInfoActionWidgets extends StatelessWidget {
  final Character character;
  const _MoreInfoActionWidgets(this.character);

  @override
  Widget build(BuildContext context) {
    final seriesCount = character.seriesAvailableCount;
    final comicsCount = character.comicsAvailableCount;
    final storiesCount = character.storiesAvailableCount;
    final eventsCount = character.eventsAvailableCount;

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8.0,
      runAlignment: WrapAlignment.center,
      children: [
        TonalButton(
          text: 'Series ($seriesCount)',
          iconData: Icons.ac_unit,
          onPresed: seriesCount == 0 ? null : () {},
        ),
        TonalButton(
          text: 'Comics ($comicsCount)',
          iconData: Icons.book,
          onPresed: comicsCount == 0 ? null : () {},
        ),
        TonalButton(
          text: 'Stories ($storiesCount)',
          iconData: Icons.battery_6_bar_sharp,
          onPresed: storiesCount == 0
              ? null
              : () => context.pushNamed(StoriesScreen.screenName),
        ),
        TonalButton(
          text: 'Events ($eventsCount)',
          iconData: Icons.event,
          onPresed: eventsCount == 0 ? null : () {},
        ),
      ],
    );
  }
}
