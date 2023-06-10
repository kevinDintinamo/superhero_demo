import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const screenName = 'home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('HOME SCREEN HERE'),
      ),
    );
  }
}
