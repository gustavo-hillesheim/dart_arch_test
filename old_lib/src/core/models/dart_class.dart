import 'models.dart';

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
    this.fields = const [],
    this.methods = const [],
    this.superInterfaces = const [],
    this.isAbstract = false,
    this.isEnum = false,
    this.superClass,
    DartElementRef<DartLibrary>? parentRef,
    List<DartType> generics = const [],
    bool isTopLevel = true,
    List<DartMetadata> metadata = const [],
  }) : super(
          name: name,
          generics: generics,
          location: location,
          parentRef: parentRef,
          isTopLevel: isTopLevel,
          metadata: metadata,
        );

  @override
  List<Object?> get props =>
      super.props +
      [isAbstract, isEnum, fields, methods, superClass, superInterfaces];

  @override
  List<DartDeclaration> get children => [...methods, ...fields];
}
