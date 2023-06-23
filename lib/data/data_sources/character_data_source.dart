import '/models/characters/characters.dart';
import '/models/events/events.dart';
import '/models/comics/comics.dart';
import '/models/series/series.dart';
import '/models/stories/stories.dart';

export '/models/characters/characters.dart';
export '/models/events/events.dart';
export '/models/comics/comics.dart';
export '/models/series/series.dart';
export '/models/stories/stories.dart';

abstract class CharacterDataSource {
  final String baseUrl;

  CharacterDataSource(this.baseUrl);

  Future<CharacterWrapper> getCharacters({int offset = 0}) {
    throw UnimplementedError();
  }

  Future<ComicWrapper> getComics(int characterId, {int offset = 0}) async {
    throw UnimplementedError();
  }

  Future<EventWrapper> getEvents(int characterId, {int offset = 0}) async {
    throw UnimplementedError();
  }

  Future<SerieWrapper> getSeries(int characterId, {int offset = 0}) async {
    throw UnimplementedError();
  }

  Future<StoryWrapper> getStories(int characterId, {int offset = 0}) async {
    throw UnimplementedError();
  }
}
