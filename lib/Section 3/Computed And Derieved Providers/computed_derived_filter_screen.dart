
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_exercise/Section%203/Computed%20And%20Derieved%20Providers/computed_derived_providers.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final todos = ref.watch(filterTodosProvider);
    final notifier = ref.watch(todoListProvider.notifier);

    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: (){
          final text1 = 'Cricket Playing';
          final text2 = 'Football Playing';
          final text3 = 'Badminton Playing';
          notifier.add(text1);
          notifier.add(text2);
          notifier.add(text3);
        },
        icon: Icon(Icons.add),
      ),
      appBar: AppBar(title: Text("Filter Screen"),),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: const InputDecoration(labelText: 'Search'),
              onChanged: (t)=>ref.read(filterTextProvider.notifier).state = t,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (_, i) {
                final todo = todos[i];
                return ListTile(
                  leading: Checkbox(value: todo.completed,
                    onChanged: (t)=>notifier.update(id: todo.id,completed: !todo.completed),
                  ),
                  title: Text(todo.title,style: TextStyle(color: Colors.orange,fontSize: 16),),
                  trailing: IconButton(
                    onPressed: (){
                      notifier.remove(todo.id);
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
