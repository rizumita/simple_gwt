import 'package:flutter_test/flutter_test.dart';
import 'package:simple_gwt/simple_gwt.dart';

void main() {
  String? a;
  String? b;

  aIsNull() => a = null;
  bIsNull() => b = null;

  test('Test1', gwt(() {
    given(aIsNull);
    and(bIsNull);
    when(() => a = 'a', 'set a');
    and(() => b = 'b', 'set b');
    then(() => expect(a, 'a'), 'a is a');
    and(() => expect(b, 'b'), 'b is b');
  }));

  test('Test2', gwt(() {
    given(aIsNull);
    and(bIsNull);
    when(() => a = 'b');
    and(() => b = 'a');
    then(() => expect(a, 'b'));
    and(() => expect(b, 'a'));
  }));
}
