
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_exercise/Section2/FutureProviderDemo/fake_api_service.dart';

// Create a Future Provider

// Provide _ in parameter for no provide any parameter.
final fakeApiProvider = Provider((_)=>FakeService());

// with family you can also provide parameters
// it is use for getall and GetbyId
// whenever greetingFutureProvider is not use it automatically clear memory or dispose the state
final greetingFutureProvider = FutureProvider.autoDispose.family<String,int?>((Ref ref,id) async{
  final service = ref.read(fakeApiProvider);

  if(id != 0) return await service.fetchGreeting(id:id);

  return await service.fetchGreeting();
});

// UI Screen to display Future Data

// ConsumerWidget is StatelessWidget
class Greetingscreen extends ConsumerWidget {
  const Greetingscreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    // Watch Future Provider
    final greetingAsync = ref.watch(greetingFutureProvider(0));

    return Scaffold(
      appBar: AppBar(title: const Text('Async Greeting.'),),
      body: Center(
        child: greetingAsync.when(
          // when refresh at that time loader skip if true
          skipLoadingOnRefresh: false,
          data: (greeting) => Text(greeting ,style: const TextStyle(fontSize: 24)),
          error: (error,stackTrace) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Error: $error',style: const TextStyle(color: Colors.red),),
              const SizedBox(height: 12,),
              ElevatedButton(
                // it is re-run the a Provider and reset it's state.
                onPressed: () => ref.refresh(greetingFutureProvider(100)),
                child: const Text('Retry'),
              ),
            ],
          ),
          loading: () => CircularProgressIndicator(),
        ),
      ),
    );
  }
}
