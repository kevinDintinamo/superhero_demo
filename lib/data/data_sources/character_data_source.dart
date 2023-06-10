abstract class CharacterDataSource {
  String baseUrl;

  CharacterDataSource(this.baseUrl);

  Future<dynamic> getCharacter() async {}

  Future<dynamic> getComics(int characterId) async {}

  Future<dynamic> getEvents(int characterId) async {}

  Future<dynamic> getSeries(int characterId) async {}

  Future<dynamic> getStories(int characterId) async {}
}
