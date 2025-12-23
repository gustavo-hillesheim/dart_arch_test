import 'dart:io';
import 'dart:isolate';

import 'package:arch_test/isolate_channel.dart';
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

  final channel = IsolateChannel();

  channel.messages.listen((message) async {
    if (message is PrintIsolateMessage) {
      print(message.message);
    } else if (message is ProcessFinishedIsolateMessage) {
      await archTestRunnerFile.delete();
      channel.close();
    }
  });

  await Isolate.spawnUri(archTestRunnerFile.uri, [], channel.sendPort);
}

const _archTestRunnerFileContent = '''import 'dart:io';
import 'dart:isolate';

import 'package:analyzer/dart/element/element.dart';
import 'package:arch_test/arch_test.dart';
import 'package:arch_test/isolate_channel.dart';

import 'arch_test.dart' as tests;

void main(List<String> args, SendPort sendPort) async {
  final channel = IsolateChannel.fromSendPort(sendPort);

  channel.send(PrintIsolateMessage(message: 'Loading package libraries...'));

  final packageLoader = PackageLoader();
  final packageLibraries = await packageLoader.loadLibraries(Directory.current);

  channel.send(PrintIsolateMessage(message: 'Package libraries loaded!'));
  channel.send(PrintIsolateMessage(message: 'Registering architecture rules...'));

  tests.main();

  channel.send(PrintIsolateMessage(message: 'Architecture rules registered!'));
  channel.send(PrintIsolateMessage(message: 'Checking architecture rules...'));

  final ruleViolations = _checkRules(packageLibraries);

  channel.send(PrintIsolateMessage(message: 'Architecture rules checked!'));

  if (ruleViolations.isEmpty) {
    channel.send(PrintIsolateMessage(
      message: 'No architecture violations found. 🎉',
    ));
  } else {
    channel.send(PrintIsolateMessage(
      message: 'Architecture violations found:',
    ));
    for (final violation in ruleViolations) {
      channel.send(PrintIsolateMessage(
        message: '- [\${violation.severity}] \${violation.message} (Element: \${violation.element.name})',
      ));
    }
  }

  channel.send(const ProcessFinishedIsolateMessage());
}

List<RuleViolation> _checkRules(List<LibraryElement> packageLibraries) {
  final testsRunner = ArchTestsRunner(
    declaredRules: ArchTestDeclarator.instance.declaredRules,
    packageLibraries: packageLibraries,
  );
  return testsRunner.checkRules();
}

''';
