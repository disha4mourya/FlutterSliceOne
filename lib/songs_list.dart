import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

Future<ResultModel> fetchPost() async {
  print("resultis" + "initial");

  final response =
      await http.get('https://itunes.apple.com/search?term=Michael+jackson');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print("resultis" + response.body.toString());

    return ResultModel.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class ResultModel {
  int resultCount;
  List<SongsModel> results = [];

  ResultModel.fromJson(Map<String, dynamic> parsedJson) {
    resultCount = parsedJson['resultCount'];
    print("CountIS" + resultCount.toString());

    List<SongsModel> songs = [];

    for (int i = 0; i < parsedJson['results'].length; i++) {
      SongsModel songModel = SongsModel(parsedJson['results'][i]);
      songs.add(songModel);
    }

    results = songs;
  }
}

class SongsModel {
  String _wrapper_type;
  String _track_name;
  String artworkUrl30;
  String artworkUrl100;

  SongsModel(result) {
    _wrapper_type = result['wrapperType'];
    _track_name = result['trackName'];
    artworkUrl30 = result['artworkUrl30'];
    artworkUrl100 = result['artworkUrl100'];
  }

  String get wrapper_type => _wrapper_type;

  String get track_name => _track_name;

  String get artworkUrl_30 => artworkUrl30;

  String get artworkUrl_100 => artworkUrl100;
}

void main() => runApp(AsyncCall());

class AsyncCall extends StatelessWidget {
  // final Future<ResultModel> post;

  //AsyncCall({Key key, this.post}) : super(key: key);
  final songsFetcher = PublishSubject<ResultModel>();

  Observable<ResultModel> get allSongs => songsFetcher.stream;

  fetchAllSOngs() async {
    ResultModel resultModel = await fetchPost();
    songsFetcher.sink.add(resultModel);
  }

  AsyncCall() {
    fetchAllSOngs();
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
              print("resultis" + "snapshot" + snapshot.hasData.toString());
              print("resultis" + "snapshot" + snapshot.hasError.toString());
              print("resultis" + "snapshot" + snapshot.hashCode.toString());

              if (snapshot.hasData) {
                // return Text(snapshot.data.title);
                return buildList(snapshot);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner
              return CircularProgressIndicator();
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
          /*return GridTile(
            child: InkResponse(
          enableFeedback: true,
          child: Text(snapshot.data.results[index].track_name),
        ));*/
        });
  }
}
