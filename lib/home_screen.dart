import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:practice_riverpod/slider_provider.dart';

// Switch must be StateProvider, not Provider.
final switchButton = StateProvider<bool>((ref) {
  return false;
});

final counter = StateProvider<int>((ref) {
  return 0;
});

// class HomeScreen extends ConsumerStatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   ConsumerState<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends ConsumerState<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//         return Scaffold(
//       appBar: AppBar(title: const Text("data")),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Counter text
//           Consumer(
//             builder: (context, ref, child) {
//               print("build1 ful");
//               final count = ref.watch(counter);
//               return Center(
//                 child: Text("consumer: $count", style: TextStyle(fontSize: 20)),
//               );
//             },
//           ),

//           // Switch
//           Consumer(
//             builder: (context, ref, child) {
//               print("build2");
//               final switchState = ref.watch(switchButton);
//               return Center(
//                 child: Switch(
//                   value: switchState,
//                   onChanged: (value) {
//                     ref.read(switchButton.notifier).state = value;
//                   },
//                 ),
//               );
//             },
//           ),

//           // + button
//           IconButton(
//             onPressed: () {
//               ref.read(counter.notifier).state++;
//             },
//             icon: const Icon(Icons.add),
//           ),

//           // - button
//           IconButton(
//             onPressed: () {
//               ref.read(counter.notifier).state--;
//             },
//             icon: const Icon(Icons.remove),
//           ),
//         ],
//       ),
//     );
//   }
// }

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("build");

    return Scaffold(
      appBar: AppBar(title: const Text("data")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Counter text
          Consumer(
            builder: (context, ref, child) {
              print("build1");
              final count = ref.watch(counter);
              return Center(
                child: Text("consumer: $count", style: TextStyle(fontSize: 20)),
              );
            },
          ),

          // Switch
          Consumer(
            builder: (context, ref, child) {
              print("build2");
              final switchState = ref.watch(switchButton);
              return Center(
                child: Switch(
                  value: switchState,
                  onChanged: (value) {
                    ref.read(switchButton.notifier).state = value;
                  },
                ),
              );
            },
          ),

          // + button
          IconButton(
            onPressed: () {
              ref.read(counter.notifier).state++;
            },
            icon: const Icon(Icons.add),
          ),

          // - button
          IconButton(
            onPressed: () {
              ref.read(counter.notifier).state--;
            },
            icon: const Icon(Icons.remove),
          ),

          Consumer(
            builder: (context, ref, child) {
              print("container Icon");
              final sliderValue = ref.watch(sliderProvider.select((state)=>state.showPassword));
              return InkWell(
                onTap: () {
                  final appStateProvider=ref.read(sliderProvider.notifier);
                  appStateProvider.state=appStateProvider.state.copyWith(showPassword: !sliderValue);
                  
                },
                child: Container(
                  height: 200,
                  width: 200,
                  // ignore: deprecated_member_use
                  color: Colors.green,
                  child: sliderValue? Icon(Icons.remove_red_eye):Icon(Icons.generating_tokens),
                ),
              );
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              print("container consumer");
              final sliderValue = ref.watch(sliderProvider.select((state)=>state.slider));
              return Container(
                height: 200,
                width: 200,
                // ignore: deprecated_member_use
                color: Colors.amber.withOpacity(sliderValue),
              );
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              //final sliderValue = ref.watch(sliderProvider);
              final sliderValue = ref.watch(sliderProvider.select((state)=>state.slider));
              print("slider consumer");
              return Slider(
                value: sliderValue,
                onChanged: (value) {
                  final appStateProvider=ref.read(sliderProvider.notifier);
                  appStateProvider.state=appStateProvider.state.copyWith(slider: value);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
