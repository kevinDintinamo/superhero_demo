import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get marvelPublicKey {
    final key = dotenv.env['MARVEL_PUBLIC_KEY'];
    if (key == null) {
      throw Exception('MARVEL_PUBLIC_KEY is not defined in .env file');
    }

    return key;
  }

  static String get marvelPrivateKey {
    final key = dotenv.env['MARVEL_PRIVATE_KEY'];

    if (key == null) {
      throw Exception('MARVEL_PRIVATE_KEY is not defined in .env file');
    }

    return key;
  }
}
