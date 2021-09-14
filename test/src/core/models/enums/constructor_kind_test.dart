import 'package:arch_test/src/core/models/enums/constructor_kind.dart';
import 'package:arch_test/src/exception.dart';
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
    expect(constructorKindFromMirror(mirror), ConstructorKind.CONST);
  });
  test('should return ConstructorKind.FACTORY', () {
    final mirror = FakeMethodMirror(
      '',
      isConstructor: true,
      isFactoryConstructor: true,
      isRegularMethod: false,
    );
    expect(constructorKindFromMirror(mirror), ConstructorKind.FACTORY);
  });
  test('should return ConstructorKind.GENERATIVE', () {
    final mirror = FakeMethodMirror(
      '',
      isConstructor: true,
      isGenerativeConstructor: true,
      isRegularMethod: false,
    );
    expect(constructorKindFromMirror(mirror), ConstructorKind.GENERATIVE);
  });
  test('should return ConstructorKind.REDIRECTING', () {
    final mirror = FakeMethodMirror(
      '',
      isConstructor: true,
      isRedirectingConstructor: true,
      isRegularMethod: false,
    );
    expect(constructorKindFromMirror(mirror), ConstructorKind.REDIRECTING);
  });
  test('should throw error on unknown ConstructorKind', () {
    final mirror = FakeMethodMirror(
      '',
      isRegularMethod: false,
      isConstructor: true,
    );
    expect(() => constructorKindFromMirror(mirror),
        throwsA(isA<UnknownConstructorTypeException>()));
  });
  test('should throw error on non-constructor MethodMirror', () {
    final mirror = FakeMethodMirror('');
    expect(() => constructorKindFromMirror(mirror),
        throwsA(isA<MethodIsNotConstructorException>()));
  });
}
