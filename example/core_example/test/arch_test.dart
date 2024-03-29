import 'package:arch_test/arch_test.dart';
import 'package:core_example/helper/text_printer.dart';
import 'package:core_example/main.dart';
import 'package:test/test.dart';

void main() {
  test('should create DartPackage correctly', () {
    final dartPackage = DartPackageLoader.instance.loadPackage('core_example');

    expect(
      dartPackage,
      DartPackage(
        name: 'core_example',
        libraries: [
          DartLibrary(
            name: 'helper/text_printer.dart',
            location: ElementLocation(
              uri: 'package:core_example/helper/text_printer.dart',
              line: 1,
              column: 1,
            ),
            classes: [
              DartClass(
                name: 'TextPrinter',
                location: ElementLocation(
                  uri: 'package:core_example/helper/text_printer.dart',
                  line: 1,
                  column: 1,
                ),
                parentRef: DartElementRef<DartLibrary>(
                  name: 'helper/text_printer.dart',
                  location: ElementLocation(
                    uri: 'package:core_example/helper/text_printer.dart',
                    line: 1,
                    column: 1,
                  ),
                ),
                fields: [
                  DartVariable(
                    name: 'arguments',
                    location: ElementLocation(
                      uri: 'package:core_example/helper/text_printer.dart',
                      line: 2,
                      column: 22,
                    ),
                    parentRef: DartElementRef<DartClass>(
                      name: 'TextPrinter',
                      location: ElementLocation(
                        uri: 'package:core_example/helper/text_printer.dart',
                        line: 1,
                        column: 1,
                      ),
                    ),
                    type: DartType.from<List<String>>(),
                    isFinal: true,
                  ),
                  DartVariable(
                    name: '_argIndex',
                    location: ElementLocation(
                      uri: 'package:core_example/helper/text_printer.dart',
                      line: 3,
                      column: 7,
                    ),
                    parentRef: DartElementRef<DartClass>(
                      name: 'TextPrinter',
                      location: ElementLocation(
                        uri: 'package:core_example/helper/text_printer.dart',
                        line: 1,
                        column: 1,
                      ),
                    ),
                    type: DartType.from<int>(),
                  ),
                ],
                methods: [
                  DartMethod(
                    name: 'printText',
                    location: ElementLocation(
                      uri: 'package:core_example/helper/text_printer.dart',
                      line: 7,
                      column: 3,
                    ),
                    parentRef: DartElementRef<DartClass>(
                      name: 'TextPrinter',
                      location: ElementLocation(
                        uri: 'package:core_example/helper/text_printer.dart',
                        line: 1,
                        column: 1,
                      ),
                    ),
                    returnType: DartType.voidType(),
                    parameters: [
                      DartParameter(
                        name: 'text',
                        type: DartType.from<String>(),
                        parentRef: DartElementRef<DartMethod>(
                          name: 'printText',
                          location: ElementLocation(
                            uri:
                                'package:core_example/helper/text_printer.dart',
                            line: 7,
                            column: 3,
                          ),
                        ),
                      ),
                    ],
                  ),
                  DartConstructor(
                    name: 'TextPrinter',
                    location: ElementLocation(
                      uri: 'package:core_example/helper/text_printer.dart',
                      line: 5,
                      column: 3,
                    ),
                    parentRef: DartElementRef<DartClass>(
                      name: 'TextPrinter',
                      location: ElementLocation(
                        uri: 'package:core_example/helper/text_printer.dart',
                        line: 1,
                        column: 1,
                      ),
                    ),
                    returnType: DartType.from<TextPrinter>(),
                    constructorKind: ConstructorKind.GENERATIVE,
                    parameters: [
                      DartParameter(
                        name: 'arguments',
                        type: DartType.from<List<String>>(),
                        parentRef: DartElementRef<DartConstructor>(
                          name: 'TextPrinter',
                          location: ElementLocation(
                            uri:
                                'package:core_example/helper/text_printer.dart',
                            line: 5,
                            column: 3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          DartLibrary(
            name: 'main.dart',
            location: ElementLocation(
              uri: 'package:core_example/main.dart',
              line: 1,
              column: 1,
            ),
            variables: [
              DartVariable(
                name: 'myConst',
                location: ElementLocation(
                  uri: 'package:core_example/main.dart',
                  line: 3,
                  column: 7,
                ),
                parentRef: DartElementRef<DartLibrary>(
                  name: 'main.dart',
                  location: ElementLocation(
                    uri: 'package:core_example/main.dart',
                    line: 1,
                    column: 1,
                  ),
                ),
                type: DartType.from<int>(),
                isTopLevel: true,
                isConst: true,
                isFinal: true,
                isStatic: true,
              ),
            ],
            methods: [
              DartMethod(
                name: 'main',
                isTopLevel: true,
                location: ElementLocation(
                  uri: 'package:core_example/main.dart',
                  line: 5,
                  column: 1,
                ),
                parentRef: DartElementRef<DartLibrary>(
                  name: 'main.dart',
                  location: ElementLocation(
                    uri: 'package:core_example/main.dart',
                    line: 1,
                    column: 1,
                  ),
                ),
                isStatic: true,
                returnType: DartType.voidType(),
                parameters: [
                  DartParameter(
                    name: 'arguments',
                    type: DartType.from<List<String>>(),
                    parentRef: DartElementRef<DartMethod>(
                      name: 'main',
                      location: ElementLocation(
                        uri: 'package:core_example/main.dart',
                        line: 5,
                        column: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            dependencies: [
              DartLibraryDependency(
                kind: LibraryDependencyKind.IMPORT,
                path: 'package:core_example/helper/text_printer.dart',
                location: ElementLocation.unknown(),
                parentRef: DartElementRef<DartLibrary>(
                  name: 'main.dart',
                  location: ElementLocation(
                    uri: 'package:core_example/main.dart',
                    line: 1,
                    column: 1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  });
}
