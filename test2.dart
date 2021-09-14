import 'dart:mirrors';

void main() {
  final testC = reflectType(TestC) as ClassMirror;
  print(testC == testC.declarations[#a]?.owner);
}

class TestC {
  final String a = '';
}
