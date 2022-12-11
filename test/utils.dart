import 'package:flutter_test/flutter_test.dart';

void runTests(Map tests) {
  for (final t in tests.entries) {
    runTest(t);
  }
}

void runTest(MapEntry t) {
  try {
    group(t.key, () {
      for (final g in (t.value as Map).entries) {
        runTest(g);
      }
    });
  } catch (_) {
    test(t.key, t.value);
  }
}
