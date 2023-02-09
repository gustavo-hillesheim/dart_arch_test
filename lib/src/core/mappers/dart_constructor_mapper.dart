import 'package:analyzer/dart/element/element.dart';
import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/core/mappers/dart_paremeter_mapper.dart';
import 'package:arch_test/src/core/mappers/dart_type_mapper.dart';
import 'package:arch_test/src/core/utils/element_utils.dart';

class DartConstructorMapper {
  static late DartConstructorMapper instance = DartConstructorMapper(
    DartTypeMapper.instance,
    DartParameterMapper.instance,
  );

  final DartTypeMapper dartTypeMapper;
  final DartParameterMapper dartParameterMapper;

  DartConstructorMapper(this.dartTypeMapper, this.dartParameterMapper);

  DartConstructor fromConstructorElement(ConstructorElement element) {
    final parameters = element.parameters
        .map<DartParameter<DartConstructor>>(
            dartParameterMapper.fromParameterElement)
        .toList(growable: false);
    return DartConstructor(
      name: element.name,
      parameters: parameters,
      parentRef: ElementUtils.parentRef(element),
      location: ElementUtils.elementLocation(element),
      returnType: dartTypeMapper.fromTypeElement(element.returnType),
      constructorKind: constructorKindFromElement(element),
      metadata: ElementUtils.readMetadata(element),
    );
  }
}
