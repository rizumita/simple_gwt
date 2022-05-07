// ignore_for_file: avoid_print

import 'dart:async';

import 'package:simple_gwt/src/keys.dart';
import 'package:simple_gwt/src/state.dart';

FutureOr<void> given(String description, dynamic Function() body) async {
  final givens = Zone.current[givenKey] as List<String>?;

  if (givens == null) throw Exception('Use gwt method');

  (Zone.current[stateKey] as State).key = givenKey;
  givens.add(description);
  await body();
}

FutureOr<void> when(String description, dynamic Function() body) async {
  final whens = Zone.current[whenKey] as List<String>?;

  if (whens == null) throw Exception('Use gwt method');

  (Zone.current[stateKey] as State).key = whenKey;
  whens.add(description);
  await body();
}

FutureOr<void> Function() whenThrows(
    String description, dynamic Function() body) {
  final whens = Zone.current[whenKey] as List<String>?;

  if (whens == null) throw Exception('Use gwt method');

  final state = Zone.current[stateKey] as State;
  state.key = whenKey;
  state.whenThrowsCount += 1;
  whens.add(description);

  return () async {
    state.whenThrowsCount -= 1;
    return await body();
  };
}

FutureOr<void> then(String description, dynamic Function() body) async {
  final thens = Zone.current[thenKey] as List<String>?;

  if (thens == null) throw Exception('Use gwt method');

  (Zone.current[stateKey] as State).key = thenKey;
  thens.add(description);
  await body();
}

FutureOr<void> and(String description, dynamic Function() body) async {
  final state = Zone.current[stateKey] as State?;

  if (state == null) {
    throw Exception('Use and method after given, when, whenThrows or then');
  }

  switch (state.key) {
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

FutureOr<void> Function() andThrows(
  String description,
  dynamic Function() body,
) {
  final state = Zone.current[stateKey] as State?;

  if (state == null) {
    throw Exception('Use andThrows method after when or whenThrows');
  }

  switch (state.key) {
    case whenKey:
      return whenThrows(description, body);
    default:
      throw Exception('Use andThrows method after when or whenThrows');
  }
}
