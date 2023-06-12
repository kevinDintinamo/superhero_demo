import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

AppBar customAppBar(String titleText, WidgetRef ref) {
  final characterName = ref.watch(characterSelectedNameProvider);

  final textTheme = Theme.of(ref.context).textTheme;

  return AppBar(
    centerTitle: true,

    title: Column(
      children: [
        Text(characterName),
        Text(
          titleText,
          style: textTheme.labelSmall,
        ),
      ],
    ),
    // title: const Text('Stories'),
  );
}
