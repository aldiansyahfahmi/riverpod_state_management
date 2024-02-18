import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'counter_provider.g.dart';

@riverpod
class CounterNotifier extends _$CounterNotifier {
  @override
  int build() => 0;

  increment() => state++;
  decrement() {
    if (state > 0) {
      state--;
    }
  }
}
