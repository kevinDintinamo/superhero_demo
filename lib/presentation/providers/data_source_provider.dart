import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/data_sources/character_data_source.dart';
import '../../data/repositories/marvel_character_repository.dart';

final dataSourceProvider = Provider<CharacterDataSource>((ref) {
  return MarvelCharacterRepository();
});
