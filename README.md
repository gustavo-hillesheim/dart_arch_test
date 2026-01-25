# Arch Test

Package to write architectural tests, ensuring that your team's definitions are being followed.

## Table of Contents
- [How to use](#how-to-use)
- [Writing a test](#writing-a-test)
- [Predicates](#predicates)
- [Predicate building API](#predicate-building-api)

## How to use

1. Create a `arch_test.dart` file inside your `test` folder
2. Declare your tests using `archTest` function
3. Execute `runArchTests` after declaring your tests
4. Run your tests with `arch_test` command

An example `arch_test.dart` file would be:

```dart
import 'package:arch_test/arch_test.dart';
import 'package:arch_test/predicate_builders.dart';

void main() {
  archTest(
    classes
        .that(have(name(), endingWith('Entity')))
        .should(have(libraryPath(), containing('src/domain/entities'))),
  );
  runArchTests();
}
```

## Writing a test

To write a test your first need to define which elements in your project you want to validate, this will be your `ElementSelector`. Then, you need to define what you'll be checking these elements for, this will be your `ArchRule`.

Usually your tests will be structured following the pattern `(element type) [THAT follow some condition] SHOULD (follow some condition)`. For example, `entities SHOULD be inside folder src/domain/entities` or `repositories SHOULD be abstract interfaces`.

To write the first test we'll create a custom `ElementSelector`:

```dart
import 'package:analyzer/dart/element/element.dart';
import 'package:arch_test/arch_test.dart';
import 'package:arch_test/predicate_builders.dart';

final entities = NamedElementSelector(
  classes.that(have(name(), endingWith('Entity'))),
  'entities',
);

// OR

class EntityElementSelector extends ElementSelector<Element, ClassElement> {
  const EntityElementSelector();

  @override
  String describe() {
    return 'entities';
  }

  @override
  List<E> select(List<Element> elements) {
    return elements
        .whereType<ClassElement>()
        .where((e) => e.name?.endsWith('Entity') ?? false)
        .toList();
  }
}

```

And then a custom `ArchRule`:

```dart
import 'package:analyzer/dart/element/element.dart';
import 'package:arch_test/arch_test.dart';

final beAbstractInterface = BeAbstractInterfaceRule();

class BeAbstractInterfaceRule extends ArchRule<ClassElement> {
  BeAbstractInterfaceRule();

  @override
  String describe() {
    return 'be abstract interface';
  }

  @override
  void check(ClassElement element, ReportViolation reportViolation) {
    final className = element.name;

    if (!element.isAbstract) {
      reportViolation(
        ViolationSeverity.error,
        'Class "$className" is not abstract.',
      );
    }

    if (!element.isInterface) {
      reportViolation(
        ViolationSeverity.error,
        'Class "$className" is not an interface.',
      );
    }
  }
}
```

And then you combine them with `selector.should`:

```dart
archTest(entities.should(beAbstractInterface));
```

### Predicates

Predicates are a way for further selecting which elements you want to test, but also for writing rules to test them against. This is useful to write code that can be used interchangeably with `ElementSelector`s and as `ArchRule`s.

So, if we had a predicate `haveNameEndingWith` and a predicate `areInsideFolder`/`beInsideFolder` we could write both `classes.that(haveNameEndingWith('Entity')).should(beInsideFolder('src/domain/entities'))` and `classes.that(areInsideFolder('src/domain/entities')).should(haveNameEndingWith('Entity'))`.

An implementation for these predicates could be as follows:

```dart
import 'package:analyzer/dart/element/element.dart';
import 'package:arch_test/arch_test.dart';

ElementPredicate<E> haveNameEndingWith<E extends Element>(String suffix) =>
    HaveNameEndingWithPredicate<E>(suffix);

ElementPredicate<E> areInsideFolder<E extends Element>(String folder) =>
    InsideFolderPredicate<E>(folder, description: 'are inside folder');

ElementPredicate<E> beInsideFolder<E extends Element>(String folder) =>
    InsideFolderPredicate<E>(folder, description: 'be inside folder');

class HaveNameEndingWithPredicate<E extends Element>
    implements ElementPredicate<E> {
  const HaveNameEndingWithPredicate(this.suffix);

  final String suffix;

  @override
  String describe() {
    return 'have name ending with "$suffix"';
  }

  @override
  bool satisfies(E element) {
    return element.name?.endsWith(suffix) ?? false;
  }
}

class InsideFolderPredicate<E extends Element> implements ElementPredicate<E> {
  const InsideFolderPredicate(this.folder, {required this.description});

  final String folder;
  final String description;

  @override
  String describe() {
    return description;
  }

  @override
  bool satisfies(E element) {
    final libraryPath = element.firstFragment.libraryFragment?.source.uri.path;
    return libraryPath != null && libraryPath.contains(folder);
  }
}
```

### Predicate building API

Predicate will probably be the main way you'll write your tests, so this should be as simple and reusable as possible.

To achieve this we can use the Predicate building API.

This API consists of simple, specific and reusable methods and classes, used to create any type of predicate. The main entrypoints to this API are `have` and `be`, which accept `ElementPropertyAcessor`s and `ValueMatcher`s.

A `ElementPropertyAcessor` is a class that returns the value of a property of an element. A `ValueMatcher` is a class that checks is a value matches an expected value/pattern. Their main implementations are `FunctionalPropertyAccessor` and `FunctionalValueMatcher`.

Using this API we can rewrite our previous test (`classes.that(haveNameEndingWith('Entity')).should(beInsideFolder('src/domain/entities'))`) as follows:

```dart
import 'package:analyzer/dart/element/element.dart';
import 'package:arch_test/arch_test.dart';

archTest(
    classes
        .that(have(name(), endingWith('Entity')))
        .should(have(libraryPath(), containing('src/domain/entities'))),
);

ElementPropertyAcessor<E, String?> name<E extends Element>() {
  return FunctionalPropertyAccessor<E, String?>(
    description: 'name',
    getter: (element) => element.name,
  );
}

ElementPropertyAcessor<E, String?> libraryPath<E extends Element>() {
  return FunctionalPropertyAccessor<E, String?>(
    description: 'library path',
    getter: (element) => element.firstFragment.libraryFragment?.source.uri.path,
  );
}

ValueMatcher<String?> endingWith(String suffix) {
  return FunctionalValueMatcher<String?>(
    description: 'ending with "$suffix"',
    matcher: (value) => value != null && value.endsWith(suffix),
  );
}

ValueMatcher<String?> containing(String substring) {
  return FunctionalValueMatcher<String?>(
    description: 'containing "$substring"',
    matcher: (value) => value != null && value.contains(substring),
  );
}
```