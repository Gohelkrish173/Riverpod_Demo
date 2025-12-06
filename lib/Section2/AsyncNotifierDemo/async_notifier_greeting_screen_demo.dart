
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_exercise/Section2/AsyncNotifierDemo/async_notifier.dart';

class AsyncNotifierGreetingScreenDemo extends ConsumerWidget{
  const AsyncNotifierGreetingScreenDemo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final greetingAsync = ref.watch(greetingAsyncNotifierProvider);
    final notifier = ref.watch(greetingAsyncNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text('Async Notifier Demo')),
      body: Center(child: greetingAsync.when(
          data: (data) => Text(data,style: TextStyle(fontSize: 24),),
          error: (e,StackTrace) => Text('Error : $e',style: TextStyle(color: Colors.red,fontSize: 16),),
          loading: () => CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          notifier.refreshGreeting();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

}