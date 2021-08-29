library arch_test;

import 'dart:mirrors';

import 'package:arch_test/src/core/factories/dart_type_factory.dart';

void main(List<String> arguments) {
  final library = currentMirrorSystem().findLibrary(#arch_test);
  print(DartTypeFactory().fromTypeMirror(
      (library.declarations[#main] as MethodMirror).returnType));
}
