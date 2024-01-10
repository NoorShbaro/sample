import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

final List<String> _movies = [];

const String _baseURL = 'unimobile.000webhostapp.com';

class ShowMovie extends StatefulWidget {
  const ShowMovie({super.key});

  @override
  State<ShowMovie> createState() => _ShowMovieState();
}

class _ShowMovieState extends State<ShowMovie> {
  bool _load = false;

  void update(bool success) {
    setState(() {
      _load = true;
      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('failed to load data')));
      }
    });
  }


  @override
  void initState() {
    updateMovie(update);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Available Movies'),
          centerTitle: true,
        ),
        body: _load ? const ListMovies() : const Center(
            child: SizedBox(width: 100, height: 100, child: CircularProgressIndicator())
        )
    );
  }
}

class ListMovies extends StatelessWidget {
  const ListMovies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _movies.length,
        itemBuilder: (context, index) => Column(children: [
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Flexible(child: Text(_movies[index], style:const TextStyle(fontSize: 18)))
          ])
        ])
    );
  }
}

void updateMovie(Function(bool success) update) async {
  try {
    final url = Uri.https(_baseURL, 'getMovies.php');
    final response = await http.get(url)
        .timeout(const Duration(seconds: 5));
    _movies.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse) {
        _movies.add(
            'name: ${row['name']} \ngenre: ${row['genre']} \nduration: ${row['duration']}');
      }
      update(true);
    }
  }
  catch(e) {
    update(false);
  }
}