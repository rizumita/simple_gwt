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

  test('Test2', gwt(() async {
    given('', aIsNull);
    and('', bIsNull);

    await when('set a with delay', () async {
      await Future.delayed(const Duration(milliseconds: 100));
      a = 'delayed_a';
    });
    then('a is delayed_a', () => expect(a, 'delayed_a'));

    await when('set b with delay', () async {
      await Future.delayed(const Duration(milliseconds: 100));
      b = 'delayed_b';
    });
    then('b is delayed_b', () => expect(b, 'delayed_b'));

    expect(a, 'delayed_a');
    expect(b, 'delayed_b');
  }));
}
