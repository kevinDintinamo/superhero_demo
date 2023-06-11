import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/data/data_sources/character_data_source.dart';
import 'character_provider.dart';
import 'data_source_provider.dart';

// Main Provider that fetch data from API.
final storyDataProvider = FutureProvider<StoryWrapper>((ref) async {
  final storyOffset = ref.watch(storiesOffsetProvider);
  final characterId = ref.watch(characterSelectedIdProvider);

  final dataSource = ref.watch(dataSourceProvider);

  final wrapper = await dataSource.getStories(characterId, offset: storyOffset);

  /// Reset the subpage index to 0 when the page changes.
  ref.read(storySubPageIndexProvider.notifier).update((_) => 0);

  return wrapper;
});

/// Value of the page (offset) im in the list of Stories pagination.
final storiesOffsetProvider = StateProvider<int>((ref) {
  return 0;
});

/// Index of the Result in Wrapper List.
final storySubPageIndexProvider = StateProvider<int>((ref) {
  return 0;
});
