# Arch Test
Arch test is a package used to create architecture tests for a dart application.

## Getting started
To start creating architecture tests you first need to create a test file, usually it is a file named `arch_test.dart` at the root of your `test` folder. 

In this file you will need to import the main library from your package. Without this, this package won't be able to find any elements from your package.
```dart
// at test/arch_test.dart
import 'package:my_package/main.dart';

void main() {
	// You'll write your tests here
}
```

Then, you'll import arch_test's main file, it provides all methods and classes you'll need to create your tests.
Use the function `archTest` passing an `ArchRule` as argument to run your tests.
You can create `ArchRule`s both fluently and as normal objects.
```dart
// at test/arch_test.dart
import 'package:my_package/main.dart';
import 'package:arch_test/arch_test.dart';

void main() {
	// Fluent testing
	archTest(classes.that
		.areInsideFolder('entity')
		.should
		.extendClass<BaseEntity>(),
	);
	// Creating ArchRule as normal object using premade helpers
	archTest(ArchRule(
		selector: Selectors.classes,
		filter: Filters.insideFolder('entity'),
		validation: Validations.extendClass<BaseEntity>(),
	));
}
```
When using `archTest`, it will automatically load your package's structure, and create a test with a name based on the `ArchRule` you provide to it, for example, both the tests above would be named `classes THAT are inside folder "entity" SHOULD extend BaseEntity`.

## Package Layers
This package is divided into three layers of abstraction:
* **Core**: Responsible for translating the dart mirror system to a internal and more friendly class hierarchy. This is the most flexible way of testing, but you'll also need to write a lot more code;
* **Testing**: Provides base classes for testing the class hierarchy provided by Core. An easier way of testing, but still not as simple and fluid as Fluent;
* **Fluent**: Provides an easy and human-readable way to create your tests. This should be your go-to way of testing.
You can see how to use each of these layers in the following sections.

### Core
TODO
### Testing
TODO
### Fluent
TODO

## Known Limitations
TODO