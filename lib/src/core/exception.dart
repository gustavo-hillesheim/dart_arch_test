import 'dart:mirrors';

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
}

class MethodIsNotConstructorException implements Exception {
  final message = 'MethodMirror does not belong to a constructor';
  final MethodMirror methodMirror;

  MethodIsNotConstructorException({required this.methodMirror});
}

class UnknownConstructorTypeException implements Exception {
  final message = 'Unknown constructor type';
  final MethodMirror methodMirror;

  UnknownConstructorTypeException({required this.methodMirror});
}

class UnknownMethodTypeException implements Exception {
  final message = 'Unknown method type';
  final MethodMirror methodMirror;

  UnknownMethodTypeException({required this.methodMirror});
}

class UnsupportedMirrorType implements Exception {
  final String message;

  UnsupportedMirrorType(Type mirrorType)
      : message = 'The type ${mirrorType.toString()} is not supported';
}

class PackageNameNotFoundException implements Exception {
  final String message;

  PackageNameNotFoundException(this.message);
}

class PackageNotFoundException implements Exception {
  final String message;

  PackageNotFoundException(this.message);
}
