// ignore_for_file: avoid_print

import 'dart:async';

import 'package:simple_gwt/src/gwt.dart';
import 'package:simple_gwt/src/keys.dart';
import 'package:simple_gwt/src/phase.dart';

void given(String description, dynamic Function() body) {
  final givens = Zone.current[givenKey] as List<GWT>?;

  if (givens == null) {
    throw Exception('Use testGWT method');
  } else {
    (Zone.current[phaseKey] as Phase).key = givenKey;
    givens.add(GWT(description, body));
  }
}

void when(String description, dynamic Function() body) {
  final whens = Zone.current[whenKey] as List<GWT>?;

  if (whens == null) {
    throw Exception('Use testGWT method');
  } else {
    (Zone.current[phaseKey] as Phase).key = whenKey;
    whens.add(GWT(description, body));
  }
}

void then(String description, dynamic Function() body) {
  final thens = Zone.current[thenKey] as List<GWT>?;

  if (thens == null) {
    throw Exception('Use testGWT method');
  } else {
    (Zone.current[phaseKey] as Phase).key = thenKey;
    thens.add(GWT(description, body));
  }
}

void and(String description, dynamic Function() body) {
  switch ((Zone.current[phaseKey] as Phase).key) {
    case givenKey:
      given(description, body);
      break;
    case whenKey:
      when(description, body);
      break;
    case thenKey:
      then(description, body);
      break;
  }
}
