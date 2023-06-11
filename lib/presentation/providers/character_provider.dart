import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/data/data_sources/character_data_source.dart';
import '/presentation/providers/data_source_provider.dart';

// Main Provider that fetch data from API.
final characterDataProvider = FutureProvider<CharacterWrapper>((ref) async {
  final characterOffset = ref.watch(charactersOffsetProvider);

  final dataSource = ref.watch(dataSourceProvider);

  final wrapper = await dataSource.getCharacters(offset: characterOffset);

  /// Reset the subpage index to 0 when the page changes.
  ref.read(characterSubPageIndexProvider.notifier).update((_) => 0);

  return wrapper;
});

/// Value of the page (offset) im in the list of characters pagination.
final charactersOffsetProvider = StateProvider<int>((ref) {
  return 0;
});

/// Index of the Result in Wrapper List.
final characterSubPageIndexProvider = StateProvider<int>((ref) {
  return 0;
});

final characterSelectedIdProvider = StateProvider<int>((ref) {
  return 0;
});
