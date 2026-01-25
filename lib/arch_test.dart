library;

import 'dart:io';

import 'src/core/core.dart';

export 'src/core/core.dart'
    hide PackageLoader, ArchTestsRunner, ArchTestDeclarator;
export 'src/selectors/selectors.dart';

void archTest(ArchTest test) {
  ArchTestDeclarator.instance.add(test);
}

Future<void> runArchTests() async {
  final packageLoader = PackageLoader();
  final packageLibraries = await packageLoader.loadLibraries(Directory.current);

  final testsRunner = ArchTestsRunner(
    tests: ArchTestDeclarator.instance.declaredTests,
    packageLibraries: packageLibraries,
  );
  final ruleViolations = testsRunner.runTests();

  if (ruleViolations.isEmpty) {
    print('No architecture violations found. 🎉');
  } else {
    print('${ruleViolations.length} architecture violations found:');
    for (final violation in ruleViolations) {
      final element = violation.element;
      final fragment = element.firstFragment;
      final library = element.library;

      final lineInfo = fragment.libraryFragment?.lineInfo;
      final location = lineInfo?.getLocation(fragment.offset);
      final fullLocation = library != null && location != null
          ? '${library.uri.path}:${location.lineNumber}:${location.columnNumber}'
          : 'unknown location';

      print(
        '- [${violation.severity.name.toUpperCase()}] ${violation.message} (violated by ${violation.element.name} ($fullLocation))',
      );
    }
  }
}
