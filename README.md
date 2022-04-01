# Simple Given When Then

The simple_gwt package is to write tests in the 'Given When Then' style.

## Features

- Given When Then style test functions

## Getting started

```bash
flutter pub add -d simple_gwt
```

## Usage

```dart
testGWT('Test1', () {
  given('A is null', () => a = null);
  when('set a', () => a = 'a');
  then('a is a', () => expect(a, 'a'));
});
```
