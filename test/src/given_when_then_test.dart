import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:simple_gwt/src/given_when_then.dart';
import 'package:simple_gwt/src/keys.dart';
import 'package:simple_gwt/src/test_gwt.dart';

void main() {
  group('given', () {
    test('Throws an exception when not using gwt method',
        () => expect(() => given('Exception', () {}), throwsException));

    test('Executes body and store description', gwt(() {
      var a = 0;
      var b = 0;

      given('First', () => a = 1);
      given('Second', () => b = 1);

      expect(a, 1);
      expect(b, 1);
      List<String> givens = Zone.current[givenKey];
      expect(givens, ['First', 'Second']);
    }));

    test('Executes async body', gwt(() async {
      var a = 0;

      await given(
          'First',
          () => Future.delayed(const Duration(milliseconds: 500), (() {
                a = 1;
              })));
      given('Second', () => a = 2);

      expect(a, 2);
      List<String> givens = Zone.current[givenKey];
      expect(givens, ['First', 'Second']);
    }));
  });

  group('when', () {
    test('Throws an exception when not using gwt method',
        () => expect(() => when('Exception', () {}), throwsException));

    test('Executes body and store description', gwt(() {
      var a = 0;
      var b = 0;

      when('First', () => a = 1);
      when('Second', () => b = 1);

      expect(a, 1);
      expect(b, 1);
      List<String> whens = Zone.current[whenKey];
      expect(whens, ['First', 'Second']);
    }));

    test('Executes async body', gwt(() async {
      var a = 0;

      await when(
          'First',
          () => Future.delayed(const Duration(milliseconds: 500), (() {
                a = 1;
              })));
      when('Second', () => a = 2);

      expect(a, 2);
      List<String> whens = Zone.current[whenKey];
      expect(whens, ['First', 'Second']);
    }));
  });

  group('then', () {
    test('Throws an exception when not using gwt method',
        () => expect(() => then('Exception', () {}), throwsException));

    test('Executes body and store description', gwt(() {
      var a = 0;
      var b = 0;

      then('First', () => a = 1);
      then('Second', () => b = 1);

      expect(a, 1);
      expect(b, 1);
      List<String> thens = Zone.current[thenKey];
      expect(thens, ['First', 'Second']);
    }));

    test('Executes async body', gwt(() async {
      var a = 0;

      await then(
          'First',
          () => Future.delayed(const Duration(milliseconds: 500), (() {
                a = 1;
              })));
      then('Second', () => a = 2);

      expect(a, 2);
      List<String> thens = Zone.current[thenKey];
      expect(thens, ['First', 'Second']);
    }));
  });

  group('and', () {
    test('Throws an exception when not using gwt method',
        gwt(() => expect(() => and('Exception', () {}), throwsException)));

    test('Executes body and store description', gwt(() {
      var a = 0;
      var b = 0;

      given('First given', () => a = 1);
      and('First and', () => b = 1);
      expect(a, 1);
      expect(b, 1);

      when('First when', () => a = 2);
      and('Second and', () => b = 2);
      expect(a, 2);
      expect(b, 2);

      then('First then', () => a = 3);
      and('Third and', () => b = 3);
      expect(a, 3);
      expect(b, 3);

      List<String> givens = Zone.current[givenKey];
      expect(givens, ['First given', 'First and']);
      List<String> whens = Zone.current[whenKey];
      expect(whens, ['First when', 'Second and']);
      List<String> thens = Zone.current[thenKey];
      expect(thens, ['First then', 'Third and']);
    }));

    test('Executes async body', gwt(() async {
      var a = 0;
      var b = 0;

      given('First given', () => a = 1);
      await and('First and',
          () => Future.delayed(const Duration(milliseconds: 100), () => b = 1));
      expect(a, 1);
      expect(b, 1);

      when('First when', () => a = 2);
      await and('Second and',
          () => Future.delayed(const Duration(milliseconds: 100), () => b = 2));
      expect(a, 2);
      expect(b, 2);

      then('First then', () => a = 3);
      await and('Third and',
          () => Future.delayed(const Duration(milliseconds: 100), () => b = 3));
      expect(a, 3);
      expect(b, 3);

      List<String> givens = Zone.current[givenKey];
      expect(givens, ['First given', 'First and']);
      List<String> whens = Zone.current[whenKey];
      expect(whens, ['First when', 'Second and']);
      List<String> thens = Zone.current[thenKey];
      expect(thens, ['First then', 'Third and']);
    }));
  });
}