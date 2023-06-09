import 'dart:convert';

import 'shared/image_path.dart';

Story storyFromJson(String str) => Story.fromJson(json.decode(str));

String storyToJson(Story data) => json.encode(data.toJson());

class Story {
  final int id;
  final String title;
  final String description;
  final String type;
  final String modifiedDate;
  final ImagePath? thumbnail;

  Story({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.modifiedDate,
    this.thumbnail,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      modifiedDate: json['modified'] ?? '',
      thumbnail: ImagePath.fromJson(json['thumbnail']),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "type": type,
        "modified": modifiedDate,
        "thumbnail": thumbnail?.toJson(),
      };
}
