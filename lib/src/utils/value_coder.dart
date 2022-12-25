class ValueCoder<T> {
  final String Function(T decoded) encode;
  final T Function(String encoded) decode;

  ValueCoder({
    required this.encode,
    required this.decode,
  });
}
