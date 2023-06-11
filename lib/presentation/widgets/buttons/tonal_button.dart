import 'package:flutter/material.dart';

class TonalButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  final VoidCallback? onPresed;
  const TonalButton({
    super.key,
    required this.text,
    required this.iconData,
    required this.onPresed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed: onPresed,
      child: IntrinsicWidth(
        child: Row(
          children: [
            Icon(iconData),
            const SizedBox(width: 8.0),
            // Promote a more symmetrical size.
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 85),
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }
}
