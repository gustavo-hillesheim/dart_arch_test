import 'package:arch_test/src/core/models/enums/constructor_kind.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../../../mock/mirror_system.dart';

void main() {
  test('should return ConstructorKind.CONST', () {
    final mirror = FakeMethodMirror(
      '',
      isConstructor: true,
      isConstConstructor: true,
      isRegularMethod: false,
    );
    expect(constructorTypeFromMirror(mirror), ConstructorKind.CONST);
  });
  test('should return ConstructorKind.FACTORY', () {
    final mirror = FakeMethodMirror(
      '',
      isConstructor: true,
      isFactoryConstructor: true,
      isRegularMethod: false,
    );
    expect(constructorTypeFromMirror(mirror), ConstructorKind.FACTORY);
  });
  test('should return ConstructorKind.GENERATIVE', () {
    final mirror = FakeMethodMirror(
      '',
      isConstructor: true,
      isGenerativeConstructor: true,
      isRegularMethod: false,
    );
    expect(constructorTypeFromMirror(mirror), ConstructorKind.GENERATIVE);
  });
  test('should return ConstructorKind.REDIRECTING', () {
    final mirror = FakeMethodMirror(
      '',
      isConstructor: true,
      isRedirectingConstructor: true,
      isRegularMethod: false,
    );
    expect(constructorTypeFromMirror(mirror), ConstructorKind.REDIRECTING);
  });
  test('should throw error on unknown ConstructorKind', () {
    final mirror = FakeMethodMirror(
      '',
      isRegularMethod: false,
      isConstructor: true,
    );
    expect(() => constructorTypeFromMirror(mirror), throwsA(isA<Exception>()));
  });
  test('should throw error on non-constructor MethodMirror', () {
    final mirror = FakeMethodMirror('');
    expect(() => constructorTypeFromMirror(mirror), throwsA(isA<Exception>()));
  });
}