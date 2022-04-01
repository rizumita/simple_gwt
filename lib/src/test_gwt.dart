// ignore_for_file: avoid_print

import 'dart:async';

import 'package:meta/meta.dart';
import 'package:simple_gwt/src/gwt.dart';
import 'package:simple_gwt/src/keys.dart';
import 'package:test/test.dart';

dynamic Function() gwt(dynamic Function() body) {
  var givens = <GWT>[];
  var whens = <GWT>[];
  var thens = <GWT>[];
  final zoneValues = {
    givenKey: givens,
    whenKey: whens,
    thenKey: thens,
  };

  return () async {
    await runZoned(() async {
      await body();
    }, zoneValues: zoneValues);

    var descriptions = <String>[];

    try {
      await Future.forEach<MapEntry<int, GWT>>(givens.asMap().entries, (entry) async {
        descriptions.add(entry.key == 0 ? 'Given ${entry.value.description}' : '      ' + entry.value.description);
        await entry.value.body();
      });
      await Future.forEach<MapEntry<int, GWT>>(whens.asMap().entries, (entry) async {
        descriptions.add(entry.key == 0 ? 'When ${entry.value.description}' : '     ' + entry.value.description);
        await entry.value.body();
      });
      await Future.forEach<MapEntry<int, GWT>>(thens.asMap().entries, (entry) async {
        descriptions.add(entry.key == 0 ? 'Then ${entry.value.description}' : '     ' + entry.value.description);
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

@isTest
void testGWT(
  Object description,
  dynamic Function() body, {
  String? testOn,
  Timeout? timeout,
  dynamic skip,
  dynamic tags,
  Map<String, dynamic>? onPlatform,
  int? retry,
}) {
  test(
    description,
    gwt(body),
    testOn: testOn,
    timeout: timeout,
    skip: skip,
    onPlatform: onPlatform,
    tags: tags,
    retry: retry,
  );
}
