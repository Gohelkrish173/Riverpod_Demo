import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// RiverPod Stateful Widget is required when initState and dispose is used.

final textProvider = StateProvider((Ref ref){
  return '';
});

class Riverpod_Stateful_Widget extends ConsumerStatefulWidget {
  const Riverpod_Stateful_Widget({super.key});

  @override
  ConsumerState<Riverpod_Stateful_Widget> createState() => _Riverpod_Stateful_WidgetState();
}

class _Riverpod_Stateful_WidgetState extends ConsumerState<Riverpod_Stateful_Widget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener((){
      // here state change the text value from above _controller
      ref.read(textProvider.notifier).state = _controller.text;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // here in ConsumerStateful Widget no need to add WidgetRef in Build Method.
  @override
  Widget build(BuildContext context) {
    final text = ref.watch(textProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Text Form'),),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(controller: _controller,),
            const SizedBox(height: 20,),
            Text('You Typed : $text'),
          ],
        ),
      ),
    );
  }
}
