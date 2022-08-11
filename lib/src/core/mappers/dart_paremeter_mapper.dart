import 'package:analyzer/dart/element/element.dart';
import 'package:arch_test/arch_test.dart';

import 'dart_type_mapper.dart';
import '../utils/element_utils.dart';

class DartParameterMapper {
  static late DartParameterMapper instance =
      DartParameterMapper(DartTypeMapper.instance);

  final DartTypeMapper dartTypeMapper;

  DartParameterMapper(this.dartTypeMapper);

  DartParameter<T> fromParameterElement<T extends DartElement>(
      ParameterElement parameterElement) {
    return DartParameter<T>(
      name: parameterElement.name,
      type: dartTypeMapper.fromTypeElement(parameterElement.type),
      isFinal: parameterElement.isFinal,
      isConst: parameterElement.isConst,
      hasDefaultValue: parameterElement.hasDefaultValue,
      location: ElementUtils.elementLocation(parameterElement),
      parentRef: ElementUtils.parentRef(parameterElement),
      metadata: ElementUtils.readMetadata(parameterElement),
    );
  }
}
