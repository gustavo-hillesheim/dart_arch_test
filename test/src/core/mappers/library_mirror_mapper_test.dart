import 'package:arch_test/src/core/core.dart';
import 'package:arch_test/src/core/models/dart_class.dart';
import 'package:arch_test/src/core/models/dart_library.dart';
import 'package:arch_test/src/core/models/dart_library_dependency.dart';
import 'package:arch_test/src/core/models/dart_method.dart';
import 'package:arch_test/src/core/models/element_location.dart';
import 'package:arch_test/src/core/models/enums/library_dependency_kind.dart';
import 'package:arch_test/src/di_container.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../../mock/mirror_system.dart';

void main() {
  late LibraryMirrorMapper mapper;

  setUp(() {
    mapper = setupDIContainer().resolve<LibraryMirrorMapper>();
  });

  test('should create DartLibrary from LibraryMirror', () {
    final libraryMirror =
        FakeLibraryMirror('package:pkg/library.dart', declarations: {
      #FakeClass:
          FakeClassMirror('FakeClass', path: 'package:pkg/library.dart'),
      #utilFunction: FakeMethodMirror('utilFunction', returnType: String),
    }, libraryDependencies: [
      FakeLibraryDependencyMirror(uri: 'package:pkg/helpers/utils.dart'),
      FakeLibraryDependencyMirror(),
      FakeLibraryDependencyMirror(
          uri: 'helpers/components.dart', isExport: true, isImport: false),
      FakeLibraryDependencyMirror(uri: './helpers/services.dart'),
      FakeLibraryDependencyMirror(uri: 'file://path/to/some/lib/main.dart'),
    ]);

    final dartLibrary = mapper.toDartLibrary(libraryMirror);

    expect(
      dartLibrary,
      DartLibrary(
        name: 'library.dart',
        location: ElementLocation.unknown(),
        classes: [
          DartClass(
            name: 'FakeClass',
            location: ElementLocation(
              uri: 'package:pkg/library.dart',
              column: 1,
              line: 1,
            ),
            fields: [],
            generics: [],
            superInterfaces: [],
            methods: [],
          ),
        ],
        methods: [
          DartMethod(
            name: 'utilFunction',
            location: ElementLocation.unknown(),
            returnType: stringDartType,
            parameters: [],
          ),
        ],
        dependencies: [
          DartLibraryDependency(
            kind: LibraryDependencyKind.IMPORT,
            location: ElementLocation.unknown(),
            targetLibrary: 'helpers\\utils.dart',
          ),
          DartLibraryDependency(
            kind: LibraryDependencyKind.EXPORT,
            location: ElementLocation.unknown(),
            targetLibrary: 'helpers\\components.dart',
          ),
          DartLibraryDependency(
            kind: LibraryDependencyKind.IMPORT,
            location: ElementLocation.unknown(),
            targetLibrary: 'helpers\\services.dart',
          ),
        ],
      ),
    );
  });
}
