import 'dart:convert';

import 'shared/image_path.dart';

Event eventFromJson(String str) => Event.fromJson(json.decode(str));

String eventToJson(Event data) => json.encode(data.toJson());

class Event {
  final int id;
  final String title;
  final String description;
  final String modifiedDate;
  final String startDate;
  final String endDate;
  final ImagePath thumbnail;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.modifiedDate,
    required this.thumbnail,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      modifiedDate: json['modified'] ?? '',
      thumbnail: ImagePath.fromJson(json['thumbnail']),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "startDate": startDate,
        "endDate": endDate,
        "modified": modifiedDate,
        "thumbnail": thumbnail.toJson(),
      };
}
