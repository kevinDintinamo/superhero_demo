import 'character.dart';

class CharacterWrapper {
  final int offset;
  final int limit;
  final int total;
  final int count;
  final List<Character> characters;

  CharacterWrapper({
    required this.offset,
    required this.limit,
    required this.total,
    required this.count,
    required this.characters,
  });
}
