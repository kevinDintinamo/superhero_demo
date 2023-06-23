import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../config/constants/constants.dart';
import '../../config/constants/environment.dart';
import '../../models/shared/data_wrapper.dart';

/// Returns a [Future<Wrapper>] with the data from the API.
///
/// `baseUrl:` is the base url to make the request to the API.
///
/// `relativeUrl:` is the relative url to make the request to the API.
///
/// `offset:` is the number of items to skip before starting to collect the result set.
Future<DataWrapper?> getDataFromApi(
  http.Client client, {
  int offset = 0,
  required String baseUrl,
  required String relativeUrl,
}) async {
  assert(offset >= 0, 'offset must be greater than or equal to 0');
  log('Antes de  a testear ');
  final url = getUrlWithHash(
    baseUrl: baseUrl,
    relativeUrl: relativeUrl,
    offset: offset,
  );
  log('VOY a testear ');
  // final response = await http.get(url);
  final response = await client.get(url);
  client.close();
  log('RESPONSE BODY');
  log(response.body);
  // Success.
  if (response.statusCode == 200) {
    try {
      final decodedData = json.decode(response.body)["data"];

      final data = DataWrapper.fromJson(decodedData);

      return data;
    } catch (e) {
      if (kDebugMode) {
        print('ERROR: $e');
        print('ERROR on URL: /$relativeUrl');
        print('Full URL path: $url');
      }

      return null;
    }
  }

  // Error.
  else {
    return null;
  }
}

/// Returns a [Uri] with the url to make the request to the API.
Uri getUrlWithHash(
    {required String baseUrl, required String relativeUrl, int offset = 0}) {
  final publicKey = Environment.marvelPublicKey;

  final privateKey = Environment.marvelPrivateKey;

  final timestamp = DateTime.now().millisecondsSinceEpoch.toString();

  final hash = md5.convert(utf8.encode(timestamp + privateKey + publicKey));

  var url = '$baseUrl$relativeUrl?'
      'ts=$timestamp'
      '&apikey=$publicKey'
      '&hash=$hash'
      '&limit=$apiLimitPerQuery'
      '&offset=$offset';

  final absoluteUrl = Uri.parse(url);

  return absoluteUrl;
}
