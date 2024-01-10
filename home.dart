import 'package:flutter/material.dart';
import 'package:sample_final/add_movie.dart';
import 'package:sample_final/show_movie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => Home();
}

class Home extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie App'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://img.freepik.com/premium-vector/colorful-movie-logo_18099-26.jpg?w=740',
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const AddMovie()));
              },
              child:const Text('Add Movie'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const ShowMovie()));
              },
              child: const Text('View Movie'),
            ),
          ],
        ),
      ),
    );
  }
}