import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:superhero_demo/config/constants/constants.dart';

import '../../providers/providers.dart';

AppBar customAppBar(String titleText, WidgetRef ref) {
  final characterName = ref.watch(characterSelectedNameProvider);

  final textTheme = Theme.of(ref.context).textTheme;

  return AppBar(
    centerTitle: true,

    title: Column(
      children: [
        FadeInDown(
          duration: animationDuration,
          child: Text(
            characterName,
            style: textTheme.titleMedium,
          ),
        ),
        SlideInDown(
          delay: const Duration(milliseconds: 100),
          duration: animationDuration,
          child: Text(
            titleText,
            style: textTheme.labelSmall,
          ),
        ),
      ],
    ),
    // title: const Text('Stories'),
  );
}
