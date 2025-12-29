import 'package:analyzer/dart/element/element.dart';
import 'package:arch_test/arch_test.dart';

HaveNameEndingWithPredicate<E> haveNameEndingWith<E extends Element>(
  String suffix,
) {
  return HaveNameEndingWithPredicate<E>(suffix);
}

ResideInPredicate<E> resideIn<E extends Element>(String directory) {
  return ResideInPredicate<E>(directory);
}

final beAbstract = BeAbstractPredicate();

final beInterface = BeInterfacePredicate();

class HaveNameEndingWithPredicate<E extends Element>
    extends ElementPredicate<E> {
  final String suffix;

  HaveNameEndingWithPredicate(this.suffix);

  @override
  String describe() {
    return 'have name ending with "$suffix"';
  }

  @override
  bool satisfies(Element element) {
    final name = element.name;
    return name != null && name.endsWith(suffix);
  }
}

class ResideInPredicate<E extends Element> extends ElementPredicate<E> {
  final String directory;

  ResideInPredicate(this.directory);

  @override
  String describe() {
    return 'reside in "$directory"';
  }

  @override
  bool satisfies(E element) {
    final fileUri = element.firstFragment.libraryFragment?.source.uri;
    return fileUri?.path.contains(directory) ?? false;
  }
}

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
