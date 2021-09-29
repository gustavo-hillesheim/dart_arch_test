import 'package:arch_test/core/core.dart';
import 'package:arch_test/core/models/dart_parameter.dart';
import 'package:arch_test/core/models/element_location.dart';
import 'package:arch_test/core/models/enums/parameter_kind.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../mock/mirror_system.dart';

void main() {
  late ParameterMirrorMapper mapper;

  setUp(() {
    mapper = ParameterMirrorMapper.instance;
  });

  test('should create DartParameter from ParameterMirror', () {
    final parameterMirror = FakeParameterMirror('aParameter', type: String);

    final dartParameter = mapper.toDartParameter(parameterMirror);

    expect(
      dartParameter,
      DartParameter(
        name: 'aParameter',
        type: stringDartType,
      ),
    );
  });

  test('should create final DartParameter from ParameterMirror', () {
    final parameterMirror = FakeParameterMirror(
      'aParameter',
      type: String,
      isFinal: true,
    );

    final dartParameter = mapper.toDartParameter(parameterMirror);

    expect(
      dartParameter,
      DartParameter(
        name: 'aParameter',
        type: stringDartType,
        isFinal: true,
      ),
    );
  });

  test('should create const DartParameter from ParameterMirror', () {
    final parameterMirror = FakeParameterMirror(
      'aParameter',
      type: String,
      isConst: true,
    );

    final dartParameter = mapper.toDartParameter(parameterMirror);

    expect(
      dartParameter,
      DartParameter(
        name: 'aParameter',
        type: stringDartType,
        isConst: true,
      ),
    );
  });

  test('should create DartParameter with default value from ParameterMirror',
      () {
    final parameterMirror = FakeParameterMirror(
      'aParameter',
      type: String,
      hasDefaultValue: true,
    );

    final dartParameter = mapper.toDartParameter(parameterMirror);

    expect(
      dartParameter,
      DartParameter(
        name: 'aParameter',
        type: stringDartType,
        hasDefaultValue: true,
      ),
    );
  });

  test('should create positional DartParameter from ParameterMirror', () {
    final parameterMirror = FakeParameterMirror(
      'aParameter',
      type: String,
      isOptional: true,
    );

    final dartParameter = mapper.toDartParameter(parameterMirror);

    expect(
      dartParameter,
      DartParameter(
        name: 'aParameter',
        type: stringDartType,
        kind: ParameterKind.POSITIONAL,
      ),
    );
  });

  test('should create named DartParameter from ParameterMirror', () {
    final parameterMirror = FakeParameterMirror(
      'aParameter',
      type: String,
      isOptional: true,
      isNamed: true,
    );

    final dartParameter = mapper.toDartParameter(parameterMirror);

    expect(
      dartParameter,
      DartParameter(
        name: 'aParameter',
        type: stringDartType,
        kind: ParameterKind.NAMED,
      ),
    );
  });
}
