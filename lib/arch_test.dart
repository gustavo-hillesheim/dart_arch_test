library;

import 'dart:io';

import 'package:analyzer/dart/element/element.dart';

import 'src/core/core.dart';

export 'src/assertions/assertions.dart';
export 'src/core/core.dart'
    hide PackageLoader, ArchTestsRunner, ArchTestDeclarator;
export 'src/matchers/matchers.dart';

void archTest(ArchRule rule) {
  ArchTestDeclarator.instance.addTestFor(rule);
}

Future<void> runArchTests() async {
  print('Loading package libraries...');

  final packageLoader = PackageLoader();
  final packageLibraries = await packageLoader.loadLibraries(Directory.current);

  print('Package libraries loaded!');
  print('Registering architecture rules...');

  print('Architecture rules registered!');
  print('Checking architecture rules...');

  final ruleViolations = _checkRules(packageLibraries);

  print('Architecture rules checked!');

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

List<RuleViolation> _checkRules(List<LibraryElement> packageLibraries) {
  final testsRunner = ArchTestsRunner(
    declaredRules: ArchTestDeclarator.instance.declaredRules,
    packageLibraries: packageLibraries,
  );
  return testsRunner.checkRules();
}
