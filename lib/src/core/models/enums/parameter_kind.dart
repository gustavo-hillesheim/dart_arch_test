import 'dart:mirrors';

enum ParameterKind { REGULAR, POSITIONAL, NAMED }

ParameterKind parameterKindFromMirror(ParameterMirror mirror) {
  if (mirror.isOptional) {
    if (mirror.isNamed) {
      return ParameterKind.NAMED;
    }
    return ParameterKind.POSITIONAL;
  }
  return ParameterKind.REGULAR;
}
