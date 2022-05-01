import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';

import 'dart_method_mapper.dart';
import 'dart_type_mapper.dart';
import 'dart_variable_mapper.dart';
import '../models/models.dart';
import '../utils/element_utils.dart';

class DartClassMapper {
  static late DartClassMapper instance = DartClassMapper(
    DartVariableMapper.instance,
    DartMethodMapper.instance,
    DartTypeMapper.instance,
  );

  final DartVariableMapper dartVariableMapper;
  final DartMethodMapper dartMethodMapper;
  final DartTypeMapper dartTypeMapper;

  DartClassMapper(
      this.dartVariableMapper, this.dartMethodMapper, this.dartTypeMapper);

  DartClass fromClassElement(ClassElement classElement) {
    return DartClass(
      name: classElement.name,
      location: ElementUtils.elementLocation(classElement),
      parentRef: ElementUtils.elementRef(classElement.enclosingElement),
      generics: _getGenerics(classElement),
      isTopLevel: true,
      isAbstract: classElement.isAbstract,
      isEnum: classElement.isEnum,
      fields: _getFields(classElement),
      methods: _getMethods(classElement),
      superClass: _getSuperClass(classElement),
      superInterfaces: _getSuperInterfaces(classElement),
      metadata: ElementUtils.readMetadata(classElement),
    );
  }

  List<DartType> _getGenerics(ClassElement classElement) {
    return classElement.typeParameters
        .map((tp) =>
            tp.bound ??
            tp.instantiate(nullabilitySuffix: NullabilitySuffix.none).bound)
        .map(dartTypeMapper.fromTypeElement)
        .toList(growable: false);
  }

  List<DartVariable> _getFields(ClassElement classElement) {
    return classElement.fields
        .map(dartVariableMapper.fromVariableElement)
        .toList(growable: false);
  }

  List<DartMethod> _getMethods(ClassElement classElement) {
    return classElement.methods
        .map(dartMethodMapper.fromMethodElement)
        .toList(growable: false);
  }

  DartClass? _getSuperClass(ClassElement classElement) {
    if (classElement.supertype != null) {
      return fromClassElement(classElement.supertype!.element);
    }
    return null;
  }

  List<DartClass> _getSuperInterfaces(ClassElement classElement) {
    return classElement.interfaces
        .map((it) => fromClassElement(it.element))
        .toList(growable: false);
  }
}
