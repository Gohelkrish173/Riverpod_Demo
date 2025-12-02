import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// Counter Provider

final counterProvider = StateProvider((Ref ref){
  return 0;
});

class StateProviderDemo extends ConsumerWidget {
  const StateProviderDemo({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    // use counterProvider
    final counter = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(title: Text('State Provider Tutorial.'),),
      floatingActionButton: IconButton(onPressed: () {}, icon: Icon(Icons.add)),
      body: Center(child: Text('0'),),
    );
  }
}
