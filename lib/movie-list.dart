import 'package:flutter/material.dart';
import 'movie.service.dart';

class MovieList extends StatefulWidget {
  MovieList({this.title});

  final String title;

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  bool _isChecked = false;

  void toggleCheck(bool isChecked) async {
    var data = await MovieService.getRandomBreed();
    print("data from place ${data.message}");
    print("Current Value: $isChecked");
    setState(() {
     _isChecked = isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
  
    return Card(
      child: Checkbox(value: _isChecked, onChanged: (val) => this.toggleCheck(val)),
    );
  }
}