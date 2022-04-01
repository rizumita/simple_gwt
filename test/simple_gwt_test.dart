import 'package:flutter_test/flutter_test.dart';
import 'package:simple_gwt/simple_gwt.dart';

void main() {
  String? a;
  String? b;

  nullifyA() => a = null;
  nullifyB() => b = null;

  testGWT('Test1', () {
    given('A is null', nullifyA);
    given('B is null', nullifyB);
    when('set a', () => a = 'a');
    when('set b', () => b = 'b');
    then('a is a', () => expect(a, 'a'));
    then('b is b', () => expect(b, 'b'));
  });

  testGWT('Test2', () {
    given('A is null', nullifyA);
    given('B is null', nullifyB);
    when('set b to a', () => a = 'b');
    when('set a to b', () => b = 'a');
    then('a is b', () => expect(a, 'b'));
    then('b is a', () => expect(b, 'a'));
  });
}
