import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class StoriesScreen extends StatelessWidget {
  static const screenName = 'stories';

  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final appBar = AppBar(
      centerTitle: true,
      title: Column(
        children: [
          Text(
            'Stories',
            style: theme.textTheme.titleMedium,
          ),
          Text(
            'Super Hero Name',
            style: theme.textTheme.labelSmall,
          ),
        ],
      ),
    );

    final bottomPageNavigationBar = BottomPageNavigationBar(
      leftText: '3',
      centerText: '4 / 8',
      rightText: '5',
      onLeftPressed: () {},
      onRightPressed: () {},
    );

    return Scaffold(
      appBar: appBar,
      body: const SafeArea(child: _StroriesView()),
      bottomNavigationBar: bottomPageNavigationBar,
    );
  }
}

class _StroriesView extends StatelessWidget {
  const _StroriesView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = PageController(viewportFraction: 0.85);

    return ListView(
      children: [
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 300,
          child: SinglePageView(controller: controller),
        ),
        Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Story Title',
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.start,
              ),
              Text(
                'Description ofVeniam nulla reprehenderit adipisicing non enim magna ad cillum proident.',
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 4.0),
              Text(
                'Typo: Dominguera',
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 8.0),
              Text(
                'Fecha de modificación: {2022-02-02}',
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
