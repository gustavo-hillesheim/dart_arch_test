library arch_test;

import 'dart:mirrors';

import 'package:arch_test/src/core/models/dart_variable.dart';

void main(List<String> arguments) {
  final library = currentMirrorSystem().findLibrary(#arch_test);
  final aClass = library.declarations[#A] as ClassMirror;
  for (final method in aClass.declarations.values.whereType<MethodMirror>()) {
    print(method.simpleName);
    method.parameters.forEach((p) {
      print('${p.simpleName} - ${p.isOptional} - ${p.isNamed}');
    });
  }
}

class A {
  final a = 1;
  final String c = '';

  A(String d, {bool f = true}) {}

  void b([dynamic e]) {}
}
