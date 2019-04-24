import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slice_one/home_page_details.dart';
import 'package:flutter_slice_one/models/songs_model.dart';
import 'package:http/http.dart' as http;

void main() => runApp(AsyncCallFuture());

class AsyncCallFuture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Future Fetch Data Example',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white70,
          primarySwatch: Colors.blueGrey),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Future Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<ResultModel>(
            future: fetchPost(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // return Text(snapshot.data.title);
                return buildList(snapshot);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else {
                // By default, show a loading spinner
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ResultModel> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.results.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return _buildRow(context, snapshot, index);
        });
  }

  Widget _buildRow(
      BuildContext context, AsyncSnapshot<ResultModel> snapshot, int index) {
    return Padding(
        padding: const EdgeInsets.all(2.0),
        child: GestureDetector(
          child: Card(
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      snapshot.data.results[index].track_name,
                      textAlign: TextAlign.center,
                    )),
                Image.network(snapshot.data.results[index].artworkUrl_100,
                    fit: BoxFit.fill)
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePageDetails()),
            );
          },
        ));
  }

  Future<ResultModel> fetchPost() async {
    final response =
        await http.get('https://itunes.apple.com/search?term=Michael+jackson');

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ResultModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
