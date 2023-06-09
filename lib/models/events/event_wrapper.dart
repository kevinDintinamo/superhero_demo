import '../shared/data_wrapper.dart';
import 'event.dart';

class EventWrapper extends DataWrapper {
  final List<Event> events;

  EventWrapper({
    required int offset,
    required int limit,
    required int total,
    required int count,
    required List results,
    required this.events,
  }) : super(
            offset: offset,
            limit: limit,
            total: total,
            count: count,
            results: results);
}
