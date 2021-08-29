import 'package:arch_test/src/core/models/dart_method.dart';
import 'package:arch_test/src/core/models/dart_variable.dart';
import 'package:equatable/equatable.dart';

/// Representation of a Dart class
class DartClass extends Equatable {
  final String name;
  final bool isAbstract;
  final bool isEnum;
  final List<DartVariable> fields;
  final List<DartMethod> methods;

  DartClass({
    required this.name,
    List<DartVariable>? fields,
    List<DartMethod>? methods,
    this.isAbstract = false,
    this.isEnum = false,
  })  : fields = fields ?? [],
        methods = methods ?? [];

  @override
  List<Object?> get props => [name, isAbstract, isEnum, fields, methods];

  @override
  String toString() {
    return 'DartClass(name="$name", isAbstract=$isAbstract, isEnum=$isEnum, fields=$fields, methods=$methods)';
  }
}
