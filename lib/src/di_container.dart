import 'package:arch_test/src/core/core.dart';
import 'package:kiwi/kiwi.dart';

KiwiContainer setupDIContainer() {
  final diContainer = KiwiContainer.scoped();
  diContainer.registerFactory((i) => TypeMirrorMapper());
  diContainer.registerFactory((i) => VariableMirrorMapper(i()));
  diContainer.registerFactory((i) => ParameterMirrorMapper(i()));
  diContainer.registerFactory((i) => MethodMirrorMapper(i(), i()));
  diContainer.registerFactory((i) => ClassMirrorMapper(i(), i(), i()));
  diContainer.registerFactory((i) => LibraryMirrorMapper(i(), i()));
  return diContainer;
}
