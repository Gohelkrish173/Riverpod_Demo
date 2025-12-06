import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod_exercise/Section2/StateNotifierDemo/todo_example/todo_model.dart';
import 'package:riverpod_exercise/Section2/StateNotifierDemo/todo_example/todo_provider_controller.dart';

// number Provider
final numberProvider = StateProvider<List<int>>((_){
  return [1,2,3,4,5];
});

// Derived State
// it is Depend On Other Providers for Generate Values
final sumProvider = Provider<int>((Ref ref){
  final list = ref.watch(numberProvider);
  int sum = list.reduce((a,b)=>a+b);
  //or
  // int sum2 = list.fold(0, (total , n)=> total + n);
  return sum;
});

// Example 2 This is Example of Computed State and Derived State Provider
// In Computed State Means value Comes form two providers and then return it.
final todoListProvider = StateNotifierProvider<TodoListNotifier,List<TodoModel>>(
    (ref) => TodoListNotifier([]),
);

final filterTextProvider = StateProvider<String>((_) => '');

final filterTodosProvider = Provider<List<TodoModel>>((Ref ref){
  // for continues watching todoListPRovider therefore if any change in
  // todoListProvider then it auto Change in Screen.
  final todos = ref.watch(todoListProvider);
  final filter = ref.watch(filterTextProvider);

  if(filter.isEmpty){
    return todos;
  }

  return todos.where((t)=>t.title.toLowerCase().contains(filter.toLowerCase())).toList();
});