import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/source/source.dart';
import 'package:mocktail/mocktail.dart';

final mockLibraries = [
  createMockLibrary(
    children: [
      createMockClass(
        name: 'UserEntity',
        libraryUri: Uri.parse('package:app/domain/entities/user_entity.dart'),
      ),
    ],
  ),
  createMockLibrary(
    children: [
      createMockClass(
        name: 'OrderEntity',
        libraryUri: Uri.parse('package:app/domain/entities/order_entity.dart'),
      ),
    ],
  ),
  createMockLibrary(
    children: [productServiceMockClass],
  ),
];

final productServiceMockClass = createMockClass(
  name: 'ProductService',
  libraryUri: Uri.parse('package:app/domain/service/product_service.dart'),
);

LibraryElement createMockLibrary({
  List<Element> children = const [],
}) {
  final library = FakeLibraryElement();

  when(() => library.children).thenReturn(children);

  return library;
}

ClassElement createMockClass({
  String name = 'MockClass',
  Uri? libraryUri,
}) {
  final classElement = FakeClassElement();

  when(() => classElement.name).thenReturn(name);
  if (libraryUri != null) {
    final firstFragment = FakeClassFragment();
    final libraryFragment = FakeLibraryFragment();
    final source = FakeSource();
    when(() => source.uri).thenReturn(libraryUri);
    when(() => libraryFragment.source).thenReturn(source);
    when(() => firstFragment.libraryFragment).thenReturn(libraryFragment);
    when(() => classElement.firstFragment).thenReturn(firstFragment);
  }

  return classElement;
}

class FakeLibraryElement extends Mock implements LibraryElement {}

class FakeClassElement extends Mock implements ClassElement {}

class FakeClassFragment extends Mock implements ClassFragment {}

class FakeLibraryFragment extends Mock implements LibraryFragment {}

class FakeSource extends Mock implements Source {}
