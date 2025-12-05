
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final counterProvider = StateNotifierProvider<CounterNotifier,int>((_){
  return CounterNotifier(0);
});

class CounterNotifier extends StateNotifier<int>{
  CounterNotifier(super.state);

  void increment() => state++;
  void decrement() => state--;
  void reset() =>  state = 0;
}