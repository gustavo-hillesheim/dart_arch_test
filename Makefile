# before running this command, make sure you have `nodemon` installed globally. Use `npm install -g nodemon` to install it.
test_watch:
	nodemon --watch lib --watch test --exec \"dart test\" -e dart

test_examples:
	cd example/core_example && dart test
	cd example/testing_with_core && dart test
	cd example/testing_with_testing && dart test
	cd example/testing_with_fluent && dart test

test_all:
	dart test
	make test_examples

coverage:
	dart run code_coverage

install_local:
	- rm -rf .dart_tool
	- fvm dart pub get
	- fvm dart pub global deactivate arch_test
	- rm ~/.pub-cache/bin/arch_test
	- dart pub global activate --overwrite --source path .

test_example:
	- make install_local
	- cd example && arch_test