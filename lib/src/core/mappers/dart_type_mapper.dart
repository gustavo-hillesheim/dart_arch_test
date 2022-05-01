import 'package:analyzer/dart/element/type.dart' as analyzer;

import '../utils/element_utils.dart';
import '../models/dart_type.dart';

class DartTypeMapper {
  static late DartTypeMapper instance = DartTypeMapper();

  const DartTypeMapper();

  DartType fromTypeElement(analyzer.DartType typeElement) {
    final name = typeElement.getDisplayString(withNullability: false);
    final generics = typeElement is analyzer.ParameterizedType
        ? typeElement.typeArguments.map(fromTypeElement).toList()
        : <DartType>[];
    return DartType(
      name: name,
      generics: generics,
      location: ElementUtils.elementLocation(typeElement.element),
      parentRef: ElementUtils.elementRef(typeElement.element?.enclosingElement),
      metadata: ElementUtils.readMetadata(typeElement.element),
    );
  }
}
