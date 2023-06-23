import 'package:http/http.dart' as http;

import '../data_sources/character_data_source.dart';
import '../shared/get_data.dart';

class MarvelCharacterRepository implements CharacterDataSource {
  @override
  final String baseUrl;
  final String preffixUrl = '/characters';

  MarvelCharacterRepository({
    this.baseUrl = 'https://gateway.marvel.com/v1/public',
  });

  @override
  Future<CharacterWrapper> getCharacters({int offset = 0}) async {
    var data = await getDataFromApi(
      http.Client(),
      offset: offset,
      baseUrl: baseUrl,
      relativeUrl: preffixUrl,
    );

    if (data == null || data.results.isEmpty) {
      return CharacterWrapper.empty();
    }

    final characterList =
        data.results.map((e) => Character.fromJson(e)).toList();

    final characterWrapper = CharacterWrapper(
      offset: data.offset,
      limit: data.limit,
      total: data.total,
      count: data.count,
      results: data.results,
      characters: characterList,
    );

    return characterWrapper;
  }

  @override
  Future<ComicWrapper> getComics(int characterId, {int offset = 0}) async {
    final data = await getDataFromApi(
      http.Client(),
      offset: offset,
      baseUrl: baseUrl,
      relativeUrl: '$preffixUrl/$characterId/comics',
    );

    if (data == null || data.results.isEmpty) {
      return ComicWrapper.empty();
    }

    final comicList = data.results.map((e) => Comic.fromJson(e)).toList();

    final comicWrapper = ComicWrapper(
      offset: data.offset,
      limit: data.limit,
      total: data.total,
      count: data.count,
      results: data.results,
      comics: comicList,
    );

    return comicWrapper;
  }

  @override
  Future<EventWrapper> getEvents(int characterId, {int offset = 0}) async {
    final data = await getDataFromApi(
      http.Client(),
      offset: offset,
      baseUrl: baseUrl,
      relativeUrl: '$preffixUrl/$characterId/events',
    );

    if (data == null || data.results.isEmpty) {
      return EventWrapper.empty();
    }

    final eventList = data.results.map((e) => Event.fromJson(e)).toList();

    final eventWrapper = EventWrapper(
      offset: data.offset,
      limit: data.limit,
      total: data.total,
      count: data.count,
      results: data.results,
      events: eventList,
    );

    return eventWrapper;
  }

  @override
  Future<SerieWrapper> getSeries(int characterId, {int offset = 0}) async {
    final data = await getDataFromApi(
      http.Client(),
      offset: offset,
      baseUrl: baseUrl,
      relativeUrl: '$preffixUrl/$characterId/series',
    );

    if (data == null || data.results.isEmpty) {
      return SerieWrapper.empty();
    }

    final serieList = data.results.map((e) => Serie.fromJson(e)).toList();

    final serieWrapper = SerieWrapper(
      offset: data.offset,
      limit: data.limit,
      total: data.total,
      count: data.count,
      results: data.results,
      series: serieList,
    );

    return serieWrapper;
  }

  @override
  Future<StoryWrapper> getStories(int characterId, {int offset = 0}) async {
    final data = await getDataFromApi(
      http.Client(),
      offset: offset,
      baseUrl: baseUrl,
      relativeUrl: '$preffixUrl/$characterId/stories',
    );

    if (data == null || data.results.isEmpty) {
      return StoryWrapper.empty();
    }

    final storyList = data.results.map((e) => Story.fromJson(e)).toList();

    final storyWrapper = StoryWrapper(
      offset: data.offset,
      limit: data.limit,
      total: data.total,
      count: data.count,
      results: data.results,
      stories: storyList,
    );

    return storyWrapper;
  }
}
