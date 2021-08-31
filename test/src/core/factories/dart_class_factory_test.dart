import 'package:arch_test/src/core/factories/dart_class_factory.dart';
import 'package:arch_test/src/core/models/dart_class.dart';
import 'package:arch_test/src/core/models/dart_method.dart';
import 'package:arch_test/src/core/models/dart_type.dart';
import 'package:arch_test/src/core/models/dart_variable.dart';
import 'package:arch_test/src/core/models/enums/constructor_kind.dart';
import 'package:arch_test/src/core/models/enums/method_kind.dart';
import 'package:arch_test/src/di_container.dart';
import 'package:test/scaffolding.dart';
import 'package:test/test.dart';

import '../../../mock/mirror_system.dart';

void main() {
  late DartClassFactory factory;

  setUp(() {
    factory = setupDIContainer().resolve<DartClassFactory>();
  });

  test('should create DartClass from ClassMirror', () {
    final classMirror = FakeClassMirror('FakeClass',
        path: 'package:pkg/fake_class.dart',
        superclass:
            FakeClassMirror('SuperClass', path: 'package:pkg/super_class.dart'),
        superinterfaces: [
          FakeClassMirror('SuperInterface',
              path: 'package:pkg/super_interface.dart'),
          FakeClassMirror('MegaInterface',
              path: 'package:pkg/mega_interface.dart'),
        ],
        declarations: {
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
          #FakeClass: FakeMethodMirror.constructor(
            'FakeClass',
            ConstructorKind.GENERATIVE,
            returnTypeMirror:
                FakeTypeMirror('FakeClass', 'package:pkg/fake_class.dart'),
          ),
        });

    final dartClass = factory.fromClassMirror(classMirror);

    expect(
      dartClass,
      DartClass(
        name: 'FakeClass',
        package: 'pkg',
        library: 'fake_class.dart',
        superClass: DartClass(
          name: 'SuperClass',
          package: 'pkg',
          library: 'super_class.dart',
        ),
        superInterfaces: [
          DartClass(
            name: 'SuperInterface',
            package: 'pkg',
            library: 'super_interface.dart',
          ),
          DartClass(
            name: 'MegaInterface',
            package: 'pkg',
            library: 'mega_interface.dart',
          ),
        ],
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
          ),
          DartMethod(
            name: 'FakeClass',
            kind: MethodKind.CONSTRUCTOR,
            constructorKind: ConstructorKind.GENERATIVE,
            returnType: DartType(
              name: 'FakeClass',
              library: 'fake_class.dart',
              package: 'pkg',
            ),
          ),
        ],
      ),
    );
  });

  test('should create DartClass for enum ClassMirror', () {
    final enumMirror = FakeClassMirror('MyEnum',
        path: 'package:pkg/fake_enum.dart', isEnum: true);

    final dartClass = factory.fromClassMirror(enumMirror);

    expect(
      dartClass,
      DartClass(
        name: 'MyEnum',
        package: 'pkg',
        library: 'fake_enum.dart',
        isEnum: true,
      ),
    );
  });

  test('should create DartClass for abstract class ClassMirror', () {
    final abstractClassMirror = FakeClassMirror('MyAbstractClass',
        path: 'package:pkg/fake_abstract_class.dart', isAbstract: true);

    final dartClass = factory.fromClassMirror(abstractClassMirror);

    expect(
      dartClass,
      DartClass(
        name: 'MyAbstractClass',
        package: 'pkg',
        library: 'fake_abstract_class.dart',
        isAbstract: true,
      ),
    );
  });
}
