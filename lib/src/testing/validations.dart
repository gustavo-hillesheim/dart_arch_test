import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/testing/types.dart';

abstract class Validations {
  static Validation<T> nameEndsWith<T extends DartElement>(String str) {
    return _createCondition(
      (el) => el.name.endsWith(str),
      (el) => 'Name of ${el.name} should end with "$str"',
    );
  }

  static Validation<T> nameStartsWith<T extends DartElement>(String str) {
    return _createCondition(
      (el) => el.name.startsWith(str),
      (el) => 'Name of ${el.name} should start with "$str"',
    );
  }

  static Validation<DartClass> implementsClass(DartClass cls) {
    return _createCondition(
      (el) => el.superInterfaces.contains(cls),
      (el) => '${el.name} should implement ${cls.name}',
    );
  }

  static Validation<DartClass> extendsClass(DartClass cls) {
    return _createCondition(
      (el) => el.superClass != null && el.superClass == cls,
      (el) => '${el.name} should extend ${cls.name}',
    );
  }

  static Validation<DartLibrary> noDependencyMatches(
    String regExp, {
    String message = '',
  }) {
    return (lib, addViolation) {
      final regExpMatcher = RegExp(regExp);
      final invalidDependencies =
          lib.dependencies.where((dep) => regExpMatcher.hasMatch(dep.path));
      if (invalidDependencies.isNotEmpty) {
        final invalidImports = 'Invalid imports:\n' +
            invalidDependencies.map((dep) => '- ${dep.path}').join('\n');

        addViolation(
          'Errors in library ${lib.name}.\n' +
              (message.isNotEmpty ? '$message.\n' : '') +
              invalidImports,
        );
      }
    };
  }

  static Validation<T> _createCondition<T extends DartElement>(
      bool Function(T el) validation, String Function(T el) violationMessage) {
    return (el, addViolation) {
      if (!validation(el)) {
        addViolation(violationMessage(el));
      }
    };
  }
}
