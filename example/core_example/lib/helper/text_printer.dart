class TextPrinter {
  final List<String> arguments;
  int _argIndex = 0;

  TextPrinter(this.arguments);

  void printText(String text) {
    while (text.contains('%s')) {
      text = text.replaceFirst('%s', arguments[_argIndex++]);
    }
    print(text);
  }
}
