
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_exercise/Section2/StateNotifierDemo/todo_example/todo_provider_controller.dart';

class TodoScreen_Using_StateNotifier extends ConsumerStatefulWidget {
  const TodoScreen_Using_StateNotifier({super.key});

  @override
  ConsumerState<TodoScreen_Using_StateNotifier> createState() => _TodoScreen_Using_StateNotifierState();
}

class _TodoScreen_Using_StateNotifierState extends ConsumerState<TodoScreen_Using_StateNotifier> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoListProvider);
    final notifier = ref.read(todoListProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text('Todo List'),),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Add todo
            Row(
              children: [
                Expanded(child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(labelText: "new Task"),
                  ),
                ),
                IconButton(
                  onPressed: (){
                    final text = _controller.text.trim();
                    if(text.isNotEmpty){
                      notifier.add(text);
                      _controller.clear();
                    }
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),

            SizedBox(height: 16,),

            // List Todo
            Expanded(child: ListView.builder(
                itemBuilder: (_,i){
                  final todo  = todos[i];
                  return ListTile(
                    leading: Checkbox(
                        value: todo.completed,
                        onChanged: (_) => notifier.update(id: todo.id,completed: !todo.completed)
                    ),
                    title: Row(
                      children: [
                        Text(
                          todo.title,
                          style: TextStyle(
                            decoration: todo.completed
                            ? TextDecoration.lineThrough :
                               TextDecoration.none
                          ),
                        ),
                        SizedBox(width: 10,),
                        IconButton(
                          onPressed: () => notifier.remove(todo.id),
                          icon: Icon(Icons.delete)
                        ),
                      ],
                    ),
                  );
                },
                itemCount: todos.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
