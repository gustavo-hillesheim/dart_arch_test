import 'dart:mirrors';

enum ConstructorKind { CONST, FACTORY, GENERATIVE, REDIRECTING }

ConstructorKind constructorKindFromMirror(MethodMirror methodMirror) {
  if (!methodMirror.isConstructor) {
    throw Exception('MethodMirror does not belong to a constructor');
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
  throw Exception('Unknown constructor type');
}
