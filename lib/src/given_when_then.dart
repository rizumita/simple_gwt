// ignore_for_file: avoid_print

import 'dart:async';

import 'package:simple_gwt/src/keys.dart';
import 'package:simple_gwt/src/state.dart';

FutureOr<T> given<T>(String description, FutureOr<T> Function() body) {
  final givens = Zone.current[givenKey] as List<String>?;

  if (givens == null) throw Exception('Use gwt method');

  final state = Zone.current[stateKey] as State;
  state.key = givenKey;
  givens.add(description);

  final result = body();

  if (result is Future) {
    return Future.sync(() async => await result);
  } else {
    return result;
  }
}

FutureOr<T> when<T>(String description, FutureOr<T> Function() body) {
  final whens = Zone.current[whenKey] as List<String>?;

  if (whens == null) throw Exception('Use gwt method');

  final state = Zone.current[stateKey] as State;
  state.key = whenKey;
  whens.add(description);

  try {
    final result = body();
    if (result is Future) {
      return Future.sync(() async => await result);
    } else {
      return result;
    }
  } catch (e) {
    state.throwCount += 1;
    return Future(() {
      state.throwCount -= 1;
      // ignore: use_rethrow_when_possible
      throw e;
    });
  }
}

FutureOr<T> then<T>(String description, FutureOr<T> Function() body) {
  final thens = Zone.current[thenKey] as List<String>?;

  if (thens == null) throw Exception('Use gwt method');

  final state = Zone.current[stateKey] as State;
  state.key = thenKey;
  thens.add(description);

  final result = body();

  if (result is Future) {
    return Future.sync(() async => await result);
  } else {
    return result;
  }
}

FutureOr<T> and<T>(String description, FutureOr<T> Function() body) {
  final state = Zone.current[stateKey] as State?;

  if (state == null) {
    throw Exception('Use and method after given, when, whenThrows or then');
  }

  switch (state.key) {
    case givenKey:
      return given(description, body);
    case whenKey:
      return when(description, body);
    case thenKey:
      return then(description, body);
    case null:
      throw Exception('Use and method after given, when or then');
    default:
      throw UnimplementedError();
  }
}
