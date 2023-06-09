import '../shared/data_wrapper.dart';
import 'character.dart';

class CharacterWrapper extends DataWrapper {
  final List<Character> characters;

  CharacterWrapper({
    required int offset,
    required int limit,
    required int total,
    required int count,
    required List results,
    required this.characters,
  }) : super(
            offset: offset,
            limit: limit,
            total: total,
            count: count,
            results: results);
}
