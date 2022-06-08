import 'dart:async';

import 'package:flutter_test/flutter_test.dart' as ft;
import 'package:simple_gwt/src/gwt.dart';
import 'package:simple_gwt/src/keys.dart';

void main() {
  ft.test('gwt stores descriptions', () {
    gwt(() {
      expect(Zone.current[givenKey] is List<String>, true);
      expect(Zone.current[whenKey] is List<String>, true);
      expect(Zone.current[thenKey] is List<String>, true);
    })();
  });

  ft.test('gwt_ stores descriptions', () {
    gwt_((int value) async {
      expect(value, 1);
      expect(Zone.current[givenKey] is List<String>, true);
      expect(Zone.current[whenKey] is List<String>, true);
      expect(Zone.current[thenKey] is List<String>, true);
    })(1);
  });

  group('test wrapper function', () {
    test(() {
      const b = true;
      expect(b, true);
    });
  });
}
