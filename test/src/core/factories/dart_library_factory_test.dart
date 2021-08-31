import 'package:arch_test/src/core/factories/dart_library_factory.dart';
import 'package:arch_test/src/core/models/dart_class.dart';
import 'package:arch_test/src/core/models/dart_library.dart';
import 'package:arch_test/src/core/models/dart_library_dependency.dart';
import 'package:arch_test/src/core/models/dart_method.dart';
import 'package:arch_test/src/core/models/enums/library_dependency_kind.dart';
import 'package:arch_test/src/di_container.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../../mock/mirror_system.dart';

void main() {
  late DartLibraryFactory factory;

  setUp(() {
    factory = setupDIContainer().resolve<DartLibraryFactory>();
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

    final dartLibrary = factory.fromLibraryMirror(libraryMirror);

    expect(
      dartLibrary,
      DartLibrary(
        name: 'library.dart',
        package: 'pkg',
        classes: [
          DartClass(name: 'FakeClass', package: 'pkg', library: 'library.dart'),
        ],
        methods: [
          DartMethod(
            name: 'utilFunction',
            returnType: stringDartType,
          ),
        ],
        dependencies: [
          DartLibraryDependency(
            kind: LibraryDependencyKind.IMPORT,
            package: 'pkg',
            library: 'helpers\\utils.dart',
          ),
          DartLibraryDependency(
            kind: LibraryDependencyKind.EXPORT,
            package: 'pkg',
            library: 'helpers\\components.dart',
          ),
          DartLibraryDependency(
            kind: LibraryDependencyKind.IMPORT,
            package: 'pkg',
            library: 'helpers\\services.dart',
          ),
        ],
      ),
    );
  });
}
