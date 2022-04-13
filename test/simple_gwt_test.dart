import 'package:flutter_test/flutter_test.dart';
import 'package:simple_gwt/simple_gwt.dart';

void main() {
  String? a;
  String? b;

  nullifyA() => a = null;
  nullifyB() => b = null;

  testGWT('Test1', () {
    given(nullifyA, 'A is null');
    and(nullifyB, 'B is null');
    when(() => a = 'a', 'set a');
    and(() => b = 'b', 'set b');
    then(() => expect(a, 'a'), 'a is a');
    and(() => expect(b, 'b'), 'b is b');
  });

  testGWT('Test2', () {
    given(nullifyA);
    and(nullifyB);
    when(() => a = 'b');
    and(() => b = 'a');
    then(() => expect(a, 'b'));
    and(() => expect(b, 'a'));
  });
}
