library;

import 'dart:io';

import 'src/core/core.dart';

export 'src/core/core.dart'
    hide PackageLoader, ArchTestsRunner, ArchTestDeclarator;
export 'src/predicates/predicates.dart';
export 'src/selectors/selectors.dart';

void archTest(ArchTest test) {
  ArchTestDeclarator.instance.add(test);
}

Future<void> runArchTests() async {
  print('Loading package libraries...');

  final packageLoader = PackageLoader();
  final packageLibraries = await packageLoader.loadLibraries(Directory.current);

  print('Architecture tests registered!');
  print('Running architecture tests...');

  final testsRunner = ArchTestsRunner(
    tests: ArchTestDeclarator.instance.declaredTests,
    packageLibraries: packageLibraries,
  );
  final ruleViolations = testsRunner.runTests();

  print('Architecture tests run!');

  if (ruleViolations.isEmpty) {
    print('No architecture violations found. 🎉');
  } else {
    print('Architecture violations found:');
    for (final violation in ruleViolations) {
      print(
          '- [${violation.severity}] ${violation.message} (Element: ${violation.element.name})');
    }
  }
}
