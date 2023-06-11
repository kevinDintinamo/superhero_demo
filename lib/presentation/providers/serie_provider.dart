import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/data/data_sources/character_data_source.dart';
import 'character_provider.dart';
import 'data_source_provider.dart';

// Main Provider that fetch data from API.
final serieDataProvider = FutureProvider<SerieWrapper>((ref) async {
  final seriesOffset = ref.watch(seriesOffsetProvider);
  final characterId = ref.watch(characterSelectedIdProvider);

  final dataSource = ref.watch(dataSourceProvider);

  final wrapper = await dataSource.getSeries(characterId, offset: seriesOffset);

  /// Reset the subpage index to 0 when the page changes.
  ref.read(serieSubPageIndexProvider.notifier).update((_) => 0);

  return wrapper;
});

/// Value of the page (offset) im in the list of Series pagination.
final seriesOffsetProvider = StateProvider<int>((ref) {
  return 0;
});

/// Index of the Result in Wrapper List.
final serieSubPageIndexProvider = StateProvider<int>((ref) {
  return 0;
});
