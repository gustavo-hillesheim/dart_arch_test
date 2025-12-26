import 'package:analyzer/dart/element/element.dart';
import 'package:arch_test/arch_test.dart';

HaveNameEndingWithPredicate<E> haveNameEndingWith<E extends Element>(
  String suffix,
) {
  return HaveNameEndingWithPredicate<E>(suffix);
}

ResideInDirectoryPredicate<E> resideInDirectory<E extends Element>(
    String directory) {
  return ResideInDirectoryPredicate<E>(directory);
}

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

class ResideInDirectoryPredicate<E extends Element>
    extends ElementPredicate<E> {
  final String directory;

  ResideInDirectoryPredicate(this.directory);

  @override
  String describe() {
    return 'reside in directory "$directory"';
  }

  @override
  bool satisfies(E element) {
    final fileUri = element.firstFragment.libraryFragment?.source.uri;
    return fileUri?.path.contains(directory) ?? false;
  }
}
