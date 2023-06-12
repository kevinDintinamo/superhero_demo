import 'package:flutter/material.dart';

class GoToPageAlert extends StatelessWidget {
  final TextEditingController numberController;
  final Function()? onGoPressed;

  const GoToPageAlert({
    super.key,
    required this.numberController,
    required this.onGoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: IntrinsicHeight(
        child: Column(
          children: [
            TextField(
              controller: numberController,
              maxLength: 2,
              autofocus: true,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                counterText: '',
                hintText: 'Go to page',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(8.0),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FilledButton(onPressed: onGoPressed, child: const Text('Go')),
      ],
    );
  }
}
