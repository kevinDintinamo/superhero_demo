import 'dart:convert';

import 'shared/image_path.dart';

Comic comicFromJson(String str) => Comic.fromJson(json.decode(str));

String comicToJson(Comic data) => json.encode(data.toJson());

class Comic {
  final int id;
  final int pageCount;
  final String title;
  final String description;
  final String modifiedDate;
  final ImagePath? thumbnail;

  Comic({
    required this.id,
    required this.pageCount,
    required this.title,
    required this.description,
    required this.modifiedDate,
    this.thumbnail,
  });

  factory Comic.fromJson(Map<String, dynamic> json) {
    return Comic(
      id: json['id'],
      pageCount: json['pageCount'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      modifiedDate: json['modified'] ?? '',
      thumbnail: ImagePath.fromJson(json['thumbnail']),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "pageCount": pageCount,
        "title": title,
        "description": description,
        "modified": modifiedDate,
        "thumbnail": thumbnail?.toJson(),
      };
}
