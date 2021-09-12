import 'package:arch_test/src/core/models/element_location.dart';
import 'package:equatable/equatable.dart';

class DartElement extends Equatable {
  final String name;
  final DartElement? parent;
  final ElementLocation location;

  DartElement({
    required this.name,
    required this.parent,
    required this.location,
  });

  @override
  List<Object?> get props => [name, parent, location];
}
