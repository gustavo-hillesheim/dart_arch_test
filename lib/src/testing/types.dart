import 'package:arch_test/arch_test.dart';

typedef ElementsProvider<T extends DartElement> = List<T> Function(
    DartPackage package);
typedef Filter<T extends DartElement> = List<T> Function(List<T> items);
typedef Condition<T extends DartElement> = void Function(
    T target, void Function(String) addViolation);
