import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:httprequest/models/movie.dart';

class HttpService {
  final String apiKey = 'f8678be625fe5a84f368b8b8534cb04f';
  final String baseUrl =
      'https://api.themoviedb.org/3/movie/550?api_key=f8678be625fe5a84f368b8b8534cb04f';

  Future<List> getPopularMovies() async {
    final String uri = baseUrl + apiKey;

    http.Response result = await http.get(Uri.parse(uri));
    if (result.statusCode == HttpStatus.ok) {
      print("Sukses");
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse('results');
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    } else {
      print("Fail");
      return null;
    }
  }
}
