import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slice_one/models/songs_model.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

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

void main() => runApp(AsyncCall());

class AsyncCall extends StatelessWidget {

  final songsFetcher = PublishSubject<ResultModel>();

  Observable<ResultModel> get allSongs => songsFetcher.stream;

  fetchAllSongs() async {
    ResultModel resultModel = await fetchPost();
    songsFetcher.sink.add(resultModel);
  }

  AsyncCall() {
    fetchAllSongs();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: StreamBuilder(
            stream: allSongs,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // return Text(snapshot.data.title);
                return buildList(snapshot);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }else {
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
          return Container(
            margin: new EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                new Text(snapshot.data.results[index].track_name),
                new Image.network(snapshot.data.results[index].artworkUrl_100,
                    fit: BoxFit.fill)
              ],
            ),
          );
        });
  }
}
