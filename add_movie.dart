import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


const String _baseURL = 'https://unimobile.000webhostapp.com';

class AddMovie extends StatefulWidget {
  const AddMovie({super.key});

  @override
  State<AddMovie> createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controllerID = TextEditingController();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerGenre= TextEditingController();
  TextEditingController _controllerDuration = TextEditingController();
  bool _loading = false;


  @override
  void dispose() {
    _controllerID.dispose();
    _controllerName.dispose();
    _controllerGenre.dispose();
    _controllerDuration.dispose();
    super.dispose();
  }

  void update(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Movie'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Center(child: Form(
          key: _formKey, // key to uniquely identify the form when performing validation
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              SizedBox(width: 200, child: TextFormField(controller: _controllerName,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Name',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter movie name';
                  }
                  return null;
                },
              )),
              const SizedBox(height: 10),
              SizedBox(width: 200, child: TextFormField(controller: _controllerGenre,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Genre',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the genre';
                  }
                  return null;
                },
              )),
              const SizedBox(height: 10),
              SizedBox(width: 200, child: TextFormField(controller: _controllerDuration,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Duration',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the duration';
                  }
                  return null;
                },
              )),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _loading ? null : () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _loading = true;
                    });
                    saveMovie(update, int.parse(_controllerID.text), _controllerName.text,
                        _controllerGenre.text,
                        double.parse(_controllerDuration.text));
                  }
                },
                child: const Text('Submit'),
              ),
              const SizedBox(height: 10),
              Visibility(visible: _loading, child: const CircularProgressIndicator())
            ],
          ),
        )));
  }
}

void saveMovie(Function(String text) update, int movieID, String name,String genre, double duration) async {
  try {
    final response = await http.post(
        Uri.parse('$_baseURL/saveMovie.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: convert.jsonEncode(<String, String>{
          'MovieID': '$movieID','name': name, 'genre': genre, 'duration':'$duration', 'key': 'liuFinal'
        })).timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      update(response.body);
    }
  }
  catch(e) {
    update(e.toString());
  }
}