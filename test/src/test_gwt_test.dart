import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:simple_gwt/src/keys.dart';
import 'package:simple_gwt/src/test_gwt.dart';

void main() {
  test('gwt stores descriptions', () {
    gwt(() {
      expect(Zone.current[givenKey] is List<String>, true);
      expect(Zone.current[whenKey] is List<String>, true);
      expect(Zone.current[thenKey] is List<String>, true);
    })();
  });

  test('gwt_ stores descriptions', () {
    gwt_((int value) async {
      expect(value, 1);
      expect(Zone.current[givenKey] is List<String>, true);
      expect(Zone.current[whenKey] is List<String>, true);
      expect(Zone.current[thenKey] is List<String>, true);
    })(1);
  });
}
