import 'package:arch_test/core/models/enums/parameter_kind.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../../mock/mirror_system.dart';

void main() {
  test('should return ParameterKind.REGULAR', () {
    final mirror = FakeParameterMirror('param', type: String);
    expect(parameterKindFromMirror(mirror), ParameterKind.REGULAR);
  });
  test('should return ParameterKind.POSITIONAL', () {
    final mirror = FakeParameterMirror('param', type: String, isOptional: true);
    expect(parameterKindFromMirror(mirror), ParameterKind.POSITIONAL);
  });
  test('should return ParameterKind.NAMED', () {
    final mirror = FakeParameterMirror('param',
        type: String, isOptional: true, isNamed: true);
    expect(parameterKindFromMirror(mirror), ParameterKind.NAMED);
  });
}
