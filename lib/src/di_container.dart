import 'package:arch_test/src/core/factories/dart_class_factory.dart';
import 'package:arch_test/src/core/factories/dart_library_factory.dart';
import 'package:arch_test/src/core/factories/dart_method_factory.dart';
import 'package:arch_test/src/core/factories/dart_parameter_factory.dart';
import 'package:arch_test/src/core/factories/dart_type_factory.dart';
import 'package:arch_test/src/core/factories/dart_variable_factory.dart';
import 'package:arch_test/src/exception.dart';

typedef DependencyFactory<T> = T Function(S Function<S>() diContainer);

class DIContainer {
  final Map<Type, _Bind> _binds = {};
  final Map<Type, dynamic> _instances = {};

  void register<T>(DependencyFactory<T> factory, {bool singleton = true}) {
    _binds[T] = _Bind<T>(factory: factory, isSingleton: singleton);
  }

  T get<T>() {
    if (!contains<T>()) {
      throw FactoryNotFoundException(T.toString());
    }
    final bind = _binds[T]!;
    if (!bind.isSingleton) {
      return bind.factory(get);
    }
    _instances.putIfAbsent(T, () => bind.factory(get));
    return _instances[T];
  }

  bool contains<T>() {
    return _binds.containsKey(T);
  }
}

class _Bind<T> {
  final DependencyFactory<T> factory;
  final bool isSingleton;

  _Bind({required this.factory, required this.isSingleton});
}

DIContainer setupDIContainer() {
  final diContainer = DIContainer();
  diContainer.register((i) => DartTypeFactory());
  diContainer.register((i) => DartVariableFactory(i()));
  diContainer.register((i) => DartParameterFactory(i()));
  diContainer.register((i) => DartMethodFactory(i(), i()));
  diContainer.register((i) => DartClassFactory(i(), i()));
  diContainer.register((i) => DartLibraryFactory(i(), i()));
  return diContainer;
}
