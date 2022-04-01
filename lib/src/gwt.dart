import 'dart:async';

class GWT {
  GWT(this.description, this.body);

  final FutureOr Function() body;
  final String description;
}
