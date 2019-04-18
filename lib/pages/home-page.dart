import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../redux/redux.store.dart';
import '../movie-list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                new StoreConnector<MovieAppState, String>(
                  converter: (store) {
                    
                    // String stateString = json.encode(store.state);
                    // print(stateString);
                    return store.state.count.toString();
                  },
                  builder: (context, count) {
                    return Text('The count is: $count');
                  },
                ),
                
              ],
            ),
            MovieList(title: "Awesome"),
          ],
        ),
      ),
      floatingActionButton: new StoreConnector<MovieAppState, VoidCallback>(
        converter: (store) => () => store.dispatch(IncrementCounterAction(1)),
        builder: (context, callback) {
          return FloatingActionButton(onPressed: callback, tooltip: 'Increment', child: Icon(Icons.add));
        },
      ),
    );
  }
}