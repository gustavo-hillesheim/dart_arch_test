import 'package:arch_test/arch_test.dart';

typedef ElementsProvider<T> = List<T> Function(DartPackage package);
typedef Filter<T> = List<T> Function(List<T> items);
typedef Condition<T> = void Function(
    T target, void Function(String) addViolation);
