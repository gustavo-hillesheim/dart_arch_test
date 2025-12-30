import 'package:analyzer/dart/element/element.dart';
import 'package:arch_test/arch_test.dart';

final beAbstract = BeAbstractPredicate();

final beInterface = BeInterfacePredicate();

class BeAbstractPredicate extends ElementPredicate<ClassElement> {
  @override
  String describe() {
    return 'be abstract';
  }

  @override
  bool satisfies(ClassElement element) {
    return element.isAbstract;
  }
}

class BeInterfacePredicate extends ElementPredicate<ClassElement> {
  @override
  String describe() {
    return 'be interface';
  }

  @override
  bool satisfies(ClassElement element) {
    return element.isInterface;
  }
}
