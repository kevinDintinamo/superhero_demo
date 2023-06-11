import '../shared/data_wrapper.dart';

import 'story.dart';

class StoryWrapper extends DataWrapper {
  final List<Story> stories;

  StoryWrapper({
    required int offset,
    required int limit,
    required int total,
    required int count,
    required List results,
    required this.stories,
  }) : super(
            offset: offset,
            limit: limit,
            total: total,
            count: count,
            results: results);
}
