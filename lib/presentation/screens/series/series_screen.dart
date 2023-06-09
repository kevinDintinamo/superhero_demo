import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/series/series.dart';
import '../../../utils/utils.dart';
import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class SeriesScreen extends ConsumerWidget {
  static const screenName = 'series_screen';

  const SeriesScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appBar = customAppBar('Series', ref);

    return Scaffold(
      appBar: appBar,
      body: const SafeArea(child: _SeriesView()),
      bottomNavigationBar: BottomPageNavigationBar(
        dataProvider: serieDataProvider,
        offsetProvider: seriesOffsetProvider,
      ),
    );
  }
}

class _SeriesView extends ConsumerWidget {
  const _SeriesView();

  @override
  Widget build(BuildContext context, ref) {
    final serieData = ref.watch(serieDataProvider);

    final theme = Theme.of(context);

    return serieData.when(
      loading: () => const LoadingWidget(),
      error: (e, s) => Text('$e'),
      data: (data) {
        final serie = data.series;
        return ListView(
          children: [
            // Photo Views.
            SizedBox(
                height: 440,
                width: double.infinity,
                child: SinglePageView(
                  objectListWithThumbnails: serie,
                  subPageProvider: serieSubPageIndexProvider,
                )),

            _DetailedInfoWidget(series: serie, theme: theme),
          ],
        );
      },
    );
  }
}

class _DetailedInfoWidget extends ConsumerWidget {
  const _DetailedInfoWidget({
    required this.series,
    required this.theme,
  });

  final List<Serie> series;
  final ThemeData theme;

  @override
  Widget build(BuildContext context, ref) {
    final subPageIndex = ref.watch(serieSubPageIndexProvider);
    if (series.isEmpty) {
      return const Center(child: Text('No Series to Show'));
    }

    final modifiedDate =
        Utils.getDateFormatted(series[subPageIndex].modifiedDate);

    final startDate = series[subPageIndex].startYear;
    final endDate = series[subPageIndex].endYear;

    var description = series[subPageIndex].description;
    if (description.isEmpty) description = 'No Description Available';

    return DetailsContainer(
      children: [
        // Title.
        Text(
          series[subPageIndex].title,
          style: theme.textTheme.titleMedium,
          textAlign: TextAlign.start,
        ),

        const SizedBox(height: 4.0),
        // Start Date.
        Text(
          'Start year: $startDate',
          style:
              theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,
        ),

        // End Date.
        Text(
          'End year:   $endDate',
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
