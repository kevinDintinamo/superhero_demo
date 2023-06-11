import '../shared/data_wrapper.dart';
import 'serie.dart';

class SerieWrapper extends DataWrapper {
  final List<Serie> series;

  SerieWrapper({
    required int offset,
    required int limit,
    required int total,
    required int count,
    required List results,
    required this.series,
  }) : super(
            offset: offset,
            limit: limit,
            total: total,
            count: count,
            results: results);
}
