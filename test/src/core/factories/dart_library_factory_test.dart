import 'package:arch_test/src/core/factories/dart_class_factory.dart';
import 'package:arch_test/src/core/factories/dart_library_factory.dart';
import 'package:arch_test/src/core/factories/dart_method_factory.dart';
import 'package:arch_test/src/core/factories/dart_parameter_factory.dart';
import 'package:arch_test/src/core/factories/dart_type_factory.dart';
import 'package:arch_test/src/core/factories/dart_variable_factory.dart';
import 'package:arch_test/src/core/models/dart_class.dart';
import 'package:arch_test/src/core/models/dart_library.dart';
import 'package:arch_test/src/core/models/dart_method.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../../mock/mirror_system.dart';

void main() {
  late DartLibraryFactory factory;

  setUp(() {
    final typeFactory = DartTypeFactory();
    final methodFactory = DartMethodFactory(
      typeFactory,
      DartParameterFactory(typeFactory),
    );
    factory = DartLibraryFactory(
      DartClassFactory(
        DartVariableFactory(typeFactory),
        methodFactory,
      ),
      methodFactory,
    );
  });

  test('should create DartLibrary from LibraryMirror', () {
    final libraryMirror =
        FakeLibraryMirror('package:pkg/library.dart', declarations: {
      #FakeClass: FakeClassMirror('FakeClass'),
      #utilFunction: FakeMethodMirror('utilFunction', returnType: String),
    });

    final dartLibrary = factory.fromLibraryMirror(libraryMirror);

    expect(
      dartLibrary,
      DartLibrary(
        name: 'library.dart',
        package: 'pkg',
        classes: [
          DartClass(
            name: 'FakeClass',
            fields: [],
            methods: [],
          ),
        ],
        methods: [
          DartMethod(
            name: 'utilFunction',
            returnType: stringDartType,
            parameters: [],
          ),
        ],
      ),
    );
  });
}