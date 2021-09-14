import 'dart:mirrors';

import 'package:arch_test/src/exception.dart';

enum MethodKind { SETTER, GETTER, CONSTRUCTOR, OPERATOR, REGULAR }

MethodKind methodKindFromMirror(MethodMirror methodMirror) {
  if (methodMirror.isRegularMethod) {
    return MethodKind.REGULAR;
  }
  if (methodMirror.isSetter) {
    return MethodKind.SETTER;
  }
  if (methodMirror.isGetter) {
    return MethodKind.GETTER;
  }
  if (methodMirror.isConstructor) {
    return MethodKind.CONSTRUCTOR;
  }
  if (methodMirror.isOperator) {
    return MethodKind.OPERATOR;
  }
  throw UnknownMethodTypeException(methodMirror: methodMirror);
}
