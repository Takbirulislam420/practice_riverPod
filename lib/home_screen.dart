import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final hello1 =Provider<String>((ref){
  return "hello provider pod";
});

final hello2 =Provider<int>((ref){
  return 25;
});

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final helloRiver=ref.watch(hello1);
    final intRiver=ref.watch(hello2);
    return Scaffold(
      appBar: AppBar(title: Text("data"),),
      body: Center(child: Text("consumer: $intRiver $helloRiver"),),
      );
  }
}