import 'package:flutter_test/flutter_test.dart';
import 'package:simple_gwt/simple_gwt.dart';

void main() {
  String? a;
  String? b;

  aIsNull() => a = null;
  bIsNull() => b = null;

  test('Test1', gwt(() {
    given('', aIsNull);
    and('', bIsNull);
    when('set a', () => a = 'a');
    and('set b', () => b = 'b');
    then('a is a', () => expect(a, 'a'));
    and('b is b', () => expect(b, 'b'));
  }));

  test('Test2', gwt(() {
    given('', aIsNull);
    and('', bIsNull);
    when('set b to a', () => a = 'b');
    and('set a to b', () => b = 'a');
    then('a is b', () => expect(a, 'b'));
    and('b is a', () => expect(b, 'a'));
  }));
}
