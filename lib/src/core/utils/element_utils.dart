import 'package:analyzer/dart/element/element.dart' hide ElementLocation;
import 'package:analyzer/dart/element/type.dart' as analyzer;
import 'package:analyzer/source/line_info.dart';
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
    final isDynamic =
        element.location?.components.first == 'dynamic' ? true : false;
    return ElementLocation(
      uri: isDynamic
          ? element.location!.toString()
          : element.source!.uri.toString(),
    );
  }

  static DartElementRef<T>? parentRef<T extends DartElement>(Element? element) {
    final parent = element?.enclosingElement;
    if (parent is CompilationUnitElement) {
      return elementRef(parent.enclosingElement);
    } else {
      return elementRef(parent);
    }
  }

  static DartElementRef<T>? elementRef<T extends DartElement>(
      Element? element) {
    if (element == null) {
      return null;
    } else if (element is ClassElement) {
      return _createElementRef<DartClass>(element) as DartElementRef<T>;
    } else if (element is MethodElement) {
      return _createElementRef<DartMethod>(element) as DartElementRef<T>;
    } else if (element is FunctionElement) {
      return _createElementRef<DartMethod>(element) as DartElementRef<T>;
    } else if (element is LibraryElement) {
      return _createElementRef<DartLibrary>(element) as DartElementRef<T>;
    } else if (element is VariableElement) {
      return _createElementRef<DartVariable>(element) as DartElementRef<T>;
    } else if (element is ParameterElement) {
      return _createElementRef<DartParameter>(element) as DartElementRef<T>;
    } else if (element is analyzer.DartType) {
      return _createElementRef<DartType>(element) as DartElementRef<T>;
    } else {
      return _createElementRef<T>(element);
    }
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
