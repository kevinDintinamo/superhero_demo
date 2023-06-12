import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../config/constants/constants.dart';

class DetailsContainer extends StatelessWidget {
  final List<Widget> children;
  const DetailsContainer({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
        duration: animationDuration,
        from: 30.0,
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ));
  }
}
