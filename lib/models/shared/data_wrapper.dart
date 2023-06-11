/// DataWrapper model class.
class DataWrapper {
  final int offset;
  final int limit;
  final int total;
  final int count;
  final List results;

  DataWrapper({
    required this.offset,
    required this.limit,
    required this.total,
    required this.count,
    required this.results,
  });

  factory DataWrapper.fromJson(Map<String, dynamic> json) {
    return DataWrapper(
      offset: json['offset'] ?? 0,
      limit: json['limit'] ?? 0,
      total: json['total'] ?? 0,
      count: json['count'] ?? 0,
      results: json['results'] ?? [],
    );
  }
}
