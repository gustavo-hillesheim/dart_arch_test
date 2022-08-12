import 'models.dart';

/// Representation of a Dart class
class DartClass extends DartType
    implements DartElementsParent<DartDeclaration> {
  final bool isAbstract;
  final bool isEnum;
  final List<DartVariable> fields;
  final List<DartMethod> methods;
  final List<DartConstructor> constructors;
  final DartClass? superClass;
  final List<DartClass> superInterfaces;

  DartClass({
    required String name,
    required ElementLocation location,
    this.fields = const [],
    this.methods = const [],
    this.constructors = const [],
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
      [
        isAbstract,
        isEnum,
        fields,
        constructors,
        methods,
        superClass,
        superInterfaces
      ];

  @override
  List<DartDeclaration> get children =>
      [...constructors, ...methods, ...fields];

  @override
  String toString() {
    return 'DartClass(name: "$name", location: $location, fields: $fields, methods: $methods, constructors: $constructors, generics: $generics, superClass: $superClass, superInterfaces: $superInterfaces, isAbstract: $isAbstract, isEnum: $isEnum, isTopLevel: $isTopLevel, metadata: $metadata, parentRef: $parentRef)';
  }
}
