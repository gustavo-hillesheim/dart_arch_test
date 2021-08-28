class FactoryNotFoundException {
  final String message;

  FactoryNotFoundException(String typeName)
      : message = 'Could not find factory of type "$typeName"';
}
