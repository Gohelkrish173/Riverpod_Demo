import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final SP = ref.watch(staticProvider);
    
    return Scaffold(
      body: Center(
        child: Text(SP),
      ),
    );
  }
}

