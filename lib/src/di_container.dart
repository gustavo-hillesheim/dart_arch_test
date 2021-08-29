import 'package:arch_test/src/core/factories/dart_class_factory.dart';
import 'package:arch_test/src/core/factories/dart_library_factory.dart';
import 'package:arch_test/src/core/factories/dart_method_factory.dart';
import 'package:arch_test/src/core/factories/dart_parameter_factory.dart';
import 'package:arch_test/src/core/factories/dart_type_factory.dart';
import 'package:arch_test/src/core/factories/dart_variable_factory.dart';
import 'package:kiwi/kiwi.dart';

KiwiContainer setupDIContainer() {
  final diContainer = KiwiContainer.scoped();
  diContainer.registerFactory((i) => DartTypeFactory());
  diContainer.registerFactory((i) => DartVariableFactory(i()));
  diContainer.registerFactory((i) => DartParameterFactory(i()));
  diContainer.registerFactory((i) => DartMethodFactory(i(), i()));
  diContainer.registerFactory((i) => DartClassFactory(i(), i()));
  diContainer.registerFactory((i) => DartLibraryFactory(i(), i()));
  return diContainer;
}
