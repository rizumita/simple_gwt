// ignore_for_file: avoid_print

import 'dart:async';

import 'package:simple_gwt/src/gwt.dart';
import 'package:simple_gwt/src/keys.dart';
import 'package:simple_gwt/src/phase.dart';

dynamic Function() gwt(dynamic Function() body) {
  var givens = <GWT>[];
  var whens = <GWT>[];
  var thens = <GWT>[];
  final Map<Object?, Object?> zoneValues = {
    givenKey: givens,
    whenKey: whens,
    thenKey: thens,
    phaseKey: Phase(),
  };

  return () async {
    await runZoned(() async {
      await body();
    }, zoneValues: zoneValues);

    var descriptions = <String>[];

    try {
      await Future.forEach<MapEntry<int, GWT>>(givens.asMap().entries, (entry) async {
        final description = entry.value.description.isEmpty ? '#${entry.key + 1}' : entry.value.description;
        descriptions.add(entry.key == 0 ? 'Given $description' : '      ' + description);
        await entry.value.body();
      });
      await Future.forEach<MapEntry<int, GWT>>(whens.asMap().entries, (entry) async {
        final description = entry.value.description.isEmpty ? '#${entry.key + 1}' : entry.value.description;
        descriptions.add(entry.key == 0 ? 'When $description' : '     ' + description);
        await entry.value.body();
      });
      await Future.forEach<MapEntry<int, GWT>>(thens.asMap().entries, (entry) async {
        final description = entry.value.description.isEmpty ? '#${entry.key + 1}' : entry.value.description;
        descriptions.add(entry.key == 0 ? 'Then $description' : '     ' + description);
        await entry.value.body();
      });
    } catch (_) {
      for (var description in descriptions) {
        print(description);
      }
      rethrow;
    }
  };
}

Future Function(T) gwt_<T>(Future Function(T) body) {
  var givens = <GWT>[];
  var whens = <GWT>[];
  var thens = <GWT>[];
  final Map<Object?, Object?> zoneValues = {
    givenKey: givens,
    whenKey: whens,
    thenKey: thens,
    phaseKey: Phase(),
  };

  return (value) async {
    await runZoned(() async {
      await body(value);
    }, zoneValues: zoneValues);

    var descriptions = <String>[];

    try {
      await Future.forEach<MapEntry<int, GWT>>(givens.asMap().entries, (entry) async {
        final description = entry.value.description.isEmpty ? '#${entry.key + 1}' : entry.value.description;
        descriptions.add(entry.key == 0 ? 'Given $description' : '      ' + description);
        await entry.value.body();
      });
      await Future.forEach<MapEntry<int, GWT>>(whens.asMap().entries, (entry) async {
        final description = entry.value.description.isEmpty ? '#${entry.key + 1}' : entry.value.description;
        descriptions.add(entry.key == 0 ? 'When $description' : '     ' + description);
        await entry.value.body();
      });
      await Future.forEach<MapEntry<int, GWT>>(thens.asMap().entries, (entry) async {
        final description = entry.value.description.isEmpty ? '#${entry.key + 1}' : entry.value.description;
        descriptions.add(entry.key == 0 ? 'Then $description' : '     ' + description);
        await entry.value.body();
      });
    } catch (_) {
      for (var description in descriptions) {
        print(description);
      }
      rethrow;
    }
  };
}
