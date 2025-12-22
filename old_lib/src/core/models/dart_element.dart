import 'models.dart';
import 'package:equatable/equatable.dart';

abstract class DartElement extends Equatable {
  final String name;
  final ElementLocation location;
  DartElementRef? get parentRef;

  DartElement({
    required this.name,
    required this.location,
  });

  String get package => location.package;
  String get library => location.library;

  @override
  List<Object?> get props => [name, parentRef, location];
}
