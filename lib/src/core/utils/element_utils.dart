import 'package:analyzer/dart/element/element.dart' hide ElementLocation;
import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/core/utils/uri_utils.dart';

class ElementUtils {
  static List<DartMetadata> readMetadata(Element? element) {
    if (element == null) {
      return [];
    }
    return element.metadata
        .where((m) {
          final name = m.computeConstantValue()?.type?.element?.name;
          // Default metadata added by Dart
          final forbiddenMetadata = ['_Patch', 'pragma'];
          return !forbiddenMetadata.contains(name);
        })
        .map((m) => DartMetadata(metadata: m.computeConstantValue()))
        .toList();
  }

  static ElementLocation elementLocation(Element? element) {
    if (element == null) {
      return ElementLocation.unknown();
    }
    final lineInfo =
        element is CompilationUnitElement ? element.lineInfo : null;
    final startLocation = lineInfo?.getLocation(0);
    return ElementLocation(
      uri: element.location!.encoding,
      line: startLocation?.lineNumber ?? 1,
      column: startLocation?.columnNumber ?? 1,
    );
  }

  static DartElementRef<T>? elementRef<T extends DartElement>(
      Element? element) {
    if (element == null) {
      return null;
    }
    return _createElementRef<T>(element);
  }

  static DartElementRef<T> _createElementRef<T extends DartElement>(
      Element element) {
    late String name;
    if (element is LibraryElement) {
      name = UriUtils.getLibraryPath(element.librarySource.uri.toString());
    } else {
      name = element.name ?? element.displayName;
    }
    return DartElementRef<T>(
      name: name,
      location: elementLocation(element),
    );
  }
}
