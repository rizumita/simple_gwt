// ignore_for_file: avoid_print

import 'dart:async';

import 'package:simple_gwt/src/keys.dart';
import 'package:simple_gwt/src/state.dart';

/// Prepares unit testing environment for [given]/[when]/[then] methods
///
/// An exception will be thrown if you don't wrap a test body by this.
///
/// Example:
/// ```dart
/// test('My test', gwt(() {
///   given(...);
///   when(...);
///   then(...);
/// }));
/// ```
dynamic Function() gwt(dynamic Function() body) {
  var givens = <String>[];
  var whens = <String>[];
  var thens = <String>[];
  final state = State();
  final Map<Object?, Object?> zoneValues = {
    givenKey: givens,
    whenKey: whens,
    thenKey: thens,
    stateKey: state,
  };

  return () async {
    await runZoned(() async {
      try {
        await body();
      } catch (_) {
        var descriptions = <String>[];
        for (final entry in givens.asMap().entries) {
          final description =
              entry.value.isEmpty ? '#${entry.key + 1}' : entry.value;
          descriptions.add(
              entry.key == 0 ? 'Given $description' : '      $description');
        }
        for (var entry in whens.asMap().entries) {
          final description =
              entry.value.isEmpty ? '#${entry.key + 1}' : entry.value;
          descriptions
              .add(entry.key == 0 ? 'When $description' : '     $description');
        }
        for (var entry in thens.asMap().entries) {
          final description =
              entry.value.isEmpty ? '#${entry.key + 1}' : entry.value;
          descriptions
              .add(entry.key == 0 ? 'Then $description' : '     $description');
        }
        for (var description in descriptions) {
          print(description);
        }
        rethrow;
      }

      if (state.throwCount == 1) {
        throw Exception('Unchecked error remains.');
      } else if (state.throwCount >= 2) {
        throw Exception('Unchecked ${state.throwCount} errors remain.');
      }
    }, zoneValues: zoneValues);
  };
}

/// Prepares widget testing environment for [given]/[when]/[then] methods
///
/// An exception will be thrown if you don't wrap a test body by this.
///
/// Example:
/// ```dart
/// testWidgets('My test', gwt_((tester) async {
///   given(...);
///   when(...);
///   then(...);
/// }));
/// ```
Future Function(T) gwt_<T>(Future Function(T) body) {
  var givens = <String>[];
  var whens = <String>[];
  var thens = <String>[];
  final Map<Object?, Object?> zoneValues = {
    givenKey: givens,
    whenKey: whens,
    thenKey: thens,
    stateKey: State(),
  };

  return (value) async {
    await runZoned(() async {
      await body(value);
    }, zoneValues: zoneValues);

    var descriptions = <String>[];

    try {
      for (final entry in givens.asMap().entries) {
        final description =
            entry.value.isEmpty ? '#${entry.key + 1}' : entry.value;
        descriptions
            .add(entry.key == 0 ? 'Given $description' : '      $description');
      }
      for (var entry in whens.asMap().entries) {
        final description =
            entry.value.isEmpty ? '#${entry.key + 1}' : entry.value;
        descriptions
            .add(entry.key == 0 ? 'When $description' : '     $description');
      }
      for (var entry in thens.asMap().entries) {
        final description =
            entry.value.isEmpty ? '#${entry.key + 1}' : entry.value;
        descriptions
            .add(entry.key == 0 ? 'Then $description' : '     $description');
      }
    } catch (_) {
      for (var description in descriptions) {
        print(description);
      }
      rethrow;
    }
  };
}
