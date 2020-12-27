import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:state_notifier/state_notifier.dart';

void main() {
  // 1.まず最初にApp全体をProviderScopeで囲む
  runApp(
    ProviderScope(
      child: CounterApp(),
    ),
  );
}

// 2.StateNotifierProviderを使ってcounterProviderを宣言。グローバルに宣言。
final counterProvider = StateNotifierProvider((_) => Counter());

class Counter extends StateNotifier<int> {
  Counter() : super(0);
  void increment() => state++;
}

// Note: CounterApp is a HookWidget, from flutter_hooks.
class CounterApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // 3.useProviderを使って状態を取得
    final state = useProvider(counterProvider.state);
    final counter = useProvider(counterProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('CounterApp')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                state.toString(),
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          //作って置いた関数を呼び出して値を変えることもできるぜ
          onPressed: () => counter.increment(),
          child: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
