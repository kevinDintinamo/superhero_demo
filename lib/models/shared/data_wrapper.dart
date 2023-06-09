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
      offset: json['offset'],
      limit: json['limit'],
      total: json['total'],
      count: json['count'],
      results: json['results'],
    );
  }
}
