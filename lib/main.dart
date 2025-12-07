import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_exercise/Faculty_CRUD_Using_RiverPod/Screens/faculty_list_screen.dart';
import 'package:riverpod_exercise/Section%203/Computed%20And%20Derieved%20Providers/computed_derived_filter_screen.dart';
import 'package:riverpod_exercise/Section%203/Computed%20And%20Derieved%20Providers/derived_screen.dart';
import 'package:riverpod_exercise/Section%203/Select%20Operations/select_list_screen.dart';
import 'package:riverpod_exercise/Section%203/Select%20Operations/select_simple_demo.dart';
import 'package:riverpod_exercise/Section2/AsyncNotifierDemo/async_notifier_greeting_screen_demo.dart';
import 'package:riverpod_exercise/Section2/FutureProviderDemo/StudentData_Using_FutureProvider.dart';
import 'package:riverpod_exercise/Section2/FutureProviderDemo/foodData_using_FutureProvider.dart';
import 'package:riverpod_exercise/Section2/FutureProviderDemo/greetingScreen.dart';
import 'package:riverpod_exercise/Section2/StateNotifierDemo/counter_example/counter_screen_state_notifier.dart';
import 'package:riverpod_exercise/Section2/StateNotifierDemo/student_api_example/student_crud_using_state_notifier.dart';
import 'package:riverpod_exercise/Section2/StateNotifierDemo/todo_example/todo_screen_using_state_notifier_provider.dart';
import 'package:riverpod_exercise/Section2/StreamProviderDemo/timer_screen_using_stream_provider.dart';
import 'Section1/RiverPod_StateFul_Widget/stateful_animation_screen.dart';

void main() {
  runApp(ProviderScope(child: MaterialApp(home: const MyApp(),)));
}

final staticProvider = Provider((Ref ref){
  return 'Hello World!';
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    // Section 1

    // final SP = ref.watch(staticProvider);
    
    // return Scaffold(
    //   body: Center(
    //     child: Text(SP),
    //   ),
    // );

    // return StateProviderDemo();

    // return Riverpod_Stateful_Widget();
    // return StateFul_Animation_Screen();

    // Section 2

    // return Greetingscreen();
    // return FoodData_Using_FutureProvider();
    // return StudentData_FutureProvider();

    // return TimerScreen_Using_StreamProvider();

    // return CounterScreen_StateNotifier();
    // return TodoScreen_Using_StateNotifier();
    // return StudentCrudUsingStateNotifier();

   // return AsyncNotifierGreetingScreenDemo();

   // Section 3

    // return SumScreen();
    // return FilterScreen();

    // return SimpleSelectDemo();
    // return CompareSelectSelect();

    // Faculty CRUD Operation
    return FacultyListScreen();
  }
}
