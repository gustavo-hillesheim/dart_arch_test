import 'package:analyzer/dart/element/element.dart';
import 'package:arch_test/arch_test.dart';

import 'dart_paremeter_mapper.dart';
import 'dart_type_mapper.dart';
import '../utils/element_utils.dart';
import '../models/dart_method.dart';
import '../models/enums/method_kind.dart';

class DartMethodMapper {
  static late DartMethodMapper instance = DartMethodMapper(
    DartTypeMapper.instance,
    DartParameterMapper.instance,
  );

  final DartTypeMapper dartTypeMapper;
  final DartParameterMapper dartParameterMapper;

  DartMethodMapper(this.dartTypeMapper, this.dartParameterMapper);

  DartMethod fromMethodElement(MethodElement methodElement) {
    final parameters = methodElement.parameters
        .map<DartParameter<DartMethod>>(
            dartParameterMapper.fromParameterElement)
        .toList(growable: false);
    return DartMethod(
      name: methodElement.name,
      kind: MethodKind.REGULAR,
      parentRef: ElementUtils.parentRef(methodElement),
      location: ElementUtils.elementLocation(methodElement),
      returnType: dartTypeMapper.fromTypeElement(methodElement.returnType),
      isTopLevel: false,
      isAbstract: methodElement.isAbstract,
      isStatic: methodElement.isStatic,
      parameters: parameters,
      metadata: ElementUtils.readMetadata(methodElement),
    );
  }

  DartMethod fromFunctionElement(FunctionElement functionElement) {
    final parameters = functionElement.parameters
        .map<DartParameter<DartMethod>>(
            dartParameterMapper.fromParameterElement)
        .toList(growable: false);
    return DartMethod(
      name: functionElement.name,
      kind: MethodKind.REGULAR,
      parentRef: ElementUtils.parentRef(functionElement),
      location: ElementUtils.elementLocation(functionElement),
      returnType: dartTypeMapper.fromTypeElement(functionElement.returnType),
      isTopLevel: true,
      isAbstract: functionElement.isAbstract,
      isStatic: functionElement.isStatic,
      parameters: parameters,
      metadata: ElementUtils.readMetadata(functionElement),
    );
  }
}
