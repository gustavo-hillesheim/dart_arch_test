import 'package:analyzer/dart/element/element.dart';

import 'components/dart_element_finder.dart';
import 'models/models.dart';

class MultipleElementsFoundException implements Exception {
  final String message;
  final DartElementMatcher matcher;
  final DartElementsParent source;
  final List<DartElement> elementsFound;

  MultipleElementsFoundException(
      {required this.matcher,
      required this.source,
      required this.elementsFound})
      : message =
            'Found more than one element on source $source with matcher $matcher.'
                'Total elements found: ${elementsFound.length}';

  @override
  String toString() {
    return message;
  }
}

class UnknownConstructorTypeException implements Exception {
  final message = 'Unknown constructor type';
  final ConstructorElement constructorElement;

  UnknownConstructorTypeException({required this.constructorElement});

  @override
  String toString() {
    return message;
  }
}

class UnsupportedMirrorType implements Exception {
  final String message;

  UnsupportedMirrorType(Type mirrorType)
      : message = 'The type ${mirrorType.toString()} is not supported';

  @override
  String toString() {
    return message;
  }
}

class PackageNameNotFoundException implements Exception {
  final String message;

  PackageNameNotFoundException(this.message);

  @override
  String toString() {
    return message;
  }
}

class PackageNotFoundException implements Exception {
  final String message;

  PackageNotFoundException(this.message);

  @override
  String toString() {
    return message;
  }
}

class DartTypeNotFoundException implements Exception {
  final String name;
  final String? package;
  final String? library;
  final String message;

  DartTypeNotFoundException({
    required this.name,
    this.package,
    this.library,
  }) : message = _createMessage(name: name, package: package, library: library);

  static String _createMessage({
    required String name,
    String? package,
    String? library,
  }) {
    var message = 'Could not find type "$name"';
    if (package != null) {
      message += ' at package "$package"';
    }
    if (library != null) {
      message += ' in library "$library"';
    }
    return message;
  }

  @override
  String toString() {
    return message;
  }
}
