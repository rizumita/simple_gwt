// ignore_for_file: avoid_print

import 'dart:async';

import 'package:simple_gwt/src/keys.dart';
import 'package:simple_gwt/src/phase.dart';

FutureOr<void> given(String description, dynamic Function() body) async {
  final givens = Zone.current[givenKey] as List<String>?;

  if (givens == null) {
    throw Exception('Use gwt method');
  } else {
    (Zone.current[phaseKey] as Phase).key = givenKey;
    givens.add(description);
    await body();
  }
}

FutureOr<void> when(String description, dynamic Function() body) async {
  final whens = Zone.current[whenKey] as List<String>?;

  if (whens == null) {
    throw Exception('Use gwt method');
  } else {
    (Zone.current[phaseKey] as Phase).key = whenKey;
    whens.add(description);
    await body();
  }
}

FutureOr<void> then(String description, dynamic Function() body) async {
  final thens = Zone.current[thenKey] as List<String>?;

  if (thens == null) {
    throw Exception('Use gwt method');
  } else {
    (Zone.current[phaseKey] as Phase).key = thenKey;
    thens.add(description);
    await body();
  }
}

FutureOr<void> and(String description, dynamic Function() body) async {
  final phase = Zone.current[phaseKey] as Phase;

  switch (phase.key) {
    case givenKey:
      await given(description, body);
      break;
    case whenKey:
      await when(description, body);
      break;
    case thenKey:
      await then(description, body);
      break;
    case null:
      throw Exception('Use and method after given, when or then');
  }
}
