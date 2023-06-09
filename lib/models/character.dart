import 'dart:convert';

import 'shared/image_path.dart';

Character characterFromJson(String str) => Character.fromJson(json.decode(str));

String characterToJson(Character data) => json.encode(data.toJson());

/// Super Hero Character.
class Character {
  final int id;
  final String name;
  final String description;
  final String modifiedDate;
  final ImagePath? thumbnail;

  final int comicsAvailableCount;
  final int storiesAvailableCount;
  final int eventsAvailableCount;
  final int seriesAvailableCount;

  Character({
    required this.id,
    required this.name,
    required this.description,
    required this.modifiedDate,
    this.thumbnail,
    this.comicsAvailableCount = 0,
    this.storiesAvailableCount = 0,
    this.eventsAvailableCount = 0,
    this.seriesAvailableCount = 0,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      modifiedDate: json['modified'] ?? '',
      thumbnail: ImagePath.fromJson(json['thumbnail']),
      comicsAvailableCount: json['comics']['available'],
      storiesAvailableCount: json['stories']['available'],
      eventsAvailableCount: json['events']['available'],
      seriesAvailableCount: json['series']['available'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "modified": modifiedDate,
        "thumbnail": thumbnail?.toJson(),
        "comics": {"available": comicsAvailableCount},
        "stories": {"available": storiesAvailableCount},
        "events": {"available": eventsAvailableCount},
        "series": {"available": seriesAvailableCount},
      };
}
