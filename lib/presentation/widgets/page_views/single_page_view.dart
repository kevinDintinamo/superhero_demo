import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SinglePageView extends ConsumerWidget {
  /// Must provide an object that has a `thumbnail` property of type `ImagePath`.
  final List objectListWithThumbnails;
  final StateProvider<int> subPageProvider;
  const SinglePageView({
    super.key,
    required this.objectListWithThumbnails,
    required this.subPageProvider,
  });

  @override
  Widget build(BuildContext context, ref) {
    final theme = Theme.of(context);

    final subPageIndex = ref.watch(subPageProvider);
    final controller =
        PageController(viewportFraction: 0.85, initialPage: subPageIndex);

    final pageView = PageView.builder(
        itemCount: objectListWithThumbnails.length,
        pageSnapping: true,
        controller: controller,
        onPageChanged: (value) {
          ref.read(subPageProvider.notifier).update((_) => value);
        },
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var isShown = index == subPageIndex;
          return Opacity(
            opacity: isShown ? 1 : 0.5,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
              ),
              child: _CustomImage(
                  objectWithThumbnail: objectListWithThumbnails[index]),
            ),
          );
        });

    final paginationText = _UnderPagination(
      theme: theme,
      subPageProvider: subPageProvider,
      objectListWithThumbnails: objectListWithThumbnails,
    );

    return Column(
      children: [
        const SizedBox(height: 20),
        Expanded(child: pageView),
        paginationText,
        const SizedBox(height: 4.0),
      ],
    );
  }
}

class _UnderPagination extends ConsumerWidget {
  const _UnderPagination({
    required this.theme,
    // required this.subPageIndex,
    required this.subPageProvider,
    required this.objectListWithThumbnails,
  });

  final ThemeData theme;
  // final int subPageIndex;
  final StateProvider<int> subPageProvider;
  final List objectListWithThumbnails;

  @override
  Widget build(BuildContext context, ref) {
    final subPageIndex = ref.watch(subPageProvider);
    return Text(
      '${subPageIndex + 1}/${objectListWithThumbnails.length}',
      style: theme.textTheme.labelSmall,
      textAlign: TextAlign.center,
    );
  }
}

class _CustomImage extends StatelessWidget {
  final dynamic objectWithThumbnail;
  const _CustomImage({
    required this.objectWithThumbnail,
  });

  @override
  Widget build(BuildContext context) {
    var hasImage = objectWithThumbnail.thumbnail?.fullPath != null;

    if (!hasImage) {
      return const Center(
        child: Text('No image'),
      );
    }

    return Image.network(
      objectWithThumbnail.thumbnail?.fullPath,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(Icons.error),
            SizedBox(height: 10),
            Text('Error loading image'),
          ],
        ),
      ),
    );
  }
}
