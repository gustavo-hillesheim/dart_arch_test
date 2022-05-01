import 'package:analyzer/dart/element/element.dart';

import 'dart_type_mapper.dart';
import '../utils/element_utils.dart';
import '../models/dart_parameter.dart';

class DartParameterMapper {
  static late DartParameterMapper instance =
      DartParameterMapper(DartTypeMapper.instance);

  final DartTypeMapper dartTypeMapper;

  DartParameterMapper(this.dartTypeMapper);

  DartParameter fromParameterElement(ParameterElement parameterElement) {
    return DartParameter(
      name: parameterElement.name,
      type: dartTypeMapper.fromTypeElement(parameterElement.type),
      isFinal: parameterElement.isFinal,
      isConst: parameterElement.isConst,
      hasDefaultValue: parameterElement.hasDefaultValue,
      parentRef: ElementUtils.elementRef(parameterElement.enclosingElement),
      metadata: ElementUtils.readMetadata(parameterElement),
    );
  }
}
