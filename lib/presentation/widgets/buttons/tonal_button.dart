import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:superhero_demo/config/constants/constants.dart';

class TonalButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  final VoidCallback? onPressed;
  final int millisecondsDelay;
  const TonalButton({
    super.key,
    required this.text,
    required this.iconData,
    required this.onPressed,
    this.millisecondsDelay = 0,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return ZoomIn(
      duration: animationDuration,
      delay: Duration(milliseconds: millisecondsDelay),
      child: FilledButton.tonal(
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
                child: Text(
                  text,
                  style: TextStyle(color: primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
