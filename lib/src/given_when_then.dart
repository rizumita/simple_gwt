// ignore_for_file: avoid_print

import 'dart:async';

import 'package:simple_gwt/src/gwt.dart';
import 'package:simple_gwt/src/keys.dart';
import 'package:simple_gwt/src/phase.dart';

void given(dynamic Function() body, [String description = '']) {
  final givens = Zone.current[givenKey] as List<GWT>?;

  if (givens == null) {
    throw Exception('Use testGWT method');
  } else {
    (Zone.current[phaseKey] as Phase).key = givenKey;
    givens.add(GWT(description, body));
  }
}

void when(dynamic Function() body, [String description = '']) {
  final whens = Zone.current[whenKey] as List<GWT>?;

  if (whens == null) {
    throw Exception('Use testGWT method');
  } else {
    (Zone.current[phaseKey] as Phase).key = whenKey;
    whens.add(GWT(description, body));
  }
}

void then(dynamic Function() body, [String description = '']) {
  final thens = Zone.current[thenKey] as List<GWT>?;

  if (thens == null) {
    throw Exception('Use testGWT method');
  } else {
    (Zone.current[phaseKey] as Phase).key = thenKey;
    thens.add(GWT(description, body));
  }
}

void and(dynamic Function() body, [String description = '']) {
  switch ((Zone.current[phaseKey] as Phase).key) {
    case givenKey:
      given(body, description);
      break;
    case whenKey:
      when(body, description);
      break;
    case thenKey:
      then(body, description);
      break;
  }
}
