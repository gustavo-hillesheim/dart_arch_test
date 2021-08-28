run:
	dart run

run_watch:
	nodemon --watch lib --watch bin --exec \"make run\" -e dart

# before running this command, make sure you have `nodemon` installed globally. Use `npm install -g nodemon` to install it.
test_watch:
	nodemon --watch lib --watch test --exec \"dart test\" -e dart

coverage:
	dart run code_coverage