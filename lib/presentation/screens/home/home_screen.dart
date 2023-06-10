import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const screenName = 'home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      centerTitle: true,
      title: const Text('Marvel Super Heroes'),
    );

    final bottomPageNavigationBar = BottomPageNavigationBar(
      leftText: '1',
      centerText: '2 / 95',
      rightText: '3',
      onLeftPressed: () {},
      onRightPressed: () {},
    );

    return Scaffold(
      appBar: appBar,
      body: const SafeArea(child: _HomeView()),
      bottomNavigationBar: bottomPageNavigationBar,
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final controller = PageController(viewportFraction: 0.85);

    return ListView(
      children: [
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 350,
          child: SinglePageView(controller: controller),
        ),
        Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SuperHero Name',
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.start,
              ),
              Text(
                // 'Desc.',
                'Description ofVeniam nulla reprehenderit adipisicing non enim magna ad cillum proident.',
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 8.0),
              Text(
                'Fecha de modificación: {2022-02-02}',
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 24.0),
              const _MoreInfoActionWidgets(),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ],
    );
  }
}

class _MoreInfoActionWidgets extends StatelessWidget {
  const _MoreInfoActionWidgets();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8.0,
      runAlignment: WrapAlignment.center,
      children: [
        TonalButton(
          text: 'Series (4)',
          iconData: Icons.ac_unit,
          onPresed: () {},
        ),
        TonalButton(
          text: 'Comics (4)',
          iconData: Icons.book,
          onPresed: () {},
        ),
        const TonalButton(
          text: 'Stories (3)',
          iconData: Icons.battery_6_bar_sharp,
          onPresed: null,
        ),
        TonalButton(
          text: 'Events (0)',
          iconData: Icons.event,
          onPresed: () {},
        ),
      ],
    );
  }
}
