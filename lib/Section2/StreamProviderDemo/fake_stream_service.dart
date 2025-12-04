
import 'package:flutter_riverpod/flutter_riverpod.dart';

final timerServiceProvider = Provider((_)=>TimerService());

class TimerService{

  //Emits an Integer every Second, starting at 0
  Stream<int> tick(){
    return Stream.periodic(const Duration(seconds: 9), (count)=> count);
  }

  // In TimerService
  // when you use Stream you want to use async with * => async*
  Stream<int> tickWithError() async*{
    for(int i=0;i<5;i++){
      await Future.delayed(const Duration(seconds: 1));
      // here yield is use for return the stream value.
      yield i;
    }
    throw Exception("Timer Stopped Unexpectedly.");
  }
}