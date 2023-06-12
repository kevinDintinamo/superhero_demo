import 'package:flutter/material.dart';

class TonalButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  final VoidCallback? onPressed;
  const TonalButton({
    super.key,
    required this.text,
    required this.iconData,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return FilledButton.tonal(
      onPressed: onPressed,
      child: IntrinsicWidth(
        child: Row(
          children: [
            Icon(
              iconData,
              color: primaryColor.withOpacity(onPressed == null ? .4 : 1),
            ),
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
