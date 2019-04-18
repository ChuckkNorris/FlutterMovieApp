import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import './redux/redux.store.dart';
import './pages/home-page.dart';

void main() => runApp(MyApp(store: movieAppStore));

class MyApp extends StatelessWidget {
  final Store<MovieAppState> store;
  
  MyApp({Key key, this.store}): super(key: key);

  @override
  Widget build(BuildContext context) {
    final darkTheme = Theme.of(context).textTheme.apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    );
    final originalTheme = ThemeData(
        primarySwatch: Colors.blue,
        // textTheme: darkTheme
      );
    return new StoreProvider<MovieAppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: originalTheme,
        home: HomePage(title: 'Flutter Demo Home Page'),
      )
    );
  }
}


