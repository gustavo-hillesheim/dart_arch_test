import 'package:arch_test/arch_test.dart';
import 'package:arch_test/core/models/dart_declaration.dart';
import 'package:arch_test/core/models/dart_method.dart';
import 'package:arch_test/core/models/dart_variable.dart';
import 'package:arch_test/core/models/element_location.dart';

/// Representation of a Dart class
class DartClass extends DartType
    implements DartElementsParent<DartDeclaration> {
  final bool isAbstract;
  final bool isEnum;
  final List<DartVariable> fields;
  final List<DartMethod> methods;
  final DartClass? superClass;
  final List<DartClass> superInterfaces;

  DartClass({
    required String name,
    required ElementLocation location,
    List<DartType> generics = const [],
    DartElementRef<DartLibrary>? parentRef,
    this.fields = const [],
    this.methods = const [],
    this.superInterfaces = const [],
    bool isTopLevel = true,
    this.isAbstract = false,
    this.isEnum = false,
    this.superClass,
  }) : super(
          name: name,
          generics: generics,
          location: location,
          parentRef: parentRef,
          isTopLevel: isTopLevel,
        );

  @override
  List<Object?> get props =>
      super.props +
      [isAbstract, isEnum, fields, methods, superClass, superInterfaces];

  @override
  List<DartDeclaration> get children => [...methods, ...fields];
}
