import 'dart:io';

import 'package:path/path.dart';

void main() async {
  final packageDirectory = Directory.current;
  final archTestFile = File(
    join(packageDirectory.path, 'test', 'arch_test.dart'),
  );
  if (!await archTestFile.exists()) {
    print(
      'arch_test.dart file not found in test/ directory of the package.',
    );
    exit(1);
  }

  final archTestRunnerFile = File(
    join(archTestFile.parent.path, '.arch_test_runner.dart'),
  );
  await archTestRunnerFile.create();
  await archTestRunnerFile.writeAsString(
    _archTestRunnerFileContent,
    flush: true,
  );

  final process = await Process.start(
    Platform.resolvedExecutable,
    ['run', archTestRunnerFile.path],
    workingDirectory: packageDirectory.path,
    mode: ProcessStartMode.inheritStdio,
  );
  await process.exitCode;

  await archTestRunnerFile.delete();
}

const _archTestRunnerFileContent = '''import 'dart:io';
import 'dart:isolate';

import 'package:analyzer/dart/element/element.dart';
import 'package:arch_test/arch_test.dart';

import 'arch_test.dart' as tests;

void main() async {
  print('Loading package libraries...');

  final packageLoader = PackageLoader();
  final packageLibraries = await packageLoader.loadLibraries(Directory.current);

  print('Package libraries loaded!');
  print('Registering architecture rules...');

  tests.main();

  print('Architecture rules registered!');
  print('Checking architecture rules...');

  final ruleViolations = _checkRules(packageLibraries);

  print('Architecture rules checked!');

  if (ruleViolations.isEmpty) {
    print('No architecture violations found. 🎉');
  } else {
    print('Architecture violations found:');
    for (final violation in ruleViolations) {
      print('- [\${violation.severity}] \${violation.message} (Element: \${violation.element.name})');
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

''';
