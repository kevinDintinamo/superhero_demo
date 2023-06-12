import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:superhero_demo/models/shared/price.dart';

import '../../../models/comics/comics.dart';
import '../../../utils/utils.dart';
import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class ComicsScreen extends ConsumerWidget {
  static const screenName = 'comics_screen';

  const ComicsScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appBar = customAppBar('Comics', ref);

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
      loading: () => const LoadingWidget(),
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

  final List<Comic> comics;
  final ThemeData theme;

  @override
  Widget build(BuildContext context, ref) {
    final subPageIndex = ref.watch(comicSubPageIndexProvider);
    if (comics.isEmpty) {
      return const Center(child: Text('No Comics to Show'));
    }

    final modifiedDate =
        Utils.getDateFormatted(comics[subPageIndex].modifiedDate);

    final prices = comics[subPageIndex].prices;

    var description = comics[subPageIndex].description;
    if (description.isEmpty) description = 'No Description Available';

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

          Text(
            'PageCount: ${comics[subPageIndex].pageCount}',
            style: theme.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),

          // Modified Date.
          Text(
            'Modified Date: $modifiedDate',
            style: theme.textTheme.bodySmall,
            textAlign: TextAlign.start,
          ),
          // Description.
          const SizedBox(height: 8.0),

          Text(
            description,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 8.0),

          const SizedBox(height: 16.0),
          // Prices.
          _PricesWidget(prices: prices, theme: theme),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}

class _PricesWidget extends StatelessWidget {
  const _PricesWidget({
    required this.prices,
    required this.theme,
  });

  final List<Price> prices;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: prices.length * 100.0,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: prices.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(.05),
                borderRadius: const BorderRadius.all(Radius.circular(24.0)),
              ),
              child: Column(
                children: [
                  IntrinsicWidth(
                    child: Text(
                      '\$${prices[index].price}',
                      style: theme.textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  IntrinsicWidth(
                    child: Text(prices[index].type),
                  )
                ],
              ),
            );
          }),
    );
  }
}
