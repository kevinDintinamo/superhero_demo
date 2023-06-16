import '../shared/data_wrapper.dart';
import 'comic.dart';

class ComicWrapper extends DataWrapper {
  final List<Comic> comics;

  ComicWrapper({
    required int offset,
    required int limit,
    required int total,
    required int count,
    required List results,
    required this.comics,
  }) : super(
            offset: offset,
            limit: limit,
            total: total,
            count: count,
            results: results);

  factory ComicWrapper.empty() {
    return ComicWrapper(
      offset: 0,
      limit: 0,
      total: 0,
      count: 0,
      results: [],
      comics: <Comic>[],
    );
  }
}
