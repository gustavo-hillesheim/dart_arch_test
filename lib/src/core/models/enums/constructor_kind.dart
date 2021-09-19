import 'dart:mirrors';

import 'package:arch_test/src/core/exception.dart';

enum ConstructorKind { CONST, FACTORY, GENERATIVE, REDIRECTING }

ConstructorKind constructorKindFromMirror(MethodMirror methodMirror) {
  if (!methodMirror.isConstructor) {
    throw MethodIsNotConstructorException(methodMirror: methodMirror);
  }
  if (methodMirror.isConstConstructor) {
    return ConstructorKind.CONST;
  }
  if (methodMirror.isFactoryConstructor) {
    return ConstructorKind.FACTORY;
  }
  if (methodMirror.isGenerativeConstructor) {
    return ConstructorKind.GENERATIVE;
  }
  if (methodMirror.isRedirectingConstructor) {
    return ConstructorKind.REDIRECTING;
  }
  throw UnknownConstructorTypeException(methodMirror: methodMirror);
}
