import 'package:analyzer/dart/element/element.dart';
import 'package:arch_test/arch_test.dart';

const classes = TypeElementMatcher<ClassElement>();

ResideInDirectoryMatcher<E> resideInDirectory<E extends Element>(
    String directory) {
  return ResideInDirectoryMatcher<E>(directory);
}

class TypeElementMatcher<E extends Element> extends ElementMatcher<E> {
  const TypeElementMatcher();

  @override
  bool matches(E item) {
    return true;
  }
}

class ResideInDirectoryMatcher<E extends Element> extends ElementMatcher<E> {
  final String directory;

  ResideInDirectoryMatcher(this.directory);

  @override
  bool matches(E item) {
    final fileUri = item.firstFragment.libraryFragment?.source.uri;
    return fileUri?.path.contains(directory) ?? false;
  }
}
