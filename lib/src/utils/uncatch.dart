import 'dart:async';

FutureOr<void> uncatch(FutureOr<void> Function() callback) async {
  try {
    await callback();
  } catch (e) {
    return null;
  }
}
