import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:superhero_demo/config/constants/constants.dart';

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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: _CustomImage(
                    objectWithThumbnail: objectListWithThumbnails[index]),
              ),
            ),
          );
        });

    final paginationText = _UnderPagination(
      theme: theme,
      subPageProvider: subPageProvider,
      objectListWithThumbnails: objectListWithThumbnails,
    );

    final decoration = BoxDecoration(boxShadow: [
      BoxShadow(
          blurRadius: 10.0,
          offset: const Offset(0, 10),
          spreadRadius: 0.1,
          color: theme.primaryColor.withOpacity(.05)),
    ]);

    return Container(
      decoration: decoration,
      child: Column(
        children: [
          const SizedBox(height: 20.0),
          Expanded(child: pageView),
          paginationText,
          const SizedBox(height: 4.0),
        ],
      ),
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
    String fullPath =
        objectWithThumbnail.thumbnail?.fullPath ?? defaulNetworkImageUrl;

    final imageName = fullPath.split('/').last.split('.').first;
    final isGenericImage = imageName == 'image_not_available';

    return ElasticIn(
      duration: animationDuration,
      child: FadeInImage.assetNetwork(
        image: fullPath,
        fit: isGenericImage ? BoxFit.fill : BoxFit.cover,
        placeholder: defaultAssetImageUrl,
        imageErrorBuilder: _imageErrorBuilder,
      ),
    );
  }

  Widget _imageErrorBuilder(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Opacity(
          opacity: 0.5,
          child: Image.asset(
            defaultAssetImageUrl,
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.error),
              const SizedBox(height: 10),
              Text(
                'Error loading image',
                style: theme.textTheme.titleSmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
