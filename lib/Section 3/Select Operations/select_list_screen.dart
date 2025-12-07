
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_exercise/Section2/StateNotifierDemo/todo_example/todo_model.dart';
import '../../Section2/StateNotifierDemo/todo_example/todo_provider_controller.dart';

class CompareSelectSelect extends ConsumerWidget {
  const CompareSelectSelect({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final notifier = ref.read(todoListProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: Text('ref.watch vs ref.watch(...select...)'),),
      body: Row(
        children: [
          // Left watches whole list (no select)
          Expanded(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(8.0),
                  child: Text('Without Select (bad)'),
                ),
                Expanded(child: TodoListWithoutSelect()),
              ],
            )
          ),

          // Right Side: use Select (good)
          Expanded(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(8.0),
                  child: Text('With Select (god)'),
                ),
                Expanded(child: TodoListWithSelect()),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()=>notifier.add('New Task ${DateTime.now().second}'),
        label : Text('Add Todo'),
        icon: Icon(Icons.add),
      ),
    );
  }
}

class TodoListWithoutSelect extends ConsumerWidget {
  const TodoListWithoutSelect({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final todos = ref.watch(todoListProvider);
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (_, i) {
        final todo = todos[i];
        return TodoItemWithoutSelect(todo : todo);
      },
    );
  }
}

class TodoItemWithoutSelect extends ConsumerWidget {
  final TodoModel todo;
  const TodoItemWithoutSelect({required this.todo,super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final notifier = ref.read(todoListProvider.notifier);
    // print to see rebuild
    print('WithoutSelect: build item ${todo.id}');

    return ListTile(
      title: Text(todo.title),
      leading: Checkbox(
        value: todo.completed,
        onChanged: (_){
          notifier.update(id:todo.id,completed: !todo.completed);
        }
      ),
    );
  }
}

class TodoListWithSelect extends ConsumerWidget {
  const TodoListWithSelect({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    // it is read only single time and rebuild when list length would be changed.
    final todos = ref.watch(todoListProvider);
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (_, i) {
        final title = ref.read(todoListProvider)[i].title;
        final id = ref.read(todoListProvider)[i].id;
        return TodoItemWithSelect(todoId : id,title : title);
      },
    );
  }
}

class TodoItemWithSelect extends ConsumerWidget {
  final int todoId;
  final String title;
  const TodoItemWithSelect({required this.todoId,required this.title,super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final completed = ref.watch(
      todoListProvider.select((list){
        // this is runs on provider change, but the resulting bool is Completed with ==,
        // so widget rebuilds only when the bool toggles.
        final t = list.firstWhere((t)=> t.id == todoId);
        return t.completed;
      }),
    );
    // print to see rebuild
    print('WithSelect: build item ${todoId} - completed $completed');

    final notifier = ref.read(todoListProvider.notifier);
    
    return ListTile(
      title: Text(title),
      leading: Checkbox(
          value: completed,
          onChanged: (_){
            notifier.update(id:todoId,completed: !completed);
          }
      ),
    );
  }
}