
import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod_exercise/Section2/StateNotifierDemo/todo_example/todo_model.dart';

// StateNotifier Provider

final todoListProvider = StateNotifierProvider<TodoListNotifier,List<TodoModel>>(
        (ref)=>TodoListNotifier([]),
);

// Class

class TodoListNotifier extends StateNotifier<List<TodoModel>>{
  TodoListNotifier(super.state);

  void add(String title){
    final newTodo = TodoModel(
      id: state.isEmpty ? 0 : state.last.id + 1,
      title: title,
      completed: false
    );

    state = [...state,newTodo];
  }

  void remove(int id){
    state = state.where((t)=>t.id != id).toList();
  }

  void update({int? id, String? title, bool? completed}){
    final todos = [...state];

    final index = todos.indexWhere((t)=>t.id == id);

    if(index == -1) return;

    final todo = todos[index];

    todos[index] = todo.copyWith(title: title,completed: completed);

    state = todos;
  }
}