import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/data/data_sources/character_data_source.dart';
import '/presentation/providers/data_source_provider.dart';

final characterDataProvider = FutureProvider<CharacterWrapper>((ref) async {
  final characterOffset = ref.watch(charactersOffsetProvider);

  final dataSource = ref.watch(dataSourceProvider);

  final dataSou = await dataSource.getCharacters(offset: characterOffset);

  /// Reset the subpage index to 0 when the page changes.
  ref.read(characterSubPageIndexProvider.notifier).update((_) => 0);

  return dataSou;
});

/// Value of the page (offset) im in the list of characters pagination.
final charactersOffsetProvider = StateProvider<int>((ref) {
  return 0;
});

/// Index of the Result in Wrapper List.
final characterSubPageIndexProvider = StateProvider<int>((ref) {
  return 0;
});