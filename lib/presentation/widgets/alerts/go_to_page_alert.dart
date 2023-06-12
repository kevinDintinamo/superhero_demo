import 'package:flutter/material.dart';

class GoToPageAlert extends StatelessWidget {
  final TextEditingController numberController;
  final Function() onGoPressed;

  const GoToPageAlert({
    super.key,
    required this.numberController,
    required this.onGoPressed,
  });

  @override
  Widget build(BuildContext context) {
    const decoration = InputDecoration(
      counterText: '',
      hintText: 'Go to page',
      hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
      border: InputBorder.none,
      contentPadding: EdgeInsets.all(8.0),
    );

    return AlertDialog(
      content: IntrinsicHeight(
        child: Column(
          children: [
            TextField(
              maxLength: 2,
              textInputAction: TextInputAction.go,
              onEditingComplete: () => onGoPressed(),
              autofocus: true,
              decoration: decoration,
              textAlign: TextAlign.left,
              controller: numberController,
              keyboardType: TextInputType.number,
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
