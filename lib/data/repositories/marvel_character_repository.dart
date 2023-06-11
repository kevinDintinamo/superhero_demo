import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../config/constants/environment.dart';
import '../../models/shared/data_wrapper.dart';
import '../data_sources/character_data_source.dart';

class MarvelCharacterRepository implements CharacterDataSource {
  @override
  String baseUrl;

  MarvelCharacterRepository({
    this.baseUrl = 'https://gateway.marvel.com/v1/public',
  });

  @override
  Future<CharacterWrapper> getCharacters({int offset = 0}) async {
    var data = await _getDataFromApi(offset: offset);

    if (data == null || data.results.isEmpty) {
      return CharacterWrapper(
        offset: 0,
        limit: 0,
        total: 0,
        count: 0,
        results: [],
        characters: <Character>[],
      );
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
  Future<List<Comic>> getComics(int characterId) async {
    final data = await _getDataFromApi(url: 'characters/$characterId/comics');
    if (data == null || data.results.isEmpty) return [];

    final comicList = data.results.map((e) => Comic.fromJson(e)).toList();
    return comicList;
  }

  @override
  Future<List<Event>> getEvents(int characterId) async {
    final data = await _getDataFromApi(url: 'characters/$characterId/events');
    if (data == null || data.results.isEmpty) return [];

    final eventList = data.results.map((e) => Event.fromJson(e)).toList();
    return eventList;
  }

  @override
  Future<List<Serie>> getSeries(int characterId) async {
    final data = await _getDataFromApi(url: 'characters/$characterId/series');
    if (data == null || data.results.isEmpty) return [];

    final serieList = data.results.map((e) => Serie.fromJson(e)).toList();
    return serieList;
  }

  @override
  Future<List<Story>> getStories(int characterId) async {
    final data = await _getDataFromApi(url: 'characters/$characterId/stories');
    if (data == null || data.results.isEmpty) return [];

    final storyList = data.results.map((e) => Story.fromJson(e)).toList();
    return storyList;
  }

  Future<DataWrapper?> _getDataFromApi(
      {String url = 'characters', int offset = 0}) async {
    final publicKey = Environment.marvelPublicKey;
    final privateKey = Environment.marvelPrivateKey;
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final hash = md5.convert(utf8.encode(timestamp + privateKey + publicKey));

    var getUrl = '$baseUrl/$url?ts=$timestamp'
        '&apikey=$publicKey&hash=$hash';

    if (offset > 0) getUrl += '&offset=$offset';

    try {
      final response = await http.get(Uri.parse(getUrl));
      final decodedData = json.decode(response.body)["data"];

      final data = DataWrapper.fromJson(decodedData);

      return data;
    } catch (e) {
      if (kDebugMode) {
        print('ERROR on URL: /$url');
        print('ERROR: $e');

        print('Complete URL: $getUrl');
      }
      return null;
    }
  }
}
