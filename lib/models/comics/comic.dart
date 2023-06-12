import 'dart:convert';

import '../shared/image_path.dart';
import '../shared/price.dart';

Comic comicFromJson(String str) => Comic.fromJson(json.decode(str));

String comicToJson(Comic data) => json.encode(data.toJson());

class Comic {
  final int id;
  final int pageCount;
  final String title;
  final String description;
  final String modifiedDate;
  final List<Price> prices;
  final ImagePath? thumbnail;

  Comic({
    required this.id,
    required this.pageCount,
    required this.title,
    required this.description,
    required this.modifiedDate,
    required this.prices,
    this.thumbnail,
  });

  factory Comic.fromJson(Map<String, dynamic> json) {
    return Comic(
      id: json['id'],
      pageCount: json['pageCount'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      modifiedDate: json['modified'] ?? '',
      prices: _extractPrices(json),
      thumbnail: imagePathFromJsonMap(json['thumbnail']),
    );
  }

  static List<Price> _extractPrices(Map<String, dynamic> json) =>
      (json['prices'] as List<dynamic>)
          .map((e) => Price.fromJson(e as Map<String, dynamic>))
          .toList();

  Map<String, dynamic> toJson() => {
        "id": id,
        "pageCount": pageCount,
        "title": title,
        "description": description,
        "modified": modifiedDate,
        "thumbnail": thumbnail?.toJson(),
      };
}
