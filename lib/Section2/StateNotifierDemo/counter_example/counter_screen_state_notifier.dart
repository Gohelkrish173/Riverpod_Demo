import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_exercise/Section2/StateNotifierDemo/counter_example/counter_provider_controller.dart';

// UI

class CounterScreen_StateNotifier extends ConsumerWidget {
  const CounterScreen_StateNotifier({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final count = ref.watch(counterProvider);
    final ctrl = ref.read(counterProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: Text("Counter Notifier"),),
      body: Center(child: Text('Count : $count',style: TextStyle(fontSize: 32))),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(onPressed: ctrl.decrement,heroTag: 'dec',child: Icon(Icons.remove)),
          SizedBox(width: 12,),
          FloatingActionButton(onPressed: ctrl.increment,heroTag: 'inc',child: Icon(Icons.add)),
          SizedBox(width: 12,),
          FloatingActionButton(onPressed: ctrl.reset,heroTag: 'Reset',child: Icon(Icons.refresh)),
        ],
      ),
    );
  }
}
