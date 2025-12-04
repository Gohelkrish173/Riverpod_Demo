import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_exercise/Section2/StreamProviderDemo/fake_stream_service.dart';

// Create StreamProvider
final tickerProvider = StreamProvider((Ref ref){
  return Stream.periodic(const Duration(seconds: 1), (count) => count);
});

// ticker which tick at every 10 seconds
final tickerProvider2 = StreamProvider((Ref ref){
  final service = ref.read(timerServiceProvider);
  return service.tick();
});

// ticker with Error
final ticker_with_error_provider = StreamProvider((Ref ref) {
  final service = ref.read(timerServiceProvider);
  return service.tickWithError();
});

// UI

// ConsumerWidget is StatelessWidget
class TimerScreen_Using_StreamProvider extends ConsumerWidget {
  const TimerScreen_Using_StreamProvider({super.key});
  
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final tickAsync = ref.watch(tickerProvider);
    final tickAsync10sec = ref.watch(tickerProvider2);
    final tickAsyncWithError = ref.watch(ticker_with_error_provider);

    return Scaffold(
      appBar: AppBar(title: Text('Live Timer'),),
      body: Column(
        children: [
          Center(
            child: tickAsync.when(
              data: (count)=> Text(
                'Seconds elapsed: ${count}',
                style: const TextStyle(fontSize: 32),
              ),
              error: (e , _) => Text("Error: ${e}"),
              loading: () => const CircularProgressIndicator(),
            ),
          ),
          SizedBox(height: 10,),
          Center(
            child: tickAsync10sec.when(
              data: (count) => Text("Tick Every 10 sec : ${count}",
                style: TextStyle(fontSize: 32,color: Colors.red),
              ),
              error: (e,_) => Text("$e",style: TextStyle(fontSize: 16),),
              loading: () => const CircularProgressIndicator(),
            ),
          ),
          SizedBox(height: 10,),
          Center(
            child: tickAsyncWithError.when(
              data: (count) => Text("Tick With Error : ${count}",
                style: TextStyle(fontSize: 32,color: Colors.red),
              ),
              error: (e,_) => Text("$e",style: TextStyle(fontSize: 16),),
              loading: () => const CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
