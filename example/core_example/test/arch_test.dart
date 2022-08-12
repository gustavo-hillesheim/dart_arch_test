import 'package:arch_test/arch_test.dart';
import 'package:core_example/helper/text_printer.dart';
import 'package:test/test.dart';

void main() {
  test('should create DartPackage correctly', () async {
    final dartPackage = await DartPackageLoader.instance.loadCurrentPackage();

    expect(
      dartPackage,
      DartPackage(
        name: 'core_example',
        libraries: [
          DartLibrary(
            name: 'helper/text_printer.dart',
            location: ElementLocation(
              uri: 'package:core_example/helper/text_printer.dart',
            ),
            classes: [
              DartClass(
                name: 'TextPrinter',
                location: ElementLocation(
                  uri: 'package:core_example/helper/text_printer.dart',
                ),
                parentRef: DartElementRef<DartLibrary>(
                  name: 'helper/text_printer.dart',
                  location: ElementLocation(
                    uri: 'package:core_example/helper/text_printer.dart',
                  ),
                ),
                fields: [
                  DartVariable(
                    name: 'arguments',
                    location: ElementLocation(
                      uri: 'package:core_example/helper/text_printer.dart',
                    ),
                    parentRef: DartElementRef<DartClass>(
                      name: 'TextPrinter',
                      location: ElementLocation(
                        uri: 'package:core_example/helper/text_printer.dart',
                      ),
                    ),
                    type: DartType.listType,
                    isFinal: true,
                  ),
                  DartVariable(
                    name: '_argIndex',
                    location: ElementLocation(
                      uri: 'package:core_example/helper/text_printer.dart',
                    ),
                    parentRef: DartElementRef<DartClass>(
                      name: 'TextPrinter',
                      location: ElementLocation(
                        uri: 'package:core_example/helper/text_printer.dart',
                      ),
                    ),
                    type: DartType.intType,
                  ),
                ],
                constructors: [
                  DartConstructor(
                    name: '',
                    location: ElementLocation(
                      uri: 'package:core_example/helper/text_printer.dart',
                    ),
                    parentRef: DartElementRef<DartClass>(
                      name: 'TextPrinter',
                      location: ElementLocation(
                        uri: 'package:core_example/helper/text_printer.dart',
                      ),
                    ),
                    returnType:
                        DartType.from<TextPrinter>().resolve(dartPackage),
                    constructorKind: ConstructorKind.GENERATIVE,
                    parameters: [
                      DartParameter(
                        name: 'arguments',
                        location: ElementLocation(
                          uri: 'package:core_example/helper/text_printer.dart',
                        ),
                        isFinal: true,
                        type: DartType.listType,
                        parentRef: DartElementRef<DartConstructor>(
                          name: '',
                          location: ElementLocation(
                            uri:
                                'package:core_example/helper/text_printer.dart',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                methods: [
                  DartMethod(
                    name: 'printText',
                    location: ElementLocation(
                      uri: 'package:core_example/helper/text_printer.dart',
                    ),
                    parentRef: DartElementRef<DartClass>(
                      name: 'TextPrinter',
                      location: ElementLocation(
                        uri: 'package:core_example/helper/text_printer.dart',
                      ),
                    ),
                    returnType: DartType.voidType,
                    parameters: [
                      DartParameter(
                        name: 'text',
                        location: ElementLocation(
                          uri: 'package:core_example/helper/text_printer.dart',
                        ),
                        type: DartType.stringType,
                        parentRef: DartElementRef<DartMethod>(
                          name: 'printText',
                          location: ElementLocation(
                            uri:
                                'package:core_example/helper/text_printer.dart',
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
            ),
            variables: [
              DartVariable(
                name: 'myConst',
                location: ElementLocation(
                  uri: 'package:core_example/main.dart',
                ),
                parentRef: DartElementRef<DartLibrary>(
                  name: 'main.dart',
                  location: ElementLocation(
                    uri: 'package:core_example/main.dart',
                  ),
                ),
                type: DartType.intType,
                isTopLevel: true,
                isConst: true,
                isFinal: false,
                isStatic: true,
              ),
            ],
            methods: [
              DartMethod(
                name: 'main',
                isTopLevel: true,
                location: ElementLocation(
                  uri: 'package:core_example/main.dart',
                ),
                parentRef: DartElementRef<DartLibrary>(
                  name: 'main.dart',
                  location: ElementLocation(
                    uri: 'package:core_example/main.dart',
                  ),
                ),
                isStatic: true,
                returnType: DartType.voidType,
                parameters: [
                  DartParameter(
                    name: 'arguments',
                    location: ElementLocation(
                      uri: 'package:core_example/main.dart',
                    ),
                    type: DartType.listType,
                    parentRef: DartElementRef<DartMethod>(
                      name: 'main',
                      location: ElementLocation(
                        uri: 'package:core_example/main.dart',
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
                location:
                    ElementLocation(uri: 'package:core_example/main.dart'),
                parentRef: DartElementRef<DartLibrary>(
                  name: 'main.dart',
                  location: ElementLocation(
                    uri: 'package:core_example/main.dart',
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
