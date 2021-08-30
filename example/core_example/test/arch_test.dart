import 'package:arch_test/arch_test.dart';
import 'package:core_example/helper/text_printer.dart';
import 'package:core_example/main.dart';
import 'package:test/test.dart';

void main() {
  test('should create DartPackage correctly', () {
    final archTest = ArchTest();
    final dartPackage = archTest.loadPackage('core_example');

    expect(
      dartPackage,
      DartPackage(
        name: 'core_example',
        libraries: [
          DartLibrary(
            name: 'helper/text_printer.dart',
            package: 'core_example',
            classes: [
              DartClass(
                name: 'TextPrinter',
                fields: [
                  DartVariable(
                    name: 'arguments',
                    type: DartType.from(
                      List,
                      generics: [DartType.from(String)],
                    ),
                    isFinal: true,
                  ),
                  DartVariable(
                    name: '_argIndex',
                    type: DartType.from(int),
                    isPrivate: true,
                  ),
                ],
                methods: [
                  DartMethod(
                    name: 'printText',
                    returnType: DartType.voidType(),
                    parameters: [
                      DartParameter(
                        name: 'text',
                        type: DartType.from(String),
                      ),
                    ],
                  ),
                  DartMethod(
                    name: 'TextPrinter',
                    returnType: DartType.from(TextPrinter),
                    kind: MethodKind.CONSTRUCTOR,
                    constructorKind: ConstructorKind.GENERATIVE,
                    parameters: [
                      DartParameter(
                        name: 'arguments',
                        type: DartType.from(
                          List,
                          generics: [DartType.from(String)],
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
            package: 'core_example',
            methods: [
              DartMethod(
                name: 'main',
                isStatic: true,
                returnType: DartType.voidType(),
                parameters: [
                  DartParameter(
                    name: 'arguments',
                    type: DartType.from(
                      List,
                      generics: [DartType.from(String)],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  });
}
