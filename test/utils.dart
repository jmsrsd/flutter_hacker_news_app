import 'package:flutter_test/flutter_test.dart';

void runTests(Map tests) {
  final entries = List.of(tests.entries)..sort(_compareTest);

  for (final entry in entries) {
    _runTest(entry);
  }
}

void _runTest(MapEntry entry) {
  try {
    final entries = List.of((entry.value as Map).entries)..sort(_compareTest);

    group(entry.key, () {
      for (final e in entries) {
        _runTest(e);
      }
    });
  } catch (_) {
    test(entry.key, entry.value);
  }
}

int _compareTest(MapEntry a, MapEntry b) {
  return a.key.toString().compareTo(b.key.toString());
}
