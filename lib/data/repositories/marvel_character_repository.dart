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
  Future getCharacter() async {
    var data = await _getDataFromApi();
    if (data == null) return;
  }

  @override
  Future getComics(int characterId) async {
    final data = await _getDataFromApi('characters/$characterId/comics');
    if (data == null || data.results.isEmpty) return;
  }

  @override
  Future getEvents(int characterId) async {
    final data = await _getDataFromApi('characters/$characterId/events');
    if (data == null || data.results.isEmpty) return;
  }

  @override
  Future getSeries(int characterId) async {
    final data = await _getDataFromApi('characters/$characterId/series');
    if (data == null || data.results.isEmpty) return;
  }

  @override
  Future getStories(int characterId) async {
    final data = await _getDataFromApi('characters/$characterId/stories');
    if (data == null || data.results.isEmpty) return;
  }

  Future<DataWrapper?> _getDataFromApi([String url = 'characters']) async {
    final publicKey = Environment.marvelPublicKey;
    final privateKey = Environment.marvelPrivateKey;
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final hash = md5.convert(utf8.encode(timestamp + privateKey + publicKey));

    final getUrl = '$baseUrl/$url?ts=$timestamp'
        '&apikey=$publicKey&hash=$hash';

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
