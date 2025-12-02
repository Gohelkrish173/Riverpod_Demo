import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// create simple provider for get the value
final durationProvider = Provider((_) => const Duration(seconds: 5));

class StateFul_Animation_Screen extends ConsumerStatefulWidget {
  const StateFul_Animation_Screen({super.key});

  @override
  ConsumerState<StateFul_Animation_Screen> createState() => _StateFul_Animation_ScreenState();
}

class _StateFul_Animation_ScreenState extends ConsumerState<StateFul_Animation_Screen>
  with SingleTickerProviderStateMixin{
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    final duration = ref.read(durationProvider);
    _animationController = AnimationController(vsync: this,duration: duration)
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // here you don't need to add WidgetRef b'coz of ConsumerStatefulWidget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pulsing Circle.'),),
      body: Center(
        child: ScaleTransition(
          scale: _animationController.drive(Tween(begin: 0.5,end: 5)),
          child: const Icon(Icons.circle,size: 80,color: Colors.blue,),
        ),
      ),
    );
  }
}