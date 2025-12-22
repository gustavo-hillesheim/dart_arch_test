import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';

class PackageLoader {
  Future<List<LibraryElement>> loadLibraries(Directory directory) async {
    final context = _createAnalysisContextCollection(directory);
    final libraryElements = await _getLibraryElements(context);
    return libraryElements;
  }

  Future<List<LibraryElement>> _getLibraryElements(
      AnalysisContextCollection contextCollection) async {
    final libraryElements = <LibraryElement>[];

    for (final context in contextCollection.contexts) {
      final session = context.currentSession;
      final analyzedFiles =
          context.contextRoot.analyzedFiles().where((f) => f.endsWith('.dart'));

      for (final filePath in analyzedFiles) {
        final unitElement = await session.getResolvedLibrary(filePath);
        if (unitElement is ResolvedLibraryResult) {
          libraryElements.add(unitElement.element);
        }
      }
    }

    return libraryElements;
  }

  AnalysisContextCollection _createAnalysisContextCollection(
      Directory directory) {
    return AnalysisContextCollection(
      includedPaths: [directory.absolute.path],
    );
  }
}
