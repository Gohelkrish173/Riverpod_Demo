
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod_exercise/Section2/StateNotifierDemo/todo_example/todo_model.dart';

final simpleSelectProvider = StateProvider((ref)=>TodoModel(id: 1, title: "Cricket Playing", completed: false));

class SimpleSelectDemo extends ConsumerWidget {
  const SimpleSelectDemo({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final completed = ref.watch(simpleSelectProvider.select((t)=>t.completed));
    final title = ref.watch(simpleSelectProvider).title;
    print('Rebuild');
    return Scaffold(
      appBar: AppBar(title: Text('Simple Select Demo'),),
      body: Column(
        children: [
          Text("With Select",style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(height: 8,),
          Text('Title (read) : ${title}'),
          SizedBox(height: 6,),
          Row(
            children: [
              Text('Completed:'),
              SizedBox(width: 8,),
              Checkbox(value: completed, onChanged: (_){
                final t = ref.read(simpleSelectProvider);
                ref.read(simpleSelectProvider.notifier).state = t.copyWith(completed: !t.completed);
              }),
              Checkbox(value: completed, onChanged: (_){
                final t = ref.read(simpleSelectProvider);
                ref.read(simpleSelectProvider.notifier).state = t.copyWith(title: "Football Playing");
              }),
            ],
          )
        ],
      ),
    );
  }
}
