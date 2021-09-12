import 'package:arch_test/src/core/models/element_location.dart';
import 'package:equatable/equatable.dart';

class DartElement extends Equatable {
  final String name;
  final ElementLocation location;
  // Temporarily removed since a reference to a parent element requires
  // circular dependency between the objects
  //final DartElement? parent;

  DartElement({
    required this.name,
    //required this.parent,
    required this.location,
  });

  @override
  List<Object?> get props => [name, location];
}
