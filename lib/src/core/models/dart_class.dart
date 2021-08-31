import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/core/models/dart_method.dart';
import 'package:arch_test/src/core/models/dart_variable.dart';

/// Representation of a Dart class
class DartClass extends DartType {
  final bool isAbstract;
  final bool isEnum;
  final List<DartVariable> fields;
  final List<DartMethod> methods;
  final DartClass? superClass;
  final List<DartClass> superInterfaces;

  DartClass({
    required String name,
    required String library,
    required String package,
    List<DartType>? generics,
    List<DartVariable>? fields,
    List<DartMethod>? methods,
    this.isAbstract = false,
    this.isEnum = false,
    this.superClass,
    List<DartClass>? superInterfaces,
  })  : fields = fields ?? [],
        methods = methods ?? [],
        superInterfaces = superInterfaces ?? [],
        super(
          name: name,
          library: library,
          package: package,
          generics: generics,
        );

  @override
  List<Object?> get props => [
        name,
        library,
        package,
        generics,
        isAbstract,
        isEnum,
        fields,
        methods,
        superClass,
        superInterfaces
      ];

  @override
  String toString() {
    return 'DartClass(name="$name", library="$library", isAbstract=$isAbstract, isEnum=$isEnum, fields=$fields, methods=$methods, superClass=$superClass, superInterfaces=$superInterfaces)';
  }
}
