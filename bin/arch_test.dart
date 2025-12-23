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

const _archTestRunnerFileContent = '''import 'package:arch_test/arch_test.dart';

import 'arch_test.dart' as tests;

void main() async {
  tests.main();

  await runArchTests();
}

''';
