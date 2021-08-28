import 'package:arch_test/src/di_container.dart';
import 'package:arch_test/src/exception.dart';
import 'package:test/test.dart';

void main() {
  late DIContainer diContainer;

  setUp(() {
    diContainer = DIContainer();
  });

  test('Should register class on diContainer', () {
    diContainer.register((_) => AnyClass());

    expect(true, diContainer.contains<AnyClass>());
  });

  test('Should get instance of class from diContainer', () {
    diContainer.register((_) => AnyClass());

    expect(diContainer.get<AnyClass>(), isA<AnyClass>());
  });

  test('Should be able to register class with another dependencies', () {
    diContainer.register((_) => AnyClass());
    diContainer.register((di) => AnotherClass(di()));

    expect(diContainer.get<AnotherClass>(), isA<AnotherClass>());
  });

  test('Should get same instance of singleton class form diContainer', () {
    diContainer.register((_) => AnyClass());

    expect(diContainer.get<AnyClass>(), diContainer.get<AnyClass>());
  });

  test('Should be able to register class as non-singleton', () {
    diContainer.register((_) => AnyClass(), singleton: false);

    expect(diContainer.get<AnyClass>(),
        isNot(equals(diContainer.get<AnyClass>())));
  });

  test(
      'Should throw exception when trying to get instance that is not registered',
      () {
    expect(() => diContainer.get<AnyClass>(),
        throwsA(isA<FactoryNotFoundException>()));
  });

  test('Should throw exception when nested dependency is not registered', () {
    diContainer.register((di) => AnotherClass(di()));

    expect(() => diContainer.get<AnotherClass>(),
        throwsA(isA<FactoryNotFoundException>()));
  });
}

class AnotherClass {
  final AnyClass anyClass;

  AnotherClass(this.anyClass);
}

class AnyClass {}
