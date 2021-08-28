import 'package:arch_test/src/core/models/dart_class.dart';
import 'package:arch_test/src/core/models/dart_method.dart';
import 'package:equatable/equatable.dart';

/// Representation of a Dart library
class DartLibrary extends Equatable {
  final String package;
  final String name;
  final List<DartClass> classes;
  final List<DartMethod> methods;

  DartLibrary({
    required this.name,
    required this.package,
    required this.classes,
    required this.methods,
  });

  @override
  List<Object?> get props => [package, name, classes, methods];
}
