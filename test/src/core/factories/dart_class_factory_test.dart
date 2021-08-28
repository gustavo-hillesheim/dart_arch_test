import 'package:arch_test/src/core/factories/dart_class_factory.dart';
import 'package:arch_test/src/core/factories/dart_method_factory.dart';
import 'package:arch_test/src/core/factories/dart_parameter_factory.dart';
import 'package:arch_test/src/core/factories/dart_type_factory.dart';
import 'package:arch_test/src/core/factories/dart_variable_factory.dart';
import 'package:arch_test/src/core/models/dart_class.dart';
import 'package:arch_test/src/core/models/dart_method.dart';
import 'package:arch_test/src/core/models/dart_type.dart';
import 'package:arch_test/src/core/models/dart_variable.dart';
import 'package:arch_test/src/core/models/enums/constructor_kind.dart';
import 'package:arch_test/src/core/models/enums/method_kind.dart';
import 'package:test/scaffolding.dart';
import 'package:test/test.dart';

import '../../../mock/mirror_system.dart';

void main() {
  late DartClassFactory factory;

  setUp(() {
    final typeFactory = DartTypeFactory();
    factory = DartClassFactory(DartVariableFactory(typeFactory),
        DartMethodFactory(typeFactory, DartParameterFactory(typeFactory)));
  });

  test('should create DartClass from ClassMirror', () {
    final classMirror = FakeClassMirror('FakeClass', declarations: {
      #aField: FakeVariableMirror(
        'aField',
        type: String,
      ),
      #_bField: FakeVariableMirror(
        '_bField',
        isFinal: true,
        isPrivate: true,
        type: double,
      ),
      #cMethod: FakeMethodMirror(
        'cMethod',
        returnType: String,
      ),
      #FakeClass: FakeMethodMirror(
        'FakeClass',
        isRegularMethod: false,
        isConstructor: true,
        isGenerativeConstructor: true,
        returnTypeMirror:
            FakeTypeMirror('FakeClass', 'package:pkg/fake_class.dart'),
      ),
    });

    final dartClass = factory.fromClassMirror(classMirror);

    expect(
      dartClass,
      DartClass(
        name: 'FakeClass',
        fields: [
          DartVariable(
            name: 'aField',
            type: stringDartType,
          ),
          DartVariable(
            name: '_bField',
            isFinal: true,
            isPrivate: true,
            type: doubleDartType,
          ),
        ],
        methods: [
          DartMethod(
            name: 'cMethod',
            returnType: stringDartType,
            parameters: [],
          ),
          DartMethod(
            name: 'FakeClass',
            kind: MethodKind.CONSTRUCTOR,
            constructorType: ConstructorKind.GENERATIVE,
            returnType: DartType(
              name: 'FakeClass',
              library: 'package:pkg/fake_class.dart',
              package: 'pkg',
            ),
            parameters: [],
          ),
        ],
      ),
    );
  });

  test('should create DartClass for enum ClassMirror', () {
    final enumMirror = FakeClassMirror('MyEnum', isEnum: true);

    final dartClass = factory.fromClassMirror(enumMirror);

    expect(
      dartClass,
      DartClass(
        name: 'MyEnum',
        isEnum: true,
        fields: [],
        methods: [],
      ),
    );
  });

  test('should create DartClass for abstract class ClassMirror', () {
    final abstractClassMirror =
        FakeClassMirror('MyAbstractClass', isAbstract: true);

    final dartClass = factory.fromClassMirror(abstractClassMirror);

    expect(
      dartClass,
      DartClass(
        name: 'MyAbstractClass',
        isAbstract: true,
        fields: [],
        methods: [],
      ),
    );
  });
}