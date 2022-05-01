import 'package:arch_test/core.dart';
import 'package:arch_test/src/core/mappers/mappers.dart';
import 'package:test/scaffolding.dart';
import 'package:test/test.dart';

import '../../../mock/mirror_system.dart';

void main() {
  late DartClassMapper mapper;

  setUp(() {
    mapper = DartClassMapper.instance;
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

    final dartClass = mapper.toDartClass(classMirror);

    expect(
      dartClass,
      DartClass(
        name: 'FakeClass',
        location: ElementLocation(
          uri: 'package:pkg/fake_class.dart',
          column: 1,
          line: 1,
        ),
        superClass: DartClass(
          name: 'SuperClass',
          location: ElementLocation(
            uri: 'package:pkg/super_class.dart',
            column: 1,
            line: 1,
          ),
        ),
        superInterfaces: [
          DartClass(
            name: 'SuperInterface',
            location: ElementLocation(
              uri: 'package:pkg/super_interface.dart',
              column: 1,
              line: 1,
            ),
          ),
          DartClass(
            name: 'MegaInterface',
            location: ElementLocation(
              uri: 'package:pkg/mega_interface.dart',
              column: 1,
              line: 1,
            ),
          ),
        ],
        fields: [
          DartVariable(
            name: 'aField',
            location: ElementLocation.unknown(),
            type: stringDartType,
          ),
          DartVariable(
            name: '_bField',
            location: ElementLocation.unknown(),
            isFinal: true,
            type: doubleDartType,
          ),
        ],
        methods: [
          DartMethod(
            name: 'cMethod',
            location: ElementLocation.unknown(),
            returnType: stringDartType,
          ),
          DartConstructor(
            name: 'FakeClass',
            location: ElementLocation.unknown(),
            constructorKind: ConstructorKind.GENERATIVE,
            returnType: DartType(
              name: 'FakeClass',
              location: ElementLocation(
                uri: 'package:pkg/fake_class.dart',
                column: 1,
                line: 1,
              ),
            ),
          ),
        ],
      ),
    );
  });

  test('should create DartClass for enum ClassMirror', () {
    final enumMirror = FakeClassMirror('MyEnum',
        path: 'package:pkg/fake_enum.dart', isEnum: true);

    final dartClass = mapper.toDartClass(enumMirror);

    expect(
      dartClass,
      DartClass(
        name: 'MyEnum',
        location: ElementLocation(
          uri: 'package:pkg/fake_enum.dart',
          column: 1,
          line: 1,
        ),
        isEnum: true,
      ),
    );
  });

  test('should create DartClass for abstract class ClassMirror', () {
    final abstractClassMirror = FakeClassMirror('MyAbstractClass',
        path: 'package:pkg/fake_abstract_class.dart', isAbstract: true);

    final dartClass = mapper.toDartClass(abstractClassMirror);

    expect(
      dartClass,
      DartClass(
        name: 'MyAbstractClass',
        location: ElementLocation(
          uri: 'package:pkg/fake_abstract_class.dart',
          column: 1,
          line: 1,
        ),
        isAbstract: true,
      ),
    );
  });
}
