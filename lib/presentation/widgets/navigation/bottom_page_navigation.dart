import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/constants/constants.dart';
import '../widgets.dart';

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
      centerText: 'loading...',
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

        final int actualPage = (offset / limit).ceil();

        final int maxPagesAvailable = (total / limit).ceil();

        final leftText = actualPage > 0 ? '$actualPage' : '';
        final centerText = 'Pag: ${actualPage + 1} / $maxPagesAvailable';

        final rightText =
            (actualPage + 1 < maxPagesAvailable) ? '${actualPage + 2}' : '';

        onLeftPressed() {
          ref
              .read(offsetProvider.notifier)
              .update((state) => state - apiLimitPerQuery);
        }

        onRightPressed() {
          ref
              .read(offsetProvider.notifier)
              .update((state) => state + apiLimitPerQuery);
        }

        final canGoLeft = actualPage > 1;
        final canGoRight = actualPage + 2 <= maxPagesAvailable;

        return _BottomPageNavigationBar(
          leftText: leftText,
          centerText: centerText,
          rightText: rightText,
          maxPagesAvailable: maxPagesAvailable,
          onLeftPressed: canGoLeft ? onLeftPressed : null,
          onRightPressed: canGoRight ? onRightPressed : null,
          offsetProvider: (canGoLeft || canGoRight) ? offsetProvider : null,
        );
      },
    );
  }
}

class _BottomPageNavigationBar extends ConsumerWidget {
  final String leftText;
  final String centerText;
  final String rightText;
  final VoidCallback? onLeftPressed;
  final VoidCallback? onRightPressed;
  final int? maxPagesAvailable;

  final StateProvider<int>? offsetProvider;

  const _BottomPageNavigationBar({
    required this.leftText,
    required this.centerText,
    required this.rightText,
    this.offsetProvider,
    this.maxPagesAvailable,
    this.onLeftPressed,
    this.onRightPressed,
  });

  @override
  Widget build(BuildContext context, ref) {
    const duration = Duration(milliseconds: 300);

    return SafeArea(
      child: SlideInUp(
        duration: duration,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SlideInLeft(
                delay: duration,
                duration: duration,
                child: FilledButton.icon(
                  label: Text(leftText),
                  icon: const Icon(Icons.skip_previous_rounded),
                  onPressed: onLeftPressed,
                ),
              ),
              TextButton(
                  onPressed: offsetProvider == null
                      ? null
                      : () => onCenterBottomPressed(
                            context,
                            ref,
                            offsetProvider!,
                            maxPagesAvailable!,
                          ),
                  child: Text(centerText)),
              SlideInRight(
                delay: duration,
                duration: duration,
                child: FilledButton.icon(
                  label: Text(rightText),
                  icon: const Icon(Icons.skip_next_rounded),
                  onPressed: onRightPressed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onCenterBottomPressed(
    BuildContext context,
    WidgetRef ref,
    StateProvider<int> offsetProvider,
    int maxPagesAvailable,
  ) {
    final numberController = TextEditingController();

    onGoPressed() {
      String number = numberController.text;

      // Update offset to navigate to the page.
      ref.read(offsetProvider.notifier).update((state) {
        var newValue = int.tryParse(number);
        if (newValue == null || newValue > maxPagesAvailable || newValue < 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Invalid page number'),
              duration: const Duration(seconds: 2),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          );

          return state;
        }

        if (newValue <= 1) newValue = 1;
        newValue = (newValue - 1) * apiLimitPerQuery;

        return newValue;
      });
      Navigator.pop(context);
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GoToPageAlert(
          onGoPressed: onGoPressed,
          numberController: numberController,
        );
      },
    );
  }
}
