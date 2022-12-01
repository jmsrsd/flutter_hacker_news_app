import 'package:flutter/widgets.dart';

List<Widget> withSeparator({
  required Widget separator,
  required List<Widget> children,
}) {
  return children
      .map((e) => [separator, e])
      .reduce((v, e) => [...v, ...e])
      .sublist(1);
}
