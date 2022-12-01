import 'dart:async';

FutureOr<void> uncatch(FutureOr<void> Function() fn) async {
  try {
    await fn();
  } catch (e) {
    e;
  }
}
