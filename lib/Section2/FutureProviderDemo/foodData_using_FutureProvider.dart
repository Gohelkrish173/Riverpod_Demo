import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_exercise/Section2/FutureProviderDemo/demo_food_api_service.dart';

// provider for fetch demo food api service
final foodApiProvider = Provider((ref)=>FoodService());

final foodFutureProvider = FutureProvider((Ref ref) async{
  final service = ref.read(foodApiProvider);
  return await service.FetchFoods();
});

// UI Screen

class FoodData_Using_FutureProvider extends ConsumerWidget {
  const FoodData_Using_FutureProvider({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final FoodAsync = ref.watch(foodFutureProvider);
    return Scaffold(
      appBar: AppBar(title: Text("Food Api Cards"),),
      body: FoodAsync.when(
        data: (food) {
          final items = food;
          return ListView.builder(
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  child: Column(
                    children: [
                      Text(item['id'].toString()),
                      Text(item['foodname'].toString())
                    ],
                  ),
                );
              },
            itemCount: items.length,
          );
        },
        error: (error,stackTrace) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Error: $error',style: const TextStyle(color: Colors.red),),
            const SizedBox(height: 12,),
            ElevatedButton(
              // it is re-run the a Provider and reset it's state.
              onPressed: () => ref.refresh(foodFutureProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
        loading: () => CircularProgressIndicator(),
      ),
    );
  }
}
