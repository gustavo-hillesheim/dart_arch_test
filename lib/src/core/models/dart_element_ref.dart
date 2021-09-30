import '../components/dart_element_finder.dart';
import 'models.dart';
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
