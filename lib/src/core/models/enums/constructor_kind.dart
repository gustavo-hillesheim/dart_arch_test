import 'dart:mirrors';

import 'package:analyzer/dart/element/element.dart';

import '../../exception.dart';

enum ConstructorKind { CONST, FACTORY, GENERATIVE, REDIRECTING }

ConstructorKind constructorKindFromElement(ConstructorElement element) {
  if (element.isConst) {
    return ConstructorKind.CONST;
  }
  if (element.isFactory) {
    return ConstructorKind.FACTORY;
  }
  if (element.isGenerative) {
    return ConstructorKind.GENERATIVE;
  }
  if (element.redirectedConstructor != null) {
    return ConstructorKind.REDIRECTING;
  }
  throw UnknownConstructorTypeException(constructorElement: element);
}
