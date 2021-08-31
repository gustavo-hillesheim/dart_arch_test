import 'package:arch_test/arch_test.dart';

typedef Filter<T> = T Function(DartPackage package);
typedef Condition<T> = void Function(
    T target, void Function(String) addViolation);
