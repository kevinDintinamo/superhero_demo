import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/presentation/providers/providers.dart';

class SinglePageView extends ConsumerWidget {
  /// Must provide an object that has a `thumbnail` property of type `ImagePath`.
  final List objectListWithThumbnails;
  const SinglePageView({
    super.key,
    required this.objectListWithThumbnails,
  });

  @override
  Widget build(BuildContext context, ref) {
    final controller = PageController(viewportFraction: 0.85);
    final subPage = ref.watch(characterSubPageIndexProvider);

    return PageView.builder(
        itemCount: objectListWithThumbnails.length,
        pageSnapping: true,
        controller: controller,
        onPageChanged: (value) {
          ref.read(characterSubPageIndexProvider.notifier).update((_) => value);
        },
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var isShown = index == subPage;
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
  }
}

class _CustomImage extends StatelessWidget {
  final dynamic objectWithThumbnail;
  const _CustomImage({
    required this.objectWithThumbnail,
  });

  @override
  Widget build(BuildContext context) {
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
