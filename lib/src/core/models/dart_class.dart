import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/core/models/dart_method.dart';
import 'package:arch_test/src/core/models/dart_variable.dart';
import 'package:arch_test/src/core/models/element_location.dart';

/// Representation of a Dart class
class DartClass extends DartType implements DartElementsParent {
  final bool isAbstract;
  final bool isEnum;
  final List<DartVariable> fields;
  final List<DartMethod> methods;
  final DartClass? superClass;
  final List<DartClass> superInterfaces;

  DartClass({
    required String name,
    required ElementLocation location,
    required List<DartType> generics,
    required this.fields,
    required this.methods,
    required this.superInterfaces,
    this.isAbstract = false,
    this.isEnum = false,
    this.superClass,
  }) : super(
          name: name,
          generics: generics,
          location: location,
        );

  @override
  List<Object?> get props =>
      super.props +
      [isAbstract, isEnum, fields, methods, superClass, superInterfaces];

  @override
  List<DartElement> get children => [...methods, ...fields];
}
