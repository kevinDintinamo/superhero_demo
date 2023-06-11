import 'dart:convert';

import '../shared/image_path.dart';

Serie serieFromJson(String str) => Serie.fromJson(json.decode(str));

String serieToJson(Serie data) => json.encode(data.toJson());

class Serie {
  final int id;
  final String title;
  final String description;
  final int startYear;
  final int endYear;
  final String modifiedDate;
  final ImagePath? thumbnail;

  Serie({
    required this.id,
    required this.title,
    required this.description,
    required this.startYear,
    required this.endYear,
    required this.modifiedDate,
    this.thumbnail,
  });

  factory Serie.fromJson(Map<String, dynamic> json) {
    return Serie(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      startYear: json['startYear'] ?? 0,
      endYear: json['endYear'] ?? DateTime(DateTime.now().year).year,
      modifiedDate: json['modified'] ?? '',
      thumbnail: imagePathFromJsonMap(json['thumbnail']),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "startYear": startYear,
        "endYear": endYear,
        "modified": modifiedDate,
        "thumbnail": thumbnail?.toJson(),
      };
}
