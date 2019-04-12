
// import 'package:http';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'dart:io';

class MovieService {
  static const String _baseUrl = "https://dog.ceo/api";

  static Future<DogResponse> getRandomBreed() async {
    String fullUrl = "$_baseUrl/breeds/image/random";
    var response = await http.get(fullUrl);
    // return response.body;
    final responseJson = json.decode(response.body);
    return DogResponse(responseJson);
    // return responseJson;

    // HttpClient client = new HttpClient();
    // var response = await client.getUrl(Uri.parse(fullUrl));
    // var real = await response.close();
    // String dataToReturn = "";
    // real.transform(Utf8Decoder()).listen((data) => print(data));
    // return dataToReturn;
  }
}

class DogResponse {
  DogResponse(dynamic resp) {
    this.status = resp['status'];
    this.message = resp['message'];
  }
  String status;
  String message;
}