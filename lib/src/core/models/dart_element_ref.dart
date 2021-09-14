import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/core/components/dart_element_finder.dart';
import 'package:equatable/equatable.dart';

/// Used for creating a reference for an element without creating an instance of
/// it. Later the actual element can be queried using [DartElementFinder].
class DartElementRef<T extends DartElement> extends Equatable {
  final String name;
  final ElementLocation location;

  DartElementRef({
    required this.name,
    required this.location,
  });

  bool matches(DartElement el) {
    return el is T && name == el.name && location == el.location;
  }

  @override
  List<Object?> get props => [T, name, location];
}
