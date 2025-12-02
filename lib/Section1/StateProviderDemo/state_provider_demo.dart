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
    print("Build method Loaded.");
    return Scaffold(
      appBar: AppBar(title: Text('State Provider Tutorial.'),),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(onPressed: () {
            // here notifier is provide the state Controll. state++ update the count +1 of stateProvider.
            ref.read(counterProvider.notifier).state++;
          },
              icon: Icon(Icons.add)
          ),
          SizedBox(width: 10,),
          IconButton(onPressed: () {
            // here notifier is provide the state Controll. state-- update the count -1 of stateProvider.
            ref.read(counterProvider.notifier).state--;
          },
              icon: Icon(Icons.exposure_minus_1)
          ),
        ],
      ),
      body: Center(
        // it's use for update only part of updated StateProviders and UI.
        // it does not update whole build when state updated.
        child : Consumer(
          builder: (BuildContext context,WidgetRef ref,Widget? child){
            // use counterProvider
            final counter = ref.watch(counterProvider);
            print("Consumer method Loaded.");
            return Text(counter.toString());
          },
        ),
      ),
    );
  }
}
