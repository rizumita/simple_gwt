import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_gwt/simple_gwt.dart';

void main() {
  testWidgets(
    "WidgetTest",
    gwt_((tester) async {
      var result = '';
      given(() => tester
          .pumpWidget(MaterialApp(home: TextButton(onPressed: () => result = 'test', child: const Text('test')))));
      when(() => tester.tap(find.byType(TextButton)));
      then(() => expect(result, 'test'));
    }),
  );
}
