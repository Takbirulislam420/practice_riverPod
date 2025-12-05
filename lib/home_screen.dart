import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final hello1 = Provider<String>((ref) {
  return "hello provider";
});

final counter = StateProvider<int>((ref) {
  return 0;
});

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final helloRiver = ref.watch(hello1);
    return Scaffold(
      appBar: AppBar(title: Text("data")),
      body: Center(child: Text("consumer: $helloRiver")),
    );
  }
}


// Work with RiverPod
 
// class HomeScreen extends ConsumerWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final helloRiver=ref.watch(hello1);
//     final intRiver=ref.watch(hello2);
//     return Scaffold(
//       appBar: AppBar(title: Text("data"),),
//       body: Center(child: Text("consumer: $intRiver $helloRiver"),),
//       );
//   }
// }
