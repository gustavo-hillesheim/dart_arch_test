import 'dart:mirrors';

import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/core/components/dart_element_finder.dart';

/// Used for creating a reference for an element without creating an instance of
/// it. Later the actual element can be queried using [DartElementFinder].
///
/// The [elementType] should be of a class that extends from DartElement, otherwise
/// any queries using this ref will fail, since they are performed with DartElements.
class DartElementRef {
  final Type elementType;
  final String name;
  final ElementLocation location;

  DartElementRef({
    required this.elementType,
    required this.name,
    required this.location,
  });

  bool matches(DartElement el) {
    final isElementType =
        reflect(el).type.isSubclassOf(reflectClass(elementType));
    return isElementType && name == el.name && location == el.location;
  }
}
