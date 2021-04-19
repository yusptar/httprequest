import 'package:flutter/material.dart';
import 'package:httprequest/pages/movie_detail.dart';
import 'package:httprequest/service/http_service.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  int moviesCount;
  List movies;
  HttpService service;

  Future initialize() async {
    movies = [];
    movies = await service.getPopularMovies();
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  @override
  void initState() {
    service = HttpService();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final image = "https://image.tmdb.org/t/p/w500";
    return Scaffold(
      appBar: AppBar(
        title: Text("Popular Movies"),
      ),
      body: ListView.builder(
        itemCount: (this.moviesCount == null) ? 0 : this.moviesCount,
        itemBuilder: (context, int position) {
          return Card(
            margin: EdgeInsets.all(10),
            color: Colors.blueGrey[700],
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(10),
              leading: CircleAvatar(
                radius: 30,
                backgroundImage:
                    NetworkImage(image + movies[position].posterPath),
              ),
              title: Text(
                movies[position].title,
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(Icons.arrow_right_alt_sharp),
              subtitle: Text(
                movies[position].voteAverage.toString(),
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(
                    builder: (_) => MovieDetail(movies[position]));
                Navigator.push(context, route);
              },
            ),
          );
        },
      ),
    );
  }
}
