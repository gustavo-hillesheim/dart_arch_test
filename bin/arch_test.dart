import 'dart:io';
import 'dart:isolate';

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

  final receivePort = ReceivePort();

  receivePort.listen((message) async {
    receivePort.close();
    await archTestRunnerFile.delete();
  });

  await Isolate.spawnUri(archTestRunnerFile.uri, [], receivePort.sendPort);
}

const _archTestRunnerFileContent = '''import 'dart:io';
import 'dart:isolate';

import 'package:analyzer/dart/element/element.dart';
import 'package:arch_test/arch_test.dart';

import 'arch_test.dart' as tests;

void main(List<String> args, SendPort sendPort) async {
  final packageLoader = PackageLoader();
  final packageLibraries = await packageLoader.loadLibraries(Directory.current);

  tests.main();

  await _checkRules(packageLibraries);

  sendPort.send(null);
}

Future<void> _checkRules(List<LibraryElement> packageLibraries) async {
  final testsRunner = ArchTestsRunner(
    declaredRules: ArchTestDeclarator.instance.declaredRules,
    packageLibraries: packageLibraries,
  );
  testsRunner.checkRules();
}

''';
