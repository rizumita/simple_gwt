# Simple Given When Then

The simple_gwt package is to write tests in the 'Given When Then' style.

## Features

- Given When Then style test functions

## Getting started

Add the simple_gwh package to dev_dependencies in pubspec.yaml.

## Usage

```dart
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
}
```
