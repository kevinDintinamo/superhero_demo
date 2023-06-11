import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/data/data_sources/character_data_source.dart';
import 'character_provider.dart';
import 'data_source_provider.dart';

// Main Provider that fetch data from API.
final comicDataProvider = FutureProvider<ComicWrapper>((ref) async {
  final comicOffset = ref.watch(comicsOffsetProvider);
  final characterId = ref.watch(characterSelectedIdProvider);

  final dataSource = ref.watch(dataSourceProvider);

  final wrapper = await dataSource.getComics(characterId, offset: comicOffset);

  /// Reset the subpage index to 0 when the page changes.
  ref.read(comicSubPageIndexProvider.notifier).update((_) => 0);

  return wrapper;
});

/// Value of the page (offset) im in the list of Comics pagination.
final comicsOffsetProvider = StateProvider<int>((ref) {
  return 0;
});

/// Index of the Result in Wrapper List.
final comicSubPageIndexProvider = StateProvider<int>((ref) {
  return 0;
});
