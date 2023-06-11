import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/utils.dart';
import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class ComicsScreen extends StatelessWidget {
  static const screenName = 'comics_screen';

  const ComicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      centerTitle: true,
      title: const Text('Comics'),
    );

    return Scaffold(
      appBar: appBar,
      body: const SafeArea(child: _ComicsView()),
      bottomNavigationBar: BottomPageNavigationBar(
        dataProvider: comicDataProvider,
        offsetProvider: comicsOffsetProvider,
      ),
    );
  }
}

class _ComicsView extends ConsumerWidget {
  const _ComicsView();

  @override
  Widget build(BuildContext context, ref) {
    final comicData = ref.watch(comicDataProvider);

    final theme = Theme.of(context);

    return comicData.when(
      loading: () => const Center(child: Text('Loading...')),
      error: (e, s) => Text('$e'),
      data: (data) {
        final comics = data.comics;
        return ListView(
          children: [
            // Photo Views.
            SizedBox(
                height: 540,
                width: double.infinity,
                child: SinglePageView(
                  objectListWithThumbnails: comics,
                  subPageProvider: comicSubPageIndexProvider,
                )),

            _DetailedInfoWidget(comics: comics, theme: theme),
          ],
        );
      },
    );
  }
}

class _DetailedInfoWidget extends ConsumerWidget {
  const _DetailedInfoWidget({
    required this.comics,
    required this.theme,
  });

  final List comics;
  final ThemeData theme;

  @override
  Widget build(BuildContext context, ref) {
    final subPageIndex = ref.watch(comicSubPageIndexProvider);
    final modifiedDate =
        Utils.getDateFormatted(comics[subPageIndex].modifiedDate);

    return Padding(
      padding: const EdgeInsets.all(36.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title.
          Text(
            comics[subPageIndex].title,
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.start,
          ),

          const SizedBox(height: 4.0),
          // Page Count.
          Text(
            'PageCount: ${comics[subPageIndex].pageCount}',
            style: theme.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 8.0),

          // Description.
          Text(
            comics[subPageIndex].description,
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
      ),
    );
  }
}
