import 'package:arch_test/src/core/factories/dart_method_factory.dart';
import 'package:arch_test/src/core/factories/dart_parameter_factory.dart';
import 'package:arch_test/src/core/factories/dart_type_factory.dart';
import 'package:arch_test/src/core/models/dart_method.dart';
import 'package:arch_test/src/core/models/dart_parameter.dart';
import 'package:arch_test/src/core/models/enums/constructor_kind.dart';
import 'package:arch_test/src/core/models/enums/method_kind.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../../mock/mirror_system.dart';

void main() {
  late DartMethodFactory factory;

  setUp(() {
    final typeFactory = DartTypeFactory();
    factory = DartMethodFactory(typeFactory, DartParameterFactory(typeFactory));
  });

  test('should create DartMethod from MethodMirror', () {
    final methodMirror = FakeMethodMirror('aMethod',
        parameters: [FakeParameterMirror('aParameter', type: String)]);

    final dartMethod = factory.fromMethodMirror(methodMirror);

    expect(
      dartMethod,
      DartMethod(
        name: 'aMethod',
        returnType: voidDartType,
        kind: MethodKind.REGULAR,
        parameters: [DartParameter(name: 'aParameter', type: stringDartType)],
      ),
    );
  });

  test('should create factory constructor DartMethod from MethodMirror', () {
    final methodMirror = FakeMethodMirror(
      'aConstructor',
      isConstructor: true,
      isFactoryConstructor: true,
      isRegularMethod: false,
      returnType: String,
    );

    final dartMethod = factory.fromMethodMirror(methodMirror);

    expect(
      dartMethod,
      DartMethod(
        name: 'aConstructor',
        returnType: stringDartType,
        kind: MethodKind.CONSTRUCTOR,
        constructorKind: ConstructorKind.FACTORY,
        parameters: [],
      ),
    );
  });

  test('should create getter DartMethod from MethodMirror', () {
    final methodMirror = FakeMethodMirror(
      'aGetter',
      isGetter: true,
      isRegularMethod: false,
      returnType: String,
    );

    final dartMethod = factory.fromMethodMirror(methodMirror);

    expect(
      dartMethod,
      DartMethod(
        name: 'aGetter',
        returnType: stringDartType,
        kind: MethodKind.GETTER,
        parameters: [],
      ),
    );
  });
}
