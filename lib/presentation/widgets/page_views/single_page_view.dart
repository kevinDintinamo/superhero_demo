import 'package:flutter/material.dart';

class SinglePageView extends StatelessWidget {
  const SinglePageView({
    super.key,
    required this.controller,
  });

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: 10,
      pageSnapping: true,
      controller: controller,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => Container(
        // padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 100,
        width: 100,
        decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
      ),
    );
  }
}
