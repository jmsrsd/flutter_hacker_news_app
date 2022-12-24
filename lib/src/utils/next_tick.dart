import 'delay.dart';

Future<void> nextTick() async {
  return await delay(1);
}
