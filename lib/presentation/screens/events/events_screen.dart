import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:superhero_demo/data/data_sources/character_data_source.dart';

import '../../../utils/utils.dart';
import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class EventsScreen extends StatelessWidget {
  static const screenName = 'events_screen';

  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      centerTitle: true,
      title: const Text('Events'),
    );

    return Scaffold(
      appBar: appBar,
      body: const SafeArea(child: _EventsView()),
      bottomNavigationBar: BottomPageNavigationBar(
        dataProvider: eventDataProvider,
        offsetProvider: eventsOffsetProvider,
      ),
    );
  }
}

class _EventsView extends ConsumerWidget {
  const _EventsView();

  @override
  Widget build(BuildContext context, ref) {
    final eventData = ref.watch(eventDataProvider);

    final theme = Theme.of(context);

    return eventData.when(
      loading: () => const Center(child: Text('Loading...')),
      error: (e, s) => Text('$e'),
      data: (data) {
        final events = data.events;
        return ListView(
          children: [
            // Photo Views.
            SizedBox(
                height: 400,
                width: double.infinity,
                child: SinglePageView(
                  objectListWithThumbnails: events,
                  subPageProvider: eventSubPageIndexProvider,
                )),

            _DetailedInfoWidget(events: events, theme: theme),
          ],
        );
      },
    );
  }
}

class _DetailedInfoWidget extends ConsumerWidget {
  const _DetailedInfoWidget({
    required this.events,
    required this.theme,
  });

  final List<Event> events;
  final ThemeData theme;

  @override
  Widget build(BuildContext context, ref) {
    final subPageIndex = ref.watch(eventSubPageIndexProvider);
    final modifiedDate =
        Utils.getDateFormatted(events[subPageIndex].modifiedDate);

    final startDate = Utils.getDateFormatted(events[subPageIndex].startDate);
    final endDate = Utils.getDateFormatted(events[subPageIndex].endDate);

    return Padding(
      padding: const EdgeInsets.all(36.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title.
          Text(
            events[subPageIndex].title,
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.start,
          ),

          const SizedBox(height: 4.0),
          // Start Date.
          Text(
            'Start: $startDate',
            style: theme.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),

          // End Date.
          Text(
            'End: $endDate',
            style: theme.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 8.0),

          // Description.
          Text(
            events[subPageIndex].description,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 8.0),

          // Modified Date.
          Text(
            'Modified Date: $modifiedDate',
            style: theme.textTheme.bodySmall,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}
