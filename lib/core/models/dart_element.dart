import 'package:arch_test/arch_test.dart';
import 'package:arch_test/core/models/element_location.dart';
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
