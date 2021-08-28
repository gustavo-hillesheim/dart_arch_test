A package to test the architecture of a package.

## Desired checks:
- Dependencies between libraries (library 'x' should not depend on library 'y')
- File structure (should have library 'x' and 'y', files from library 'x' should end with '_x', files from library 'y' should starts with 'y_')
- Classes (nameStartsWith, nameEndsWith, extends, implements, mixins, number of classes per file)
- File content (number of classes, number of functions, imports and exports)

## Good to have:
- Specify in which line and file the check is violated