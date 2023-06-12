import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text('Loading...', textAlign: TextAlign.center),
            SizedBox(height: 8.0),
            SizedBox(width: 100, child: LinearProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
