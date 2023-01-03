import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    // 1.まず最初にApp全体をProviderScopeで囲む
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// 2.StateNotifierProviderを使ってcounterProviderを宣言。グローバルに宣言。
final counterProvider = StateNotifierProvider((ref) {
  return Counter();
});

// StateNotifier<**> -> **はstateという変数の型になる
class Counter extends StateNotifier<int> {
  Counter() : super(0);
  void increment() => state++;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends HookConsumerWidget {
  const MyHomePage({super.key});
  final String title = 'title';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watchでプロバイダを監視する
    final counter = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //作って置いた関数を呼び出して値を変えることもできるぜ
          ref.read(counterProvider.notifier).increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
