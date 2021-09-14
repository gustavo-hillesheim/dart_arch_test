import 'package:arch_test/src/core/models/enums/method_kind.dart';
import 'package:arch_test/src/exception.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../../../mock/mirror_system.dart';

void main() {
  test('should return MethodKind.REGULAR_METHOD', () {
    final mirror = FakeMethodMirror('');
    expect(methodKindFromMirror(mirror), MethodKind.REGULAR);
  });
  test('should return MethodKind.CONSTRUCTOR', () {
    final mirror =
        FakeMethodMirror('', isConstructor: true, isRegularMethod: false);
    expect(methodKindFromMirror(mirror), MethodKind.CONSTRUCTOR);
  });
  test('should return MethodKind.GETTER', () {
    final mirror = FakeMethodMirror('', isGetter: true, isRegularMethod: false);
    expect(methodKindFromMirror(mirror), MethodKind.GETTER);
  });
  test('should return MethodKind.SETTER', () {
    final mirror = FakeMethodMirror('', isSetter: true, isRegularMethod: false);
    expect(methodKindFromMirror(mirror), MethodKind.SETTER);
  });
  test('should return MethodKind.OPERATOR', () {
    final mirror =
        FakeMethodMirror('', isOperator: true, isRegularMethod: false);
    expect(methodKindFromMirror(mirror), MethodKind.OPERATOR);
  });
  test('should throw error on unknown MethodKind', () {
    final mirror = FakeMethodMirror('', isRegularMethod: false);
    expect(() => methodKindFromMirror(mirror),
        throwsA(isA<UnknownMethodTypeException>()));
  });
}
