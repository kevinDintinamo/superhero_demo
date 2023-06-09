import 'dart:convert';

Thumbnail thumbnailFromJson(String str) => Thumbnail.fromJson(json.decode(str));

String thumbnailToJson(Thumbnail data) => json.encode(data.toJson());

/// Image formed by the route and the extension of the file.
class Thumbnail {
  final String path;
  final String fileExtension;

  Thumbnail({
    required this.path,
    required this.fileExtension,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        path: json["path"],
        fileExtension: json["extension"],
      );

  Map<String, dynamic> toJson() => {
        "path": path,
        "extension": fileExtension,
      };

  /// Returns the full path of the image.
  String get fullPath => '$path.$fileExtension';
}
