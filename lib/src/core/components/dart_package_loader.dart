import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:path/path.dart';
import '../models/models.dart';
import '../mappers/mappers.dart';
import '../../utils.dart';

class DartPackageLoader {
  static late DartPackageLoader instance = DartPackageLoader(
    DartLibraryMapper.instance,
  );

  final DartLibraryMapper dartLibraryMapper;

  DartPackageLoader(this.dartLibraryMapper);

  Future<DartPackage> loadCurrentPackage() async {
    final nearestPackageDirectory =
        await findNearestPackageDirectory(Directory.current);
    return loadPackageAt(nearestPackageDirectory);
  }

  Future<DartPackage> loadPackageAt(Directory directory) async {
    final libraries = await _findLibrariesAt(directory);
    final packageName = await findPackageName(directory);
    return DartPackage(name: packageName, libraries: libraries);
  }

  Future<List<DartLibrary>> _findLibrariesAt(Directory directory) async {
    final collection = _createAnalysisContextCollection(directory);
    final libraries = await _findLibrariesOf(collection);
    return libraries
        .map(dartLibraryMapper.fromResolvedLibrary)
        .toList(growable: false);
  }

  AnalysisContextCollection _createAnalysisContextCollection(
      Directory directory) {
    return AnalysisContextCollection(
      includedPaths: ['${directory.absolute.path}${separator}lib'],
      resourceProvider: PhysicalResourceProvider.INSTANCE,
    );
  }

  Future<List<ResolvedLibraryResult>> _findLibrariesOf(
      AnalysisContextCollection collection) async {
    final result = <ResolvedLibraryResult>[];
    for (final context in collection.contexts) {
      for (final filePath in context.contextRoot.analyzedFiles()) {
        if (!filePath.endsWith('.dart')) {
          continue;
        }
        final parsedLibrary =
            await context.currentSession.getResolvedLibrary(filePath);
        if (parsedLibrary is ResolvedLibraryResult) {
          result.add(parsedLibrary);
        }
      }
    }
    return result;
  }
}
