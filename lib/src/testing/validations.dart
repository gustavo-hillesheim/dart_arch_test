import 'package:arch_test/arch_test.dart';
import 'package:arch_test/src/testing/types.dart';
import 'package:path/path.dart';
import 'package:collection/collection.dart';

abstract class Validations {
  static Validation<T> nameEndsWith<T extends DartElement>(String str) {
    return _createValidation(
      (el) => el.name.endsWith(str),
      (el) => 'Name of ${el.name} should end with "$str"',
    );
  }

  static Validation<T> nameStartsWith<T extends DartElement>(String str) {
    return _createValidation(
      (el) => el.name.startsWith(str),
      (el) => 'Name of ${el.name} should start with "$str"',
    );
  }

  static Validation<DartClass> implementsClass<C>() {
    final type = DartType.from<C>();
    return _createValidation(
      (el) =>
          _matchType(el, type) ||
          el.superInterfaces.any((interface) => _matchType(interface, type)),
      (el) => '${el.name} should implement ${C.toString()}',
    );
  }

  static Validation<DartClass> extendsClass<C>() {
    final type = DartType.from<C>();
    return _createValidation(
      (el) =>
          _matchType(el, type) ||
          el.superClass != null && _matchType(el.superClass!, type),
      (el) => '${el.name} should extend ${C.toString()}',
    );
  }

  static bool _matchType(DartType typeToMatch, DartType typeMatch) {
    final matcher = DeepCollectionEquality();
    final typeToMatchGenerics = [];
    final typeMatchGenerics = [];
    for (var i = 0;
        i < typeMatch.generics.length && i < typeToMatch.generics.length;
        i++) {
      // If the generic from typeMatch is dynamic, than any type can be matched,
      // so we just ignore this index of the generics
      if (typeMatch.generics[i] != DartType.dynamicType()) {
        typeToMatchGenerics.add(typeToMatch.generics[i]);
        typeMatchGenerics.add(typeMatch.generics[i]);
      }
    }
    final typeToMatchProps = [
      typeToMatch.name,
      typeToMatch.location,
      typeToMatch.parentRef,
      typeToMatchGenerics,
    ];
    final typeMatchProps = [
      typeMatch.name,
      typeMatch.location,
      typeMatch.parentRef,
      typeMatchGenerics,
    ];
    return matcher.equals(typeToMatchProps, typeMatchProps);
  }

  static Validation<DartLibrary> noDependencyMatches(
    String regExp, {
    String message = '',
  }) {
    return (lib, _, addViolation) {
      final regExpMatcher = RegExp(regExp);
      final invalidDependencies =
          lib.dependencies.where((dep) => regExpMatcher.hasMatch(dep.path));
      if (invalidDependencies.isNotEmpty) {
        addViolation(
          'Errors in library ${lib.name}.\n' +
              (message.isNotEmpty ? '$message.\n' : '') +
              _buildInvalidImports(invalidDependencies),
        );
      }
    };
  }

  // Only validates folders from this package
  static Validation<DartLibrary> onlyHaveDependenciesFromFolders(
    List<String> folders,
  ) {
    return (lib, package, addViolation) {
      final invalidDependencies = lib.dependencies.where((dep) {
        final isFromOtherPackage = dep.targetPackage != package.name;
        return !folders.any((folder) {
          final isDepFromFolder =
              dep.targetLibrary.contains('$folder$separator');
          return isDepFromFolder || isFromOtherPackage;
        });
      });
      if (invalidDependencies.isNotEmpty) {
        addViolation(
          'Errors in library ${lib.name}.\n'
                  'Can only have dependencies from folders $folders.\n' +
              _buildInvalidImports(invalidDependencies),
        );
      }
    };
  }

  static String _buildInvalidImports(
      Iterable<DartLibraryDependency> dependencies) {
    return 'Invalid imports:\n' +
        dependencies.map((dep) => '- ${dep.path}').join('\n');
  }

  static Validation<T> _createValidation<T extends DartElement>(
      bool Function(T el) validation, String Function(T el) violationMessage) {
    return (el, _, addViolation) {
      if (!validation(el)) {
        addViolation(violationMessage(el));
      }
    };
  }
}
