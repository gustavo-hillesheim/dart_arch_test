import 'dart:mirrors';

import 'package:arch_test/core/core.dart';
import 'package:arch_test/core/models/dart_class.dart';
import 'package:arch_test/core/models/dart_library.dart';
import 'package:arch_test/core/models/dart_library_dependency.dart';
import 'package:arch_test/core/models/dart_method.dart';
import 'package:arch_test/core/models/element_location.dart';
import 'package:arch_test/core/models/enums/library_dependency_kind.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../mock/mirror_system.dart';

void main() {
  late LibraryMirrorMapper mapper;

  setUp(() {
    mapper = LibraryMirrorMapper.instance;
  });

  test('should create DartLibrary from LibraryMirror', () {
    final dartLibrary = mapper.toDartLibrary(createLibraryMirror());

    final libraryRef = DartElementRef<DartLibrary>(
      name: 'library.dart',
      location: ElementLocation.unknown(),
    );
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
          ),
        ],
        methods: [
          DartMethod(
            name: 'utilFunction',
            location: ElementLocation.unknown(),
            returnType: stringDartType,
          ),
        ],
        dependencies: [
          DartLibraryDependency(
            kind: LibraryDependencyKind.IMPORT,
            location: ElementLocation.unknown(),
            parentRef: libraryRef,
            path: 'package:pkg/helpers/utils.dart',
          ),
          DartLibraryDependency(
            kind: LibraryDependencyKind.EXPORT,
            location: ElementLocation.unknown(),
            parentRef: libraryRef,
            path: 'package:pkg/helpers/components.dart',
          ),
          DartLibraryDependency(
            kind: LibraryDependencyKind.IMPORT,
            location: ElementLocation.unknown(),
            parentRef: libraryRef,
            path: 'package:pkg/helpers/services.dart',
          ),
        ],
      ),
    );
  });
}

LibraryMirror createLibraryMirror() {
  final dependencies = <LibraryDependencyMirror>[];
  final libraryMirror = FakeLibraryMirror(
    'package:pkg/library.dart',
    declarations: {
      #FakeClass:
          FakeClassMirror('FakeClass', path: 'package:pkg/library.dart'),
      #utilFunction: FakeMethodMirror('utilFunction', returnType: String),
    },
    libraryDependencies: dependencies,
  );
  dependencies.add(FakeLibraryDependencyMirror(
    uri: 'package:pkg/helpers/utils.dart',
    sourceLibrary: libraryMirror,
  ));
  dependencies.add(FakeLibraryDependencyMirror(
    sourceLibrary: libraryMirror,
  ));
  dependencies.add(FakeLibraryDependencyMirror(
    uri: 'helpers/components.dart',
    isExport: true,
    isImport: false,
    sourceLibrary: libraryMirror,
  ));
  dependencies.add(FakeLibraryDependencyMirror(
    uri: './helpers/services.dart',
    sourceLibrary: libraryMirror,
  ));
  dependencies.add(FakeLibraryDependencyMirror(
    uri: 'file://path/to/some/lib/main.dart',
    sourceLibrary: libraryMirror,
  ));
  return libraryMirror;
}
