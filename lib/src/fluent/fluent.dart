import 'exception.dart';

import '../testing/models/models.dart';
import '../testing/premade/premade.dart';
import '../core/models/models.dart';

part 'builders/selector_builders.dart';
part 'builders/filter_builders.dart';
part 'builders/validation_builders.dart';
part 'models/join_type.dart';

final variables = ReadySelectorBuilder._(Selectors.variables);
final methods = ReadySelectorBuilder._(Selectors.methods);
final classes = ReadySelectorBuilder._(Selectors.classes);
final enums = ReadySelectorBuilder._(Selectors.enums);
final libraries = ReadySelectorBuilder._(Selectors.libraries);
final elements = ReadySelectorBuilder._(Selectors.elements);
