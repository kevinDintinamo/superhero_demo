import 'package:flutter/material.dart';

class BottomPageNavigationBar extends StatelessWidget {
  final String leftText;
  final String centerText;
  final String rightText;
  final VoidCallback? onLeftPressed;
  final VoidCallback? onRightPressed;

  const BottomPageNavigationBar(
      {super.key,
      required this.leftText,
      required this.centerText,
      required this.rightText,
      this.onLeftPressed,
      this.onRightPressed});

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
