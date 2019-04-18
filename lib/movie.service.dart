
import 'dart:convert';
import 'package:http/http.dart' as http;

String getImageBaseUrl(String relativeImagePath, [int width = 185]) {
  return "https://image.tmdb.org/t/p/w$width$relativeImagePath";
}

class MovieService {
  static const String _baseUrl = "https://api.themoviedb.org/3";
  static const String _apiKey = "1d24f7e213bcc3fc22382ffbf01e4cb2";

  static Future<List<Movie>> getMovies([int pageNumber = 1]) async {
    String fullUrl = "$_baseUrl/tv/top_rated?api_key=$_apiKey&page=$pageNumber";
    var responseJson = json.decode((await http.get(fullUrl)).body);
    var movieResponse = MovieResponse(responseJson);
    return movieResponse.results;
  }

}

class Movie {
  Movie(dynamic movieItemJson) {
    name = movieItemJson['name'];
    overview = movieItemJson['overview'];
    backdropUrl = "${getImageBaseUrl(movieItemJson['backdrop_path'])}";
    posterUrl = "${getImageBaseUrl(movieItemJson['poster_path'])}";
    genreIds = (movieItemJson['genre_ids'] as List<dynamic>).map<int>((item) => item).toList();
  }

  String name;
  String overview;
  String backdropUrl;
  String posterUrl;
  List<int> genreIds;
}

class MovieResponse {
  MovieResponse(dynamic movieResponseJson) {
    page = movieResponseJson['page'];
    totalResults = movieResponseJson['total_results'];
    totalPages = movieResponseJson['total_pages'];
    var allMovies = movieResponseJson['results'] as List<dynamic>;
    results = allMovies.map<Movie>((movieItem) => Movie(movieItem)).toList();
  }
  int page;
  int totalResults;
  int totalPages;
  List<Movie> results;
}
