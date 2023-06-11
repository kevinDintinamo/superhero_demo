import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/data/data_sources/character_data_source.dart';
import 'character_provider.dart';
import 'data_source_provider.dart';

// Main Provider that fetch data from API.
final eventDataProvider = FutureProvider<EventWrapper>((ref) async {
  final eventOffset = ref.watch(eventsOffsetProvider);
  final characterId = ref.watch(characterSelectedIdProvider);

  final dataSource = ref.watch(dataSourceProvider);

  final wrapper = await dataSource.getEvents(characterId, offset: eventOffset);

  /// Reset the subpage index to 0 when the page changes.
  ref.read(eventSubPageIndexProvider.notifier).update((_) => 0);

  return wrapper;
});

/// Value of the page (offset) im in the list of Events pagination.
final eventsOffsetProvider = StateProvider<int>((ref) {
  return 0;
});

/// Index of the Result in Wrapper List.
final eventSubPageIndexProvider = StateProvider<int>((ref) {
  return 0;
});
