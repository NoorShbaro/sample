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
          //'https://img.freepik.com/premium-vector/colorful-movie-logo_18099-26.jpg?w=740'
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('data:image/jpeg;base64,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'),
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