import 'package:analyzer/dart/element/element.dart';

import 'dart_type_mapper.dart';
import '../models/dart_variable.dart';
import '../utils/element_utils.dart';

class DartVariableMapper {
  static late DartVariableMapper instance =
      DartVariableMapper(DartTypeMapper.instance);

  final DartTypeMapper dartTypeMapper;

  DartVariableMapper(this.dartTypeMapper);

  DartVariable fromVariableElement(VariableElement variableElement) {
    final simpleName = variableElement.name;
    return DartVariable(
      name: simpleName,
      isConst: variableElement.isConst,
      isFinal: variableElement.isFinal,
      isTopLevel: variableElement is TopLevelVariableElement,
      isStatic: variableElement.isStatic,
      type: dartTypeMapper.fromTypeElement(variableElement.type),
      metadata: ElementUtils.readMetadata(variableElement),
      location: ElementUtils.elementLocation(variableElement),
      parentRef: ElementUtils.parentRef(variableElement),
    );
  }
}
