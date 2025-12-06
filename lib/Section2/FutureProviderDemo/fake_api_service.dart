import 'dart:async';
import 'dart:math';

class FakeService{
  Future<String> fetchGreeting({int? id}) async{
    await Future.delayed(const Duration(seconds: 2));

    // simulate the 30% chance of failure.
    if(Random().nextDouble() < 0.3){
      throw Exception('Failed to fetch greeting');
    }

    final value = 'Hello from Async';
    return id == null ? value : value + '$id';
  }
}