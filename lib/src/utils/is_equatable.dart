import 'package:equatable/equatable.dart';

bool isEquatable(dynamic value) {
  return [
    value is int,
    value is double,
    value is String,
    value is bool,
    value is List,
    value is Set,
    value is Map,
    value is Runes,
    value is Symbol,
    value == null,
    value is Enum,
    value is Iterable,
    value is Never,
    value is Equatable,
  ].reduce((v, e) {
    return v || e;
  });
}
