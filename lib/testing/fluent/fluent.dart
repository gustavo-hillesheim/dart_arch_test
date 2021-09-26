import 'dart:mirrors';

import 'package:arch_test/arch_test.dart';
import 'package:arch_test/testing/fluent/exception.dart';

part 'builders/selector_builders.dart';
part 'builders/filter_builders.dart';
part 'builders/validation_builders.dart';
part 'models/join_type.dart';

final methods = ReadySelectorBuilder._(Selectors.methods);
final classes = ReadySelectorBuilder._(Selectors.classes);
final enums = ReadySelectorBuilder._(Selectors.enums);
final libraries = ReadySelectorBuilder._(Selectors.libraries);
