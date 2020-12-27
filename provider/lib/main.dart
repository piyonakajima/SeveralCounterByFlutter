import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// １.状態を定義する（ChangeNotifierを拡張したクラスを定義する）
class CountState extends ChangeNotifier {
  int count = 0;
  void addCount() {
    count++;
    //　これがないと描画してくれない
    notifyListeners();
  }
}

void main() {
  runApp(CountApp());
}

class CountApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // CounterStateを呼び出す、ただしWidgetの中で！
    final CountState countState = CountState();

    // ２．ウィジェット全体をChangeNotifierProviderで囲む
    return ChangeNotifierProvider<CountState>.value(
      value: countState,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text('CounterApp')),
          body: _Body(),
          floatingActionButton: _FloatingActionButton(),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ３．Stateを取り出す
    final CountState countState = Provider.of<CountState>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'You have pushed the button this many times:',
          ),
          Text(
            countState.count.toString(),
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }
}

class _FloatingActionButton extends StatelessWidget {
  Widget build(BuildContext context) {
    // ３．Stateを取り出す
    final CountState counterState = Provider.of<CountState>(context);
    return FloatingActionButton(
      onPressed: () => counterState.addCount(),
      child: Icon(Icons.add),
    );
  }
}
