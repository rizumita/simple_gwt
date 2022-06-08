import 'package:flutter/material.dart';
import 'package:simple_gwt/simple_gwt.dart';

void main() {
  String? a;
  String? b;

  aIsNull() => a = null;
  bIsNull() => b = null;

  test(() {
    given('', aIsNull);
    and('', bIsNull);
    when('set a', () => a = 'a');
    and('set b', () => b = 'b');
    thenExpect('a is a', a, 'a');
    andExpect('b is b', b, 'b');
  });

  test(() async {
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
  });

  testWidgets(
    (tester) async {
      var result = '';
      given(
          'Show TextButton',
          () => tester.pumpWidget(MaterialApp(
              home: TextButton(
                  onPressed: () => result = 'test',
                  child: const Text('test')))));
      when('Tap the button', () => tester.tap(find.byType(TextButton)));
      then('result is \'test\'', () => expect(result, 'test'));
    },
  );
}
