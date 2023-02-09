import '../models/filter.dart';
import '../../core/models/models.dart';

abstract class Filters {
  static Filter<T> id<T extends DartElement>() {
    return Filter((_) => true, description: 'exist');
  }

  static Filter<T> pathMatches<T extends DartElement>(String regExp) {
    return Filter(
      (el) => RegExp(regExp).hasMatch(el.library),
      description: 'have path matching "$regExp"',
    );
  }

  static Filter<T> nameStartsWith<T extends DartElement>(String str) {
    return Filter(
      (el) => el.name.startsWith(str),
      description: 'have name starting with "$str"',
    );
  }

  static Filter<T> nameEndsWith<T extends DartElement>(String str) {
    return Filter(
      (el) => el.name.endsWith(str),
      description: 'have name ending with "$str"',
    );
  }

  static Filter<T> insideFolder<T extends DartElement>(
    String folder, {
    bool includeNested = true,
  }) {
    final description;
    if (includeNested) {
      description = 'are inside folder "$folder"';
    } else {
      description = 'are directly inside folder "$folder"';
    }
    return Filter(
      (el) {
        // The last one will be the file name
        final folders = el.location.library.split('/')..removeLast();
        if (!includeNested) {
          return folders.last == folder;
        } else {
          return folders.contains(folder);
        }
      },
      description: description,
    );
  }
}
