import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    // ①まず最初にApp全体をProviderScopeで囲む
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

/// ②StateProviderを使ってProviderを宣言。グローバルに宣言。
final StateProvider counterProvider = StateProvider((ref) {
  return 0;
});

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: GoodText(context),
      ),
      floatingActionButton: FloatingActionButton(
        // ③Listenしておかなくても、providerを読んで更新できる。
        onPressed: () => context.read(counterProvider).state++,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class GoodText extends ConsumerWidget {
  GoodText(BuildContext context);

  Widget build(BuildContext context, ScopedReader watch) {
    // ③ConsumerWidgetを使って、providerを読む
    final count = watch(counterProvider).state;
    print("iine is rewrite $count");
    return Text('$countいいね');
  }
}
