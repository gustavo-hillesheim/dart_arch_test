import 'package:arch_test/core/core.dart';
import 'package:arch_test/core/models/dart_method.dart';
import 'package:arch_test/core/models/dart_parameter.dart';
import 'package:arch_test/core/models/element_location.dart';
import 'package:arch_test/core/models/enums/constructor_kind.dart';
import 'package:arch_test/core/models/enums/method_kind.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../mock/mirror_system.dart';

void main() {
  late MethodMirrorMapper mapper;

  setUp(() {
    mapper = MethodMirrorMapper.instance;
  });

  test('should create DartMethod from MethodMirror', () {
    final methodMirror = FakeMethodMirror(
      'aMethod',
      parameters: [FakeParameterMirror('aParameter', type: String)],
    );

    final dartMethod = mapper.toDartMethod(methodMirror);

    expect(
      dartMethod,
      DartMethod(
        name: 'aMethod',
        returnType: voidDartType,
        kind: MethodKind.REGULAR,
        parameters: [
          DartParameter(
            name: 'aParameter',
            type: stringDartType,
            location: ElementLocation.unknown(),
          ),
        ],
        location: ElementLocation.unknown(),
      ),
    );
  });

  test('should create factory constructor DartMethod from MethodMirror', () {
    final methodMirror = FakeMethodMirror.constructor(
      'aConstructor',
      ConstructorKind.FACTORY,
      returnType: String,
    );

    final dartMethod = mapper.toDartMethod(methodMirror);

    expect(
      dartMethod,
      DartConstructor(
        name: 'aConstructor',
        returnType: stringDartType,
        constructorKind: ConstructorKind.FACTORY,
        location: ElementLocation.unknown(),
      ),
    );
  });

  test('should create getter DartMethod from MethodMirror', () {
    final methodMirror = FakeMethodMirror.getter(
      'aGetter',
      returnType: String,
    );

    final dartMethod = mapper.toDartMethod(methodMirror);

    expect(
      dartMethod,
      DartMethod(
        name: 'aGetter',
        returnType: stringDartType,
        kind: MethodKind.GETTER,
        location: ElementLocation.unknown(),
      ),
    );
  });
}
