import 'package:arch_test/src/core/factories/dart_type_factory.dart';
import 'package:arch_test/src/core/models/dart_type.dart';
import 'package:arch_test/src/di_container.dart';
import 'package:test/scaffolding.dart';
import 'package:test/test.dart';

import '../../../mock/mirror_system.dart';

void main() {
  late DartTypeFactory factory;

  setUp(() {
    factory = setupDIContainer().resolve<DartTypeFactory>();
  });

  test('should create DartType from TypeMirror', () {
    final typeMirror = FakeTypeMirror('MyType', 'package:pkg/src/my_type.dart');

    final dartType = factory.fromTypeMirror(typeMirror);

    expect(
        dartType,
        DartType(
          name: 'MyType',
          package: 'pkg',
          library: 'src/my_type.dart',
        ));
  });
}
