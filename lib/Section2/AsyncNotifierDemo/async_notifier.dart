
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_exercise/Section2/FutureProviderDemo/greetingScreen.dart';

// in <> first is AsyncNotifierClass And second is Return type
final greetingAsyncNotifierProvider = AsyncNotifierProvider<GreetingAsyncNotifier,String>(
    (){
      return GreetingAsyncNotifier();
    }
);

// when you use future with AsyncNotifier add parameter type after return type like given below
final greetingAsyncNotifierProvider2 = AsyncNotifierProvider.autoDispose.family<GreetingAsyncNotifier,String,int>(
    (id){
      return GreetingAsyncNotifier();
    }
);

class GreetingAsyncNotifier extends AsyncNotifier<String>{

  @override
  FutureOr<String> build() async{
    return await ref.read(fakeApiProvider).fetchGreeting();
  }

  Future<void> refreshGreeting() async{
    // try{
    //   final oldData = state.value ?? '';
    //   state = const AsyncValue.loading();
    //
    //   final value = await ref.read(fakeApiProvider).fetchGreeting();
    //   // AsyncValue is Wrapper Class And AsyncData is Subclass of AsyncValue
    //   state = AsyncValue.data(value);
    // }catch(e){
    //   state = AsyncValue.error(e, StackTrace.current);
    // }

    // or

    // Write the one Line Only insted of Above try Catch Block Code
    // It's The Short and Fastest Use OF AsyncNotifier

    state = await AsyncValue.guard(()=> ref.read(fakeApiProvider).fetchGreeting(id:10));
  }

}