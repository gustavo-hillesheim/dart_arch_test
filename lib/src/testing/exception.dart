import 'dart:mirrors';

import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/core/components/dart_element_finder.dart';

class ViolationsException implements Exception {
  final String message;
  final List<String> violations;
  final DartPackage package;

  ViolationsException({required this.violations, required this.package})
      : message =
            'Found the following violations on package "${package.name}": '
                '\r\n${violations.map((v) => '- $v').join(';\r\n')}';
}

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
