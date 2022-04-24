import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_gwt/simple_gwt.dart';

void main() {
  testWidgets(
    "WidgetTest",
    gwt_((tester) async {
      var result = '';
      given(
          'Show TextButton',
          () => tester
              .pumpWidget(MaterialApp(home: TextButton(onPressed: () => result = 'test', child: const Text('test')))));
      when('Tap the button', () => tester.tap(find.byType(TextButton)));
      then('result is \'test\'', () => expect(result, 'test'));
    }),
  );
}
