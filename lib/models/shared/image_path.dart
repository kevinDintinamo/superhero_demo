import 'dart:convert';

ImagePath imagePathFromJson(String str) => ImagePath.fromJson(json.decode(str));

ImagePath? imagePathFromJsonMap(Map<String, dynamic>? json) {
  if (json == null) return null;
  return ImagePath.fromJson(json);
}

String imagePathToJson(ImagePath data) => json.encode(data.toJson());

/// Image formed by the route (path) and the extension of the file.
class ImagePath {
  final String path;
  final String fileExtension;

  ImagePath({
    required this.path,
    required this.fileExtension,
  });

  factory ImagePath.fromJson(Map<String, dynamic> json) => ImagePath(
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
