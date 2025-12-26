import 'dart:io';

import 'package:path/path.dart' as path;

final _packageDirectory = Directory.current;

void main() async {
  final archTestFile = _getArchTestFile();
  await _verifyFileExists(archTestFile);
  await _runFile(archTestFile);
}

File _getArchTestFile() {
  final archTestFile = File(
    path.join(_packageDirectory.path, 'test', 'arch_test.dart'),
  );
  return archTestFile;
}

Future<void> _verifyFileExists(File file) async {
  if (!await file.exists()) {
    print(
      '${path.basename(file.path)} file not found in package\'s ${path.basename(file.parent.path)}/ directory.',
    );
    exit(1);
  }
}

Future<void> _runFile(File file) async {
  final process = await Process.start(
    Platform.resolvedExecutable,
    ['run', file.path],
    workingDirectory: _packageDirectory.path,
    mode: ProcessStartMode.inheritStdio,
  );
  await process.exitCode;
}
