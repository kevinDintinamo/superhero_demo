import '/models/characters/characters.dart';
import '../../models/events/event.dart';
import '../../models/stories/story.dart';
import '../../models/comics/comic.dart';
import '../../models/serie.dart';

export '/models/characters/characters.dart';
export '../../models/events/event.dart';
export '../../models/stories/story.dart';
export '../../models/comics/comic.dart';
export '../../models/serie.dart';

abstract class CharacterDataSource {
  String baseUrl;

  CharacterDataSource(this.baseUrl);

  Future<CharacterWrapper> getCharacters({int offset = 0}) {
    throw UnimplementedError();
  }

  Future<List<Comic>> getComics(int characterId) async {
    throw UnimplementedError();
  }

  Future<List<Event>> getEvents(int characterId) async {
    throw UnimplementedError();
  }

  Future<List<Serie>> getSeries(int characterId) async {
    throw UnimplementedError();
  }

  Future<List<Story>> getStories(int characterId) async {
    throw UnimplementedError();
  }
}
