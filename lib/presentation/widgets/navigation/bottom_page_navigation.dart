import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/constants/constants.dart';

class BottomPageNavigationBar extends ConsumerWidget {
  final FutureProvider dataProvider;
  final StateProvider<int> offsetProvider;
  const BottomPageNavigationBar({
    super.key,
    required this.dataProvider,
    required this.offsetProvider,
  });

  @override
  Widget build(BuildContext context, ref) {
    final dataWrapper = ref.watch(dataProvider);
    const defaultBottom = _BottomPageNavigationBar(
      leftText: '',
      centerText: '',
      rightText: '',
    );

    const loadingButton = _BottomPageNavigationBar(
      leftText: '',
      centerText: 'loading',
      rightText: '',
    );

    return dataWrapper.when(
      error: (error, stackTrace) => defaultBottom,
      loading: () => loadingButton,
      // DataWrapper
      data: (dataWrp) {
        final total = dataWrp.total;
        final limit = dataWrp.limit == 0 ? apiLimitPerQuery : dataWrp.limit;
        final offset = dataWrp.offset;

        final actualPage = (offset / limit).ceil();

        final maxPagesAvailable = (total / limit).ceil();

        final leftText = actualPage > 0 ? '$actualPage' : '';
        final centerText = 'Pag# ${actualPage + 1} / $maxPagesAvailable';

        final rightText =
            (actualPage + 1 < maxPagesAvailable) ? '${actualPage + 2}' : '';

        return _BottomPageNavigationBar(
          leftText: leftText,
          centerText: centerText,
          rightText: rightText,
          onLeftPressed: actualPage == 0
              ? null
              : () {
                  ref
                      .read(offsetProvider.notifier)
                      .update((state) => state - 20);
                },
          onRightPressed: actualPage >= maxPagesAvailable - 1
              ? null
              : () {
                  ref
                      .read(offsetProvider.notifier)
                      .update((state) => state + 20);
                },
        );
      },
    );
  }
}

class _BottomPageNavigationBar extends StatelessWidget {
  final String leftText;
  final String centerText;
  final String rightText;
  final VoidCallback? onLeftPressed;
  final VoidCallback? onRightPressed;

  const _BottomPageNavigationBar({
    required this.leftText,
    required this.centerText,
    required this.rightText,
    this.onLeftPressed,
    this.onRightPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilledButton.icon(
              label: Text(leftText),
              icon: const Icon(Icons.skip_previous_rounded),
              onPressed: onLeftPressed,
            ),
            Text(centerText),
            FilledButton.icon(
              label: Text(rightText),
              icon: const Icon(Icons.skip_next_rounded),
              onPressed: onRightPressed,
            ),
          ],
        ),
      ),
    );
  }
}
