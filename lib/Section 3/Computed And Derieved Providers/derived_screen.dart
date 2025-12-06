
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_exercise/Section%203/Computed%20And%20Derieved%20Providers/derived_providers.dart';

class SumScreen extends ConsumerWidget {
  const SumScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final sum = ref.watch(sumProvider);
    return Scaffold(
      appBar: AppBar(title: Text("Sum Calculator"),),
      body: Center(child: Text("Total = $sum",style: TextStyle(fontSize: 32),),),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          final list = ref.read(numberProvider.notifier).state;
          ref.read(numberProvider.notifier).state = [...list,list.length+1];
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
