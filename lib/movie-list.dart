import 'package:flutter/material.dart';
import 'movie.service.dart';
import 'package:url_launcher/url_launcher.dart';

openUrl(String url) {
  launch(url);
}

ListView movieListBuilder(List<Movie> allMovies, ScrollController scrollController) {
    if (scrollController != null)
      print(scrollController.initialScrollOffset);
    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.all(8.0),
      itemCount: allMovies.length,
      itemExtent: 178.0,
      itemBuilder: (BuildContext context, int index) {
        Movie currMovie = allMovies[index];
        return Card(
          color: Color.fromRGBO(60, 60, 60, .5),
          child: Container(
            // height: 144,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(currMovie.posterUrl),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter
              )
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.album),
                  title: Text(currMovie.name,
                      style: TextStyle(color: Colors.amberAccent)),
                  subtitle: Text(currMovie.overview, maxLines: 4),
                ),
                ButtonTheme.bar(
                  // make buttons use the appropriate styles for cards
                  child: ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: const Text('BUY TICKETS'),
                        onPressed: () {
                          openUrl("https://google.com/search?q=$index");
                        },
                      ),
                      FlatButton(
                        child: const Text('LISTEN'),
                        onPressed: () {/* ... */},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

class MovieList extends StatefulWidget {
  MovieList({this.title});

  final String title;

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  ScrollController _scrollController;
  bool _isChecked = false;
  List<Movie> _movies = new List<Movie>();
  int _currentPage = 1;
  bool _isGettingMovies = false;

  _scrollListener() {
    var scrollPercentage = _scrollController.offset / _scrollController.position.maxScrollExtent;
    // TODO: Prevent requests while next page is loading
    // if (scrollPercentage > .8 && !_isGettingMovies) {
    //   _isGettingMovies = false;
    //   print("Getting next movies: ${this._currentPage}");
    //   this.getMovies();
    // }
  }

  @override
  void initState() {
    this._scrollController = ScrollController();
    this._scrollController.addListener(_scrollListener);
    super.initState();
    getMovies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void getMovies() async {
    
    var data = await MovieService.getMovies(_currentPage);
    print("data from place ${data.length}");
    setState(() {
      _movies = [this._movies, data].expand((x) => x).toList();
      _currentPage++;
      _isGettingMovies = false;
    });
  }

  void toggleCheck(bool isChecked) {
    
    print("Current Value: $isChecked");
    setState(() {
      _isChecked = isChecked;
      _isGettingMovies = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Checkbox(value: _isChecked, onChanged: (val) => this.toggleCheck(val)),
        Container(height: 500, child: movieListBuilder(_movies, _scrollController))
      ],
    );
  }
}
