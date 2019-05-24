import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slice_one/part_one/song_details.dart';
import 'package:flutter_slice_one/part_one/screen_arguments.dart';
import 'package:flutter_slice_one/part_one/songs_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_slice_one/part_one/login.dart';

void main() => runApp(AsyncCallFuture());

class AsyncCallFuture extends StatelessWidget {
  static String tag = '/listing';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Future Fetch Data Example'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.all_out, color: Colors.white,),
            onPressed: () {
              logOut(context);
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<ResultModel>(
          future: fetchPost(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
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
    );
  }

  Widget buildList(AsyncSnapshot<ResultModel> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.results.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          snapshot.data.results[index].track_name,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0),
                        )),
                    Hero(
                        tag: index,
                        child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 48.0,
                            backgroundImage: NetworkImage(
                                snapshot.data.results[index].artworkUrl100)))
                  ],
                ),
              )),
          onTap: () {
            Navigator.of(context).pushNamed(HomePageDetails.tag,
                arguments: ScreenArguments(
                    snapshot.data.results[index].track_name,
                    snapshot.data.results[index].collection_censored_name,
                    index,
                    snapshot.data.results[index].artworkUrl100));
          },
        ));
  }

  Future<ResultModel> fetchPost() async {
    final response =
        await http.get('https://itunes.apple.com/search?term=Eminem'); // Michael+jackson

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ResultModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  void logOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    Route route = MaterialPageRoute(builder: (context) => LoginPageCooler());
    Navigator.pushReplacement(context, route);
  }
}
